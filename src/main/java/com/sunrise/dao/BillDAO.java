package com.sunrise.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.sunrise.model.Bill;
import com.sunrise.util.DBConnection;

public class BillDAO {

    // =========================================================
    // ADD BILL
    // =========================================================

    public boolean addBill(Bill bill) {

        String sql =
                "INSERT INTO bills " +
                "(bill_number, appointment_id, consultation_fee, " +
                "treatment_fee, total_amount, created_by) " +
                "VALUES (?, ?, ?, ?, ?, ?)";

        try (
            Connection con = DBConnection.getConnection();
            PreparedStatement st = con.prepareStatement(sql)
        ) {

            st.setString(1, bill.getBillNumber());
            st.setInt(2, bill.getAppointmentId());
            st.setDouble(3, bill.getConsultationFee());
            st.setDouble(4, bill.getTreatmentFee());
            st.setDouble(5, bill.getTotalAmount());
            st.setInt(6, bill.getCreatedBy());

            return st.executeUpdate() > 0;

        } catch (Exception e) {

            System.out.println("ERROR ADDING BILL:");
            e.printStackTrace();
        }

        return false;
    }


    // =========================================================
    // GET NEXT BILL ID
    // =========================================================

    public int getNextBillId() {

        String sql =
                "SELECT AUTO_INCREMENT " +
                "FROM INFORMATION_SCHEMA.TABLES " +
                "WHERE TABLE_SCHEMA = DATABASE() " +
                "AND TABLE_NAME = 'bills'";

        try (
            Connection con = DBConnection.getConnection();
            PreparedStatement st = con.prepareStatement(sql);
            ResultSet rs = st.executeQuery()
        ) {

            if (rs.next()) {

                return rs.getInt("AUTO_INCREMENT");
            }

        } catch (Exception e) {

            System.out.println(
                    "ERROR GETTING NEXT BILL ID:"
            );

            e.printStackTrace();
        }

        return 0;
    }


    // =========================================================
    // GET ALL BILLS
    // =========================================================

    public List<Bill> getAllBills() {

        List<Bill> bills = new ArrayList<>();

        String sql =
                "SELECT * FROM bills " +
                "ORDER BY bill_id DESC";

        try (
            Connection con = DBConnection.getConnection();
            PreparedStatement st = con.prepareStatement(sql);
            ResultSet rs = st.executeQuery()
        ) {

            while (rs.next()) {

                bills.add(
                        mapResultSetToBill(rs)
                );
            }

        } catch (Exception e) {

            System.out.println(
                    "ERROR LOADING BILLS:"
            );

            e.printStackTrace();
        }

        return bills;
    }


    // =========================================================
    // GET BILL BY ID
    // =========================================================

    public Bill getBillById(int billId) {

        String sql =
                "SELECT * FROM bills " +
                "WHERE bill_id = ?";

        try (
            Connection con = DBConnection.getConnection();
            PreparedStatement st = con.prepareStatement(sql)
        ) {

            st.setInt(1, billId);

            try (ResultSet rs = st.executeQuery()) {

                if (rs.next()) {

                    return mapResultSetToBill(rs);
                }
            }

        } catch (Exception e) {

            System.out.println(
                    "ERROR FINDING BILL:"
            );

            e.printStackTrace();
        }

        return null;
    }


    // =========================================================
    // GET BILL BY APPOINTMENT
    // =========================================================

    public Bill getBillByAppointmentId(
            int appointmentId) {

        String sql =
                "SELECT * FROM bills " +
                "WHERE appointment_id = ?";

        try (
            Connection con = DBConnection.getConnection();
            PreparedStatement st = con.prepareStatement(sql)
        ) {

            st.setInt(1, appointmentId);

            try (ResultSet rs = st.executeQuery()) {

                if (rs.next()) {

                    return mapResultSetToBill(rs);
                }
            }

        } catch (Exception e) {

            System.out.println(
                    "ERROR FINDING BILL FOR APPOINTMENT:"
            );

            e.printStackTrace();
        }

        return null;
    }


    // =========================================================
    // CHECK BILL NUMBER
    // =========================================================

    public boolean billNumberExists(
            String billNumber) {

        String sql =
                "SELECT COUNT(*) " +
                "FROM bills " +
                "WHERE bill_number = ?";

        try (
            Connection con = DBConnection.getConnection();
            PreparedStatement st = con.prepareStatement(sql)
        ) {

            st.setString(1, billNumber);

            try (ResultSet rs = st.executeQuery()) {

                if (rs.next()) {

                    return rs.getInt(1) > 0;
                }
            }

        } catch (Exception e) {

            System.out.println(
                    "ERROR CHECKING BILL NUMBER:"
            );

            e.printStackTrace();
        }

        return false;
    }


