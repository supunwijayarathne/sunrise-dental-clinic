package com.sunrise.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Date;
import java.sql.Time;
import java.sql.SQLException;

import java.util.ArrayList;
import java.util.List;

import com.sunrise.model.Appointment;
import com.sunrise.util.DBConnection;


public class AppointmentDAO {

    // =========================================================
    // ADD APPOINTMENT
    // =========================================================

    public boolean addAppointment(Appointment appointment) {

        String sql =
                "INSERT INTO appointments " +
                "(appointment_number, patient_id, dentist_id, " +
                "treatment_id, appointment_date, appointment_time, " +
                "status, notes, created_by) " +
                "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";

        try (
            Connection con = DBConnection.getConnection();
            PreparedStatement st = con.prepareStatement(sql)
        ) {

            st.setString(1, appointment.getAppointmentNumber());
            st.setInt(2, appointment.getPatientId());
            st.setInt(3, appointment.getDentistId());
            st.setInt(4, appointment.getTreatmentId());

            st.setDate(
                    5,
                    Date.valueOf(
                            appointment.getAppointmentDate()
                    )
            );

            st.setTime(
                    6,
                    Time.valueOf(
                            appointment.getAppointmentTime()
                    )
            );

            st.setString(7, appointment.getStatus());
            st.setString(8, appointment.getNotes());
            st.setInt(9, appointment.getCreatedBy());

            return st.executeUpdate() > 0;

        } catch (Exception e) {

            System.out.println("ERROR ADDING APPOINTMENT:");
            e.printStackTrace();
        }

        return false;
    }


    // =========================================================
    // GET ALL APPOINTMENTS
    // =========================================================

    public List<Appointment> getAllAppointments() {

        List<Appointment> appointments =
                new ArrayList<>();

        String sql =
                "SELECT * FROM appointments " +
                "ORDER BY appointment_date DESC, " +
                "appointment_time DESC";

        try (
            Connection con = DBConnection.getConnection();
            PreparedStatement st = con.prepareStatement(sql);
            ResultSet rs = st.executeQuery()
        ) {

            while (rs.next()) {

                appointments.add(
                        mapResultSetToAppointment(rs)
                );
            }

        } catch (Exception e) {

            System.out.println(
                    "ERROR LOADING APPOINTMENTS:"
            );

            e.printStackTrace();
        }

        return appointments;
    }


    // =========================================================
    // GET APPOINTMENT BY ID
    // =========================================================

    public Appointment getAppointmentById(
            int appointmentId) {

        String sql =
                "SELECT * FROM appointments " +
                "WHERE appointment_id = ?";

        try (
            Connection con = DBConnection.getConnection();
            PreparedStatement st = con.prepareStatement(sql)
        ) {

            st.setInt(1, appointmentId);

            try (ResultSet rs = st.executeQuery()) {

                if (rs.next()) {

                    return mapResultSetToAppointment(rs);
                }
            }

        } catch (Exception e) {

            System.out.println(
                    "ERROR FINDING APPOINTMENT:"
            );

            e.printStackTrace();
        }

        return null;
    }


    // =========================================================
    // UPDATE APPOINTMENT
    // =========================================================

    public boolean updateAppointment(
            Appointment appointment) {

        String sql =
                "UPDATE appointments SET " +
                "patient_id = ?, " +
                "dentist_id = ?, " +
                "treatment_id = ?, " +
                "appointment_date = ?, " +
                "appointment_time = ?, " +
                "status = ?, " +
                "notes = ? " +
                "WHERE appointment_id = ?";

        try (
            Connection con = DBConnection.getConnection();
            PreparedStatement st = con.prepareStatement(sql)
        ) {

            st.setInt(1, appointment.getPatientId());
            st.setInt(2, appointment.getDentistId());
            st.setInt(3, appointment.getTreatmentId());

            st.setDate(
                    4,
                    Date.valueOf(
                            appointment.getAppointmentDate()
                    )
            );

            st.setTime(
                    5,
                    Time.valueOf(
                            appointment.getAppointmentTime()
                    )
            );

            st.setString(6, appointment.getStatus());
            st.setString(7, appointment.getNotes());

            st.setInt(
                    8,
                    appointment.getAppointmentId()
            );

            return st.executeUpdate() > 0;

        } catch (Exception e) {

            System.out.println(
                    "ERROR UPDATING APPOINTMENT:"
            );

            e.printStackTrace();
        }

        return false;
    }


    // =========================================================
    // SEARCH APPOINTMENTS
    // =========================================================

