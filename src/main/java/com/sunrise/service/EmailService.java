package com.sunrise.service;

import java.time.format.DateTimeFormatter;
import java.util.Properties;

import jakarta.mail.Authenticator;
import jakarta.mail.Message;
import jakarta.mail.PasswordAuthentication;
import jakarta.mail.Session;
import jakarta.mail.Transport;
import jakarta.mail.internet.InternetAddress;
import jakarta.mail.internet.MimeMessage;

import com.sunrise.model.Appointment;
import com.sunrise.model.Dentist;
import com.sunrise.model.Patient;
import com.sunrise.model.Treatment;

public class EmailService {

    /*
     * =========================================================
     * EMAIL CONFIGURATION
     * =========================================================
     *
     * Use a Gmail account + Gmail App Password.
     *
     * DO NOT use your normal Gmail password.
     *
     * Example:
     *
     * EMAIL_USERNAME = "yourclinic@gmail.com";
     * EMAIL_PASSWORD = "abcdefghijklmnop";
     *
     */

    private static final String EMAIL_USERNAME =
            "8supun@gmail.com";

    private static final String EMAIL_PASSWORD =
            "tuaz tyxl bvzq yzdq";


    private static final String FROM_NAME =
            "Sunrise Dental Clinic";


    // =========================================================
    // SMTP CONFIGURATION
    // =========================================================

    private static Session createSession() {

        Properties properties =
                new Properties();

        properties.put(
                "mail.smtp.host",
                "smtp.gmail.com"
        );

        properties.put(
                "mail.smtp.port",
                "587"
        );

        properties.put(
                "mail.smtp.auth",
                "true"
        );

        properties.put(
                "mail.smtp.starttls.enable",
                "true"
        );


        return Session.getInstance(
                properties,
                new Authenticator() {

                    @Override
                    protected PasswordAuthentication
                    getPasswordAuthentication() {

                        return new PasswordAuthentication(
                                EMAIL_USERNAME,
                                EMAIL_PASSWORD
                        );
                    }
                }
        );
    }


    // =========================================================
    // SEND APPOINTMENT BOOKING EMAILS
    // =========================================================

    public static void sendAppointmentCreatedEmails(
            Appointment appointment,
            Patient patient,
            Dentist dentist,
            Treatment treatment) {

        String patientEmail =
                patient != null
                ? clean(patient.getEmail())
                : "";

        String dentistEmail =
                dentist != null
                ? clean(dentist.getEmail())
                : "";


        // -----------------------------------------------------
        // PATIENT
        // -----------------------------------------------------

        if (!patientEmail.isEmpty()) {

            try {

                sendEmail(
                        patientEmail,
                        "Appointment Confirmation - "
                                + appointment.getAppointmentNumber(),
                        buildPatientBookingEmail(
                                appointment,
                                patient,
                                dentist,
                                treatment
                        )
                );

                System.out.println(
                        "Appointment confirmation sent to patient: "
                                + patientEmail
                );

            } catch (Exception e) {

                System.out.println(
                        "Unable to send appointment email to patient: "
                                + patientEmail
                );

                e.printStackTrace();
            }
        }


        // -----------------------------------------------------
        // DENTIST
        // -----------------------------------------------------

        if (!dentistEmail.isEmpty()) {

            try {

                sendEmail(
                        dentistEmail,
                        "New Appointment - "
                                + appointment.getAppointmentNumber(),
                        buildDentistBookingEmail(
                                appointment,
                                patient,
                                dentist,
                                treatment
                        )
                );

                System.out.println(
                        "Appointment notification sent to dentist: "
                                + dentistEmail
                );

            } catch (Exception e) {

                System.out.println(
                        "Unable to send appointment email to dentist: "
                                + dentistEmail
                );

                e.printStackTrace();
            }
        }
    }


    // =========================================================
    // SEND CANCELLATION EMAILS
    // =========================================================