    // =========================================================
    // CHECK APPOINTMENT ALREADY BILLED
    // =========================================================

    public boolean appointmentAlreadyBilled(
            int appointmentId) {

        String sql =
                "SELECT COUNT(*) " +
                "FROM bills " +
                "WHERE appointment_id = ?";

        try (
            Connection con = DBConnection.getConnection();
            PreparedStatement st = con.prepareStatement(sql)
        ) {

            st.setInt(1, appointmentId);

            try (ResultSet rs = st.executeQuery()) {

                if (rs.next()) {

                    return rs.getInt(1) > 0;
                }
            }

        } catch (Exception e) {

            System.out.println(
                    "ERROR CHECKING APPOINTMENT BILL:"
            );

            e.printStackTrace();
        }

        return false;
    }


    // =========================================================
    // SEARCH BILLS
    // =========================================================

    public List<Bill> searchBills(
            String keyword) {

        List<Bill> bills = new ArrayList<>();

        String sql =
                "SELECT b.* " +
                "FROM bills b " +
                "INNER JOIN appointments a " +
                "ON b.appointment_id = a.appointment_id " +
                "INNER JOIN patients p " +
                "ON a.patient_id = p.patient_id " +
                "WHERE b.bill_number LIKE ? " +
                "OR a.appointment_number LIKE ? " +
                "OR p.patient_code LIKE ? " +
                "OR p.name LIKE ? " +
                "ORDER BY b.bill_id DESC";

        try (
            Connection con = DBConnection.getConnection();
            PreparedStatement st = con.prepareStatement(sql)
        ) {

            String value =
                    "%" + keyword + "%";

            st.setString(1, value);
            st.setString(2, value);
            st.setString(3, value);
            st.setString(4, value);

            try (ResultSet rs = st.executeQuery()) {

                while (rs.next()) {

                    bills.add(
                            mapResultSetToBill(rs)
                    );
                }
            }

        } catch (Exception e) {

            System.out.println(
                    "ERROR SEARCHING BILLS:"
            );

            e.printStackTrace();
        }

        return bills;
    }


    // =========================================================
    // GET BILLS BY PATIENT
    // =========================================================

    public List<Bill> getBillsByPatient(
            int patientId) {

        List<Bill> bills = new ArrayList<>();

        String sql =
                "SELECT b.* " +
                "FROM bills b " +
                "INNER JOIN appointments a " +
                "ON b.appointment_id = a.appointment_id " +
                "WHERE a.patient_id = ? " +
                "ORDER BY b.bill_id DESC";

        try (
            Connection con = DBConnection.getConnection();
            PreparedStatement st = con.prepareStatement(sql)
        ) {

            st.setInt(1, patientId);

            try (ResultSet rs = st.executeQuery()) {

                while (rs.next()) {

                    bills.add(
                            mapResultSetToBill(rs)
                    );
                }
            }

        } catch (Exception e) {

            System.out.println(
                    "ERROR LOADING PATIENT BILLS:"
            );

            e.printStackTrace();
        }

        return bills;
    }


    // =========================================================
    // GET BILL COUNT
    // =========================================================

    public int getBillCount() {

        String sql =
                "SELECT COUNT(*) FROM bills";

        try (
            Connection con = DBConnection.getConnection();
            PreparedStatement st = con.prepareStatement(sql);
            ResultSet rs = st.executeQuery()
        ) {

            if (rs.next()) {

                return rs.getInt(1);
            }

        } catch (Exception e) {

            System.out.println(
                    "ERROR GETTING BILL COUNT:"
            );

            e.printStackTrace();
        }

        return 0;
    }


    // =========================================================
    // MAP RESULT SET TO BILL
    // =========================================================

    private Bill mapResultSetToBill(
            ResultSet rs) throws Exception {

        Bill bill = new Bill();

        bill.setBillId(
                rs.getInt("bill_id")
        );

        bill.setBillNumber(
                rs.getString("bill_number")
        );

        bill.setAppointmentId(
                rs.getInt("appointment_id")
        );

        bill.setConsultationFee(
                rs.getDouble("consultation_fee")
        );

        bill.setTreatmentFee(
                rs.getDouble("treatment_fee")
        );

        bill.setTotalAmount(
                rs.getDouble("total_amount")
        );

        bill.setCreatedBy(
                rs.getInt("created_by")
        );

        bill.setCreatedAt(
                rs.getTimestamp("created_at")
        );

        return bill;
    }
}