    public List<Appointment> searchAppointments(String keyword) {

        List<Appointment> appointments = new ArrayList<>();

        String sql =
                "SELECT a.* " +
                "FROM appointments a " +
                "INNER JOIN patients p " +
                "ON a.patient_id = p.patient_id " +
                "INNER JOIN dentists d " +
                "ON a.dentist_id = d.dentist_id " +
                "INNER JOIN treatments t " +
                "ON a.treatment_id = t.treatment_id " +
                "WHERE a.appointment_number LIKE ? " +
                "OR p.patient_code LIKE ? " +
                "OR p.name LIKE ? " +
                "OR p.contact_number LIKE ? " +
                "OR d.dentist_name LIKE ? " +
                "OR t.treatment_name LIKE ? " +
                "OR a.status LIKE ? " +
                "ORDER BY a.appointment_date DESC, " +
                "a.appointment_time DESC";

        try (
            Connection con = DBConnection.getConnection();
            PreparedStatement st = con.prepareStatement(sql)
        ) {

            String value = "%" + keyword + "%";

            st.setString(1, value);
            st.setString(2, value);
            st.setString(3, value);
            st.setString(4, value);
            st.setString(5, value);
            st.setString(6, value);
            st.setString(7, value);

            try (ResultSet rs = st.executeQuery()) {

                while (rs.next()) {

                    appointments.add(
                        mapResultSetToAppointment(rs)
                    );
                }
            }

        } catch (Exception e) {

            System.out.println(
                "ERROR SEARCHING APPOINTMENTS:"
            );

            e.printStackTrace();
        }

        return appointments;
    }


    // =========================================================
    // CHECK DENTIST AVAILABILITY
    // =========================================================

    public boolean isDentistAvailable(
            int dentistId,
            java.time.LocalDate appointmentDate,
            java.time.LocalTime appointmentTime,
            int appointmentId) {

        String sql =
                "SELECT COUNT(*) " +
                "FROM appointments " +
                "WHERE dentist_id = ? " +
                "AND appointment_date = ? " +
                "AND appointment_time = ? " +
                "AND status NOT IN ('CANCELLED', 'NO_SHOW') " +
                "AND appointment_id <> ?";

        try (
            Connection con = DBConnection.getConnection();
            PreparedStatement st = con.prepareStatement(sql)
        ) {

            st.setInt(1, dentistId);

            st.setDate(
                    2,
                    Date.valueOf(appointmentDate)
            );

            st.setTime(
                    3,
                    Time.valueOf(appointmentTime)
            );

            st.setInt(4, appointmentId);

            try (ResultSet rs = st.executeQuery()) {

                if (rs.next()) {

                    return rs.getInt(1) == 0;
                }
            }

        } catch (Exception e) {

            System.out.println(
                    "ERROR CHECKING DENTIST AVAILABILITY:"
            );

            e.printStackTrace();
        }

        return false;
    }


    // =========================================================
    // CHECK PATIENT AVAILABILITY
    // =========================================================

    public boolean isPatientAvailable(
            int patientId,
            java.time.LocalDate appointmentDate,
            java.time.LocalTime appointmentTime,
            int appointmentId) {

        String sql =
                "SELECT COUNT(*) " +
                "FROM appointments " +
                "WHERE patient_id = ? " +
                "AND appointment_date = ? " +
                "AND appointment_time = ? " +
                "AND status NOT IN ('CANCELLED', 'NO_SHOW') " +
                "AND appointment_id <> ?";

        try (
            Connection con = DBConnection.getConnection();
            PreparedStatement st = con.prepareStatement(sql)
        ) {

            st.setInt(1, patientId);

            st.setDate(
                    2,
                    Date.valueOf(appointmentDate)
            );

            st.setTime(
                    3,
                    Time.valueOf(appointmentTime)
            );

            st.setInt(4, appointmentId);

            try (ResultSet rs = st.executeQuery()) {

                if (rs.next()) {

                    return rs.getInt(1) == 0;
                }
            }

        } catch (Exception e) {

            System.out.println(
                    "ERROR CHECKING PATIENT AVAILABILITY:"
            );

            e.printStackTrace();
        }

        return false;
    }
    
 // =========================================================
 // APPOINTMENT NUMBER
 // =========================================================

 public String generateNextAppointmentNumber() {

     String sql =
             "SELECT appointment_number " +
             "FROM appointments " +
             "ORDER BY appointment_id DESC " +
             "LIMIT 1";

     try (
         Connection con = DBConnection.getConnection();
         PreparedStatement ps = con.prepareStatement(sql);
         ResultSet rs = ps.executeQuery()
     ) {

         if (rs.next()) {

             String lastNumber =
                     rs.getString("appointment_number");

             if (lastNumber != null
                     && lastNumber.startsWith("APT-")) {

                 try {

                     int number =
                             Integer.parseInt(
                                     lastNumber.substring(4)
                             );

                     return String.format(
                             "APT-%03d",
                             number + 1
                     );

                 } catch (NumberFormatException e) {

                     System.out.println(
                             "Invalid appointment number: "
                             + lastNumber
                     );

                     e.printStackTrace();
                 }
             }
         }

     } catch (ClassNotFoundException e) {

         System.out.println(
                 "MySQL JDBC Driver not found."
         );

         e.printStackTrace();

     } catch (SQLException e) {

         System.out.println(
                 "ERROR GENERATING APPOINTMENT NUMBER:"
         );

         e.printStackTrace();
     }

     // First appointment / fallback
     return "APT-001";
 }


