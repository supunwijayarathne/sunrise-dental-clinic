package com.sunrise.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

import com.sunrise.model.Patient;
import com.sunrise.util.DBConnection;

public class PatientDAO {

    // =========================================================
    // CREATE - Add new patient
    // =========================================================

	// =========================================================
	// CREATE - Add new patient
	// =========================================================

	public boolean addPatient(Patient patient) {

	    String sql = "INSERT INTO patients "
	               + "(patient_code, name, address, contact_number, email) "
	               + "VALUES (?, ?, ?, ?, ?)";

	    try (
	        Connection con = DBConnection.getConnection();
	        PreparedStatement st = con.prepareStatement(
	            sql,
	            java.sql.Statement.RETURN_GENERATED_KEYS
	        )
	    ) {

	        st.setString(1, patient.getPatientCode());
	        st.setString(2, patient.getName());
	        st.setString(3, patient.getAddress());
	        st.setString(4, patient.getContactNumber());
	        st.setString(5, patient.getEmail());

	        int rows = st.executeUpdate();

	        if (rows > 0) {

	            try (ResultSet rs = st.getGeneratedKeys()) {

	                if (rs.next()) {
	                    patient.setPatientId(rs.getInt(1));
	                }
	            }

	            return true;
	        }

	    } catch (Exception e) {

	        System.out.println("ERROR ADDING PATIENT:");
	        e.printStackTrace();
	    }

	    return false;
	}


    // =========================================================
    // READ - Get all patients
    // =========================================================

    public List<Patient> getAllPatients() {

        List<Patient> patients = new ArrayList<>();

        String sql =
            "SELECT * FROM patients ORDER BY patient_id DESC";

        try (
            Connection con = DBConnection.getConnection();
            PreparedStatement st = con.prepareStatement(sql);
            ResultSet rs = st.executeQuery()
        ) {

            while (rs.next()) {

                Patient patient = new Patient();

                patient.setPatientId(
                    rs.getInt("patient_id")
                );

                patient.setPatientCode(
                    rs.getString("patient_code")
                );

                patient.setName(
                    rs.getString("name")
                );

                patient.setAddress(
                    rs.getString("address")
                );

                patient.setContactNumber(
                    rs.getString("contact_number")
                );

                patient.setEmail(
                    rs.getString("email")
                );

                Timestamp createdAt =
                    rs.getTimestamp("created_at");

                if (createdAt != null) {

                    patient.setCreatedAt(
                        createdAt.toLocalDateTime()
                    );
                }

                patients.add(patient);
            }

        } catch (Exception e) {

            System.out.println("ERROR LOADING PATIENTS:");
            e.printStackTrace();
        }

        return patients;
    }


    // =========================================================
    // READ - Get patient by ID
    // =========================================================

    public Patient getPatientById(int patientId) {

        Patient patient = null;

        String sql =
            "SELECT * FROM patients WHERE patient_id = ?";

        try (
            Connection con = DBConnection.getConnection();
            PreparedStatement st = con.prepareStatement(sql)
        ) {

            st.setInt(1, patientId);

            try (ResultSet rs = st.executeQuery()) {

                if (rs.next()) {

                    patient = new Patient();

                    patient.setPatientId(
                        rs.getInt("patient_id")
                    );

                    patient.setPatientCode(
                        rs.getString("patient_code")
                    );

                    patient.setName(
                        rs.getString("name")
                    );

                    patient.setAddress(
                        rs.getString("address")
                    );

                    patient.setContactNumber(
                        rs.getString("contact_number")
                    );

                    patient.setEmail(
                        rs.getString("email")
                    );

                    Timestamp createdAt =
                        rs.getTimestamp("created_at");

                    if (createdAt != null) {

                        patient.setCreatedAt(
                            createdAt.toLocalDateTime()
                        );
                    }
                }
            }

        } catch (Exception e) {

            System.out.println("ERROR FINDING PATIENT:");
            e.printStackTrace();
        }

        return patient;
    }


    // =========================================================
    // UPDATE - Update patient
    // =========================================================

    public boolean updatePatient(Patient patient) {

        String sql =
            "UPDATE patients SET "
          + "name = ?, "
          + "address = ?, "
          + "contact_number = ?, "
          + "email = ? "
          + "WHERE patient_id = ?";

        try (
            Connection con = DBConnection.getConnection();
            PreparedStatement st = con.prepareStatement(sql)
        ) {

            st.setString(1, patient.getName());
            st.setString(2, patient.getAddress());
            st.setString(3, patient.getContactNumber());
            st.setString(4, patient.getEmail());
            st.setInt(5, patient.getPatientId());

            int rows = st.executeUpdate();

            return rows > 0;

        } catch (Exception e) {

            System.out.println("ERROR UPDATING PATIENT:");
            e.printStackTrace();
        }

        return false;
    }
 // =========================================================
 // SEARCH - Search patients
 // =========================================================

 public List<Patient> searchPatients(String keyword) {

     List<Patient> patients = new ArrayList<>();

     String sql =
         "SELECT * FROM patients "
       + "WHERE patient_id LIKE ? "
       + "OR patient_code LIKE ? "
       + "OR name LIKE ? "
       + "ORDER BY patient_id DESC";

     try (
         Connection con = DBConnection.getConnection();
         PreparedStatement st = con.prepareStatement(sql)
     ) {

         String searchValue = "%" + keyword + "%";

         st.setString(1, searchValue);
         st.setString(2, searchValue);
         st.setString(3, searchValue);

         try (ResultSet rs = st.executeQuery()) {

             while (rs.next()) {

                 Patient patient = new Patient();

                 patient.setPatientId(
                     rs.getInt("patient_id")
                 );

                 patient.setPatientCode(
                     rs.getString("patient_code")
                 );

                 patient.setName(
                     rs.getString("name")
                 );

                 patient.setAddress(
                     rs.getString("address")
                 );

                 patient.setContactNumber(
                     rs.getString("contact_number")
                 );

                 patient.setEmail(
                     rs.getString("email")
                 );

                 Timestamp createdAt =
                     rs.getTimestamp("created_at");

                 if (createdAt != null) {

                     patient.setCreatedAt(
                         createdAt.toLocalDateTime()
                     );
                 }

                 patients.add(patient);
             }
         }

     } catch (Exception e) {

         System.out.println("ERROR SEARCHING PATIENTS:");
         e.printStackTrace();
     }

     return patients;
 }
}