    public static void sendAppointmentCancelledEmails(
            Appointment appointment,
            Patient patient,
            Dentist dentist,
            Treatment treatment) {

        String patientEmail =
                patient != null
                ? clean(patient.getEmail())
                : "";

        String dentistEmail =
                dentist != null
                ? clean(dentist.getEmail())
                : "";


        // -----------------------------------------------------
        // PATIENT
        // -----------------------------------------------------

        if (!patientEmail.isEmpty()) {

            try {

                sendEmail(
                        patientEmail,
                        "Appointment Cancelled - "
                                + appointment.getAppointmentNumber(),
                        buildPatientCancellationEmail(
                                appointment,
                                patient,
                                dentist,
                                treatment
                        )
                );

                System.out.println(
                        "Cancellation email sent to patient: "
                                + patientEmail
                );

            } catch (Exception e) {

                System.out.println(
                        "Unable to send cancellation email to patient: "
                                + patientEmail
                );

                e.printStackTrace();
            }
        }


        // -----------------------------------------------------
        // DENTIST
        // -----------------------------------------------------

        if (!dentistEmail.isEmpty()) {

            try {

                sendEmail(
                        dentistEmail,
                        "Appointment Cancelled - "
                                + appointment.getAppointmentNumber(),
                        buildDentistCancellationEmail(
                                appointment,
                                patient,
                                dentist,
                                treatment
                        )
                );

                System.out.println(
                        "Cancellation email sent to dentist: "
                                + dentistEmail
                );

            } catch (Exception e) {

                System.out.println(
                        "Unable to send cancellation email to dentist: "
                                + dentistEmail
                );

                e.printStackTrace();
            }
        }
    }


    // =========================================================
    // SEND EMAIL
    // =========================================================

    private static void sendEmail(
            String recipient,
            String subject,
            String body)
            throws Exception {

        Session session =
                createSession();


        MimeMessage message =
                new MimeMessage(session);


        message.setFrom(
                new InternetAddress(
                        EMAIL_USERNAME,
                        FROM_NAME
                )
        );


        message.setRecipients(
                Message.RecipientType.TO,
                InternetAddress.parse(
                        recipient
                )
        );


        message.setSubject(
                subject,
                "UTF-8"
        );


        message.setText(
                body,
                "UTF-8"
        );


        Transport.send(
                message
        );
    }


    // =========================================================
    // PATIENT BOOKING EMAIL
    // =========================================================

    private static String buildPatientBookingEmail(
            Appointment appointment,
            Patient patient,
            Dentist dentist,
            Treatment treatment) {

        String patientName =
                patient != null
                ? patient.getName()
                : "Patient";


        String dentistName =
                dentist != null
                ? dentist.getDentistName()
                : "Dentist";


        String specialization =
                dentist != null
                ? clean(dentist.getSpecialization())
                : "";


        String treatmentName =
                treatment != null
                ? treatment.getTreatmentName()
                : "Treatment";


        String date =
                appointment.getAppointmentDate()
                        .format(
                                DateTimeFormatter.ofPattern(
                                        "dd MMMM yyyy"
                                )
                        );


        String time =
                appointment.getAppointmentTime()
                        .format(
                                DateTimeFormatter.ofPattern(
                                        "hh:mm a"
                                )
                        );


        return
                "Dear " + patientName + ",\n\n"

                + "Your appointment at Sunrise Dental Clinic "
                + "has been successfully scheduled.\n\n"

                + "APPOINTMENT DETAILS\n"
                + "--------------------------------\n"
                + "Appointment No: "
                + appointment.getAppointmentNumber()
                + "\n"

                + "Dentist: "
                + dentistName
                + "\n"

                + (
                    specialization.isEmpty()
                    ? ""
                    : "Specialization: "
                        + specialization
                        + "\n"
                )

                + "Treatment: "
                + treatmentName
                + "\n"

                + "Date: "
                + date
                + "\n"

                + "Time: "
                + time
                + "\n"

                + "Status: SCHEDULED\n"

                + "\nPlease arrive a few minutes "
                + "before your appointment time.\n\n"

                + "Thank you,\n"
                + "Sunrise Dental Clinic";
    }


    // =========================================================
    // DENTIST BOOKING EMAIL
    // =========================================================

