<%@ page language="java"
    contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="com.sunrise.model.Bill" %>
<%@ page import="com.sunrise.model.Appointment" %>
<%@ page import="com.sunrise.model.Patient" %>
<%@ page import="com.sunrise.model.Dentist" %>
<%@ page import="com.sunrise.model.Treatment" %>

<%
    Bill bill =
        (Bill) request.getAttribute("bill");

    Appointment appointment =
        (Appointment) request.getAttribute("appointment");

    Patient patient =
        (Patient) request.getAttribute("patient");

    Dentist dentist =
        (Dentist) request.getAttribute("dentist");

    Treatment treatment =
        (Treatment) request.getAttribute("treatment");
%>

<!DOCTYPE html>

<html lang="en">

<head>

    <meta charset="UTF-8">

    <meta name="viewport"
          content="width=device-width, initial-scale=1.0">

    <title>
        Bill Details | Sunrise Dental Clinic
    </title>


    <!-- Tailwind -->

    <script src="https://cdn.tailwindcss.com"></script>


    <!-- Tailwind Config -->

    <script>

        tailwind.config = {

            theme: {

                extend: {

                    fontFamily: {

                        manrope: [
                            'Manrope',
                            'sans-serif'
                        ],

                        inter: [
                            'Inter',
                            'sans-serif'
                        ]

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

    <link
        href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600&family=Manrope:wght@400;500;600;700;800&display=swap"
        rel="stylesheet"
    >

</head>


<body class="min-h-screen bg-[#F5F7FB] font-manrope text-[#172033]">


<div class="flex min-h-screen">


    <!-- SIDEBAR -->

    <jsp:include page="../common/sidebar.jsp" />


    <!-- MAIN -->

    <main class="ml-[250px] min-h-screen flex-1 px-8 py-7">


        <!-- PAGE HEADER -->

        <div class="mb-7 flex items-center justify-between">


            <div>

                <p class="mb-1 font-inter text-[10px] font-semibold uppercase tracking-[0.12em] text-slate-400">
                    Billing
                </p>

                <h1 class="text-[25px] font-extrabold tracking-[-0.7px]">
                    Bill Details
                </h1>

                <p class="mt-1 font-inter text-xs text-slate-500">
                    View the complete billing information for this appointment.
                </p>

            </div>


            <div class="flex gap-2">


                <a
                    href="<%= request.getContextPath() %>/bills/print?id=<%= bill.getBillId() %>"
                    target="_blank"
                    class="flex items-center gap-2 rounded-lg bg-[#2563EB] px-4 py-2.5 text-xs font-bold text-white shadow-sm transition hover:bg-[#1D4ED8]"
                >

                    <svg
                        class="h-4 w-4"
                        fill="none"
                        stroke="currentColor"
                        stroke-width="1.8"
                        viewBox="0 0 24 24"
                    >

                        <path
                            stroke-linecap="round"
                            stroke-linejoin="round"
                            d="M6 9V2h12v7M6 18H4a2 2 0 01-2-2v-5a2 2 0 012-2h16a2 2 0 012 2v5a2 2 0 01-2 2h-2"
                        />

                        <path
                            stroke-linecap="round"
                            stroke-linejoin="round"
                            d="M6 14h12v8H6z"
                        />

                    </svg>

                    Print Receipt

                </a>


                <a
                    href="<%= request.getContextPath() %>/bills"
                    class="rounded-lg border border-slate-200 bg-white px-4 py-2.5 text-xs font-semibold text-slate-600 hover:bg-slate-50"
                >
                    Back
                </a>


            </div>


        </div>



        <!-- SUCCESS -->

        <% if ("1".equals(request.getParameter("success"))) { %>

            <div class="mb-5 flex items-center gap-3 rounded-lg border border-emerald-100 bg-emerald-50 px-4 py-3 text-xs font-semibold text-emerald-700">

                <span class="flex h-5 w-5 items-center justify-center rounded-full bg-emerald-100">
                    ✓
                </span>

                Bill created successfully.

            </div>

        <% } %>



        <!-- BILL -->

        <div class="mx-auto max-w-[1000px]">


            <!-- BILL HEADER -->

            <div class="overflow-hidden rounded-xl border border-slate-200 bg-white">


                <div class="flex items-start justify-between border-b border-slate-100 px-7 py-6">


                    <!-- CLINIC -->

                    <div class="flex items-center gap-3">


                        <div class="flex h-11 w-11 items-center justify-center rounded-xl bg-[#2563EB]">

                            <svg
                                class="h-5 w-5 text-white"
                                fill="none"
                                stroke="currentColor"
                                stroke-width="1.8"
                                viewBox="0 0 24 24"
                            >

                                <path
                                    stroke-linecap="round"
                                    stroke-linejoin="round"
                                    d="M12 3v18M3 12h18"
                                />

                            </svg>

                        </div>


                        <div>

                            <h2 class="text-base font-extrabold">
                                Sunrise Dental Clinic
                            </h2>

                            <p class="mt-0.5 font-inter text-[9px] text-slate-400">
                                Clinic Management System
                            </p>

                        </div>


                    </div>



                    <!-- BILL NUMBER -->

                    <div class="text-right">


                        <p class="font-inter text-[9px] font-semibold uppercase tracking-[0.12em] text-slate-400">
                            Patient Bill
                        </p>


                        <p class="mt-1 text-lg font-extrabold text-[#2563EB]">
                            <%= bill.getBillNumber() %>
                        </p>


                        <% if (bill.getCreatedAt() != null) { %>

                            <p class="mt-1 font-inter text-[9px] text-slate-400">
                                <%= bill.getCreatedAt() %>
                            </p>

                        <% } %>


                    </div>


                </div>



                <!-- PATIENT / APPOINTMENT SUMMARY -->

                <div class="grid grid-cols-2 gap-6 bg-slate-50/60 px-7 py-5">


                    <!-- PATIENT -->

                    <div>


                        <p class="mb-2 font-inter text-[9px] font-semibold uppercase tracking-[0.1em] text-slate-400">
                            Patient
                        </p>


                        <p class="text-sm font-extrabold">

                            <%= patient != null
                                ? patient.getName()
                                : "N/A" %>

                        </p>


                        <p class="mt-1 font-inter text-[10px] text-slate-500">

                            <%= patient != null
                                ? patient.getPatientCode()
                                : "N/A" %>

                        </p>


                    </div>



                    <!-- APPOINTMENT -->

                    <div>


                        <p class="mb-2 font-inter text-[9px] font-semibold uppercase tracking-[0.1em] text-slate-400">
                            Appointment
                        </p>


                        <p class="text-sm font-extrabold">

                            <%= appointment != null
                                ? appointment.getAppointmentNumber()
                                : "N/A" %>

                        </p>


                        <p class="mt-1 font-inter text-[10px] text-slate-500">

                            <%= appointment != null
                                ? appointment.getAppointmentDate()
                                : "N/A" %>

                            <% if (appointment != null) { %>

                                ·

                                <%= appointment.getAppointmentTime() %>

                            <% } %>

                        </p>


                    </div>


                </div>


            </div>



            <!-- DETAILS -->

            <div class="mt-5 grid grid-cols-3 gap-5">


                <!-- PATIENT INFORMATION -->

                <div class="rounded-xl border border-slate-200 bg-white p-5">


                    <div class="mb-4 flex items-center gap-3">


                        <div class="flex h-8 w-8 items-center justify-center rounded-lg bg-blue-50 text-xs font-extrabold text-blue-600">
                            P
                        </div>


                        <h3 class="text-xs font-extrabold">
                            Patient
                        </h3>


                    </div>


                    <div class="space-y-3">


                        <div>

                            <p class="font-inter text-[8px] font-semibold uppercase tracking-wide text-slate-400">
                                Patient Code
                            </p>

                            <p class="mt-1 text-[10px] font-semibold">

                                <%= patient != null
                                    ? patient.getPatientCode()
                                    : "N/A" %>

                            </p>

                        </div>


                        <div>

                            <p class="font-inter text-[8px] font-semibold uppercase tracking-wide text-slate-400">
                                Name
                            </p>

                            <p class="mt-1 text-[10px] font-semibold">

                                <%= patient != null
                                    ? patient.getName()
                                    : "N/A" %>

                            </p>

                        </div>


                    </div>


                </div>



                <!-- DENTIST -->

                <div class="rounded-xl border border-slate-200 bg-white p-5">


                    <div class="mb-4 flex items-center gap-3">


                        <div class="flex h-8 w-8 items-center justify-center rounded-lg bg-violet-50 text-xs font-extrabold text-violet-600">
                            D
                        </div>


                        <h3 class="text-xs font-extrabold">
                            Dentist
                        </h3>


                    </div>


                    <div class="space-y-3">


                        <div>

                            <p class="font-inter text-[8px] font-semibold uppercase tracking-wide text-slate-400">
                                Dentist
                            </p>

                            <p class="mt-1 text-[10px] font-semibold">

                                <%= dentist != null
                                    ? dentist.getDentistName()
                                    : "N/A" %>

                            </p>

                        </div>


                        <div>

                            <p class="font-inter text-[8px] font-semibold uppercase tracking-wide text-slate-400">
                                Specialization
                            </p>

                            <p class="mt-1 text-[10px] font-semibold">

                                <%= dentist != null
                                    ? dentist.getSpecialization()
                                    : "N/A" %>

                            </p>

                        </div>


                    </div>


                </div>



                <!-- APPOINTMENT -->

                <div class="rounded-xl border border-slate-200 bg-white p-5">


                    <div class="mb-4 flex items-center gap-3">


                        <div class="flex h-8 w-8 items-center justify-center rounded-lg bg-emerald-50 text-xs font-extrabold text-emerald-600">
                            A
                        </div>


                        <h3 class="text-xs font-extrabold">
                            Appointment
                        </h3>


                    </div>


                    <div class="space-y-3">


                        <div>

                            <p class="font-inter text-[8px] font-semibold uppercase tracking-wide text-slate-400">
                                Appointment No.
                            </p>

                            <p class="mt-1 text-[10px] font-semibold">

                                <%= appointment != null
                                    ? appointment.getAppointmentNumber()
                                    : "N/A" %>

                            </p>

                        </div>


                        <div>

                            <p class="font-inter text-[8px] font-semibold uppercase tracking-wide text-slate-400">
                                Date
                            </p>

                            <p class="mt-1 text-[10px] font-semibold">

                                <%= appointment != null
                                    ? appointment.getAppointmentDate()
                                    : "N/A" %>

                            </p>

                        </div>


                    </div>


                </div>


            </div>



            <!-- SERVICES -->

            <div class="mt-5 overflow-hidden rounded-xl border border-slate-200 bg-white">


                <div class="border-b border-slate-100 px-6 py-4">


                    <h2 class="text-sm font-extrabold">
                        Services
                    </h2>


                    <p class="mt-0.5 font-inter text-[9px] text-slate-400">
                        Services and charges for this appointment
                    </p>


                </div>



                <div class="overflow-x-auto">


                    <table class="w-full">


                        <thead class="bg-slate-50">


                            <tr>


                                <th class="px-6 py-3 text-left font-inter text-[9px] font-semibold uppercase tracking-wide text-slate-400">
                                    Description
                                </th>


                                <th class="px-6 py-3 text-left font-inter text-[9px] font-semibold uppercase tracking-wide text-slate-400">
                                    Dentist
                                </th>


                                <th class="px-6 py-3 text-left font-inter text-[9px] font-semibold uppercase tracking-wide text-slate-400">
                                    Treatment
                                </th>


                                <th class="px-6 py-3 text-right font-inter text-[9px] font-semibold uppercase tracking-wide text-slate-400">
                                    Amount
                                </th>


                            </tr>


                        </thead>


                        <tbody>


                            <!-- CONSULTATION -->

                            <tr class="border-t border-slate-100">


                                <td class="px-6 py-4">

                                    <p class="text-[11px] font-bold">
                                        Consultation
                                    </p>

                                    <p class="mt-0.5 font-inter text-[9px] text-slate-400">
                                        Dental consultation fee
                                    </p>

                                </td>


                                <td class="px-6 py-4 text-[10px] text-slate-500">
                                    <%= dentist != null
                                        ? dentist.getDentistName()
                                        : "N/A" %>
                                </td>


                                <td class="px-6 py-4 text-[10px] text-slate-500">
                                    —
                                </td>


                                <td class="px-6 py-4 text-right text-[11px] font-bold">

                                    LKR
                                    <%= String.format(
                                        "%.2f",
                                        bill.getConsultationFee()
                                    ) %>

                                </td>


                            </tr>



                            <!-- TREATMENT -->

                            <tr class="border-t border-slate-100">


                                <td class="px-6 py-4">

                                    <p class="text-[11px] font-bold">

                                        <%= treatment != null
                                            ? treatment.getTreatmentName()
                                            : "Treatment" %>

                                    </p>

                                    <p class="mt-0.5 font-inter text-[9px] text-slate-400">
                                        Dental treatment
                                    </p>

                                </td>


                                <td class="px-6 py-4 text-[10px] text-slate-500">

                                    <%= dentist != null
                                        ? dentist.getDentistName()
                                        : "N/A" %>

                                </td>


                                <td class="px-6 py-4 text-[10px] text-slate-500">

                                    <%= treatment != null
                                        ? treatment.getTreatmentName()
                                        : "N/A" %>

                                </td>


                                <td class="px-6 py-4 text-right text-[11px] font-bold">

                                    LKR
                                    <%= String.format(
                                        "%.2f",
                                        bill.getTreatmentFee()
                                    ) %>

                                </td>


                            </tr>


                        </tbody>


                    </table>


                </div>



                <!-- TOTAL -->

                <div class="border-t border-slate-100 px-6 py-5">


                    <div class="ml-auto w-full max-w-[320px]">


                        <div class="flex items-center justify-between py-2">

                            <span class="font-inter text-[10px] text-slate-500">
                                Consultation Fee
                            </span>

                            <span class="font-inter text-[10px] font-semibold">

                                LKR
                                <%= String.format(
                                    "%.2f",
                                    bill.getConsultationFee()
                                ) %>

                            </span>

                        </div>


                        <div class="flex items-center justify-between py-2">

                            <span class="font-inter text-[10px] text-slate-500">
                                Treatment Fee
                            </span>

                            <span class="font-inter text-[10px] font-semibold">

                                LKR
                                <%= String.format(
                                    "%.2f",
                                    bill.getTreatmentFee()
                                ) %>

                            </span>

                        </div>


                        <div class="mt-2 flex items-center justify-between rounded-lg bg-[#111827] px-4 py-4 text-white">


                            <span class="text-sm font-extrabold">
                                Total Amount
                            </span>


                            <span class="text-base font-extrabold">

                                LKR
                                <%= String.format(
                                    "%.2f",
                                    bill.getTotalAmount()
                                ) %>

                            </span>


                        </div>


                    </div>


                </div>


            </div>



            <!-- BILL INFORMATION -->

            <div class="mt-5 rounded-xl border border-slate-200 bg-white p-6">


                <div class="mb-5 flex items-center gap-3">


                    <div class="flex h-8 w-8 items-center justify-center rounded-lg bg-slate-100 text-xs font-extrabold text-slate-600">
                        #
                    </div>


                    <h2 class="text-sm font-extrabold">
                        Bill Information
                    </h2>


                </div>


                <div class="grid grid-cols-2 gap-6">


                    <div>

                        <p class="font-inter text-[9px] font-semibold uppercase tracking-wide text-slate-400">
                            Bill Number
                        </p>

                        <p class="mt-1 text-xs font-semibold">
                            <%= bill.getBillNumber() %>
                        </p>

                    </div>


                    <div>

                        <p class="font-inter text-[9px] font-semibold uppercase tracking-wide text-slate-400">
                            Created By
                        </p>

                        <p class="mt-1 text-xs font-semibold">
                            User ID: <%= bill.getCreatedBy() %>
                        </p>

                    </div>


                    <div>

                        <p class="font-inter text-[9px] font-semibold uppercase tracking-wide text-slate-400">
                            Created At
                        </p>

                        <p class="mt-1 text-xs font-semibold">

                            <%= bill.getCreatedAt() != null
                                ? bill.getCreatedAt()
                                : "N/A" %>

                        </p>

                    </div>


                    <div>

                        <p class="font-inter text-[9px] font-semibold uppercase tracking-wide text-slate-400">
                            Appointment ID
                        </p>

                        <p class="mt-1 text-xs font-semibold">

                            <%= bill.getAppointmentId() %>

                        </p>

                    </div>


                </div>


            </div>



            <!-- FOOTER -->

            <div class="mt-5 flex items-center justify-between px-1 pb-5">


                <p class="font-inter text-[9px] text-slate-400">
                    Thank you for choosing Sunrise Dental Clinic.
                </p>


                <a
                    href="<%= request.getContextPath() %>/bills"
                    class="font-inter text-[9px] font-semibold text-blue-600 hover:underline"
                >
                    ← Back to Bills
                </a>


            </div>


        </div>


    </main>


</div>


</body>

</html>