package com.sunrise.test.integration;

import static org.junit.jupiter.api.Assertions.*;
import java.time.LocalTime;
import java.util.List;
import org.junit.jupiter.api.*;
import com.sunrise.dao.DentistScheduleDAO;
import com.sunrise.model.DentistSchedule;

public class DentistScheduleDAOIntegrationTest {
    private final DentistScheduleDAO dao=new DentistScheduleDAO(); private int dentistId;
    @BeforeEach void setUp() throws Exception { DatabaseTestSupport.requireDatabase(); String n=DatabaseTestSupport.unique("Schedule Dentist"); DatabaseTestSupport.execute("INSERT INTO dentists(dentist_name,specialization,consultation_fee,phone_number,email,active) VALUES(?,?,?,?,?,?)",n,"General",2500,"0700000010",n.replace(" ","")+"@example.com",true); dentistId=DatabaseTestSupport.queryInt("SELECT dentist_id FROM dentists WHERE dentist_name=?",n); }
    @AfterEach void tearDown() throws Exception { DatabaseTestSupport.execute("DELETE FROM dentist_schedules WHERE dentist_id=?",dentistId); DatabaseTestSupport.execute("DELETE FROM dentists WHERE dentist_id=?",dentistId); }
    @Test void replaceAndReadSchedules() { List<DentistSchedule> input=List.of(new DentistSchedule(dentistId,"MONDAY",LocalTime.of(9,0),LocalTime.of(12,0),30,true),new DentistSchedule(dentistId,"WEDNESDAY",LocalTime.of(13,0),LocalTime.of(17,0),30,true)); assertTrue(dao.replaceDentistSchedule(dentistId,input)); List<DentistSchedule> all=dao.getSchedulesByDentist(dentistId); assertEquals(2,all.size()); assertEquals("MONDAY",all.get(0).getDayOfWeek()); }
    @Test void getSchedulesByDayFiltersCorrectly() { List<DentistSchedule> input=List.of(new DentistSchedule(dentistId,"MONDAY",LocalTime.of(9,0),LocalTime.of(12,0),30,true),new DentistSchedule(dentistId,"FRIDAY",LocalTime.of(10,0),LocalTime.of(14,0),30,true)); assertTrue(dao.replaceDentistSchedule(dentistId,input)); List<DentistSchedule> monday=dao.getSchedulesByDentistAndDay(dentistId,"MONDAY"); assertEquals(1,monday.size()); assertEquals("MONDAY",monday.get(0).getDayOfWeek()); }
    @Test void replaceScheduleReplacesPreviousRows() { assertTrue(dao.replaceDentistSchedule(dentistId,List.of(new DentistSchedule(dentistId,"TUESDAY",LocalTime.of(9,0),LocalTime.of(10,0),30,true)))); assertTrue(dao.replaceDentistSchedule(dentistId,List.of(new DentistSchedule(dentistId,"THURSDAY",LocalTime.of(11,0),LocalTime.of(13,0),30,true)))); List<DentistSchedule> all=dao.getSchedulesByDentist(dentistId); assertEquals(1,all.size()); assertEquals("THURSDAY",all.get(0).getDayOfWeek()); }
}
