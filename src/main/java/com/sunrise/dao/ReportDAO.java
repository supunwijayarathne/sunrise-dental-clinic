package com.sunrise.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

import com.sunrise.model.ReportAppointment;
import com.sunrise.model.ReportBill;
import com.sunrise.model.ReportStats;
import com.sunrise.model.ReportTreatment;
import com.sunrise.util.DBConnection;

public class ReportDAO {


    // =========================================================
    // MAIN REPORT
    // =========================================================

    public ReportStats getReportStats(
            String startDate,
            String endDate) {

        ReportStats stats =
                new ReportStats();


        // =====================================================
        // BILL COUNTS
        // =====================================================

        stats.setTotalBills(
                getCount(
                        "SELECT COUNT(*) " +
                        "FROM bills " +
                        "WHERE DATE(created_at) BETWEEN ? AND ?",
                        startDate,
                        endDate
                )
        );


        stats.setAppointmentBills(
                getCount(
                        "SELECT COUNT(*) " +
                        "FROM bills " +
                        "WHERE bill_type = 'APPOINTMENT' " +
                        "AND DATE(created_at) BETWEEN ? AND ?",
                        startDate,
                        endDate
                )
        );


        stats.setWalkInBills(
                getCount(
                        "SELECT COUNT(*) " +
                        "FROM bills " +
                        "WHERE bill_type = 'WALK_IN' " +
                        "AND DATE(created_at) BETWEEN ? AND ?",
                        startDate,
                        endDate
                )
        );


        // =====================================================
        // APPOINTMENTS
        // =====================================================

        stats.setTotalAppointments(
                getCount(
                        "SELECT COUNT(*) " +
                        "FROM appointments " +
                        "WHERE appointment_date BETWEEN ? AND ?",
                        startDate,
                        endDate
                )
        );


        stats.setScheduledAppointments(
                getAppointmentStatusCount(
                        "SCHEDULED",
                        startDate,
                        endDate
                )
        );


        stats.setCompletedAppointments(
                getAppointmentStatusCount(
                        "COMPLETED",
                        startDate,
                        endDate
                )
        );


        stats.setCancelledAppointments(
                getAppointmentStatusCount(
                        "CANCELLED",
                        startDate,
                        endDate
                )
        );


        stats.setNoShowAppointments(
                getAppointmentStatusCount(
                        "NO_SHOW",
                        startDate,
                        endDate
                )
        );


        stats.setBilledAppointments(
                getAppointmentStatusCount(
                        "BILLED",
                        startDate,
                        endDate
                )
        );


        // =====================================================
        // REVENUE
        // =====================================================

        stats.setTotalRevenue(
                getAmount(
                        "SELECT COALESCE(SUM(total_amount), 0) " +
                        "FROM bills " +
                        "WHERE DATE(created_at) BETWEEN ? AND ?",
                        startDate,
                        endDate
                )
        );


        stats.setAppointmentRevenue(
                getAmount(
                        "SELECT COALESCE(SUM(total_amount), 0) " +
                        "FROM bills " +
                        "WHERE bill_type = 'APPOINTMENT' " +
                        "AND DATE(created_at) BETWEEN ? AND ?",
                        startDate,
                        endDate
                )
        );


        stats.setWalkInRevenue(
                getAmount(
                        "SELECT COALESCE(SUM(total_amount), 0) " +
                        "FROM bills " +
                        "WHERE bill_type = 'WALK_IN' " +
                        "AND DATE(created_at) BETWEEN ? AND ?",
                        startDate,
                        endDate
                )
        );


        // =====================================================
        // DAILY REVENUE
        // =====================================================

        loadDailyRevenue(
                stats,
                startDate,
                endDate
        );


        // =====================================================
        // BILL DETAILS
        // =====================================================

        loadBills(
                stats,
                startDate,
                endDate
        );


        // =====================================================
        // APPOINTMENT DETAILS
        // =====================================================

        loadAppointments(
                stats,
                startDate,
                endDate
        );


        // =====================================================
        // TREATMENT REPORT
        // =====================================================

        loadTreatmentReport(
                stats,
                startDate,
                endDate
        );


        return stats;
    }