    // =========================================================
    // CHECK APPOINTMENT NUMBER
    // =========================================================

    public boolean appointmentNumberExists(
            String appointmentNumber,
            int appointmentId) {

        String sql =
                "SELECT COUNT(*) " +
                "FROM appointments " +
                "WHERE appointment_number = ? " +
                "AND appointment_id <> ?";

        try (
            Connection con = DBConnection.getConnection();
            PreparedStatement st = con.prepareStatement(sql)
        ) {

            st.setString(1, appointmentNumber);
            st.setInt(2, appointmentId);

            try (ResultSet rs = st.executeQuery()) {

                if (rs.next()) {

                    return rs.getInt(1) > 0;
                }
            }

        } catch (Exception e) {

            System.out.println(
                    "ERROR CHECKING APPOINTMENT NUMBER:"
            );

            e.printStackTrace();
        }

        return false;
    }


    // =========================================================
    // GET TODAY'S APPOINTMENTS
    // =========================================================

    public List<Appointment> getTodayAppointments() {

        List<Appointment> appointments =
                new ArrayList<>();

        String sql =
                "SELECT * FROM appointments " +
                "WHERE appointment_date = CURRENT_DATE " +
                "ORDER BY appointment_time ASC";

        try (
            Connection con = DBConnection.getConnection();
            PreparedStatement st = con.prepareStatement(sql);
            ResultSet rs = st.executeQuery()
        ) {

            while (rs.next()) {

                appointments.add(
                        mapResultSetToAppointment(rs)
                );
            }

        } catch (Exception e) {

            System.out.println(
                    "ERROR LOADING TODAY'S APPOINTMENTS:"
            );

            e.printStackTrace();
        }

        return appointments;
    }


    // =========================================================
    // GET APPOINTMENTS BY PATIENT
    // =========================================================

    public List<Appointment> getAppointmentsByPatient(
            int patientId) {

        List<Appointment> appointments =
                new ArrayList<>();

        String sql =
                "SELECT * FROM appointments " +
                "WHERE patient_id = ? " +
                "ORDER BY appointment_date DESC, " +
                "appointment_time DESC";

        try (
            Connection con = DBConnection.getConnection();
            PreparedStatement st = con.prepareStatement(sql)
        ) {

            st.setInt(1, patientId);

            try (ResultSet rs = st.executeQuery()) {

                while (rs.next()) {

                    appointments.add(
                            mapResultSetToAppointment(rs)
                    );
                }
            }

        } catch (Exception e) {

            System.out.println(
                    "ERROR LOADING PATIENT APPOINTMENTS:"
            );

            e.printStackTrace();
        }

        return appointments;
    }


    // =========================================================
    // GET APPOINTMENTS BY DENTIST
    // =========================================================

    public List<Appointment> getAppointmentsByDentist(
            int dentistId) {

        List<Appointment> appointments =
                new ArrayList<>();

        String sql =
                "SELECT * FROM appointments " +
                "WHERE dentist_id = ? " +
                "ORDER BY appointment_date DESC, " +
                "appointment_time DESC";

        try (
            Connection con = DBConnection.getConnection();
            PreparedStatement st = con.prepareStatement(sql)
        ) {

            st.setInt(1, dentistId);

            try (ResultSet rs = st.executeQuery()) {

                while (rs.next()) {

                    appointments.add(
                            mapResultSetToAppointment(rs)
                    );
                }
            }

        } catch (Exception e) {

            System.out.println(
                    "ERROR LOADING DENTIST APPOINTMENTS:"
            );

            e.printStackTrace();
        }

        return appointments;
    }


    // =========================================================
    // MAP RESULT SET TO APPOINTMENT
    // =========================================================

    private Appointment mapResultSetToAppointment(
            ResultSet rs) throws Exception {

        Appointment appointment =
                new Appointment();

        appointment.setAppointmentId(
                rs.getInt("appointment_id")
        );

        appointment.setAppointmentNumber(
                rs.getString("appointment_number")
        );

        appointment.setPatientId(
                rs.getInt("patient_id")
        );

        appointment.setDentistId(
                rs.getInt("dentist_id")
        );

        appointment.setTreatmentId(
                rs.getInt("treatment_id")
        );

        appointment.setAppointmentDate(
                rs.getDate("appointment_date")
                        .toLocalDate()
        );

        appointment.setAppointmentTime(
                rs.getTime("appointment_time")
                        .toLocalTime()
        );

        appointment.setStatus(
                rs.getString("status")
        );

        appointment.setNotes(
                rs.getString("notes")
        );

        appointment.setCreatedBy(
                rs.getInt("created_by")
        );

        appointment.setCreatedAt(
                rs.getTimestamp("created_at")
        );

        appointment.setUpdatedAt(
                rs.getTimestamp("updated_at")
        );

        return appointment;
    }
}