<%@ page language="java"
    contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="java.util.List" %>

<%@ page import="com.sunrise.model.Appointment" %>
<%@ page import="com.sunrise.model.Patient" %>
<%@ page import="com.sunrise.model.Dentist" %>
<%@ page import="com.sunrise.model.Treatment" %>


<%
    Appointment appointment =
        (Appointment) request.getAttribute("appointment");

    List<Patient> patients =
        (List<Patient>) request.getAttribute("patients");

    List<Dentist> dentists =
        (List<Dentist>) request.getAttribute("dentists");

    List<Treatment> treatments =
        (List<Treatment>) request.getAttribute("treatments");

    String formMode =
        (String) request.getAttribute("formMode");

    String generatedAppointmentNumber =
        (String) request.getAttribute(
            "generatedAppointmentNumber"
        );

    boolean editMode =
        "edit".equals(formMode);

    String title =
        editMode
            ? "Edit Appointment"
            : "Book Appointment";

    String buttonText =
        editMode
            ? "Update Appointment"
            : "Book Appointment";
%>


<!DOCTYPE html>

<html lang="en">

<head>

    <meta charset="UTF-8">

    <meta
        name="viewport"
        content="width=device-width, initial-scale=1.0">

    <title>
        <%= title %> | Sunrise Dental Clinic
    </title>


    <script src="https://cdn.tailwindcss.com"></script>


    <script>

        tailwind.config = {

            theme: {

                extend: {

                    fontFamily: {

                        manrope:
                            ['Manrope', 'sans-serif'],

                        inter:
                            ['Inter', 'sans-serif']

                    }

                }

            }

        };

    </script>


    <link
        rel="preconnect"
        href="https://fonts.googleapis.com">


    <link
        rel="preconnect"
        href="https://fonts.gstatic.com"
        crossorigin>


    <link
        href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600&family=Manrope:wght@400;500;600;700;800&display=swap"
        rel="stylesheet">


    <style>

        body {
            font-family: 'Manrope', sans-serif;
        }


        .font-manrope {
            font-family: 'Manrope', sans-serif;
        }


        .font-inter {
            font-family: 'Inter', sans-serif;
        }


        .search-dropdown {
            position: relative;
            width: 100%;
        }


        .search-trigger {
            width: 100%;
            min-height: 42px;
            display: flex;
            align-items: center;
            justify-content: space-between;
            gap: 10px;
            border: 1px solid #e2e8f0;
            border-radius: 8px;
            background: white;
            padding: 10px 12px;
            font-size: 12px;
            text-align: left;
            cursor: pointer;
            transition: all 0.15s ease;
        }


        .search-trigger:hover {
            border-color: #cbd5e1;
        }


        .search-trigger:focus {
            outline: none;
            border-color: #3b82f6;
            box-shadow: 0 0 0 4px #eff6ff;
        }


        .search-trigger.selected {
            color: #172033;
        }


        .search-trigger.placeholder {
            color: #94a3b8;
        }


        .search-trigger.field-error {
            border-color: #ef4444 !important;
        }


        .search-arrow {
            width: 16px;
            height: 16px;
            flex-shrink: 0;
            transition: transform 0.15s ease;
        }


        .search-dropdown.open .search-arrow {
            transform: rotate(180deg);
        }


        .search-menu {
            position: absolute;
            z-index: 100;
            top: calc(100% + 6px);
            left: 0;
            right: 0;
            background: white;
            border: 1px solid #e2e8f0;
            border-radius: 10px;
            box-shadow:
                0 10px 25px rgba(15, 23, 42, 0.08),
                0 4px 10px rgba(15, 23, 42, 0.04);
            overflow: hidden;
            display: none;
        }


        .search-dropdown.open .search-menu {
            display: block;
        }


        .search-box-wrapper {
            padding: 8px;
            border-bottom: 1px solid #f1f5f9;
            background: white;
        }


        .search-box {
            width: 100%;
            height: 36px;
            border: 1px solid #e2e8f0;
            border-radius: 7px;
            padding: 0 10px 0 34px;
            font-size: 11px;
            color: #172033;
            outline: none;
            background: #f8fafc;
        }


        .search-box:focus {
            border-color: #3b82f6;
            background: white;
            box-shadow: 0 0 0 3px #eff6ff;
        }


        .search-box-icon {
            position: absolute;
            left: 18px;
            top: 18px;
            width: 14px;
            height: 14px;
            color: #94a3b8;
            pointer-events: none;
        }


        .search-options {
            max-height: 220px;
            overflow-y: auto;
        }


        .search-option {
            width: 100%;
            padding: 10px 12px;
            border: none;
            background: white;
            text-align: left;
            font-size: 11px;
            color: #334155;
            cursor: pointer;
        }


        .search-option:hover {
            background: #eff6ff;
            color: #1d4ed8;
        }


        .search-no-results {
            padding: 16px 12px;
            text-align: center;
            font-size: 10px;
            color: #94a3b8;
        }


        .validation-message {
            display: none;
            margin-top: 5px;
            font-size: 9px;
            color: #dc2626;
            font-family: Inter, sans-serif;
        }


        .validation-message.show {
            display: block;
        }


        /* =========================================
           TIME SLOTS
        ========================================= */

        .time-slots {
            display: grid;
            grid-template-columns:
                repeat(4, minmax(0, 1fr));
            gap: 8px;
        }


        .time-slot {

            min-height: 42px;

            border: 1px solid #e2e8f0;

            border-radius: 8px;

            background: white;

            color: #475569;

            font-family: Inter, sans-serif;

            font-size: 10px;

            font-weight: 600;

            cursor: pointer;

            transition: all 0.15s ease;
        }


        .time-slot:hover {

            border-color: #bfdbfe;

            background: #eff6ff;

            color: #2563eb;
        }


        .time-slot.selected {

            border-color: #2563eb;

            background: #eff6ff;

            color: #2563eb;

            box-shadow:
                0 0 0 2px #dbeafe;
        }


        .time-slot-loading {

            padding: 18px;

            border: 1px dashed #e2e8f0;

            border-radius: 8px;

            text-align: center;

            font-family: Inter, sans-serif;

            font-size: 10px;

            color: #94a3b8;
        }


        .time-slot-empty {

            padding: 18px;

            border: 1px dashed #fecaca;

            background: #fffafa;

            border-radius: 8px;

            text-align: center;

            font-family: Inter, sans-serif;

            font-size: 10px;

            line-height: 1.5;

            color: #b91c1c;
        }


        .time-slot-hint {

            padding: 18px;

            border: 1px dashed #e2e8f0;

            border-radius: 8px;

            text-align: center;

            font-family: Inter, sans-serif;

            font-size: 10px;

            color: #94a3b8;
        }


        @media (max-width: 700px) {

            .time-slots {

                grid-template-columns:
                    repeat(3, minmax(0, 1fr));
            }

        }

    </style>