    // =========================================================
    // TREATMENT REPORT
    //
    // Counts treatments from BILLS.
    //
    // This includes:
    // 1. Appointment bills
    // 2. Walk-in bills
    //
    // The report is based on bill creation date.
    // =========================================================

    private void loadTreatmentReport(
            ReportStats stats,
            String startDate,
            String endDate) {

        List<ReportTreatment> treatments =
                new ArrayList<>();


        String sql =
                "SELECT " +
                "t.treatment_name, " +
                "COUNT(b.bill_id) AS completed_count " +

                "FROM bills b " +

                "INNER JOIN treatments t " +
                "ON b.treatment_id = t.treatment_id " +

                "WHERE DATE(b.created_at) BETWEEN ? AND ? " +

                "GROUP BY " +
                "t.treatment_id, " +
                "t.treatment_name " +

                "ORDER BY " +
                "completed_count DESC, " +
                "t.treatment_name ASC";


        try (
                Connection con =
                        DBConnection.getConnection();

                PreparedStatement ps =
                        con.prepareStatement(sql)
        ) {

            ps.setString(
                    1,
                    startDate
            );

            ps.setString(
                    2,
                    endDate
            );


            try (
                    ResultSet rs =
                            ps.executeQuery()
            ) {

                while (rs.next()) {

                    ReportTreatment treatment =
                            new ReportTreatment();


                    treatment.setTreatmentName(
                            rs.getString(
                                    "treatment_name"
                            )
                    );


                    treatment.setCompletedCount(
                            rs.getInt(
                                    "completed_count"
                            )
                    );


                    treatments.add(
                            treatment
                    );
                }
            }

        } catch (Exception e) {

            System.out.println(
                    "ERROR LOADING TREATMENT REPORT:"
            );

            e.printStackTrace();
        }


        stats.setTreatments(
                treatments
        );
    }


    // =========================================================
    // LOAD APPOINTMENTS
    // =========================================================

    private void loadAppointments(
            ReportStats stats,
            String startDate,
            String endDate) {

        List<ReportAppointment> appointments =
                new ArrayList<>();


        String sql =
                "SELECT " +
                "a.appointment_number, " +
                "a.appointment_date, " +
                "a.appointment_time, " +
                "a.status, " +
                "p.name AS patient_name, " +
                "d.dentist_name, " +
                "t.treatment_name " +
                "FROM appointments a " +
                "LEFT JOIN patients p " +
                "ON a.patient_id = p.patient_id " +
                "LEFT JOIN dentists d " +
                "ON a.dentist_id = d.dentist_id " +
                "LEFT JOIN treatments t " +
                "ON a.treatment_id = t.treatment_id " +
                "WHERE a.appointment_date BETWEEN ? AND ? " +
                "ORDER BY a.appointment_date ASC, " +
                "a.appointment_time ASC";


        try (
                Connection con =
                        DBConnection.getConnection();

                PreparedStatement ps =
                        con.prepareStatement(sql)
        ) {

            ps.setString(
                    1,
                    startDate
            );

            ps.setString(
                    2,
                    endDate
            );


            try (
                    ResultSet rs =
                            ps.executeQuery()
            ) {

                while (rs.next()) {

                    ReportAppointment appointment =
                            new ReportAppointment();


                    appointment.setAppointmentNumber(
                            rs.getString(
                                    "appointment_number"
                            )
                    );


                    if (
                            rs.getDate(
                                    "appointment_date"
                            ) != null
                    ) {

                        appointment.setAppointmentDate(
                                rs.getDate(
                                        "appointment_date"
                                ).toLocalDate()
                        );
                    }


                    if (
                            rs.getTime(
                                    "appointment_time"
                            ) != null
                    ) {

                        appointment.setAppointmentTime(
                                rs.getTime(
                                        "appointment_time"
                                ).toLocalTime()
                        );
                    }


                    appointment.setStatus(
                            rs.getString(
                                    "status"
                            )
                    );


                    appointment.setPatientName(
                            rs.getString(
                                    "patient_name"
                            )
                    );


                    appointment.setDentistName(
                            rs.getString(
                                    "dentist_name"
                            )
                    );


                    appointment.setTreatmentName(
                            rs.getString(
                                    "treatment_name"
                            )
                    );


                    appointments.add(
                            appointment
                    );
                }
            }

        } catch (Exception e) {

            System.out.println(
                    "ERROR LOADING APPOINTMENTS:"
            );

            e.printStackTrace();
        }


        stats.setAppointments(
                appointments
        );
    }


