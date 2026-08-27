package com.sunrise.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import com.sunrise.model.DashboardStats;
import com.sunrise.util.DBConnection;

public class DashboardDAO {

    public DashboardStats getDashboardStats() {

        DashboardStats stats = new DashboardStats();

        stats.setTotalPatients(
                getCount("SELECT COUNT(*) FROM patients")
        );

        stats.setTotalDentists(
                getCount(
                    "SELECT COUNT(*) FROM dentists WHERE active = 1"
                )
        );

        stats.setTotalTreatments(
                getCount(
                    "SELECT COUNT(*) FROM treatments WHERE active = 1"
                )
        );

        stats.setTodayAppointments(
                getCount(
                    "SELECT COUNT(*) FROM appointments " +
                    "WHERE appointment_date = CURDATE()"
                )
        );

        stats.setTotalBills(
                getCount(
                    "SELECT COUNT(*) FROM bills"
                )
        );

        return stats;
    }


    private int getCount(String sql) {

        try (
            Connection con = DBConnection.getConnection();
            PreparedStatement ps = con.prepareStatement(sql);
            ResultSet rs = ps.executeQuery()
        ) {

            if (rs.next()) {
                return rs.getInt(1);
            }

        } catch (Exception e) {

            System.out.println(
                    "DASHBOARD DATABASE ERROR:"
            );

            e.printStackTrace();
        }

        return 0;
    }
}