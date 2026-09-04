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
    //
    // APPOINTMENT BILL:
    // 1. Insert bill
    // 2. Change appointment status to COMPLETED
    // 3. Commit both together
    //
    // WALK-IN BILL:
    // Only insert the bill.
    // =========================================================

    public boolean addBill(Bill bill) {

        String insertSql =
                "INSERT INTO bills " +
                "(bill_number, appointment_id, patient_id, treatment_id, " +
                "bill_type, consultation_fee, treatment_fee, " +
                "total_amount, created_by) " +
                "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";


        String updateAppointmentSql =
                "UPDATE appointments " +
                "SET status = 'COMPLETED' " +
                "WHERE appointment_id = ? " +
                "AND status NOT IN ('CANCELLED', 'NO_SHOW')";


        Connection con = null;


        try {

            con = DBConnection.getConnection();

            // Start transaction
            con.setAutoCommit(false);


            // =================================================
            // INSERT BILL
            // =================================================

            try (PreparedStatement st =
                    con.prepareStatement(
                            insertSql,
                            java.sql.Statement.RETURN_GENERATED_KEYS
                    )) {


                // 1. BILL NUMBER

                st.setString(
                        1,
                        bill.getBillNumber()
                );


                // 2. APPOINTMENT ID

                if (bill.getAppointmentId() == null) {

                    st.setNull(
                            2,
                            java.sql.Types.INTEGER
                    );

                } else {

                    st.setInt(
                            2,
                            bill.getAppointmentId()
                    );
                }


                // 3. PATIENT ID

                st.setInt(
                        3,
                        bill.getPatientId()
                );


                // 4. TREATMENT ID

                if (bill.getTreatmentId() == null) {

                    st.setNull(
                            4,
                            java.sql.Types.INTEGER
                    );

                } else {

                    st.setInt(
                            4,
                            bill.getTreatmentId()
                    );
                }


                // 5. BILL TYPE

                st.setString(
                        5,
                        bill.getBillType()
                );


                // 6. CONSULTATION FEE

                st.setDouble(
                        6,
                        bill.getConsultationFee()
                );


                // 7. TREATMENT FEE

                st.setDouble(
                        7,
                        bill.getTreatmentFee()
                );


                // 8. TOTAL AMOUNT

                st.setDouble(
                        8,
                        bill.getTotalAmount()
                );


                // 9. CREATED BY

                st.setInt(
                        9,
                        bill.getCreatedBy()
                );


                int billRows =
                        st.executeUpdate();

                if (billRows <= 0) {

                    con.rollback();

                    return false;
                }

                // Get the generated bill ID
                try (ResultSet rs = st.getGeneratedKeys()) {

                    if (rs.next()) {

                        bill.setBillId(
                                rs.getInt(1)
                        );
                    }
                }
            }


            // =================================================
            // UPDATE APPOINTMENT STATUS
            //
            // Only appointment bills have appointmentId.
            // Walk-in bills skip this section.
            // =================================================

            if (bill.getAppointmentId() != null) {

                try (PreparedStatement st =
                        con.prepareStatement(
                                updateAppointmentSql
                        )) {


                    st.setInt(
                            1,
                            bill.getAppointmentId()
                    );


                    int appointmentRows =
                            st.executeUpdate();


                    // -----------------------------------------
                    // Appointment must be updated successfully
                    // -----------------------------------------

                    if (appointmentRows <= 0) {

                        System.out.println(
                                "ERROR: BILL CREATED BUT " +
                                "APPOINTMENT STATUS COULD NOT BE UPDATED."
                        );


                        con.rollback();

                        return false;
                    }
                }
            }


            // =================================================
            // EVERYTHING SUCCESSFUL
            // =================================================

            con.commit();

            return true;


        } catch (Exception e) {

            System.out.println(
                    "ERROR ADDING BILL:"
            );

            e.printStackTrace();


            // =================================================
            // ROLLBACK
            // =================================================

            if (con != null) {

                try {

                    con.rollback();

                } catch (Exception rollbackException) {

                    System.out.println(
                            "ERROR ROLLING BACK BILL TRANSACTION:"
                    );

                    rollbackException.printStackTrace();
                }
            }

        } finally {

            // =================================================
            // CLOSE CONNECTION
            // =================================================

            if (con != null) {

                try {

                    con.setAutoCommit(true);

                    con.close();

                } catch (Exception closeException) {

                    System.out.println(
                            "ERROR CLOSING BILL CONNECTION:"
                    );

                    closeException.printStackTrace();
                }
            }
        }


        return false;
    }


    // =========================================================
    // GET NEXT BILL ID
    // =========================================================

    public int getNextBillId() {

        String sql =
                "SELECT COALESCE(MAX(bill_id), 0) + 1 AS next_id " +
                "FROM bills";

        try (
            Connection con = DBConnection.getConnection();
            PreparedStatement st =
                    con.prepareStatement(sql);
            ResultSet rs =
                    st.executeQuery()
        ) {

            if (rs.next()) {

                return rs.getInt(
                        "next_id"
                );
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

        List<Bill> bills =
                new ArrayList<>();


        String sql =
                "SELECT * FROM bills " +
                "ORDER BY bill_id DESC";


        try (
            Connection con = DBConnection.getConnection();
            PreparedStatement st =
                    con.prepareStatement(sql);
            ResultSet rs =
                    st.executeQuery()
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
            PreparedStatement st =
                    con.prepareStatement(sql)
        ) {

            st.setInt(
                    1,
                    billId
            );


            try (ResultSet rs =
                    st.executeQuery()) {

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
            PreparedStatement st =
                    con.prepareStatement(sql)
        ) {

            st.setInt(
                    1,
                    appointmentId
            );


            try (ResultSet rs =
                    st.executeQuery()) {

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
    // CHECK APPOINTMENT ALREADY BILLED
    // =========================================================

    public boolean appointmentAlreadyBilled(
            int appointmentId) {

        String sql =
                "SELECT bill_id " +
                "FROM bills " +
                "WHERE appointment_id = ?";


        try (
            Connection con = DBConnection.getConnection();
            PreparedStatement st =
                    con.prepareStatement(sql)
        ) {

            st.setInt(
                    1,
                    appointmentId
            );


            try (ResultSet rs =
                    st.executeQuery()) {

                return rs.next();
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
            PreparedStatement st =
                    con.prepareStatement(sql)
        ) {

            st.setString(
                    1,
                    billNumber
            );


            try (ResultSet rs =
                    st.executeQuery()) {

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
    // SEARCH BILLS
    // =========================================================

    public List<Bill> searchBills(
            String keyword,
            String billType) {

        List<Bill> bills =
                new ArrayList<>();


        StringBuilder sql =
                new StringBuilder(

                        "SELECT b.* " +
                        "FROM bills b " +

                        "LEFT JOIN patients p " +
                        "ON b.patient_id = p.patient_id " +

                        "LEFT JOIN appointments a " +
                        "ON b.appointment_id = a.appointment_id " +

                        "WHERE (" +

                        "b.bill_number LIKE ? " +
                        "OR p.patient_code LIKE ? " +
                        "OR p.name LIKE ? " +
                        "OR a.appointment_number LIKE ?" +

                        ")"
                );


        if (billType != null
                && !billType.trim().isEmpty()
                && !"ALL".equalsIgnoreCase(
                        billType
                )) {

            sql.append(
                    " AND b.bill_type = ?"
            );
        }


        sql.append(
                " ORDER BY b.bill_id DESC"
        );


        try (
            Connection con = DBConnection.getConnection();
            PreparedStatement st =
                    con.prepareStatement(
                            sql.toString()
                    )
        ) {

            String value =
                    "%" + keyword + "%";


            st.setString(
                    1,
                    value
            );

            st.setString(
                    2,
                    value
            );

            st.setString(
                    3,
                    value
            );

            st.setString(
                    4,
                    value
            );


            if (billType != null
                    && !billType.trim().isEmpty()
                    && !"ALL".equalsIgnoreCase(
                            billType
                    )) {

                st.setString(
                        5,
                        billType
                );
            }


            try (ResultSet rs =
                    st.executeQuery()) {

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

        List<Bill> bills =
                new ArrayList<>();


        String sql =
                "SELECT * FROM bills " +
                "WHERE patient_id = ? " +
                "ORDER BY bill_id DESC";


        try (
            Connection con = DBConnection.getConnection();
            PreparedStatement st =
                    con.prepareStatement(sql)
        ) {

            st.setInt(
                    1,
                    patientId
            );


            try (ResultSet rs =
                    st.executeQuery()) {

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
            PreparedStatement st =
                    con.prepareStatement(sql);
            ResultSet rs =
                    st.executeQuery()
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

        Bill bill =
                new Bill();


        // -----------------------------------------------------
        // BILL ID
        // -----------------------------------------------------

        bill.setBillId(
                rs.getInt("bill_id")
        );


        // -----------------------------------------------------
        // BILL NUMBER
        // -----------------------------------------------------

        bill.setBillNumber(
                rs.getString("bill_number")
        );


        // -----------------------------------------------------
        // APPOINTMENT ID
        // Can be NULL for WALK_IN bills
        // -----------------------------------------------------

        int appointmentId =
                rs.getInt(
                        "appointment_id"
                );


        if (rs.wasNull()) {

            bill.setAppointmentId(
                    null
            );

        } else {

            bill.setAppointmentId(
                    appointmentId
            );
        }


        // -----------------------------------------------------
        // PATIENT ID
        // -----------------------------------------------------

        bill.setPatientId(
                rs.getInt("patient_id")
        );


        // -----------------------------------------------------
        // TREATMENT ID
        // Can be NULL
        // -----------------------------------------------------

        int treatmentId =
                rs.getInt(
                        "treatment_id"
                );


        if (rs.wasNull()) {

            bill.setTreatmentId(
                    null
            );

        } else {

            bill.setTreatmentId(
                    treatmentId
            );
        }


        // -----------------------------------------------------
        // BILL TYPE
        // -----------------------------------------------------

        bill.setBillType(
                rs.getString("bill_type")
        );


        // -----------------------------------------------------
        // CONSULTATION FEE
        // -----------------------------------------------------

        bill.setConsultationFee(
                rs.getDouble(
                        "consultation_fee"
                )
        );


        // -----------------------------------------------------
        // TREATMENT FEE
        // -----------------------------------------------------

        bill.setTreatmentFee(
                rs.getDouble(
                        "treatment_fee"
                )
        );


        // -----------------------------------------------------
        // TOTAL AMOUNT
        // -----------------------------------------------------

        bill.setTotalAmount(
                rs.getDouble(
                        "total_amount"
                )
        );


        // -----------------------------------------------------
        // CREATED BY
        // -----------------------------------------------------

        bill.setCreatedBy(
                rs.getInt(
                        "created_by"
                )
        );


        // -----------------------------------------------------
        // CREATED AT
        // -----------------------------------------------------

        bill.setCreatedAt(
                rs.getTimestamp(
                        "created_at"
                )
        );


        return bill;
    }
}