    // =========================================================
    // DAILY REVENUE
    // =========================================================

    private void loadDailyRevenue(
            ReportStats stats,
            String startDate,
            String endDate) {


        String sql =
                "SELECT " +
                "DATE(created_at) AS revenue_date, " +
                "COALESCE(SUM(total_amount), 0) AS revenue " +
                "FROM bills " +
                "WHERE DATE(created_at) BETWEEN ? AND ? " +
                "GROUP BY DATE(created_at) " +
                "ORDER BY DATE(created_at)";


        List<String> databaseDates =
                new ArrayList<>();


        List<Double> databaseValues =
                new ArrayList<>();


        try (
                Connection con =
                        DBConnection.getConnection();

                PreparedStatement ps =
                        con.prepareStatement(sql)
        ) {

            ps.setString(
                    1,
                    startDate
            );

            ps.setString(
                    2,
                    endDate
            );


            try (
                    ResultSet rs =
                            ps.executeQuery()
            ) {

                while (rs.next()) {

                    databaseDates.add(
                            rs.getString(
                                    "revenue_date"
                            )
                    );


                    databaseValues.add(
                            rs.getDouble(
                                    "revenue"
                            )
                    );
                }
            }

        } catch (Exception e) {

            System.out.println(
                    "ERROR LOADING DAILY REVENUE:"
            );

            e.printStackTrace();
        }


        // =====================================================
        // CREATE EVERY DATE
        // =====================================================

        List<String> completeDates =
                new ArrayList<>();


        List<Double> completeValues =
                new ArrayList<>();


        LocalDate start =
                LocalDate.parse(
                        startDate
                );


        LocalDate end =
                LocalDate.parse(
                        endDate
                );


        LocalDate current =
                start;


        while (!current.isAfter(end)) {

            String date =
                    current.toString();


            double revenue =
                    0.0;


            for (
                    int i = 0;
                    i < databaseDates.size();
                    i++
            ) {

                if (
                        databaseDates
                                .get(i)
                                .equals(date)
                ) {

                    revenue =
                            databaseValues.get(i);

                    break;
                }
            }


            completeDates.add(
                    date
            );


            completeValues.add(
                    revenue
            );


            current =
                    current.plusDays(1);
        }


        stats.setRevenueDates(
                completeDates
        );


        stats.setDailyRevenue(
                completeValues
        );
    }


    // =========================================================
    // LOAD BILLS
    // =========================================================