</head>


<body
    class="min-h-screen bg-[#F5F7FB] font-manrope text-[#172033]">


<div class="flex min-h-screen">


    <!-- =========================================
         SIDEBAR
    ========================================== -->

    <jsp:include
        page="../common/sidebar.jsp" />


    <!-- =========================================
         MAIN
    ========================================== -->

    <main
        class="ml-[250px] min-h-screen flex-1 px-8 py-7">


        <div
            class="mb-7">


            <h1
                class="text-[24px] font-extrabold tracking-[-0.6px]">

                <%= title %>

            </h1>


            <p
                class="mt-1 font-inter text-xs text-slate-500">

                <%= editMode
                    ? "Update the appointment details below."
                    : "Create a new patient appointment." %>

            </p>

        </div>


        <div
            class="mx-auto max-w-[950px]">


            <!-- ERROR -->

            <% if (request.getAttribute("error") != null) { %>

                <div
                    class="mb-5 flex gap-3 rounded-lg border border-red-100 bg-red-50 px-4 py-3 text-xs font-semibold text-red-700">

                    <span
                        class="flex h-5 w-5 shrink-0 items-center justify-center rounded-full bg-red-100">

                        !

                    </span>


                    <span>

                        <%= request.getAttribute("error") %>

                    </span>

                </div>

            <% } %>


            <!-- EDIT INFO -->

            <% if (editMode) { %>

                <div
                    class="mb-5 flex gap-8 rounded-xl border border-slate-200 bg-white px-5 py-4">


                    <div>

                        <p
                            class="font-inter text-[9px] font-semibold uppercase tracking-wide text-slate-400">

                            Appointment ID

                        </p>


                        <p
                            class="mt-1 text-xs font-bold">

                            <%= appointment.getAppointmentId() %>

                        </p>

                    </div>


                    <div>

                        <p
                            class="font-inter text-[9px] font-semibold uppercase tracking-wide text-slate-400">

                            Appointment Number

                        </p>


                        <p
                            class="mt-1 text-xs font-bold">

                            <%= appointment.getAppointmentNumber() %>

                        </p>

                    </div>

                </div>

            <% } %>


            <!-- FORM -->

            <form
                method="post"
                action="<%= request.getContextPath() %>/appointments/<%= editMode ? "edit" : "add" %>"
                id="appointmentForm">


                <% if (editMode) { %>

                    <input
                        type="hidden"
                        name="appointmentId"
                        value="<%= appointment.getAppointmentId() %>">

                <% } %>


                <!-- =====================================
                     APPOINTMENT DETAILS
                ====================================== -->

                <div
                    class="mb-5 rounded-xl border border-slate-200 bg-white p-6">


                    <div
                        class="mb-6 flex items-center gap-3">


                        <div
                            class="flex h-9 w-9 items-center justify-center rounded-lg bg-blue-50 text-xs font-extrabold text-blue-600">

                            A

                        </div>


                        <h2
                            class="text-sm font-extrabold">

                            Appointment Details

                        </h2>

                    </div>


                    <div
                        class="grid grid-cols-2 gap-x-5 gap-y-5">


                        <!-- NUMBER -->

                        <% if (!editMode) { %>

                            <div
                                class="col-span-2">
<label
                                    class="mb-1.5 block text-[10px] font-bold">

                                    Appointment Number

                                </label>


                                <input
                                    type="text"
                                    name="appointmentNumber"
                                    value="<%= generatedAppointmentNumber != null
                                        ? generatedAppointmentNumber
                                        : "Generating..." %>"
                                    readonly
                                    class="w-full cursor-not-allowed rounded-lg border border-slate-200 bg-slate-50 px-3 py-2.5 text-xs text-slate-600 outline-none">


                                <p
                                    class="mt-1.5 font-inter text-[9px] text-slate-400">

                                    Automatically generated by the system.

                                </p>

                            </div>

                        <% } %>


                        <!-- PATIENT -->

                        <div>

                            <label
                                class="mb-1.5 block text-[10px] font-bold">

                                Patient

                                <span class="text-red-500">*</span>

                            </label>


                            <input
                                type="hidden"
                                id="patientId"
                                name="patientId"
                                value="<%= appointment != null
                                    ? appointment.getPatientId()
                                    : "" %>">


                            <div
                                class="search-dropdown"
                                id="patientDropdown">


                                <button
                                    type="button"
                                    class="search-trigger <%= appointment != null
                                        ? "selected"
                                        : "placeholder" %>"
                                    id="patientTrigger">


                                    <span
                                        id="patientSelectedText">

                                        <%
                                            String selectedPatientText =
                                                "";

                                            if (appointment != null
                                                    && patients != null) {

                                                for (Patient patient
                                                        : patients) {

                                                    if (patient.getPatientId()
                                                            == appointment.getPatientId()) {

                                                        selectedPatientText =
                                                            patient.getPatientCode()
                                                            + " - "
                                                            + patient.getName();

                                                        break;
                                                    }
                                                }
                                            }

                                            if (!selectedPatientText.isEmpty()) {
                                        %>

                                            <%= selectedPatientText %>

                                        <%
                                            } else {
                                        %>

                                            -- Select Patient --

                                        <%
                                            }
                                        %>

                                    </span>


                                    <svg
                                        class="search-arrow"
                                        viewBox="0 0 20 20"
                                        fill="currentColor">

                                        <path
                                            fill-rule="evenodd"
                                            d="M5.23 7.21a.75.75 0 011.06.02L10 11.168l3.71-3.938a.75.75 0 111.08 1.04l-4.25 4.51a.75.75 0 01-1.08 0l-4.25-4.51a.75.75 0 01-1.08 1.06l-4.25-4.51a.75.75 0 01.02-1.06z"
                                            clip-rule="evenodd" />

                                    </svg>

                                </button>


                                <div
                                    class="search-menu">


                                    <div
                                        class="search-box-wrapper relative">


                                        <input
                                            type="text"
                                            class="search-box"
                                            placeholder="Search patient..."
                                            autocomplete="off">


                                    </div>


                                    <div
                                        class="search-options">


                                        <% if (patients != null
                                                && !patients.isEmpty()) { %>


                                            <% for (Patient patient
                                                    : patients) { %>


                                                <button
                                                    type="button"
                                                    class="search-option"
                                                    data-value="<%= patient.getPatientId() %>"
                                                    data-search="<%= patient.getPatientCode() %> <%= patient.getName() %>">

                                                    <%= patient.getPatientCode() %>
                                                    -
                                                    <%= patient.getName() %>

                                                </button>


                                            <% } %>


                                        <% } else { %>


                                            <div
                                                class="search-no-results">

                                                No patients available.

                                            </div>


                                        <% } %>

                                    </div>

                                </div>

                            </div>


                            <div
                                class="validation-message"
                                id="patientError">

                                Please select a patient.

                            </div>

                        </div>


                        <!-- DENTIST -->

                        <div>

                            <label
                                class="mb-1.5 block text-[10px] font-bold">

                                Dentist

                                <span class="text-red-500">*</span>

                            </label>


                            <input
                                type="hidden"
                                id="dentistId"
                                name="dentistId"
                                value="<%= appointment != null
                                    ? appointment.getDentistId()
                                    : "" %>">


                            <div
                                class="search-dropdown"
                                id="dentistDropdown">


                                <button
                                    type="button"
                                    class="search-trigger <%= appointment != null
                                        ? "selected"
                                        : "placeholder" %>"
                                    id="dentistTrigger">


                                    <span
                                        id="dentistSelectedText">

                                        <%
                                            String selectedDentistText =
                                                "";

                                            if (appointment != null
                                                    && dentists != null) {

                                                for (Dentist dentist
                                                        : dentists) {

                                                    if (dentist.getDentistId()
                                                            == appointment.getDentistId()) {

                                                        selectedDentistText =
                                                            dentist.getDentistName()
                                                            + " - "
                                                            + dentist.getSpecialization();

                                                        break;
                                                    }
                                                }
                                            }

                                            if (!selectedDentistText.isEmpty()) {
                                        %>

                                            <%= selectedDentistText %>

                                        <%
                                            } else {
                                        %>

                                            -- Select Dentist --

                                        <%
                                            }
                                        %>

                                    </span>


                                    <svg
                                        class="search-arrow"
                                        viewBox="0 0 20 20"
                                        fill="currentColor">

                                        <path
                                            fill-rule="evenodd"
                                            d="M5.23 7.21a.75.75 0 011.06.02L10 11.168l3.71-3.938a.75.75 0 111.08 1.04l-4.25 4.51a.75.75 0 01-1.08 0l-4.25-4.51a.75.75 0 01-1.08 1.06l-4.25-4.51a.75.75 0 01-1.08 0l-4.25-4.51a.75.75 0 01.02-1.06z"
                                            clip-rule="evenodd" />

                                    </svg>

                                </button>


                                <div
                                    class="search-menu">


                                    <div
                                        class="search-box-wrapper relative">


                                        <input
                                            type="text"
                                            class="search-box"
                                            placeholder="Search dentist..."
                                            autocomplete="off">


                                    </div>


                                    <div
                                        class="search-options">


                                        <% if (dentists != null
                                                && !dentists.isEmpty()) { %>


                                            <% for (Dentist dentist
                                                    : dentists) { %>


                                                <button
                                                    type="button"
                                                    class="search-option"
                                                    data-value="<%= dentist.getDentistId() %>"
                                                    data-search="<%= dentist.getDentistName() %> <%= dentist.getSpecialization() %>">

                                                    <%= dentist.getDentistName() %>
                                                    -
                                                    <%= dentist.getSpecialization() %>

                                                </button>


                                            <% } %>


                                        <% } else { %>


                                            <div
                                                class="search-no-results">

                                                No dentists available.

                                            </div>


                                        <% } %>

                                    </div>

                                </div>

                            </div>


                            <div
                                class="validation-message"
                                id="dentistError">

                                Please select a dentist.

                            </div>

                        </div>


                        <!-- TREATMENT -->

                        <div
                            class="col-span-2">


                            <label
                                class="mb-1.5 block text-[10px] font-bold">

                                Treatment

                                <span class="text-red-500">*</span>

                            </label>


                            <input
                                type="hidden"
                                id="treatmentId"
                                name="treatmentId"
                                value="<%= appointment != null
                                    ? appointment.getTreatmentId()
                                    : "" %>">


                            <div
                                class="search-dropdown"
                                id="treatmentDropdown">


                                <button
                                    type="button"
                                    class="search-trigger <%= appointment != null
                                        ? "selected"
                                        : "placeholder" %>"
                                    id="treatmentTrigger">


                                    <span
                                        id="treatmentSelectedText">

                                        <%
                                            String selectedTreatmentText =
                                                "";

                                            if (appointment != null
                                                    && treatments != null) {

                                                for (Treatment treatment
                                                        : treatments) {

                                                    if (treatment.getTreatmentId()
                                                            == appointment.getTreatmentId()) {

                                                        selectedTreatmentText =
                                                            treatment.getTreatmentName()
                                                            + " - LKR "
                                                            + String.format(
                                                                "%.2f",
                                                                treatment.getTreatmentFee()
                                                            );

                                                        break;
                                                    }
                                                }
                                            }

                                            if (!selectedTreatmentText.isEmpty()) {
                                        %>

                                            <%= selectedTreatmentText %>

                                        <%
                                            } else {
                                        %>

                                            -- Select Treatment --

                                        <%
                                            }
                                        %>

                                    </span>


                                    <svg
                                        class="search-arrow"
                                        viewBox="0 0 20 20"
                                        fill="currentColor">

                                        <path
                                            fill-rule="evenodd"
                                            d="M5.23 7.21a.75.75 0 011.06.02L10 11.168l3.71-3.938a.75.75 0 111.08 1.04l-4.25-4.51a.75.75 0 01.02-1.06z"
                                            clip-rule="evenodd" />

                                    </svg>

                                </button>


                                <div
                                    class="search-menu">


                                    <div
                                        class="search-box-wrapper relative">


                                        <input
                                            type="text"
                                            class="search-box"
                                            placeholder="Search treatment..."
                                            autocomplete="off">


                                    </div>


                                    <div
                                        class="search-options">


                                        <% if (treatments != null
                                                && !treatments.isEmpty()) { %>


                                            <% for (Treatment treatment
                                                    : treatments) { %>


                                                <button
                                                    type="button"
                                                    class="search-option"
                                                    data-value="<%= treatment.getTreatmentId() %>"
                                                    data-search="<%= treatment.getTreatmentName() %> <%= treatment.getTreatmentFee() %>">

                                                    <%= treatment.getTreatmentName() %>
                                                    -
                                                    LKR
                                                    <%= String.format(
                                                        "%.2f",
                                                        treatment.getTreatmentFee()
                                                    ) %>

                                                </button>


                                            <% } %>


                                        <% } else { %>


                                            <div
                                                class="search-no-results">

                                                No treatments available.

                                            </div>


                                        <% } %>

                                    </div>

                                </div>

                            </div>


                            <div
                                class="validation-message"
                                id="treatmentError">

                                Please select a treatment.

                            </div>

                        </div>


                    </div>

                </div>


                <!-- =====================================
                     SCHEDULE
                ====================================== -->

                <div
                    class="mb-5 rounded-xl border border-slate-200 bg-white p-6">


                    <div
                        class="mb-6 flex items-center gap-3">


                        <div
                            class="flex h-9 w-9 items-center justify-center rounded-lg bg-blue-50 text-xs font-extrabold text-blue-600">

                            C

                        </div>


                        <div>

                            <h2
                                class="text-sm font-extrabold">

                                Schedule &amp; Status

                            </h2>


                            <p
                                class="mt-1 font-inter text-[9px] text-slate-400">

                                Select a dentist and date to see available appointment times.

                            </p>

                        </div>

                    </div>


                    <div
                        class="grid grid-cols-2 gap-5">


                        <!-- DATE -->

                        <div
                            class="col-span-2">


                            <label
                                for="appointmentDate"
                                class="mb-1.5 block text-[10px] font-bold">

                                Appointment Date

                                <span class="text-red-500">*</span>

                            </label>


                            <input
                                type="date"
                                id="appointmentDate"
                                name="appointmentDate"
                                value="<%= appointment != null
                                    && appointment.getAppointmentDate() != null
                                    ? appointment.getAppointmentDate()
                                    : "" %>"
                                required
                                class="w-full rounded-lg border border-slate-200 px-3 py-2.5 text-xs outline-none focus:border-blue-500 focus:ring-4 focus:ring-blue-50">


                            <p
                                class="mt-1.5 font-inter text-[9px] text-slate-400">

                                Change the date if the dentist does not work on the selected day.

                            </p>

                        </div>


                        <!-- =================================
                             TIME
                        ================================== -->

                        <div
                            class="col-span-2">


                            <label
                                class="mb-1.5 block text-[10px] font-bold">

                                Available Time

                                <span class="text-red-500">*</span>

                            </label>


                            <!-- Actual value sent to controller -->

                            <input
                                type="hidden"
                                id="appointmentTime"
                                name="appointmentTime"
                                value="<%= appointment != null
                                    && appointment.getAppointmentTime() != null
                                    ? appointment.getAppointmentTime()
                                    : "" %>">


                            <!-- TIME SLOTS -->

                            <div
                                id="timeSlots"
                                class="time-slots">


                                <% if (editMode) { %>

                                    <div
                                        class="time-slot-hint col-span-full">

                                        Loading available times...

                                    </div>

                                <% } else { %>

                                    <div
                                        class="time-slot-hint col-span-full">

                                        Select a dentist and date to see available times.

                                    </div>

                                <% } %>


                            </div>


                            <div
                                id="timeError"
                                class="validation-message">

                                Please select an available appointment time.

                            </div>

                        </div>


                        <!-- STATUS -->

                        <div
                            class="col-span-2">


                            <label
                                for="status"
                                class="mb-1.5 block text-[10px] font-bold">

                                Status

                                <span class="text-red-500">*</span>

                            </label>


                            <select
                                id="status"
                                name="status"
                                required
                                class="w-full rounded-lg border border-slate-200 bg-white px-3 py-2.5 text-xs outline-none focus:border-blue-500 focus:ring-4 focus:ring-blue-50">


                                <option
                                    value="SCHEDULED"
                                    <%= appointment == null
                                        || "SCHEDULED".equals(
                                            appointment.getStatus()
                                        )
                                        ? "selected"
                                        : "" %>>

                                    Scheduled

                                </option>


                                <option
                                    value="COMPLETED"
                                    <%= appointment != null
                                        && "COMPLETED".equals(
                                            appointment.getStatus()
                                        )
                                        ? "selected"
                                        : "" %>>

                                    Completed

                                </option>


                                <option
                                    value="CANCELLED"
                                    <%= appointment != null
                                        && "CANCELLED".equals(
                                            appointment.getStatus()
                                        )
                                        ? "selected"
                                        : "" %>>

                                    Cancelled

                                </option>


                                <option
                                    value="NO_SHOW"
                                    <%= appointment != null
                                        && "NO_SHOW".equals(
                                            appointment.getStatus()
                                        )
                                        ? "selected"
                                        : "" %>>

                                    No Show

                                </option>


                                <option
                                    value="BILLED"
                                    <%= appointment != null
                                        && "BILLED".equals(
                                            appointment.getStatus()
                                        )
                                        ? "selected"
                                        : "" %>>

                                    Billed

                                </option>

                            </select>

                        </div>

                    </div>

                </div>


                <!-- =====================================
                     NOTES
                ====================================== -->

                <div
                    class="mb-5 rounded-xl border border-slate-200 bg-white p-6">


                    <div
                        class="mb-6 flex items-center gap-3">


                        <div
                            class="flex h-9 w-9 items-center justify-center rounded-lg bg-blue-50 text-xs font-extrabold text-blue-600">

                            N

                        </div>


                        <h2
                            class="text-sm font-extrabold">

                            Additional Notes

                        </h2>

                    </div>


                    <label
                        for="notes"
                        class="mb-1.5 block text-[10px] font-bold">

                        Notes

                        <span
                            class="ml-1 font-inter text-[9px] font-medium text-slate-400">

                            Optional

                        </span>

                    </label>


                    <textarea
                        id="notes"
                        name="notes"
                        maxlength="500"
                        placeholder="Enter any additional notes..."
                        class="min-h-[110px] w-full resize-y rounded-lg border border-slate-200 px-3 py-2.5 text-xs leading-relaxed outline-none placeholder:text-slate-400 focus:border-blue-500 focus:ring-4 focus:ring-blue-50"><%= appointment != null
                            && appointment.getNotes() != null
                            ? appointment.getNotes()
                            : "" %></textarea>

                </div>


                <!-- ACTIONS -->

                <div
                    class="flex items-center justify-between">


                    <p
                        class="font-inter text-[9px] text-slate-400">

                        <span class="text-red-500">*</span>

                        Required fields

                    </p>


                    <div
                        class="flex gap-2">


                        <a
                            href="<%= request.getContextPath() %>/appointments"
                            class="rounded-lg border border-slate-200 bg-white px-4 py-2.5 text-xs font-semibold text-slate-600 hover:bg-slate-50">

                            Cancel

                        </a>


                        <button
                            type="submit"
                            class="rounded-lg bg-[#2563EB] px-5 py-2.5 text-xs font-bold text-white hover:bg-[#1D4ED8]">

                            <%= buttonText %>

                        </button>

                    </div>

                </div>


            </form>

        </div>

    </main>

