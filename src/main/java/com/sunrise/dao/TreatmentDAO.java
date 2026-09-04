package com.sunrise.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import com.sunrise.model.Treatment;
import com.sunrise.util.DBConnection;

public class TreatmentDAO {

    // =========================================================
    // ADD TREATMENT
    // =========================================================

	public boolean addTreatment(Treatment treatment) {

	    String sql = "INSERT INTO treatments "
	            + "(treatment_name, description, treatment_fee, active) "
	            + "VALUES (?, ?, ?, ?)";

	    try (Connection con = DBConnection.getConnection();
	         PreparedStatement st = con.prepareStatement(
	                 sql, Statement.RETURN_GENERATED_KEYS)) {

	        st.setString(1, treatment.getTreatmentName());
	        st.setString(2, treatment.getDescription());
	        st.setDouble(3, treatment.getTreatmentFee());
	        st.setBoolean(4, treatment.isActive());

	        int rows = st.executeUpdate();

	        if (rows > 0) {

	            try (ResultSet rs = st.getGeneratedKeys()) {
	                if (rs.next()) {
	                    treatment.setTreatmentId(rs.getInt(1));
	                }
	            }

	            return true;
	        }

	    } catch (ClassNotFoundException | SQLException e) {
	        e.printStackTrace();
	    }

	    return false;
	}


    // =========================================================
    // GET ALL TREATMENTS
    // =========================================================

    public List<Treatment> getAllTreatments() {

        List<Treatment> treatments = new ArrayList<>();

        String sql =
                "SELECT * FROM treatments " +
                "ORDER BY treatment_id DESC";

        try (
            Connection con = DBConnection.getConnection();
            PreparedStatement st = con.prepareStatement(sql);
            ResultSet rs = st.executeQuery()
        ) {

            while (rs.next()) {

                treatments.add(
                    mapResultSetToTreatment(rs)
                );
            }

        } catch (Exception e) {

            System.out.println("ERROR LOADING TREATMENTS:");
            e.printStackTrace();
        }

        return treatments;
    }


    // =========================================================
    // GET TREATMENT BY ID
    // =========================================================

    public Treatment getTreatmentById(int treatmentId) {

        String sql =
                "SELECT * FROM treatments " +
                "WHERE treatment_id = ?";

        try (
            Connection con = DBConnection.getConnection();
            PreparedStatement st = con.prepareStatement(sql)
        ) {

            st.setInt(1, treatmentId);

            try (ResultSet rs = st.executeQuery()) {

                if (rs.next()) {

                    return mapResultSetToTreatment(rs);
                }
            }

        } catch (Exception e) {

            System.out.println("ERROR FINDING TREATMENT:");
            e.printStackTrace();
        }

        return null;
    }


    // =========================================================
    // UPDATE TREATMENT
    // =========================================================

    public boolean updateTreatment(Treatment treatment) {

        String sql =
                "UPDATE treatments SET " +
                "treatment_name = ?, " +
                "description = ?, " +
                "treatment_fee = ?, " +
                "active = ? " +
                "WHERE treatment_id = ?";

        try (
            Connection con = DBConnection.getConnection();
            PreparedStatement st = con.prepareStatement(sql)
        ) {

            st.setString(1, treatment.getTreatmentName());
            st.setString(2, treatment.getDescription());
            st.setDouble(3, treatment.getTreatmentFee());
            st.setBoolean(4, treatment.isActive());
            st.setInt(5, treatment.getTreatmentId());

            return st.executeUpdate() > 0;

        } catch (Exception e) {

            System.out.println("ERROR UPDATING TREATMENT:");
            e.printStackTrace();
        }

        return false;
    }


    // =========================================================
    // SEARCH TREATMENTS
    // =========================================================

    public List<Treatment> searchTreatments(String keyword) {

        List<Treatment> treatments = new ArrayList<>();

        String sql =
                "SELECT * FROM treatments " +
                "WHERE treatment_name LIKE ? " +
                "OR description LIKE ? " +
                "ORDER BY treatment_id DESC";

        try (
            Connection con = DBConnection.getConnection();
            PreparedStatement st = con.prepareStatement(sql)
        ) {

            String value = "%" + keyword + "%";

            st.setString(1, value);
            st.setString(2, value);

            try (ResultSet rs = st.executeQuery()) {

                while (rs.next()) {

                    treatments.add(
                        mapResultSetToTreatment(rs)
                    );
                }
            }

        } catch (Exception e) {

            System.out.println("ERROR SEARCHING TREATMENTS:");
            e.printStackTrace();
        }

        return treatments;
    }


    // =========================================================
    // GET ACTIVE TREATMENTS
    // =========================================================

    public List<Treatment> getActiveTreatments() {

        List<Treatment> treatments = new ArrayList<>();

        String sql =
                "SELECT * FROM treatments " +
                "WHERE active = true " +
                "ORDER BY treatment_name";

        try (
            Connection con = DBConnection.getConnection();
            PreparedStatement st = con.prepareStatement(sql);
            ResultSet rs = st.executeQuery()
        ) {

            while (rs.next()) {

                treatments.add(
                    mapResultSetToTreatment(rs)
                );
            }

        } catch (Exception e) {

            System.out.println("ERROR LOADING ACTIVE TREATMENTS:");
            e.printStackTrace();
        }

        return treatments;
    }


    // =========================================================
    // MAP RESULT SET
    // =========================================================

    private Treatment mapResultSetToTreatment(
            ResultSet rs) throws Exception {

        Treatment treatment = new Treatment();

        treatment.setTreatmentId(
                rs.getInt("treatment_id")
        );

        treatment.setTreatmentName(
                rs.getString("treatment_name")
        );

        treatment.setDescription(
                rs.getString("description")
        );

        treatment.setTreatmentFee(
                rs.getDouble("treatment_fee")
        );

        treatment.setActive(
                rs.getBoolean("active")
        );

        return treatment;
    }
}