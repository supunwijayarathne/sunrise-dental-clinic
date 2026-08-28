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
        (String) request.getAttribute("generatedAppointmentNumber");

    boolean editMode =
        "edit".equals(formMode);

    String title =
        editMode ? "Edit Appointment" : "Book Appointment";

    String buttonText =
        editMode ? "Update Appointment" : "Book Appointment";
%>

<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="UTF-8">

    <meta name="viewport"
          content="width=device-width, initial-scale=1.0">

    <title><%= title %> | Sunrise Dental Clinic</title>

    <!-- Tailwind CSS -->
    <script src="https://cdn.tailwindcss.com"></script>

    <script>
        tailwind.config = {
            theme: {
                extend: {
                    fontFamily: {
                        manrope: ['Manrope', 'sans-serif'],
                        inter: ['Inter', 'sans-serif']
                    }
                }
            }
        }
    </script>

    <!-- Fonts -->
    <link rel="preconnect"
          href="https://fonts.googleapis.com">

    <link rel="preconnect"
          href="https://fonts.gstatic.com"
          crossorigin>

    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600&family=Manrope:wght@400;500;600;700;800&display=swap"
          rel="stylesheet">

</head>


<body class="min-h-screen bg-[#F5F7FB] font-manrope text-[#172033]">


<div class="flex min-h-screen">

    <!-- SIDEBAR -->

    <jsp:include page="../common/sidebar.jsp" />


    <!-- MAIN CONTENT -->

    <main class="ml-[250px] min-h-screen flex-1 px-8 py-7">


        <!-- HEADER -->

        <div class="mb-7">

            <h1 class="text-[24px] font-extrabold tracking-[-0.6px]">
                <%= title %>
            </h1>

            <p class="mt-1 font-inter text-xs text-slate-500">

                <%= editMode
                    ? "Update the appointment details below."
                    : "Create a new patient appointment." %>

            </p>

        </div>


        <div class="mx-auto max-w-[950px]">


            <!-- ERROR MESSAGE -->

            <% if (request.getAttribute("error") != null) { %>

                <div class="mb-5 flex gap-3 rounded-lg border border-red-100 bg-red-50 px-4 py-3 text-xs font-semibold text-red-700">

                    <span class="flex h-5 w-5 shrink-0 items-center justify-center rounded-full bg-red-100">
                        !
                    </span>

                    <span>
                        <%= request.getAttribute("error") %>
                    </span>

                </div>

            <% } %>


            <!-- EDIT INFORMATION -->

            <% if (editMode) { %>

                <div class="mb-5 flex gap-8 rounded-xl border border-slate-200 bg-white px-5 py-4">

                    <!-- Appointment ID -->

                    <div>

                        <p class="font-inter text-[9px] font-semibold uppercase tracking-wide text-slate-400">
                            Appointment ID
                        </p>

                        <p class="mt-1 text-xs font-bold">
                            <%= appointment.getAppointmentId() %>
                        </p>

                    </div>


                    <!-- Appointment Number -->

                    <div>

                        <p class="font-inter text-[9px] font-semibold uppercase tracking-wide text-slate-400">
                            Appointment Number
                        </p>

                        <p class="mt-1 text-xs font-bold">
                            <%= appointment.getAppointmentNumber() %>
                        </p>

                    </div>

                </div>

            <% } %>


            <!-- FORM -->

            <form
                method="post"
                action="<%= request.getContextPath() %>/appointments/<%= editMode ? "edit" : "add" %>"
            >


                <!-- HIDDEN ID FOR EDIT -->

                <% if (editMode) { %>

                    <input
                        type="hidden"
                        name="appointmentId"
                        value="<%= appointment.getAppointmentId() %>"
                    >

                <% } %>


                <!-- ========================================== -->
                <!-- APPOINTMENT DETAILS -->
                <!-- ========================================== -->

                <div class="mb-5 rounded-xl border border-slate-200 bg-white p-6">


                    <!-- SECTION HEADER -->

                    <div class="mb-6 flex items-center gap-3">

                        <div class="flex h-9 w-9 items-center justify-center rounded-lg bg-blue-50 text-xs font-extrabold text-blue-600">
                            A
                        </div>

                        <h2 class="text-sm font-extrabold">
                            Appointment Details
                        </h2>

                    </div>


                    <div class="grid grid-cols-2 gap-x-5 gap-y-5">


                        <!-- ================================== -->
                        <!-- APPOINTMENT NUMBER -->
                        <!-- ================================== -->

                        <% if (!editMode) { %>

                            <div class="col-span-2">

                                <label
                                    for="appointmentNumber"
                                    class="mb-1.5 block text-[10px] font-bold"
                                >
                                    Appointment Number
                                </label>


                                <input
                                    type="text"
                                    id="appointmentNumber"
                                    name="appointmentNumber"
                                    maxlength="30"
                                    value="<%= generatedAppointmentNumber != null
                                        ? generatedAppointmentNumber
                                        : "Generating..." %>"
                                    readonly
                                    class="w-full cursor-not-allowed rounded-lg border border-slate-200 bg-slate-50 px-3 py-2.5 text-xs text-slate-600 outline-none"
                                >


                                <p class="mt-1.5 font-inter text-[9px] text-slate-400">
                                    Automatically generated by the system.
                                    This field cannot be edited.
                                </p>

                            </div>

                        <% } %>


                        <!-- ================================== -->
                        <!-- PATIENT -->
                        <!-- ================================== -->

                        <div>

                            <label
                                for="patientId"
                                class="mb-1.5 block text-[10px] font-bold"
                            >
                                Patient
                                <span class="text-red-500">*</span>
                            </label>


                            <select
                                id="patientId"
                                name="patientId"
                                required
                                class="w-full rounded-lg border border-slate-200 bg-white px-3 py-2.5 text-xs outline-none focus:border-blue-500 focus:ring-4 focus:ring-blue-50"
                            >

                                <option value="">
                                    -- Select Patient --
                                </option>


                                <% if (patients != null) { %>

                                    <% for (Patient patient : patients) { %>

                                        <option
                                            value="<%= patient.getPatientId() %>"

                                            <%= appointment != null
                                                && appointment.getPatientId()
                                                == patient.getPatientId()
                                                ? "selected"
                                                : "" %>
                                        >

                                            <%= patient.getPatientCode() %>
                                            -
                                            <%= patient.getName() %>

                                        </option>

                                    <% } %>

                                <% } %>

                            </select>

                        </div>


                        <!-- ================================== -->
                        <!-- DENTIST -->
                        <!-- ================================== -->

                        <div>

                            <label
                                for="dentistId"
                                class="mb-1.5 block text-[10px] font-bold"
                            >
                                Dentist
                                <span class="text-red-500">*</span>
                            </label>


                            <select
                                id="dentistId"
                                name="dentistId"
                                required
                                class="w-full rounded-lg border border-slate-200 bg-white px-3 py-2.5 text-xs outline-none focus:border-blue-500 focus:ring-4 focus:ring-blue-50"
                            >

                                <option value="">
                                    -- Select Dentist --
                                </option>


                                <% if (dentists != null) { %>

                                    <% for (Dentist dentist : dentists) { %>

                                        <option
                                            value="<%= dentist.getDentistId() %>"

                                            <%= appointment != null
                                                && appointment.getDentistId()
                                                == dentist.getDentistId()
                                                ? "selected"
                                                : "" %>
                                        >

                                            <%= dentist.getDentistName() %>
                                            -
                                            <%= dentist.getSpecialization() %>

                                        </option>

                                    <% } %>

                                <% } %>

                            </select>

                        </div>


                        <!-- ================================== -->
                        <!-- TREATMENT -->
                        <!-- ================================== -->

                        <div class="col-span-2">

                            <label
                                for="treatmentId"
                                class="mb-1.5 block text-[10px] font-bold"
                            >
                                Treatment
                                <span class="text-red-500">*</span>
                            </label>


                            <select
                                id="treatmentId"
                                name="treatmentId"
                                required
                                class="w-full rounded-lg border border-slate-200 bg-white px-3 py-2.5 text-xs outline-none focus:border-blue-500 focus:ring-4 focus:ring-blue-50"
                            >

                                <option value="">
                                    -- Select Treatment --
                                </option>


                                <% if (treatments != null) { %>

                                    <% for (Treatment treatment : treatments) { %>

                                        <option
                                            value="<%= treatment.getTreatmentId() %>"

                                            <%= appointment != null
                                                && appointment.getTreatmentId()
                                                == treatment.getTreatmentId()
                                                ? "selected"
                                                : "" %>
                                        >

                                            <%= treatment.getTreatmentName() %>
                                            -
                                            LKR
                                            <%= String.format(
                                                "%.2f",
                                                treatment.getTreatmentFee()
                                            ) %>

                                        </option>

                                    <% } %>

                                <% } %>

                            </select>

                        </div>


                    </div>

                </div>


                <!-- ========================================== -->
                <!-- SCHEDULE & STATUS -->
                <!-- ========================================== -->

                <div class="mb-5 rounded-xl border border-slate-200 bg-white p-6">


                    <!-- SECTION HEADER -->

                    <div class="mb-6 flex items-center gap-3">

                        <div class="flex h-9 w-9 items-center justify-center rounded-lg bg-blue-50 text-xs font-extrabold text-blue-600">
                            C
                        </div>

                        <h2 class="text-sm font-extrabold">
                            Schedule &amp; Status
                        </h2>

                    </div>


                    <div class="grid grid-cols-2 gap-5">


                        <!-- DATE -->

                        <div>

                            <label
                                for="appointmentDate"
                                class="mb-1.5 block text-[10px] font-bold"
                            >
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

                                class="w-full rounded-lg border border-slate-200 px-3 py-2.5 text-xs outline-none focus:border-blue-500 focus:ring-4 focus:ring-blue-50"
                            >

                        </div>


                        <!-- TIME -->

                        <div>

                            <label
                                for="appointmentTime"
                                class="mb-1.5 block text-[10px] font-bold"
                            >
                                Appointment Time
                                <span class="text-red-500">*</span>
                            </label>


                            <input
                                type="time"
                                id="appointmentTime"
                                name="appointmentTime"

                                value="<%= appointment != null
                                    && appointment.getAppointmentTime() != null
                                    ? appointment.getAppointmentTime()
                                    : "" %>"

                                required

                                class="w-full rounded-lg border border-slate-200 px-3 py-2.5 text-xs outline-none focus:border-blue-500 focus:ring-4 focus:ring-blue-50"
                            >

                        </div>


                        <!-- STATUS -->

                        <div class="col-span-2">

                            <label
                                for="status"
                                class="mb-1.5 block text-[10px] font-bold"
                            >
                                Status
                                <span class="text-red-500">*</span>
                            </label>


                            <select
                                id="status"
                                name="status"
                                required

                                class="w-full rounded-lg border border-slate-200 bg-white px-3 py-2.5 text-xs outline-none focus:border-blue-500 focus:ring-4 focus:ring-blue-50"
                            >


                                <option
                                    value="SCHEDULED"

                                    <%= appointment == null
                                        || "SCHEDULED".equals(
                                            appointment.getStatus()
                                        )
                                        ? "selected"
                                        : "" %>
                                >
                                    Scheduled
                                </option>


                                <option
                                    value="COMPLETED"

                                    <%= appointment != null
                                        && "COMPLETED".equals(
                                            appointment.getStatus()
                                        )
                                        ? "selected"
                                        : "" %>
                                >
                                    Completed
                                </option>


                                <option
                                    value="CANCELLED"

                                    <%= appointment != null
                                        && "CANCELLED".equals(
                                            appointment.getStatus()
                                        )
                                        ? "selected"
                                        : "" %>
                                >
                                    Cancelled
                                </option>


                                <option
                                    value="NO_SHOW"

                                    <%= appointment != null
                                        && "NO_SHOW".equals(
                                            appointment.getStatus()
                                        )
                                        ? "selected"
                                        : "" %>
                                >
                                    No Show
                                </option>


                                <option
                                    value="BILLED"

                                    <%= appointment != null
                                        && "BILLED".equals(
                                            appointment.getStatus()
                                        )
                                        ? "selected"
                                        : "" %>
                                >
                                    Billed
                                </option>


                            </select>

                        </div>


                    </div>

                </div>


                <!-- ========================================== -->
                <!-- ADDITIONAL NOTES -->
                <!-- ========================================== -->

                <div class="mb-5 rounded-xl border border-slate-200 bg-white p-6">


                    <!-- SECTION HEADER -->

                    <div class="mb-6 flex items-center gap-3">

                        <div class="flex h-9 w-9 items-center justify-center rounded-lg bg-blue-50 text-xs font-extrabold text-blue-600">
                            N
                        </div>

                        <h2 class="text-sm font-extrabold">
                            Additional Notes
                        </h2>

                    </div>


                    <label
                        for="notes"
                        class="mb-1.5 block text-[10px] font-bold"
                    >

                        Notes

                        <span class="ml-1 font-inter text-[9px] font-medium text-slate-400">
                            Optional
                        </span>

                    </label>


                    <textarea
                        id="notes"
                        name="notes"
                        maxlength="500"
                        placeholder="Enter any additional notes..."

                        class="min-h-[110px] w-full resize-y rounded-lg border border-slate-200 px-3 py-2.5 text-xs leading-relaxed outline-none placeholder:text-slate-400 focus:border-blue-500 focus:ring-4 focus:ring-blue-50"
                    ><%= appointment != null
                        && appointment.getNotes() != null
                        ? appointment.getNotes()
                        : "" %></textarea>

                </div>


                <!-- ========================================== -->
                <!-- ACTIONS -->
                <!-- ========================================== -->

                <div class="flex items-center justify-between">


                    <!-- REQUIRED TEXT -->

                    <p class="font-inter text-[9px] text-slate-400">

                        <span class="text-red-500">*</span>

                        Required fields

                    </p>


                    <!-- BUTTONS -->

                    <div class="flex gap-2">


                        <!-- CANCEL -->

                        <a
                            href="<%= request.getContextPath() %>/appointments"

                            class="rounded-lg border border-slate-200 bg-white px-4 py-2.5 text-xs font-semibold text-slate-600 hover:bg-slate-50"
                        >
                            Cancel
                        </a>


                        <!-- SUBMIT -->

                        <button
                            type="submit"

                            class="rounded-lg bg-[#2563EB] px-5 py-2.5 text-xs font-bold text-white hover:bg-[#1D4ED8]"
                        >
                            <%= buttonText %>
                        </button>


                    </div>

                </div>


            </form>

        </div>


    </main>

</div>


</body>

</html>