</div>


<script>

document.addEventListener(
    "DOMContentLoaded",
    function () {


    // =====================================================
    // SEARCHABLE DROPDOWNS
    // =====================================================

    function initializeSearchDropdown(config) {

        const dropdown =
            document.getElementById(
                config.dropdownId
            );

        const trigger =
            document.getElementById(
                config.triggerId
            );

        const selectedText =
            document.getElementById(
                config.selectedTextId
            );

        const hiddenInput =
            document.getElementById(
                config.hiddenInputId
            );

        const errorMessage =
            document.getElementById(
                config.errorId
            );


        if (!dropdown ||
            !trigger ||
            !selectedText ||
            !hiddenInput) {

            return;
        }


        const searchInput =
            dropdown.querySelector(
                ".search-box"
            );


        const optionsContainer =
            dropdown.querySelector(
                ".search-options"
            );


        const options =
            dropdown.querySelectorAll(
                ".search-option"
            );


        trigger.addEventListener(
            "click",
            function (event) {

                event.stopPropagation();


                const isOpen =
                    dropdown.classList.contains(
                        "open"
                    );


                document
                    .querySelectorAll(
                        ".search-dropdown"
                    )
                    .forEach(
                        function (other) {

                            if (other !== dropdown) {

                                other.classList.remove(
                                    "open"
                                );
                            }
                        }
                    );


                if (isOpen) {

                    dropdown.classList.remove(
                        "open"
                    );

                } else {

                    dropdown.classList.add(
                        "open"
                    );

                    setTimeout(
                        function () {

                            if (searchInput) {

                                searchInput.focus();
                            }

                        },
                        50
                    );
                }
            }
        );


        if (searchInput) {

            searchInput.addEventListener(
                "input",
                function () {

                    const value =
                        this.value
                            .toLowerCase()
                            .trim();


                    let visible =
                        0;


                    options.forEach(
                        function (option) {

                            const text =
                                option
                                    .getAttribute(
                                        "data-search"
                                    )
                                    .toLowerCase();


                            if (
                                value === ""
                                ||
                                text.includes(value)
                            ) {

                                option.style.display =
                                    "block";

                                visible++;

                            } else {

                                option.style.display =
                                    "none";
                            }
                        }
                    );


                    let noResults =
                        optionsContainer.querySelector(
                            ".dynamic-no-results"
                        );


                    if (visible === 0) {

                        if (!noResults) {

                            noResults =
                                document.createElement(
                                    "div"
                                );

                            noResults.className =
                                "search-no-results dynamic-no-results";

                            noResults.textContent =
                                "No results found.";

                            optionsContainer.appendChild(
                                noResults
                            );
                        }

                    } else if (noResults) {

                        noResults.remove();
                    }
                }
            );
        }


        options.forEach(
            function (option) {

                option.addEventListener(
                    "click",
                    function () {

                        const value =
                            this.getAttribute(
                                "data-value"
                            );


                        const text =
                            this.textContent.trim();


                        hiddenInput.value =
                            value;


                        selectedText.textContent =
                            text;


                        trigger.classList.remove(
                            "placeholder"
                        );


                        trigger.classList.add(
                            "selected"
                        );


                        trigger.classList.remove(
                            "field-error"
                        );


                        if (errorMessage) {

                            errorMessage.classList.remove(
                                "show"
                            );
                        }


                        dropdown.classList.remove(
                            "open"
                        );


                        if (searchInput) {

                            searchInput.value =
                                "";
                        }


                        options.forEach(
                            function (item) {

                                item.style.display =
                                    "block";
                            }
                        );


                        const noResults =
                            optionsContainer.querySelector(
                                ".dynamic-no-results"
                            );


                        if (noResults) {

                            noResults.remove();
                        }


                        // =================================
                        // DENTIST SELECTED
                        // =================================

                        if (
                            config.type ===
                            "dentist"
                        ) {

                            clearTimeSelection();

                            loadAvailableSlots();
                        }

                    }
                );
            }
        );
    }


    // =====================================================
    // TIME SLOT ELEMENTS
    // =====================================================

    const dentistInput =
        document.getElementById(
            "dentistId"
        );


    const dateInput =
        document.getElementById(
            "appointmentDate"
        );


    const timeInput =
        document.getElementById(
            "appointmentTime"
        );


    const timeSlots =
        document.getElementById(
            "timeSlots"
        );


    const timeError =
        document.getElementById(
            "timeError"
        );


    // =====================================================
    // CLEAR TIME
    // =====================================================

    function clearTimeSelection() {

        timeInput.value =
            "";


        timeSlots.innerHTML = `

            <div
                class="time-slot-hint col-span-full">

                Select a dentist and date to see available times.

            </div>

        `;


        timeError.classList.remove(
            "show"
        );
    }


    // =====================================================
    // LOAD AVAILABLE SLOTS
    // =====================================================

    function loadAvailableSlots() {

        const dentistId =
            dentistInput.value;


        const date =
            dateInput.value;


        /*
         * Both are required.
         */

        if (!dentistId || !date) {

            clearTimeSelection();

            return;
        }


        /*
         * Clear previous selection.
         */

        timeInput.value =
            "";


        timeSlots.innerHTML = `

            <div
                class="time-slot-loading col-span-full">

                Loading available times...

            </div>

        `;


        /*
         * Build URL.
         */

        let url =
            "<%= request.getContextPath() %>"
            + "/appointments/slots"
            + "?dentistId="
            + encodeURIComponent(
                dentistId
            )
            + "&appointmentDate="
            + encodeURIComponent(
                date
            );


        <% if (editMode) { %>

            url +=
                "&appointmentId="
                + encodeURIComponent(
                    "<%= appointment.getAppointmentId() %>"
                );

        <% } %>


        fetch(url)

            .then(
                function (response) {

                    if (!response.ok) {

                        throw new Error(
                            "Unable to load time slots."
                        );
                    }

                    return response.json();
                }
            )

            .then(
                function (data) {

                    timeSlots.innerHTML =
                        "";


                    if (
                        !data.available
                        ||
                        !data.slots
                        ||
                        data.slots.length === 0
                    ) {

                        timeSlots.innerHTML = `

                            <div
                                class="time-slot-empty col-span-full">

                                ${
                                    data.message
                                    ||
                                    "No available time slots for this date."
                                }

                                <br>

                                Please select another date.

                            </div>

                        `;

                        return;
                    }


                    data.slots.forEach(
                        function (slot) {

                            const button =
                                document.createElement(
                                    "button"
                                );


                            button.type =
                                "button";


                            button.className =
                                "time-slot";


                            button.textContent =
                                slot.label;


                            button.dataset.time =
                                slot.value;


                            button.addEventListener(
                                "click",
                                function () {

                                    document
                                        .querySelectorAll(
                                            ".time-slot"
                                        )
                                        .forEach(
                                            function (
                                                item
                                            ) {

                                                item.classList.remove(
                                                    "selected"
                                                );
                                            }
                                        );


                                    button.classList.add(
                                        "selected"
                                    );


                                    timeInput.value =
                                        slot.value;


                                    timeError.classList.remove(
                                        "show"
                                    );
                                }
                            );


                            /*
                             * Restore selected time
                             * when editing.
                             */

                            <% if (editMode) { %>

                                const currentTime =
                                    "<%= appointment.getAppointmentTime() %>";


                                if (
                                    currentTime
                                    &&
                                    slot.value
                                        .startsWith(
                                            currentTime.substring(
                                                0,
                                                5
                                            )
                                        )
                                ) {

                                    button.classList.add(
                                        "selected"
                                    );

                                    timeInput.value =
                                        slot.value;
                                }

                            <% } %>


                            timeSlots.appendChild(
                                button
                            );
                        }
                    );
                }
            )

            .catch(
                function (error) {

                    console.error(error);


                    timeSlots.innerHTML = `

                        <div
                            class="time-slot-empty col-span-full">

                            Unable to load available times.

                            <br>

                            Please try again.

                        </div>

                    `;
                }
            );
    }


    // =====================================================
    // DATE CHANGED
    // =====================================================

    dateInput.addEventListener(
        "change",
        function () {

            clearTimeSelection();

            loadAvailableSlots();
        }
    );


    // =====================================================
    // INITIALIZE SEARCH DROPDOWNS
    // =====================================================

    initializeSearchDropdown({

        dropdownId:
            "patientDropdown",

        triggerId:
            "patientTrigger",

        selectedTextId:
            "patientSelectedText",

        hiddenInputId:
            "patientId",

        errorId:
            "patientError",

        type:
            "patient"
    });


    initializeSearchDropdown({

        dropdownId:
            "dentistDropdown",

        triggerId:
            "dentistTrigger",

        selectedTextId:
            "dentistSelectedText",

        hiddenInputId:
            "dentistId",

        errorId:
            "dentistError",

        type:
            "dentist"
    });


    initializeSearchDropdown({

        dropdownId:
            "treatmentDropdown",

        triggerId:
            "treatmentTrigger",

        selectedTextId:
            "treatmentSelectedText",

        hiddenInputId:
            "treatmentId",

        errorId:
            "treatmentError",

        type:
            "treatment"
    });


    // =====================================================
    // CLOSE DROPDOWNS
    // =====================================================

    document.addEventListener(
        "click",
        function (event) {

            document
                .querySelectorAll(
                    ".search-dropdown"
                )
                .forEach(
                    function (dropdown) {

                        if (
                            !dropdown.contains(
                                event.target
                            )
                        ) {

                            dropdown.classList.remove(
                                "open"
                            );
                        }
                    }
                );
        }
    );


    // =====================================================
    // FORM VALIDATION
    // =====================================================

    const form =
        document.getElementById(
            "appointmentForm"
        );


    form.addEventListener(
        "submit",
        function (event) {

            let valid =
                true;


            // PATIENT

            const patient =
                document.getElementById(
                    "patientId"
                );


            if (!patient.value) {

                valid = false;

                document
                    .getElementById(
                        "patientTrigger"
                    )
                    .classList.add(
                        "field-error"
                    );

                document
                    .getElementById(
                        "patientError"
                    )
                    .classList.add(
                        "show"
                    );
            }


            // DENTIST

            const dentist =
                document.getElementById(
                    "dentistId"
                );


            if (!dentist.value) {

                valid = false;

                document
                    .getElementById(
                        "dentistTrigger"
                    )
                    .classList.add(
                        "field-error"
                    );

                document
                    .getElementById(
                        "dentistError"
                    )
                    .classList.add(
                        "show"
                    );
            }


            // TREATMENT

            const treatment =
                document.getElementById(
                    "treatmentId"
                );


            if (!treatment.value) {

                valid = false;

                document
                    .getElementById(
                        "treatmentTrigger"
                    )
                    .classList.add(
                        "field-error"
                    );

                document
                    .getElementById(
                        "treatmentError"
                    )
                    .classList.add(
                        "show"
                    );
            }


            // TIME

            if (!timeInput.value) {

                valid = false;

                timeError.classList.add(
                    "show"
                );
            }


            if (!valid) {

                event.preventDefault();

                const firstError =
                    document.querySelector(
                        ".field-error, .validation-message.show"
                    );


                if (firstError) {

                    firstError.scrollIntoView({
                        behavior: "smooth",
                        block: "center"
                    });
                }
            }

        }
    );


    // =====================================================
    // EDIT MODE
    // =====================================================

    <% if (editMode) { %>

        /*
         * Existing dentist + date already exist,
         * so load their available slots immediately.
         */

        loadAvailableSlots();

    <% } %>


});

</script>
</body>

</html>