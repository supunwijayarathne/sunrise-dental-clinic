<%@ page language="java"
    contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="com.sunrise.model.Appointment" %>
<%@ page import="com.sunrise.model.Patient" %>
<%@ page import="com.sunrise.model.Dentist" %>
<%@ page import="com.sunrise.model.Treatment" %>

<%
    Appointment appointment =
        (Appointment) request.getAttribute("appointment");

    Patient patient =
        (Patient) request.getAttribute("patient");

    Dentist dentist =
        (Dentist) request.getAttribute("dentist");

    Treatment treatment =
        (Treatment) request.getAttribute("treatment");

    String status =
        appointment.getStatus();

    String statusBg =
        "bg-blue-50 text-blue-700";

    if ("COMPLETED".equals(status)) {
        statusBg = "bg-emerald-50 text-emerald-700";
    } else if ("CANCELLED".equals(status)) {
        statusBg = "bg-red-50 text-red-700";
    } else if ("NO_SHOW".equals(status)) {
        statusBg = "bg-amber-50 text-amber-700";
    } else if ("BILLED".equals(status)) {
        statusBg = "bg-violet-50 text-violet-700";
    }
%>

<!DOCTYPE html>

<html lang="en">

<head>

    <meta charset="UTF-8">

    <meta name="viewport"
          content="width=device-width, initial-scale=1.0">

    <title>
        Appointment Details | Sunrise Dental Clinic
    </title>

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

    <jsp:include page="../common/sidebar.jsp" />


    <main class="ml-[250px] min-h-screen flex-1 px-8 py-7">


        <!-- HEADER -->

        <div class="mb-7">

            <h1 class="text-[24px] font-extrabold tracking-[-0.6px]">
                Appointment Details
            </h1>

            <p class="mt-1 font-inter text-xs text-slate-500">
                Complete information about this appointment
            </p>

        </div>


        <!-- APPOINTMENT HEADER -->

        <div class="mb-5 flex items-center justify-between rounded-xl border border-slate-200 bg-white px-6 py-5">


            <div class="flex items-center gap-4">


                <div class="flex h-11 w-11 items-center justify-center rounded-xl bg-blue-50 text-sm font-extrabold text-blue-600">
                    A
                </div>


                <div>

                    <p class="font-inter text-[9px] font-semibold uppercase tracking-wide text-slate-400">
                        Appointment Number
                    </p>

                    <h2 class="mt-1 text-base font-extrabold">
                        <%= appointment.getAppointmentNumber() %>
                    </h2>

                </div>


            </div>


            <span class="rounded-full px-3 py-1.5 font-inter text-[9px] font-semibold <%= statusBg %>">

                <%= status.replace("_", " ") %>

            </span>


        </div>


        <!-- SUCCESS -->

        <% if ("1".equals(request.getParameter("updated"))) { %>

            <div class="mb-5 flex items-center gap-3 rounded-lg border border-emerald-100 bg-emerald-50 px-4 py-3 text-xs font-semibold text-emerald-700">

                <span class="flex h-5 w-5 items-center justify-center rounded-full bg-emerald-100">
                    ✓
                </span>

                Appointment updated successfully.

            </div>

        <% } %>


        <!-- GRID -->

        <div class="grid grid-cols-2 gap-5">


            <!-- APPOINTMENT -->

            <div class="rounded-xl border border-slate-200 bg-white p-6">


                <div class="mb-5 flex items-center gap-3">

                    <div class="flex h-9 w-9 items-center justify-center rounded-lg bg-blue-50 text-xs font-extrabold text-blue-600">
                        A
                    </div>

                    <h2 class="text-sm font-extrabold">
                        Appointment Information
                    </h2>

                </div>


                <div class="grid grid-cols-2">


                    <div class="border-b border-slate-100 py-3">

                        <p class="font-inter text-[9px] font-semibold uppercase tracking-wide text-slate-400">
                            Appointment ID
                        </p>

                        <p class="mt-1 text-xs font-semibold">
                            <%= appointment.getAppointmentId() %>
                        </p>

                    </div>


                    <div class="border-b border-slate-100 py-3">

                        <p class="font-inter text-[9px] font-semibold uppercase tracking-wide text-slate-400">
                            Appointment Number
                        </p>

                        <p class="mt-1 text-xs font-semibold">
                            <%= appointment.getAppointmentNumber() %>
                        </p>

                    </div>


                    <div class="border-b border-slate-100 py-3">

                        <p class="font-inter text-[9px] font-semibold uppercase tracking-wide text-slate-400">
                            Date
                        </p>

                        <p class="mt-1 text-xs font-semibold">
                            <%= appointment.getAppointmentDate() %>
                        </p>

                    </div>


                    <div class="border-b border-slate-100 py-3">

                        <p class="font-inter text-[9px] font-semibold uppercase tracking-wide text-slate-400">
                            Time
                        </p>

                        <p class="mt-1 text-xs font-semibold">
                            <%= appointment.getAppointmentTime() %>
                        </p>

                    </div>


                    <div class="py-3">

                        <p class="font-inter text-[9px] font-semibold uppercase tracking-wide text-slate-400">
                            Status
                        </p>

                        <p class="mt-2">

                            <span class="rounded-full px-2.5 py-1 font-inter text-[9px] font-semibold <%= statusBg %>">
                                <%= status.replace("_", " ") %>
                            </span>

                        </p>

                    </div>


                </div>


            </div>


            <!-- PATIENT -->

            <div class="rounded-xl border border-slate-200 bg-white p-6">


                <div class="mb-5 flex items-center gap-3">

                    <div class="flex h-9 w-9 items-center justify-center rounded-lg bg-blue-50 text-xs font-extrabold text-blue-600">
                        P
                    </div>

                    <h2 class="text-sm font-extrabold">
                        Patient
                    </h2>

                </div>


                <div class="space-y-4">


                    <div>

                        <p class="font-inter text-[9px] font-semibold uppercase tracking-wide text-slate-400">
                            Patient Code
                        </p>

                        <p class="mt-1 text-xs font-semibold">
                            <%= patient != null
                                ? patient.getPatientCode()
                                : "N/A" %>
                        </p>

                    </div>


                    <div>

                        <p class="font-inter text-[9px] font-semibold uppercase tracking-wide text-slate-400">
                            Patient Name
                        </p>

                        <p class="mt-1 text-xs font-semibold">
                            <%= patient != null
                                ? patient.getName()
                                : "N/A" %>
                        </p>

                    </div>


                    <div>

                        <p class="font-inter text-[9px] font-semibold uppercase tracking-wide text-slate-400">
                            Contact Number
                        </p>

                        <p class="mt-1 text-xs font-semibold">
                            <%= patient != null
                                ? patient.getContactNumber()
                                : "N/A" %>
                        </p>

                    </div>


                </div>


            </div>


            <!-- DENTIST -->

            <div class="rounded-xl border border-slate-200 bg-white p-6">


                <div class="mb-5 flex items-center gap-3">

                    <div class="flex h-9 w-9 items-center justify-center rounded-lg bg-blue-50 text-xs font-extrabold text-blue-600">
                        D
                    </div>

                    <h2 class="text-sm font-extrabold">
                        Dentist
                    </h2>

                </div>


                <div class="space-y-4">


                    <div>

                        <p class="font-inter text-[9px] font-semibold uppercase tracking-wide text-slate-400">
                            Dentist Name
                        </p>

                        <p class="mt-1 text-xs font-semibold">
                            <%= dentist != null
                                ? dentist.getDentistName()
                                : "N/A" %>
                        </p>

                    </div>


                    <div>

                        <p class="font-inter text-[9px] font-semibold uppercase tracking-wide text-slate-400">
                            Specialization
                        </p>

                        <p class="mt-1 text-xs font-semibold">
                            <%= dentist != null
                                ? dentist.getSpecialization()
                                : "N/A" %>
                        </p>

                    </div>


                </div>


            </div>


            <!-- TREATMENT -->

            <div class="rounded-xl border border-slate-200 bg-white p-6">


                <div class="mb-5 flex items-center gap-3">

                    <div class="flex h-9 w-9 items-center justify-center rounded-lg bg-blue-50 text-xs font-extrabold text-blue-600">
                        T
                    </div>

                    <h2 class="text-sm font-extrabold">
                        Treatment
                    </h2>

                </div>


                <div class="space-y-4">


                    <div>

                        <p class="font-inter text-[9px] font-semibold uppercase tracking-wide text-slate-400">
                            Treatment Name
                        </p>

                        <p class="mt-1 text-xs font-semibold">
                            <%= treatment != null
                                ? treatment.getTreatmentName()
                                : "N/A" %>
                        </p>

                    </div>


                    <div>

                        <p class="font-inter text-[9px] font-semibold uppercase tracking-wide text-slate-400">
                            Treatment Fee
                        </p>

                        <p class="mt-1 text-xs font-semibold">

                            <% if (treatment != null) { %>

                                LKR
                                <%= String.format(
                                    "%.2f",
                                    treatment.getTreatmentFee()
                                ) %>

                            <% } else { %>

                                N/A

                            <% } %>

                        </p>

                    </div>


                </div>


            </div>


            <!-- NOTES -->

            <div class="col-span-2 rounded-xl border border-slate-200 bg-white p-6">


                <div class="mb-5 flex items-center gap-3">

                    <div class="flex h-9 w-9 items-center justify-center rounded-lg bg-blue-50 text-xs font-extrabold text-blue-600">
                        N
                    </div>

                    <h2 class="text-sm font-extrabold">
                        Notes
                    </h2>

                </div>


                <div class="rounded-lg border border-slate-100 bg-slate-50 px-4 py-3 font-inter text-[11px] leading-7 text-slate-600">

                    <%= appointment.getNotes() != null
                        && !appointment.getNotes().isBlank()
                        ? appointment.getNotes()
                        : "No additional notes." %>

                </div>


            </div>


            <!-- SYSTEM -->

            <div class="col-span-2 rounded-xl border border-slate-200 bg-white p-6">


                <div class="mb-5 flex items-center gap-3">

                    <div class="flex h-9 w-9 items-center justify-center rounded-lg bg-blue-50 text-xs font-extrabold text-blue-600">
                        S
                    </div>

                    <h2 class="text-sm font-extrabold">
                        System Information
                    </h2>

                </div>


                <div class="grid grid-cols-3 gap-5">


                    <div>

                        <p class="font-inter text-[9px] font-semibold uppercase tracking-wide text-slate-400">
                            Created By
                        </p>

                        <p class="mt-1 text-xs font-semibold">
                            User ID: <%= appointment.getCreatedBy() %>
                        </p>

                    </div>


                    <div>

                        <p class="font-inter text-[9px] font-semibold uppercase tracking-wide text-slate-400">
                            Created At
                        </p>

                        <p class="mt-1 text-xs font-semibold">
                            <%= appointment.getCreatedAt() != null
                                ? appointment.getCreatedAt()
                                : "N/A" %>
                        </p>

                    </div>


                    <div>

                        <p class="font-inter text-[9px] font-semibold uppercase tracking-wide text-slate-400">
                            Last Updated
                        </p>

                        <p class="mt-1 text-xs font-semibold">
                            <%= appointment.getUpdatedAt() != null
                                ? appointment.getUpdatedAt()
                                : "N/A" %>
                        </p>

                    </div>


                </div>


            </div>


        </div>


        <!-- ACTIONS -->

        <div class="mt-5 flex gap-2">


            <a
                href="<%= request.getContextPath() %>/appointments/edit?id=<%= appointment.getAppointmentId() %>"
                class="rounded-lg bg-[#2563EB] px-5 py-2.5 text-xs font-bold text-white hover:bg-[#1D4ED8]"
            >
                Edit Appointment
            </a>


            <a
                href="<%= request.getContextPath() %>/appointments"
                class="rounded-lg border border-slate-200 bg-white px-5 py-2.5 text-xs font-semibold text-slate-600 hover:bg-slate-50"
            >
                ← Back to Appointments
            </a>


        </div>


    </main>

</div>

</body>

</html>