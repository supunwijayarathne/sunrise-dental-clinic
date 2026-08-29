package com.sunrise.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Time;
import java.util.ArrayList;
import java.util.List;

import com.sunrise.model.DentistSchedule;
import com.sunrise.util.DBConnection;

public class DentistScheduleDAO {

    // =========================================================
    // GET ALL SCHEDULES FOR DENTIST
    // =========================================================

    public List<DentistSchedule> getSchedulesByDentist(
            int dentistId) {

        List<DentistSchedule> schedules =
                new ArrayList<>();

        String sql =
                "SELECT * FROM dentist_schedules " +
                "WHERE dentist_id = ? " +
                "AND active = 1 " +
                "ORDER BY " +
                "FIELD(day_of_week, " +
                "'MONDAY','TUESDAY','WEDNESDAY'," +
                "'THURSDAY','FRIDAY','SATURDAY','SUNDAY'), " +
                "start_time ASC";

        try (
            Connection con = DBConnection.getConnection();
            PreparedStatement st = con.prepareStatement(sql)
        ) {

            st.setInt(1, dentistId);

            try (ResultSet rs = st.executeQuery()) {

                while (rs.next()) {

                    schedules.add(
                        mapResultSetToSchedule(rs)
                    );
                }
            }

        } catch (Exception e) {

            System.out.println(
                "ERROR LOADING DENTIST SCHEDULE:"
            );

            e.printStackTrace();
        }

        return schedules;
    }


    // =========================================================
    // GET SCHEDULE FOR SPECIFIC DAY
    // =========================================================

    public List<DentistSchedule>
    getSchedulesByDentistAndDay(
            int dentistId,
            String dayOfWeek) {

        List<DentistSchedule> schedules =
                new ArrayList<>();

        String sql =
                "SELECT * FROM dentist_schedules " +
                "WHERE dentist_id = ? " +
                "AND day_of_week = ? " +
                "AND active = 1 " +
                "ORDER BY start_time ASC";

        try (
            Connection con = DBConnection.getConnection();
            PreparedStatement st = con.prepareStatement(sql)
        ) {

            st.setInt(1, dentistId);
            st.setString(2, dayOfWeek);

            try (ResultSet rs = st.executeQuery()) {

                while (rs.next()) {

                    schedules.add(
                        mapResultSetToSchedule(rs)
                    );
                }
            }

        } catch (Exception e) {

            System.out.println(
                "ERROR LOADING DAY SCHEDULE:"
            );

            e.printStackTrace();
        }

        return schedules;
    }


    // =========================================================
    // SAVE COMPLETE DENTIST SCHEDULE
    // =========================================================