    private void loadBills(
            ReportStats stats,
            String startDate,
            String endDate) {

        List<ReportBill> bills =
                new ArrayList<>();


        String sql =
                "SELECT " +
                "b.bill_number, " +
                "b.created_at, " +
                "b.bill_type, " +
                "b.consultation_fee, " +
                "b.treatment_fee, " +
                "b.total_amount, " +
                "p.name AS patient_name, " +
                "t.treatment_name " +
                "FROM bills b " +
                "LEFT JOIN patients p " +
                "ON b.patient_id = p.patient_id " +
                "LEFT JOIN treatments t " +
                "ON b.treatment_id = t.treatment_id " +
                "WHERE DATE(b.created_at) BETWEEN ? AND ? " +
                "ORDER BY b.created_at DESC";


        try (
                Connection con =
                        DBConnection.getConnection();

                PreparedStatement ps =
                        con.prepareStatement(sql)
        ) {

            ps.setString(
                    1,
                    startDate
            );

            ps.setString(
                    2,
                    endDate
            );


            try (
                    ResultSet rs =
                            ps.executeQuery()
            ) {

                while (rs.next()) {

                    ReportBill bill =
                            new ReportBill();


                    bill.setBillNumber(
                            rs.getString(
                                    "bill_number"
                            )
                    );


                    bill.setCreatedAt(
                            rs.getTimestamp(
                                    "created_at"
                            )
                    );


                    bill.setBillType(
                            rs.getString(
                                    "bill_type"
                            )
                    );


                    bill.setPatientName(
                            rs.getString(
                                    "patient_name"
                            )
                    );


                    bill.setTreatmentName(
                            rs.getString(
                                    "treatment_name"
                            )
                    );


                    bill.setConsultationFee(
                            rs.getDouble(
                                    "consultation_fee"
                            )
                    );


                    bill.setTreatmentFee(
                            rs.getDouble(
                                    "treatment_fee"
                            )
                    );


                    bill.setTotalAmount(
                            rs.getDouble(
                                    "total_amount"
                            )
                    );


                    bills.add(
                            bill
                    );
                }
            }

        } catch (Exception e) {

            System.out.println(
                    "ERROR LOADING REPORT BILLS:"
            );

            e.printStackTrace();
        }


        stats.setBills(
                bills
        );
    }


    // =========================================================
    // COUNT
    // =========================================================

    private int getCount(
            String sql,
            String startDate,
            String endDate) {

        try (
                Connection con =
                        DBConnection.getConnection();

                PreparedStatement ps =
                        con.prepareStatement(sql)
        ) {

            ps.setString(
                    1,
                    startDate
            );

            ps.setString(
                    2,
                    endDate
            );


            try (
                    ResultSet rs =
                            ps.executeQuery()
            ) {

                if (rs.next()) {

                    return rs.getInt(1);
                }
            }

        } catch (Exception e) {

            System.out.println(
                    "ERROR REPORT COUNT:"
            );

            e.printStackTrace();
        }


        return 0;
    }


    // =========================================================
    // APPOINTMENT STATUS COUNT
    // =========================================================

    private int getAppointmentStatusCount(
            String status,
            String startDate,
            String endDate) {

        String sql =
                "SELECT COUNT(*) " +
                "FROM appointments " +
                "WHERE status = ? " +
                "AND appointment_date BETWEEN ? AND ?";


        try (
                Connection con =
                        DBConnection.getConnection();

                PreparedStatement ps =
                        con.prepareStatement(sql)
        ) {

            ps.setString(
                    1,
                    status
            );

            ps.setString(
                    2,
                    startDate
            );

            ps.setString(
                    3,
                    endDate
            );


            try (
                    ResultSet rs =
                            ps.executeQuery()
            ) {

                if (rs.next()) {

                    return rs.getInt(1);
                }
            }

        } catch (Exception e) {

            System.out.println(
                    "ERROR APPOINTMENT STATUS:"
            );

            e.printStackTrace();
        }


        return 0;
    }


    // =========================================================
    // AMOUNT
    // =========================================================

    private double getAmount(
            String sql,
            String startDate,
            String endDate) {

        try (
                Connection con =
                        DBConnection.getConnection();

                PreparedStatement ps =
                        con.prepareStatement(sql)
        ) {

            ps.setString(
                    1,
                    startDate
            );

            ps.setString(
                    2,
                    endDate
            );


            try (
                    ResultSet rs =
                            ps.executeQuery()
            ) {

                if (rs.next()) {

                    return rs.getDouble(1);
                }
            }

        } catch (Exception e) {

            System.out.println(
                    "ERROR REPORT AMOUNT:"
            );

            e.printStackTrace();
        }


        return 0.0;
    }
}