    private static String buildDentistBookingEmail(
            Appointment appointment,
            Patient patient,
            Dentist dentist,
            Treatment treatment) {

        String dentistName =
                dentist != null
                ? dentist.getDentistName()
                : "Doctor";


        String patientName =
                patient != null
                ? patient.getName()
                : "Patient";


        String treatmentName =
                treatment != null
                ? treatment.getTreatmentName()
                : "Treatment";


        String date =
                appointment.getAppointmentDate()
                        .format(
                                DateTimeFormatter.ofPattern(
                                        "dd MMMM yyyy"
                                )
                        );


        String time =
                appointment.getAppointmentTime()
                        .format(
                                DateTimeFormatter.ofPattern(
                                        "hh:mm a"
                                )
                        );


        return
                "Dear Dr. "
                + dentistName
                + ",\n\n"

                + "A new appointment has been scheduled "
                + "for you at Sunrise Dental Clinic.\n\n"

                + "APPOINTMENT DETAILS\n"
                + "--------------------------------\n"

                + "Appointment No: "
                + appointment.getAppointmentNumber()
                + "\n"

                + "Patient: "
                + patientName
                + "\n"

                + "Treatment: "
                + treatmentName
                + "\n"

                + "Date: "
                + date
                + "\n"

                + "Time: "
                + time
                + "\n"

                + "Status: SCHEDULED\n"

                + "\nPlease review the appointment "
                + "before the scheduled time.\n\n"

                + "Sunrise Dental Clinic";
    }


    // =========================================================
    // PATIENT CANCELLATION EMAIL
    // =========================================================

    private static String buildPatientCancellationEmail(
            Appointment appointment,
            Patient patient,
            Dentist dentist,
            Treatment treatment) {

        String patientName =
                patient != null
                ? patient.getName()
                : "Patient";


        String dentistName =
                dentist != null
                ? dentist.getDentistName()
                : "Dentist";


        String treatmentName =
                treatment != null
                ? treatment.getTreatmentName()
                : "Treatment";


        String date =
                appointment.getAppointmentDate()
                        .format(
                                DateTimeFormatter.ofPattern(
                                        "dd MMMM yyyy"
                                )
                        );


        String time =
                appointment.getAppointmentTime()
                        .format(
                                DateTimeFormatter.ofPattern(
                                        "hh:mm a"
                                )
                        );


        return
                "Dear " + patientName + ",\n\n"

                + "Your appointment at Sunrise Dental Clinic "
                + "has been cancelled.\n\n"

                + "CANCELLED APPOINTMENT\n"
                + "--------------------------------\n"

                + "Appointment No: "
                + appointment.getAppointmentNumber()
                + "\n"

                + "Dentist: "
                + dentistName
                + "\n"

                + "Treatment: "
                + treatmentName
                + "\n"

                + "Date: "
                + date
                + "\n"

                + "Time: "
                + time
                + "\n"

                + "Status: CANCELLED\n\n"

                + "Please contact Sunrise Dental Clinic "
                + "if you would like to arrange another "
                + "appointment.\n\n"

                + "Thank you,\n"
                + "Sunrise Dental Clinic";
    }


    // =========================================================
    // DENTIST CANCELLATION EMAIL
    // =========================================================

    private static String buildDentistCancellationEmail(
            Appointment appointment,
            Patient patient,
            Dentist dentist,
            Treatment treatment) {

        String dentistName =
                dentist != null
                ? dentist.getDentistName()
                : "Doctor";


        String patientName =
                patient != null
                ? patient.getName()
                : "Patient";


        String treatmentName =
                treatment != null
                ? treatment.getTreatmentName()
                : "Treatment";


        String date =
                appointment.getAppointmentDate()
                        .format(
                                DateTimeFormatter.ofPattern(
                                        "dd MMMM yyyy"
                                )
                        );


        String time =
                appointment.getAppointmentTime()
                        .format(
                                DateTimeFormatter.ofPattern(
                                        "hh:mm a"
                                )
                        );


        return
                "Dear Dr. "
                + dentistName
                + ",\n\n"

                + "The following appointment at "
                + "Sunrise Dental Clinic has been cancelled.\n\n"

                + "CANCELLED APPOINTMENT\n"
                + "--------------------------------\n"

                + "Appointment No: "
                + appointment.getAppointmentNumber()
                + "\n"

                + "Patient: "
                + patientName
                + "\n"

                + "Treatment: "
                + treatmentName
                + "\n"

                + "Date: "
                + date
                + "\n"

                + "Time: "
                + time
                + "\n"

                + "Status: CANCELLED\n\n"

                + "Sunrise Dental Clinic";
    }


    // =========================================================
    // CLEAN
    // =========================================================

    private static String clean(
            String value) {

        if (value == null) {

            return "";
        }

        return value.trim();
    }
}