    public boolean replaceDentistSchedule(
            int dentistId,
            List<DentistSchedule> schedules) {

        Connection con = null;

        try {

            con = DBConnection.getConnection();

            System.out.println("=================================");
            System.out.println("SAVING DENTIST SCHEDULE");
            System.out.println("Dentist ID: " + dentistId);
            System.out.println("Number of schedules: " + schedules.size());

            for (DentistSchedule s : schedules) {

                System.out.println(
                    "DAY: " + s.getDayOfWeek()
                    + " | START: " + s.getStartTime()
                    + " | END: " + s.getEndTime()
                    + " | DURATION: " + s.getSlotDuration()
                );
            }

            System.out.println("=================================");


            con.setAutoCommit(false);


            // =====================================================
            // DELETE OLD SCHEDULES
            // =====================================================

            String deleteSQL =
                "DELETE FROM dentist_schedules " +
                "WHERE dentist_id = ?";

            try (PreparedStatement delete =
                    con.prepareStatement(deleteSQL)) {

                delete.setInt(1, dentistId);

                int deleted =
                    delete.executeUpdate();

                System.out.println(
                    "Deleted old schedules: " + deleted
                );
            }


            // =====================================================
            // INSERT NEW SCHEDULES
            // =====================================================

            String insertSQL =
                "INSERT INTO dentist_schedules " +
                "(dentist_id, day_of_week, start_time, " +
                "end_time, slot_duration, active) " +
                "VALUES (?, ?, ?, ?, ?, ?)";


            int inserted = 0;


            try (PreparedStatement insert =
                    con.prepareStatement(insertSQL)) {


                for (DentistSchedule schedule : schedules) {

                    insert.setInt(
                        1,
                        dentistId
                    );

                    insert.setString(
                        2,
                        schedule.getDayOfWeek()
                    );

                    insert.setTime(
                        3,
                        java.sql.Time.valueOf(
                            schedule.getStartTime()
                        )
                    );

                    insert.setTime(
                        4,
                        java.sql.Time.valueOf(
                            schedule.getEndTime()
                        )
                    );

                    insert.setInt(
                        5,
                        schedule.getSlotDuration()
                    );

                    insert.setInt(
                        6,
                        schedule.isActive() ? 1 : 0
                    );


                    int result =
                        insert.executeUpdate();


                    inserted += result;


                    System.out.println(
                        "Inserted schedule row: "
                        + result
                    );
                }
            }


            // =====================================================
            // COMMIT
            // =====================================================

            con.commit();


            System.out.println(
                "TOTAL INSERTED: " + inserted
            );

            System.out.println(
                "SCHEDULE COMMITTED SUCCESSFULLY"
            );


            // =====================================================
            // VERIFY FROM SAME CONNECTION
            // =====================================================

            String verifySQL =
                "SELECT schedule_id, dentist_id, " +
                "day_of_week, start_time, end_time, " +
                "slot_duration, active " +
                "FROM dentist_schedules " +
                "WHERE dentist_id = ?";


            try (PreparedStatement verify =
                    con.prepareStatement(verifySQL)) {

                verify.setInt(1, dentistId);


                try (ResultSet rs =
                        verify.executeQuery()) {


                    System.out.println(
                        "===== DATABASE VERIFICATION ====="
                    );


                    while (rs.next()) {

                        System.out.println(
                            rs.getInt("schedule_id")
                            + " | "
                            + rs.getInt("dentist_id")
                            + " | "
                            + rs.getString("day_of_week")
                            + " | "
                            + rs.getTime("start_time")
                            + " | "
                            + rs.getTime("end_time")
                            + " | "
                            + rs.getInt("slot_duration")
                            + " | "
                            + rs.getInt("active")
                        );
                    }


                    System.out.println(
                        "================================="
                    );
                }
            }


            return true;


        } catch (Exception e) {

            System.out.println(
                "================================="
            );

            System.out.println(
                "SCHEDULE SAVE FAILED"
            );

            e.printStackTrace();

            System.out.println(
                "================================="
            );


            if (con != null) {

                try {

                    con.rollback();

                    System.out.println(
                        "Transaction rolled back."
                    );

                } catch (Exception rollbackError) {

                    rollbackError.printStackTrace();
                }
            }

        } finally {

            if (con != null) {

                try {

                    con.setAutoCommit(true);
                    con.close();

                } catch (Exception closeError) {

                    closeError.printStackTrace();
                }
            }
        }


        return false;
    }


    // =========================================================
    // MAP
    // =========================================================

    private DentistSchedule mapResultSetToSchedule(
            ResultSet rs) throws Exception {

        DentistSchedule schedule =
                new DentistSchedule();

        schedule.setScheduleId(
            rs.getInt("schedule_id")
        );

        schedule.setDentistId(
            rs.getInt("dentist_id")
        );

        schedule.setDayOfWeek(
            rs.getString("day_of_week")
        );

        schedule.setStartTime(
            rs.getTime("start_time")
                .toLocalTime()
        );

        schedule.setEndTime(
            rs.getTime("end_time")
                .toLocalTime()
        );

        schedule.setSlotDuration(
            rs.getInt("slot_duration")
        );

        schedule.setActive(
            rs.getBoolean("active")
        );

        return schedule;
    }
}