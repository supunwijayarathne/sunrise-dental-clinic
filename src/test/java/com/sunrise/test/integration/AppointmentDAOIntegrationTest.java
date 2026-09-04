package com.sunrise.test.integration;

import static org.junit.jupiter.api.Assertions.*;
import java.time.LocalDate;
import java.time.LocalTime;
import java.util.List;
import org.junit.jupiter.api.*;
import com.sunrise.dao.*;
import com.sunrise.model.*;

public class AppointmentDAOIntegrationTest {
    private final AppointmentDAO dao=new AppointmentDAO();
    private int patientId,dentistId,treatmentId,userId,appointmentId; private String appointmentNumber; private LocalDate date; private LocalTime time;

    @BeforeEach void setUp() throws Exception {
        DatabaseTestSupport.requireDatabase();
        patientId=insertPatient(); dentistId=insertDentist(); treatmentId=insertTreatment(); userId=insertUser();
        appointmentNumber=DatabaseTestSupport.unique("APT-TST"); date=LocalDate.now().plusDays(14); time=LocalTime.of(10,30);
        Appointment a=new Appointment(appointmentNumber,patientId,dentistId,treatmentId,date,time,"SCHEDULED","Integration test",userId);
        assertTrue(dao.addAppointment(a)); appointmentId=DatabaseTestSupport.queryInt("SELECT appointment_id FROM appointments WHERE appointment_number=?",appointmentNumber); assertTrue(appointmentId>0);
    }
    @AfterEach void tearDown() throws Exception { DatabaseTestSupport.execute("DELETE FROM appointments WHERE appointment_id=?",appointmentId); DatabaseTestSupport.execute("DELETE FROM users WHERE user_id=?",userId); DatabaseTestSupport.execute("DELETE FROM treatments WHERE treatment_id=?",treatmentId); DatabaseTestSupport.execute("DELETE FROM dentists WHERE dentist_id=?",dentistId); DatabaseTestSupport.execute("DELETE FROM patients WHERE patient_id=?",patientId); }

    @Test void addGetAllGetById() { Appointment a=dao.getAppointmentById(appointmentId); assertNotNull(a); assertEquals(appointmentNumber,a.getAppointmentNumber()); assertEquals(patientId,a.getPatientId()); assertEquals(date,a.getAppointmentDate()); assertTrue(dao.getAllAppointments().stream().anyMatch(x->x.getAppointmentId()==appointmentId)); }
    @Test void updateAppointment() { Appointment a=dao.getAppointmentById(appointmentId); a.setAppointmentDate(date.plusDays(1)); a.setAppointmentTime(LocalTime.of(11,0)); a.setStatus("COMPLETED"); a.setNotes("Updated"); assertTrue(dao.updateAppointment(a)); Appointment x=dao.getAppointmentById(appointmentId); assertEquals(date.plusDays(1),x.getAppointmentDate()); assertEquals(LocalTime.of(11,0),x.getAppointmentTime()); assertEquals("COMPLETED",x.getStatus()); }
    @Test void searchAppointments() { List<Appointment> r=dao.searchAppointments(appointmentNumber); assertTrue(r.stream().anyMatch(x->x.getAppointmentId()==appointmentId)); }
    @Test void availabilityDetectsConflictsAndExcludesCurrentAppointment() { assertFalse(dao.isDentistAvailable(dentistId,date,time,0)); assertFalse(dao.isPatientAvailable(patientId,date,time,0)); assertTrue(dao.isDentistAvailable(dentistId,date,time,appointmentId)); assertTrue(dao.isPatientAvailable(patientId,date,time,appointmentId)); }
    @Test void bookedTimesContainsAppointmentTime() { assertTrue(dao.getBookedTimes(dentistId,date,0).contains(time)); assertFalse(dao.getBookedTimes(dentistId,date,appointmentId).contains(time)); }
    @Test void appointmentNumberExists() { assertTrue(dao.appointmentNumberExists(appointmentNumber,0)); assertFalse(dao.appointmentNumberExists(appointmentNumber,appointmentId)); }
    @Test void generatedNumberHasExpectedFormat() { assertTrue(dao.generateNextAppointmentNumber().matches("APT-\\d+")); }
    @Test void todayAppointmentsAndPatientDentistQueriesReturnLists() { assertNotNull(dao.getTodayAppointments()); assertNotNull(dao.getAppointmentsByPatient(patientId)); assertNotNull(dao.getAppointmentsByDentist(dentistId)); }
    @Test void missingAppointmentReturnsNull() { assertNull(dao.getAppointmentById(Integer.MAX_VALUE)); }

    private int insertPatient() throws Exception { String c=DatabaseTestSupport.unique("PAT-TST"); DatabaseTestSupport.execute("INSERT INTO patients(patient_code,name,address,contact_number,email) VALUES(?,?,?,?,?)",c,"Appointment Test Patient","Test Address","0700000001",c+"@example.com"); return DatabaseTestSupport.queryInt("SELECT patient_id FROM patients WHERE patient_code=?",c); }
    private int insertDentist() throws Exception { String n=DatabaseTestSupport.unique("Dentist T"); DatabaseTestSupport.execute("INSERT INTO dentists(dentist_name,specialization,consultation_fee,phone_number,email,active) VALUES(?,?,?,?,?,?)",n,"General Dentistry",2500,"0700000002",n.replace(" ","")+"@example.com",true); return DatabaseTestSupport.queryInt("SELECT dentist_id FROM dentists WHERE dentist_name=?",n); }
    private int insertTreatment() throws Exception { String n=DatabaseTestSupport.unique("Treatment T"); DatabaseTestSupport.execute("INSERT INTO treatments(treatment_name,description,treatment_fee,active) VALUES(?,?,?,?)",n,"Appointment test",5000,true); return DatabaseTestSupport.queryInt("SELECT treatment_id FROM treatments WHERE treatment_name=?",n); }
    private int insertUser() throws Exception { String u=DatabaseTestSupport.unique("apptuser"); DatabaseTestSupport.execute("INSERT INTO users(full_name,email,phone,address,position,username,password_hash,role,active,first_login) VALUES(?,?,?,?,?,?,?,?,?,?)","Appointment Tester",u+"@example.com","0700000003","Test","Receptionist",u,"test-password","RECEPTIONIST",true,false); return DatabaseTestSupport.queryInt("SELECT user_id FROM users WHERE username=?",u); }
}
