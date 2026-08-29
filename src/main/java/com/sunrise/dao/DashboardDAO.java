package com.sunrise.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import com.sunrise.model.DashboardStats;
import com.sunrise.util.DBConnection;

public class DashboardDAO {

    public DashboardStats getDashboardStats() {

        DashboardStats stats =
                new DashboardStats();


        // =====================================================
        // PATIENTS
        // =====================================================

        stats.setTotalPatients(
                getCount(
                        "SELECT COUNT(*) " +
                        "FROM patients"
                )
        );


        // =====================================================
        // ACTIVE DENTISTS
        // =====================================================

        stats.setTotalDentists(
                getCount(
                        "SELECT COUNT(*) " +
                        "FROM dentists " +
                        "WHERE active = 1"
                )
        );


        // =====================================================
        // ACTIVE TREATMENTS
        // =====================================================

        stats.setTotalTreatments(
                getCount(
                        "SELECT COUNT(*) " +
                        "FROM treatments " +
                        "WHERE active = 1"
                )
        );


        // =====================================================
        // TODAY'S APPOINTMENTS
        // =====================================================

        stats.setTodayAppointments(
                getCount(
                        "SELECT COUNT(*) " +
                        "FROM appointments " +
                        "WHERE appointment_date = CURDATE()"
                )
        );


        // =====================================================
        // TOTAL APPOINTMENTS
        // =====================================================

        stats.setTotalAppointments(
                getCount(
                        "SELECT COUNT(*) " +
                        "FROM appointments"
                )
        );


        // =====================================================
        // SCHEDULED
        // =====================================================

        stats.setScheduledAppointments(
                getAppointmentStatusCount(
                        "SCHEDULED"
                )
        );


        // =====================================================
        // COMPLETED
        // =====================================================

        stats.setCompletedAppointments(
                getAppointmentStatusCount(
                        "COMPLETED"
                )
        );


        // =====================================================
        // CANCELLED
        // =====================================================

        stats.setCancelledAppointments(
                getAppointmentStatusCount(
                        "CANCELLED"
                )
        );


        // =====================================================
        // TOTAL BILLS
        // =====================================================

        stats.setTotalBills(
                getCount(
                        "SELECT COUNT(*) " +
                        "FROM bills"
                )
        );


        // =====================================================
        // TODAY'S BILLS
        // =====================================================

        stats.setTodayBills(
                getCount(
                        "SELECT COUNT(*) " +
                        "FROM bills " +
                        "WHERE DATE(created_at) = CURDATE()"
                )
        );


        // =====================================================
        // TODAY'S REVENUE
        // =====================================================

        stats.setTodayRevenue(
                getAmount(
                        "SELECT COALESCE(SUM(total_amount), 0) " +
                        "FROM bills " +
                        "WHERE DATE(created_at) = CURDATE()"
                )
        );


        return stats;
    }


    // =========================================================
    // COUNT
    // =========================================================

    private int getCount(String sql) {

        try (
                Connection con =
                        DBConnection.getConnection();

                PreparedStatement ps =
                        con.prepareStatement(sql);

                ResultSet rs =
                        ps.executeQuery()
        ) {

            if (rs.next()) {

                return rs.getInt(1);
            }

        } catch (Exception e) {

            System.out.println(
                    "DASHBOARD COUNT DATABASE ERROR:"
            );

            e.printStackTrace();
        }

        return 0;
    }


    // =========================================================
    // APPOINTMENT STATUS COUNT
    // =========================================================

    private int getAppointmentStatusCount(
            String status) {

        String sql =
                "SELECT COUNT(*) " +
                "FROM appointments " +
                "WHERE status = ?";


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
                    "APPOINTMENT STATUS DATABASE ERROR:"
            );

            e.printStackTrace();
        }


        return 0;
    }


    // =========================================================
    // AMOUNT
    // =========================================================

    private double getAmount(String sql) {

        try (
                Connection con =
                        DBConnection.getConnection();

                PreparedStatement ps =
                        con.prepareStatement(sql);

                ResultSet rs =
                        ps.executeQuery()
        ) {

            if (rs.next()) {

                return rs.getDouble(1);
            }

        } catch (Exception e) {

            System.out.println(
                    "DASHBOARD AMOUNT DATABASE ERROR:"
            );

            e.printStackTrace();
        }

        return 0.0;
    }
}