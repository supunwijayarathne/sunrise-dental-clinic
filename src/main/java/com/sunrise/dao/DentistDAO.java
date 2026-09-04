package com.sunrise.dao;

import java.sql.Connection;
import java.sql.Statement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.sunrise.model.Dentist;
import com.sunrise.util.DBConnection;

public class DentistDAO {

    // ADD DENTIST
	public boolean addDentist(Dentist dentist) {

	    String sql = "INSERT INTO dentists "
	            + "(dentist_name, specialization, consultation_fee, phone_number, email, active) "
	            + "VALUES (?, ?, ?, ?, ?, ?)";

	    try (Connection con = DBConnection.getConnection();
	         PreparedStatement st = con.prepareStatement(
	                 sql, Statement.RETURN_GENERATED_KEYS)) {

	        st.setString(1, dentist.getDentistName());
	        st.setString(2, dentist.getSpecialization());
	        st.setDouble(3, dentist.getConsultationFee());
	        st.setString(4, dentist.getPhoneNumber());
	        st.setString(5, dentist.getEmail());
	        st.setBoolean(6, dentist.isActive());

	        int rows = st.executeUpdate();

	        if (rows > 0) {

	            try (ResultSet rs = st.getGeneratedKeys()) {
	                if (rs.next()) {
	                    dentist.setDentistId(rs.getInt(1));
	                }
	            }

	            return true;
	        }

	    } catch (ClassNotFoundException | SQLException e) {
	        e.printStackTrace();
	    }

	    return false;
	}


    // GET ALL DENTISTS
    public List<Dentist> getAllDentists() {

        List<Dentist> dentists = new ArrayList<>();

        String sql =
                "SELECT * FROM dentists " +
                "ORDER BY dentist_id DESC";

        try (
            Connection con = DBConnection.getConnection();
            PreparedStatement st = con.prepareStatement(sql);
            ResultSet rs = st.executeQuery()
        ) {

            while (rs.next()) {

                dentists.add(
                    mapResultSetToDentist(rs)
                );
            }

        } catch (Exception e) {

            System.out.println("ERROR LOADING DENTISTS:");
            e.printStackTrace();
        }

        return dentists;
    }


    // GET DENTIST BY ID
    public Dentist getDentistById(int dentistId) {

        String sql =
                "SELECT * FROM dentists " +
                "WHERE dentist_id = ?";

        try (
            Connection con = DBConnection.getConnection();
            PreparedStatement st = con.prepareStatement(sql)
        ) {

            st.setInt(1, dentistId);

            try (ResultSet rs = st.executeQuery()) {

                if (rs.next()) {

                    return mapResultSetToDentist(rs);
                }
            }

        } catch (Exception e) {

            System.out.println("ERROR FINDING DENTIST:");
            e.printStackTrace();
        }

        return null;
    }


    // UPDATE DENTIST
    public boolean updateDentist(Dentist dentist) {

        String sql =
                "UPDATE dentists SET " +
                "dentist_name = ?, " +
                "specialization = ?, " +
                "consultation_fee = ?, " +
                "phone_number = ?, " +
                "email = ?, " +
                "active = ? " +
                "WHERE dentist_id = ?";

        try (
            Connection con = DBConnection.getConnection();
            PreparedStatement st = con.prepareStatement(sql)
        ) {

            st.setString(1, dentist.getDentistName());
            st.setString(2, dentist.getSpecialization());
            st.setDouble(3, dentist.getConsultationFee());
            st.setString(4, dentist.getPhoneNumber());
            st.setString(5, dentist.getEmail());
            st.setBoolean(6, dentist.isActive());
            st.setInt(7, dentist.getDentistId());

            return st.executeUpdate() > 0;

        } catch (Exception e) {

            System.out.println("ERROR UPDATING DENTIST:");
            e.printStackTrace();
        }

        return false;
    }


    // SEARCH DENTISTS
    public List<Dentist> searchDentists(String keyword) {

        List<Dentist> dentists = new ArrayList<>();

        String sql =
                "SELECT * FROM dentists " +
                "WHERE dentist_name LIKE ? " +
                "OR specialization LIKE ? " +
                "OR dentist_id LIKE ? " +
                "OR email LIKE ? " +
                "ORDER BY dentist_id DESC";

        try (
            Connection con = DBConnection.getConnection();
            PreparedStatement st = con.prepareStatement(sql)
        ) {

            String value = "%" + keyword + "%";

            st.setString(1, value);
            st.setString(2, value);
            st.setString(3, value);
            st.setString(4, value);

            try (ResultSet rs = st.executeQuery()) {

                while (rs.next()) {

                    dentists.add(
                        mapResultSetToDentist(rs)
                    );
                }
            }

        } catch (Exception e) {

            System.out.println("ERROR SEARCHING DENTISTS:");
            e.printStackTrace();
        }

        return dentists;
    }


    // GET ACTIVE DENTISTS
    public List<Dentist> getActiveDentists() {

        List<Dentist> dentists = new ArrayList<>();

        String sql =
                "SELECT * FROM dentists " +
                "WHERE active = true " +
                "ORDER BY dentist_name";

        try (
            Connection con = DBConnection.getConnection();
            PreparedStatement st = con.prepareStatement(sql);
            ResultSet rs = st.executeQuery()
        ) {

            while (rs.next()) {

                dentists.add(
                    mapResultSetToDentist(rs)
                );
            }

        } catch (Exception e) {

            System.out.println("ERROR LOADING ACTIVE DENTISTS:");
            e.printStackTrace();
        }

        return dentists;
    }


    // MAP RESULT SET TO OBJECT
    private Dentist mapResultSetToDentist(
            ResultSet rs) throws Exception {

        Dentist dentist = new Dentist();

        dentist.setDentistId(
                rs.getInt("dentist_id")
        );

        dentist.setDentistName(
                rs.getString("dentist_name")
        );

        dentist.setSpecialization(
                rs.getString("specialization")
        );

        dentist.setConsultationFee(
                rs.getDouble("consultation_fee")
        );

        dentist.setPhoneNumber(
                rs.getString("phone_number")
        );

        dentist.setEmail(
                rs.getString("email")
        );

        dentist.setActive(
                rs.getBoolean("active")
        );

        return dentist;
    }
}