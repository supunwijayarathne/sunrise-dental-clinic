<%@ page language="java"
    contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
    if (session.getAttribute("loggedUser") == null) {

        response.sendRedirect(
            request.getContextPath() + "/login"
        );

        return;
    }
%>

<!DOCTYPE html>

<html>

<head>

<meta charset="UTF-8">

<title>New Staff Guide - Sunrise Dental Clinic</title>

<style>

* {
    box-sizing: border-box;
}

body {
    margin: 0;
    font-family: Arial, sans-serif;
    background: #f5f7fb;
    color: #172033;
}

.container {
    width: 900px;
    max-width: 92%;
    margin: 40px auto;
}

.header {
    background: white;
    padding: 32px;
    border-radius: 14px;
    margin-bottom: 20px;
    box-shadow: 0 3px 15px rgba(0,0,0,0.06);
}

.header h1 {
    margin: 0 0 10px;
}

.header p {
    margin: 0;
    color: #667085;
    line-height: 1.6;
}

.step {
    background: white;
    padding: 26px;
    margin-bottom: 16px;
    border-radius: 12px;
    border-left: 5px solid #2563eb;
    box-shadow: 0 3px 12px rgba(0,0,0,0.05);
}

.step-number {
    font-size: 13px;
    font-weight: bold;
    color: #2563eb;
    margin-bottom: 8px;
}

.step h2 {
    margin: 0 0 12px;
    font-size: 20px;
}

.step p {
    color: #475467;
    line-height: 1.6;
}

.step ul {
    color: #475467;
    line-height: 1.8;
}

.warning {
    margin-top: 15px;
    padding: 14px;
    border-radius: 8px;
    background: #fff7ed;
    border: 1px solid #fed7aa;
    color: #9a3412;
}

.finish {
    background: white;
    padding: 30px;
    border-radius: 12px;
    text-align: center;
    margin-top: 25px;
    box-shadow: 0 3px 12px rgba(0,0,0,0.05);
}

.finish p {
    color: #667085;
    line-height: 1.6;
}

button {
    background: #2563eb;
    border: none;
    color: white;
    padding: 13px 30px;
    border-radius: 8px;
    font-size: 15px;
    cursor: pointer;
}

button:hover {
    opacity: 0.9;
}

</style>

</head>

<body>

<div class="container">

    <div class="header">

        <h1>
            Welcome to Sunrise Dental Clinic
        </h1>

        <p>
            Welcome to the Sunrise Dental Clinic Management
            System. This guide introduces the main functions
            available to staff members.
        </p>

    </div>


    <div class="step">

        <div class="step-number">
            STEP 01
        </div>

        <h2>
            Understanding the Dashboard
        </h2>

        <p>
            The dashboard provides access to the main
            functions of the clinic management system.
        </p>

        <ul>
            <li>Patient management</li>
            <li>Appointment management</li>
            <li>Dentist management</li>
            <li>Treatment management</li>
            <li>Billing</li>
            <li>Reports</li>
        </ul>

    </div>


    <div class="step">

        <div class="step-number">
            STEP 02
        </div>

        <h2>
            Registering a Patient
        </h2>

        <p>
            Register a patient when a new patient needs
            to be added to the clinic system.
        </p>

        <ul>
            <li>Open the Patient section.</li>
            <li>Select the patient registration option.</li>
            <li>Enter the required patient information.</li>
            <li>Check the entered information.</li>
            <li>Save the patient record.</li>
        </ul>

    </div>


    <div class="step">

        <div class="step-number">
            STEP 03
        </div>

        <h2>
            Searching for a Patient
        </h2>

        <p>
            Patient search allows staff to quickly locate
            existing patients.
        </p>

        <ul>
            <li>Open the relevant patient or appointment section.</li>
            <li>Enter the patient's name or identifier.</li>
            <li>Review the search results.</li>
            <li>Select the correct patient.</li>
        </ul>

    </div>


    <div class="step">

        <div class="step-number">
            STEP 04
        </div>

        <h2>
            Searching for a Dentist
        </h2>

        <p>
            Dentists can be searched when creating
            appointments.
        </p>

        <ul>
            <li>Open the appointment form.</li>
            <li>Search for the dentist.</li>
            <li>Select the required dentist.</li>
            <li>Review the dentist's available schedule.</li>
        </ul>

    </div>


    <div class="step">

        <div class="step-number">
            STEP 05
        </div>

        <h2>
            Creating an Appointment
        </h2>

        <p>
            Appointments require a patient, dentist,
            treatment, date and available time.
        </p>

        <ul>
            <li>Select or search for the patient.</li>
            <li>Select or search for the dentist.</li>
            <li>Select the required treatment.</li>
            <li>Select the appointment date.</li>
            <li>Select an available time.</li>
            <li>Confirm the appointment.</li>
        </ul>

        <div class="warning">

            Appointment slots are based on the dentist's
            configured working schedule. Standard appointment
            duration is 30 minutes.

        </div>

    </div>


    <div class="step">

        <div class="step-number">
            STEP 06
        </div>

        <h2>
            Handling Walk-in Patients
        </h2>

        <p>
            Patients who arrive without a previously
            scheduled appointment can be handled as
            walk-in patients.
        </p>

        <ul>
            <li>Identify or register the patient.</li>
            <li>Select the required dentist.</li>
            <li>Select the treatment.</li>
            <li>Check the available time.</li>
            <li>Create the walk-in appointment.</li>
        </ul>

    </div>


    <div class="step">

        <div class="step-number">
            STEP 07
        </div>

        <h2>
            Generating a Bill
        </h2>

        <p>
            Billing uses appointment and treatment
            information to calculate the applicable charges.
        </p>

        <ul>
            <li>Select the relevant appointment.</li>
            <li>Review the patient information.</li>
            <li>Review the consultation fee.</li>
            <li>Review the treatment fee.</li>
            <li>Check the total amount.</li>
            <li>Generate the bill or receipt.</li>
        </ul>

    </div>


    <div class="step">

        <div class="step-number">
            STEP 08
        </div>

        <h2>
            Viewing Reports
        </h2>

        <p>
            Reports provide information about appointments,
            treatments and billing activity.
        </p>

        <ul>
            <li>Open the Reports section.</li>
            <li>Select the required report.</li>
            <li>Review the displayed information.</li>
            <li>Apply available filters when required.</li>
        </ul>

    </div>


    <div class="step">

        <div class="step-number">
            STEP 09
        </div>

        <h2>
            Logging Out
        </h2>

        <p>
            Always log out after completing your work.
        </p>

        <ul>
            <li>Finish your current work.</li>
            <li>Click Logout.</li>
            <li>Confirm that the login page is displayed.</li>
        </ul>

    </div>


    <div class="finish">

        <h2>
            You're Ready!
        </h2>

        <p>
            You have completed the new staff introduction.
            Click below to continue to the dashboard.
        </p>

        <form method="post"
              action="<%= request.getContextPath() %>/help">

            <button type="submit">
                Finish Guide & Continue
            </button>

        </form>

    </div>

</div>

</body>

</html>