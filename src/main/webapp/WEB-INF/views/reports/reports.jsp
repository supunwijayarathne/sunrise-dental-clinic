<%@ page contentType="text/html;charset=UTF-8" %>

<%@ page import="java.util.List" %>

<%@ page import="com.sunrise.model.ReportStats" %>
<%@ page import="com.sunrise.model.ReportBill" %>
<%@ page import="com.sunrise.model.ReportAppointment" %>
<%@ page import="com.sunrise.model.ReportTreatment" %>

<%
    // =========================================================
    // REPORT DATA
    // =========================================================

    ReportStats revenueStats =
            (ReportStats) request.getAttribute("revenueStats");

    ReportStats appointmentStats =
            (ReportStats) request.getAttribute("appointmentStats");

    ReportStats treatmentStats =
            (ReportStats) request.getAttribute("treatmentStats");


    if (revenueStats == null) {
        revenueStats = new ReportStats();
    }

    if (appointmentStats == null) {
        appointmentStats = new ReportStats();
    }

    if (treatmentStats == null) {
        treatmentStats = new ReportStats();
    }


    // =========================================================
    // FILTERS
    // =========================================================

    String revenueFilter =
            (String) request.getAttribute("revenueFilter");

    String appointmentFilter =
            (String) request.getAttribute("appointmentFilter");

    String treatmentFilter =
            (String) request.getAttribute("treatmentFilter");


    String revenueStartDate =
            (String) request.getAttribute("revenueStartDate");

    String revenueEndDate =
            (String) request.getAttribute("revenueEndDate");


    String appointmentStartDate =
            (String) request.getAttribute("appointmentStartDate");

    String appointmentEndDate =
            (String) request.getAttribute("appointmentEndDate");


    String treatmentStartDate =
            (String) request.getAttribute("treatmentStartDate");

    String treatmentEndDate =
            (String) request.getAttribute("treatmentEndDate");


    // =========================================================
    // DEFAULT VALUES
    // =========================================================

    if (revenueFilter == null) {
        revenueFilter = "7D";
    }

    if (appointmentFilter == null) {
        appointmentFilter = "7D";
    }

    if (treatmentFilter == null) {
        treatmentFilter = "MONTH";
    }


    if (revenueStartDate == null) {
        revenueStartDate = "";
    }

    if (revenueEndDate == null) {
        revenueEndDate = "";
    }


    if (appointmentStartDate == null) {
        appointmentStartDate = "";
    }

    if (appointmentEndDate == null) {
        appointmentEndDate = "";
    }


    if (treatmentStartDate == null) {
        treatmentStartDate = "";
    }

    if (treatmentEndDate == null) {
        treatmentEndDate = "";
    }
%>


<!DOCTYPE html>

<html lang="en">

<head>

    <meta charset="UTF-8">

    <meta
        name="viewport"
        content="width=device-width, initial-scale=1.0">

    <title>Reports - Sunrise Dental</title>


    <!-- =====================================================
         TAILWIND
    ====================================================== -->

    <script src="https://cdn.tailwindcss.com"></script>


    <!-- =====================================================
         FONTS
    ====================================================== -->

    <link
        rel="preconnect"
        href="https://fonts.googleapis.com">

    <link
        rel="preconnect"
        href="https://fonts.gstatic.com"
        crossorigin>

    <link
        href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&family=Manrope:wght@500;600;700;800&display=swap"
        rel="stylesheet">


    <!-- =====================================================
         CHART.JS
    ====================================================== -->

    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>


    <style>

        .font-inter {
            font-family: 'Inter', sans-serif;
        }

        .font-manrope {
            font-family: 'Manrope', sans-serif;
        }


        /* =====================================================
           REPORT SECTIONS
        ===================================================== */

        .report-section {
            display: none;
        }

        .report-section.active {
            display: block;
        }


        /* =====================================================
           REPORT TABS
        ===================================================== */

        .report-tab {
            color: #64748b;
            background: transparent;
            transition: all 0.2s ease;
        }

        .report-tab:hover {
            color: #2563EB;
            background: #eff6ff;
        }

        .report-tab.active {
            background: #2563EB;
            color: white;
            box-shadow: 0 1px 3px rgba(37, 99, 235, 0.20);
        }

        .report-tab.active:hover {
            background: #1D4ED8;
            color: white;
        }


        /* =====================================================
           STATUS BADGES
        ===================================================== */

        .status-badge {
            display: inline-flex;
            align-items: center;
            border-radius: 9999px;
            padding: 4px 10px;
            font-size: 10px;
            font-weight: 700;
            line-height: 1;
        }

        .status-scheduled {
            background: #eff6ff;
            color: #2563eb;
        }

        .status-completed {
            background: #ecfdf5;
            color: #047857;
        }

        .status-cancelled {
            background: #fef2f2;
            color: #dc2626;
        }

        .status-no-show {
            background: #fffbeb;
            color: #b45309;
        }

        .status-billed {
            background: #f0fdf4;
            color: #15803d;
        }

        .status-default {
            background: #f1f5f9;
            color: #475569;
        }


        /* =====================================================
           PRINT
        ====================================================== */

        .print-header {
            display: none;
        }

        @media print {

            body {
                background: white !important;
            }

            body * {
                visibility: hidden;
            }

            .print-area,
            .print-area * {
                visibility: visible;
            }

            .print-area {
                position: absolute;
                left: 0;
                top: 0;
                width: 100%;
            }

            .no-print {
                display: none !important;
            }

            .print-header {
                display: block !important;
            }

            @page {
                size: A4;
                margin: 12mm;
            }
        }

    </style>

</head>


<body class="min-h-screen bg-[#F5F7FB] font-manrope text-[#172033]">


    <!-- =========================================================
         ADMIN SIDEBAR
    ========================================================== -->

    <jsp:include page="../common/sidebar.jsp" />


    <!-- =========================================================
         MAIN CONTENT
    ========================================================== -->

    <main class="ml-[250px] min-h-screen px-8 py-7">

        <div class="mx-auto max-w-[1400px]">


            <!-- =================================================
                 HEADER
            ================================================== -->

            <div class="mb-7 flex items-end justify-between">

                <div>

                    <p
                        class="mb-1 font-inter text-[10px] font-semibold uppercase tracking-[0.12em] text-blue-600">

                        Admin

                    </p>


                    <h1
                        class="font-manrope text-2xl font-extrabold tracking-tight text-[#172033]">

                        Reports

                    </h1>


                    <p
                        class="mt-1.5 font-inter text-xs text-slate-500">

                        Overview of clinic performance and financial activity.

                    </p>

                </div>


                <div
                    class="hidden items-center gap-2 rounded-lg border border-slate-200 bg-white px-4 py-2.5 md:flex">

                    <svg
                        class="h-4 w-4 text-slate-400"
                        fill="none"
                        stroke="currentColor"
                        stroke-width="1.8"
                        viewBox="0 0 24 24">

                        <rect
                            x="3"
                            y="4"
                            width="18"
                            height="17"
                            rx="2"/>

                        <path
                            stroke-linecap="round"
                            d="M16 2v4M8 2v4M3 10h18"/>

                    </svg>


                    <span
                        class="font-inter text-[11px] font-medium text-slate-500">

                        Clinic Reports

                    </span>

                </div>

            </div>


            <!-- =================================================
                 REPORT TABS
            ================================================== -->

            <div class="mb-7 no-print">

                <div
                    class="inline-flex rounded-xl border border-slate-200 bg-white p-1 shadow-sm">


                    <button
                        type="button"
                        id="RevenueTab"
                        onclick="showReport('revenue')"
                        class="report-tab active rounded-lg px-6 py-2.5 text-sm font-semibold">

                        Revenue

                    </button>


                    <button
                        type="button"
                        id="AppointmentsTab"
                        onclick="showReport('appointments')"
                        class="report-tab rounded-lg px-6 py-2.5 text-sm font-semibold">

                        Appointments

                    </button>


                    <button
                        type="button"
                        id="TreatmentsTab"
                        onclick="showReport('treatments')"
                        class="report-tab rounded-lg px-6 py-2.5 text-sm font-semibold">

                        Treatments

                    </button>

                </div>

            </div>


            <!-- =========================================================
                 REVENUE
            ========================================================== -->

            <section
                id="revenue"
                class="report-section active print-area">


                <!-- PRINT HEADER -->

                <div class="print-header mb-6">

                    <h1
                        class="font-manrope text-2xl font-extrabold">

                        SUNRISE DENTAL

                    </h1>

                    <p
                        class="mt-1 text-lg font-bold">

                        Revenue Report

                    </p>

                    <p
                        class="mt-1 text-sm">

                        Period:

                        <%= revenueStartDate %>

                        -

                        <%= revenueEndDate %>

                    </p>

                </div>


                <!-- FILTER -->

                <div class="mb-7 no-print">

                    <form
                        method="get"
                        action="<%= request.getContextPath() %>/reports">


                        <input
                            type="hidden"
                            name="appointmentFilter"
                            value="<%= appointmentFilter %>">


                        <input
                            type="hidden"
                            name="treatmentFilter"
                            value="<%= treatmentFilter %>">


                        <div
                            class="rounded-xl border border-slate-200 bg-white p-5">


                            <div
                                class="flex flex-wrap items-end gap-3">


                                <div class="w-[220px]">

                                    <label
                                        class="mb-2 block font-inter text-[10px] font-semibold uppercase tracking-wide text-slate-400">

                                        Revenue Period

                                    </label>


                                    <select
                                        name="revenueFilter"
                                        id="revenueFilter"
                                        onchange="toggleDates('revenue')"
                                        class="w-full rounded-lg border border-slate-200 bg-white px-3 py-2.5 text-sm text-slate-700 outline-none transition focus:border-blue-500 focus:ring-2 focus:ring-blue-100">


                                        <option
                                            value="TODAY"
                                            <%= "TODAY".equals(revenueFilter) ? "selected" : "" %>>

                                            Today

                                        </option>


                                        <option
                                            value="7D"
                                            <%= "7D".equals(revenueFilter) ? "selected" : "" %>>

                                            Last 7 Days

                                        </option>


                                        <option
                                            value="MONTH"
                                            <%= "MONTH".equals(revenueFilter) ? "selected" : "" %>>

                                            This Month

                                        </option>


                                        <option
                                            value="3M"
                                            <%= "3M".equals(revenueFilter) ? "selected" : "" %>>

                                            Last 3 Months

                                        </option>


                                        <option
                                            value="YEAR"
                                            <%= "YEAR".equals(revenueFilter) ? "selected" : "" %>>

                                            This Year

                                        </option>


                                        <option
                                            value="CUSTOM"
                                            <%= "CUSTOM".equals(revenueFilter) ? "selected" : "" %>>

                                            Custom Range

                                        </option>

                                    </select>

                                </div>


                                <div
                                    id="revenueDates"
                                    class="<%= "CUSTOM".equals(revenueFilter) ? "flex" : "hidden" %> items-end gap-3">


                                    <div>

                                        <label
                                            class="mb-2 block font-inter text-[10px] font-semibold uppercase tracking-wide text-slate-400">

                                            From

                                        </label>


                                        <input
                                            type="date"
                                            name="revenueStartDate"
                                            value="<%= revenueStartDate %>"
                                            class="rounded-lg border border-slate-200 bg-white px-3 py-2.5 text-sm outline-none focus:border-blue-500 focus:ring-2 focus:ring-blue-100">

                                    </div>


                                    <div>

                                        <label
                                            class="mb-2 block font-inter text-[10px] font-semibold uppercase tracking-wide text-slate-400">

                                            To

                                        </label>


                                        <input
                                            type="date"
                                            name="revenueEndDate"
                                            value="<%= revenueEndDate %>"
                                            class="rounded-lg border border-slate-200 bg-white px-3 py-2.5 text-sm outline-none focus:border-blue-500 focus:ring-2 focus:ring-blue-100">

                                    </div>

                                </div>


                                <button
                                    type="submit"
                                    class="rounded-lg bg-[#2563EB] px-5 py-2.5 text-sm font-semibold text-white shadow-sm transition hover:bg-[#1D4ED8]">

                                    Apply

                                </button>


                                <button
                                    type="button"
                                    onclick="printReport('revenue')"
                                    class="rounded-lg border border-slate-200 bg-white px-5 py-2.5 text-sm font-semibold text-slate-700 transition hover:border-blue-200 hover:bg-blue-50 hover:text-blue-600">

                                    Print Report

                                </button>

                            </div>

                        </div>

                    </form>

                </div>


                <!-- REVENUE CARDS -->

                <div
                    class="mb-7 grid grid-cols-1 gap-4 md:grid-cols-3">


                    <div
                        class="rounded-xl border border-slate-200 bg-white p-5">

                        <p
                            class="font-inter text-[10px] font-semibold uppercase tracking-wide text-slate-400">

                            Total Revenue

                        </p>


                        <p
                            class="mt-2 font-manrope text-2xl font-extrabold text-[#172033]">

                            Rs.

                            <%= String.format(
                                    "%.2f",
                                    revenueStats.getTotalRevenue()
                            ) %>

                        </p>


                        <p
                            class="mt-1 font-inter text-[10px] text-slate-400">

                            Total revenue generated

                        </p>

                    </div>


                    <div
                        class="rounded-xl border border-slate-200 bg-white p-5">

                        <p
                            class="font-inter text-[10px] font-semibold uppercase tracking-wide text-slate-400">

                            Appointment Revenue

                        </p>


                        <p
                            class="mt-2 font-manrope text-2xl font-extrabold text-[#172033]">

                            Rs.

                            <%= String.format(
                                    "%.2f",
                                    revenueStats.getAppointmentRevenue()
                            ) %>

                        </p>


                        <p
                            class="mt-1 font-inter text-[10px] text-slate-400">

                            Revenue from appointments

                        </p>

                    </div>


                    <div
                        class="rounded-xl border border-slate-200 bg-white p-5">

                        <p
                            class="font-inter text-[10px] font-semibold uppercase tracking-wide text-slate-400">

                            Walk-in Revenue

                        </p>


                        <p
                            class="mt-2 font-manrope text-2xl font-extrabold text-[#172033]">

                            Rs.

                            <%= String.format(
                                    "%.2f",
                                    revenueStats.getWalkInRevenue()
                            ) %>

                        </p>


                        <p
                            class="mt-1 font-inter text-[10px] text-slate-400">

                            Revenue from walk-ins

                        </p>

                    </div>

                </div>


                <!-- CHART -->

                <div
                    class="mb-7 rounded-xl border border-slate-200 bg-white p-6">


                    <div class="mb-5">

                        <h2
                            class="font-manrope text-sm font-extrabold text-[#172033]">

                            Daily Revenue

                        </h2>


                        <p
                            class="mt-1 font-inter text-[10px] text-slate-400">

                            Revenue generated for each day in the selected period.

                        </p>

                    </div>


                    <div class="h-[330px]">

                        <canvas id="revenueChart"></canvas>

                    </div>

                </div>


                <!-- BILLS -->

                <div
                    class="rounded-xl border border-slate-200 bg-white">


                    <div
                        class="flex items-center justify-between border-b border-slate-100 px-6 py-5">


                        <div>

                            <h2
                                class="font-manrope text-sm font-extrabold text-[#172033]">

                                Bills

                            </h2>


                            <p
                                class="mt-1 font-inter text-[10px] text-slate-400">

                                All bills generated during this period.

                            </p>

                        </div>


                        <div class="text-right">

                            <p
                                class="font-inter text-[10px] uppercase tracking-wide text-slate-400">

                                Total Bills

                            </p>


                            <p
                                class="mt-1 font-manrope text-xl font-extrabold text-[#172033]">

                                <%= revenueStats.getTotalBills() %>

                            </p>

                        </div>

                    </div>


                    <div class="overflow-x-auto">

                        <table class="w-full text-left text-sm">


                            <thead>

                                <tr
                                    class="border-b border-slate-100 bg-slate-50/60 font-inter text-[10px] font-semibold uppercase tracking-wide text-slate-400">

                                    <th class="px-6 py-3">
                                        Bill No.
                                    </th>

                                    <th class="px-6 py-3">
                                        Date
                                    </th>

                                    <th class="px-6 py-3">
                                        Patient
                                    </th>

                                    <th class="px-6 py-3">
                                        Treatment
                                    </th>

                                    <th class="px-6 py-3">
                                        Type
                                    </th>

                                    <th class="px-6 py-3 text-right">
                                        Consultation
                                    </th>

                                    <th class="px-6 py-3 text-right">
                                        Treatment
                                    </th>

                                    <th class="px-6 py-3 text-right">
                                        Total
                                    </th>

                                </tr>

                            </thead>


                            <tbody>

                            <%
                                List<ReportBill> bills =
                                        revenueStats.getBills();

                                if (bills == null || bills.isEmpty()) {
                            %>

                                <tr>

                                    <td
                                        colspan="8"
                                        class="px-6 py-12 text-center font-inter text-xs text-slate-400">

                                        No bills found for this period.

                                    </td>

                                </tr>

                            <%
                                } else {

                                    for (ReportBill bill : bills) {
                            %>

                                <tr
                                    class="border-b border-slate-50 transition hover:bg-slate-50/60">


                                    <td
                                        class="px-6 py-4 font-semibold text-slate-700">

                                        <%= bill.getBillNumber() %>

                                    </td>


                                    <td
                                        class="px-6 py-4 text-xs text-slate-500">

                                        <%= bill.getCreatedAt() %>

                                    </td>


                                    <td
                                        class="px-6 py-4 text-slate-700">

                                        <%= bill.getPatientName() != null
                                                ? bill.getPatientName()
                                                : "Not provided" %>

                                    </td>


                                    <td
                                        class="px-6 py-4 text-slate-700">

                                        <%= bill.getTreatmentName() != null
                                                ? bill.getTreatmentName()
                                                : "Not provided" %>

                                    </td>


                                    <td class="px-6 py-4">

                                        <% if ("WALK_IN".equals(
                                                bill.getBillType())) { %>

                                            <span
                                                class="status-badge bg-amber-50 text-amber-700">

                                                Walk-in

                                            </span>

                                        <% } else { %>

                                            <span
                                                class="status-badge bg-blue-50 text-blue-700">

                                                Appointment

                                            </span>

                                        <% } %>

                                    </td>


                                    <td
                                        class="px-6 py-4 text-right text-slate-600">

                                        Rs.

                                        <%= String.format(
                                                "%.2f",
                                                bill.getConsultationFee()
                                        ) %>

                                    </td>


                                    <td
                                        class="px-6 py-4 text-right text-slate-600">

                                        Rs.

                                        <%= String.format(
                                                "%.2f",
                                                bill.getTreatmentFee()
                                        ) %>

                                    </td>


                                    <td
                                        class="px-6 py-4 text-right font-bold text-[#172033]">

                                        Rs.

                                        <%= String.format(
                                                "%.2f",
                                                bill.getTotalAmount()
                                        ) %>

                                    </td>

                                </tr>

                            <%
                                    }

                                }
                            %>

                            </tbody>


                            <tfoot>

                                <tr class="bg-slate-50/60">

                                    <td
                                        colspan="7"
                                        class="px-6 py-4 text-right font-inter text-xs font-bold uppercase tracking-wide text-slate-500">

                                        Total Revenue

                                    </td>


                                    <td
                                        class="px-6 py-4 text-right font-manrope text-base font-extrabold text-[#172033]">

                                        Rs.

                                        <%= String.format(
                                                "%.2f",
                                                revenueStats.getTotalRevenue()
                                        ) %>

                                    </td>

                                </tr>

                            </tfoot>

                        </table>

                    </div>

                </div>

            </section>


            <!-- =========================================================
                 APPOINTMENTS
            ========================================================== -->

            <section
                id="appointments"
                class="report-section print-area">


                <!-- PRINT HEADER -->

                <div class="print-header mb-6">

                    <h1
                        class="font-manrope text-2xl font-extrabold">

                        SUNRISE DENTAL

                    </h1>


                    <p
                        class="mt-1 text-lg font-bold">

                        Appointment Report

                    </p>


                    <p class="mt-1 text-sm">

                        Period:

                        <%= appointmentStartDate %>

                        -

                        <%= appointmentEndDate %>

                    </p>

                </div>


                <!-- FILTER -->

                <div class="mb-7 no-print">

                    <form
                        method="get"
                        action="<%= request.getContextPath() %>/reports">


                        <input
                            type="hidden"
                            name="revenueFilter"
                            value="<%= revenueFilter %>">


                        <input
                            type="hidden"
                            name="treatmentFilter"
                            value="<%= treatmentFilter %>">


                        <div
                            class="rounded-xl border border-slate-200 bg-white p-5">


                            <div
                                class="flex flex-wrap items-end gap-3">


                                <div class="w-[220px]">

                                    <label
                                        class="mb-2 block font-inter text-[10px] font-semibold uppercase tracking-wide text-slate-400">

                                        Appointment Period

                                    </label>


                                    <select
                                        name="appointmentFilter"
                                        id="appointmentFilter"
                                        onchange="toggleDates('appointment')"
                                        class="w-full rounded-lg border border-slate-200 bg-white px-3 py-2.5 text-sm text-slate-700 outline-none focus:border-blue-500 focus:ring-2 focus:ring-blue-100">


                                        <option
                                            value="TODAY"
                                            <%= "TODAY".equals(appointmentFilter) ? "selected" : "" %>>

                                            Today

                                        </option>


                                        <option
                                            value="7D"
                                            <%= "7D".equals(appointmentFilter) ? "selected" : "" %>>

                                            Last 7 Days

                                        </option>


                                        <option
                                            value="MONTH"
                                            <%= "MONTH".equals(appointmentFilter) ? "selected" : "" %>>

                                            This Month

                                        </option>


                                        <option
                                            value="3M"
                                            <%= "3M".equals(appointmentFilter) ? "selected" : "" %>>

                                            Last 3 Months

                                        </option>


                                        <option
                                            value="YEAR"
                                            <%= "YEAR".equals(appointmentFilter) ? "selected" : "" %>>

                                            This Year

                                        </option>


                                        <option
                                            value="CUSTOM"
                                            <%= "CUSTOM".equals(appointmentFilter) ? "selected" : "" %>>

                                            Custom Range

                                        </option>

                                    </select>

                                </div>


                                <div
                                    id="appointmentDates"
                                    class="<%= "CUSTOM".equals(appointmentFilter) ? "flex" : "hidden" %> items-end gap-3">


                                    <div>

                                        <label
                                            class="mb-2 block font-inter text-[10px] font-semibold uppercase tracking-wide text-slate-400">

                                            From

                                        </label>


                                        <input
                                            type="date"
                                            name="appointmentStartDate"
                                            value="<%= appointmentStartDate %>"
                                            class="rounded-lg border border-slate-200 px-3 py-2.5 text-sm outline-none focus:border-blue-500">

                                    </div>


                                    <div>

                                        <label
                                            class="mb-2 block font-inter text-[10px] font-semibold uppercase tracking-wide text-slate-400">

                                            To

                                        </label>


                                        <input
                                            type="date"
                                            name="appointmentEndDate"
                                            value="<%= appointmentEndDate %>"
                                            class="rounded-lg border border-slate-200 px-3 py-2.5 text-sm outline-none focus:border-blue-500">

                                    </div>

                                </div>


                                <button
                                    type="submit"
                                    class="rounded-lg bg-[#2563EB] px-5 py-2.5 text-sm font-semibold text-white shadow-sm transition hover:bg-[#1D4ED8]">

                                    Apply

                                </button>


                                <button
                                    type="button"
                                    onclick="printReport('appointments')"
                                    class="rounded-lg border border-slate-200 bg-white px-5 py-2.5 text-sm font-semibold text-slate-700 transition hover:border-blue-200 hover:bg-blue-50 hover:text-blue-600">

                                    Print Report

                                </button>

                            </div>

                        </div>

                    </form>

                </div>


                <!-- SUMMARY -->

                <div class="mb-7">


                    <div class="mb-4">

                        <h2
                            class="font-manrope text-sm font-extrabold text-[#172033]">

                            Appointment Summary

                        </h2>


                        <p
                            class="mt-1 font-inter text-[10px] text-slate-400">

                            Overview of appointment activity during the selected period.

                        </p>

                    </div>


                    <div
                        class="grid grid-cols-1 gap-4 sm:grid-cols-2 xl:grid-cols-5">


                        <div
                            class="rounded-xl border border-slate-200 bg-white p-5">

                            <p
                                class="font-inter text-[10px] font-semibold uppercase tracking-wide text-slate-400">

                                Scheduled

                            </p>


                            <p
                                class="mt-2 font-manrope text-2xl font-extrabold text-[#172033]">

                                <%= appointmentStats.getScheduledAppointments() %>

                            </p>

                        </div>


                        <div
                            class="rounded-xl border border-slate-200 bg-white p-5">

                            <p
                                class="font-inter text-[10px] font-semibold uppercase tracking-wide text-slate-400">

                                Completed

                            </p>


                            <p
                                class="mt-2 font-manrope text-2xl font-extrabold text-emerald-700">

                                <%= appointmentStats.getCompletedAppointments() %>

                            </p>

                        </div>


                        <div
                            class="rounded-xl border border-slate-200 bg-white p-5">

                            <p
                                class="font-inter text-[10px] font-semibold uppercase tracking-wide text-slate-400">

                                Cancelled

                            </p>


                            <p
                                class="mt-2 font-manrope text-2xl font-extrabold text-red-600">

                                <%= appointmentStats.getCancelledAppointments() %>

                            </p>

                        </div>


                        <div
                            class="rounded-xl border border-slate-200 bg-white p-5">

                            <p
                                class="font-inter text-[10px] font-semibold uppercase tracking-wide text-slate-400">

                                No Show

                            </p>


                            <p
                                class="mt-2 font-manrope text-2xl font-extrabold text-amber-600">

                                <%= appointmentStats.getNoShowAppointments() %>

                            </p>

                        </div>


                        <div
                            class="rounded-xl border border-slate-200 bg-white p-5">

                            <p
                                class="font-inter text-[10px] font-semibold uppercase tracking-wide text-slate-400">

                                Billed

                            </p>


                            <p
                                class="mt-2 font-manrope text-2xl font-extrabold text-blue-600">

                                <%= appointmentStats.getBilledAppointments() %>

                            </p>

                        </div>

                    </div>


                    <div class="mt-4 flex justify-end">

                        <div
                            class="rounded-xl bg-[#172033] px-7 py-4 text-white">

                            <p
                                class="font-inter text-[10px] font-semibold uppercase tracking-wide text-slate-400">

                                Total Appointments

                            </p>


                            <p
                                class="mt-1 font-manrope text-2xl font-extrabold">

                                <%= appointmentStats.getTotalAppointments() %>

                            </p>

                        </div>

                    </div>

                </div>


                <!-- APPOINTMENT TABLE -->

                <div
                    class="rounded-xl border border-slate-200 bg-white">


                    <div
                        class="border-b border-slate-100 px-6 py-5">

                        <h2
                            class="font-manrope text-sm font-extrabold text-[#172033]">

                            Appointment Details

                        </h2>


                        <p
                            class="mt-1 font-inter text-[10px] text-slate-400">

                            Appointment records and their current status.

                        </p>

                    </div>


                    <div class="overflow-x-auto">

                        <table class="w-full text-left text-sm">


                            <thead>

                                <tr
                                    class="border-b border-slate-100 bg-slate-50/60 font-inter text-[10px] font-semibold uppercase tracking-wide text-slate-400">

                                    <th class="px-6 py-3">
                                        Appointment No.
                                    </th>

                                    <th class="px-6 py-3">
                                        Date
                                    </th>

                                    <th class="px-6 py-3">
                                        Time
                                    </th>

                                    <th class="px-6 py-3">
                                        Patient
                                    </th>

                                    <th class="px-6 py-3">
                                        Dentist
                                    </th>

                                    <th class="px-6 py-3">
                                        Treatment
                                    </th>

                                    <th class="px-6 py-3">
                                        Status
                                    </th>

                                </tr>

                            </thead>


                            <tbody>

                            <%
                                List<ReportAppointment> appointments =
                                        appointmentStats.getAppointments();

                                if (appointments == null ||
                                    appointments.isEmpty()) {
                            %>

                                <tr>

                                    <td
                                        colspan="7"
                                        class="px-6 py-12 text-center font-inter text-xs text-slate-400">

                                        No appointments found for this period.

                                    </td>

                                </tr>

                            <%
                                } else {

                                    for (ReportAppointment appointment :
                                            appointments) {

                                        String status =
                                                appointment.getStatus();

                                        String statusClass =
                                                "status-default";


                                        if (status != null) {

                                            if (status.equalsIgnoreCase(
                                                    "SCHEDULED")) {

                                                statusClass =
                                                        "status-scheduled";

                                            } else if (
                                                    status.equalsIgnoreCase(
                                                            "COMPLETED")) {

                                                statusClass =
                                                        "status-completed";

                                            } else if (
                                                    status.equalsIgnoreCase(
                                                            "CANCELLED")) {

                                                statusClass =
                                                        "status-cancelled";

                                            } else if (
                                                    status.equalsIgnoreCase(
                                                            "NO SHOW")
                                                    ||
                                                    status.equalsIgnoreCase(
                                                            "NO_SHOW")) {

                                                statusClass =
                                                        "status-no-show";

                                            } else if (
                                                    status.equalsIgnoreCase(
                                                            "BILLED")) {

                                                statusClass =
                                                        "status-billed";
                                            }
                                        }
                            %>

                                <tr
                                    class="border-b border-slate-50 transition hover:bg-slate-50/60">


                                    <td
                                        class="px-6 py-4 font-semibold text-slate-700">

                                        <%= appointment.getAppointmentNumber() %>

                                    </td>


                                    <td
                                        class="px-6 py-4 text-slate-600">

                                        <%= appointment.getAppointmentDate() %>

                                    </td>


                                    <td
                                        class="px-6 py-4 text-slate-600">

                                        <%= appointment.getAppointmentTime() %>

                                    </td>


                                    <td
                                        class="px-6 py-4 text-slate-700">

                                        <%= appointment.getPatientName() != null
                                                ? appointment.getPatientName()
                                                : "Not provided" %>

                                    </td>


                                    <td
                                        class="px-6 py-4 text-slate-700">

                                        <%= appointment.getDentistName() != null
                                                ? appointment.getDentistName()
                                                : "Not provided" %>

                                    </td>


                                    <td
                                        class="px-6 py-4 text-slate-700">

                                        <%= appointment.getTreatmentName() != null
                                                ? appointment.getTreatmentName()
                                                : "Not provided" %>

                                    </td>


                                    <td class="px-6 py-4">

                                        <span
                                            class="status-badge <%= statusClass %>">

                                            <%= status != null
                                                    ? status.replace("_", " ")
                                                    : "Unknown" %>

                                        </span>

                                    </td>

                                </tr>

                            <%
                                    }
                                }
                            %>

                            </tbody>

                        </table>

                    </div>

                </div>

            </section>


            <!-- =========================================================
                 TREATMENTS
            ========================================================== -->

            <section
                id="treatments"
                class="report-section print-area">


                <!-- PRINT HEADER -->

                <div class="print-header mb-6">

                    <h1
                        class="font-manrope text-2xl font-extrabold">

                        SUNRISE DENTAL

                    </h1>


                    <p
                        class="mt-1 text-lg font-bold">

                        Treatment Report

                    </p>


                    <p class="mt-1 text-sm">

                        Period:

                        <%= treatmentStartDate %>

                        -

                        <%= treatmentEndDate %>

                    </p>

                </div>


                <!-- FILTER -->

                <div class="mb-7 no-print">

                    <form
                        method="get"
                        action="<%= request.getContextPath() %>/reports">


                        <input
                            type="hidden"
                            name="revenueFilter"
                            value="<%= revenueFilter %>">


                        <input
                            type="hidden"
                            name="appointmentFilter"
                            value="<%= appointmentFilter %>">


                        <div
                            class="rounded-xl border border-slate-200 bg-white p-5">


                            <div
                                class="flex flex-wrap items-end gap-3">


                                <div class="w-[220px]">

                                    <label
                                        class="mb-2 block font-inter text-[10px] font-semibold uppercase tracking-wide text-slate-400">

                                        Treatment Period

                                    </label>


                                    <select
                                        name="treatmentFilter"
                                        id="treatmentFilter"
                                        onchange="toggleDates('treatment')"
                                        class="w-full rounded-lg border border-slate-200 bg-white px-3 py-2.5 text-sm text-slate-700 outline-none focus:border-blue-500 focus:ring-2 focus:ring-blue-100">


                                        <option
                                            value="TODAY"
                                            <%= "TODAY".equals(treatmentFilter) ? "selected" : "" %>>

                                            Today

                                        </option>


                                        <option
                                            value="7D"
                                            <%= "7D".equals(treatmentFilter) ? "selected" : "" %>>

                                            Last 7 Days

                                        </option>


                                        <option
                                            value="MONTH"
                                            <%= "MONTH".equals(treatmentFilter) ? "selected" : "" %>>

                                            This Month

                                        </option>


                                        <option
                                            value="3M"
                                            <%= "3M".equals(treatmentFilter) ? "selected" : "" %>>

                                            Last 3 Months

                                        </option>


                                        <option
                                            value="YEAR"
                                            <%= "YEAR".equals(treatmentFilter) ? "selected" : "" %>>

                                            This Year

                                        </option>


                                        <option
                                            value="CUSTOM"
                                            <%= "CUSTOM".equals(treatmentFilter) ? "selected" : "" %>>

                                            Custom Range

                                        </option>

                                    </select>

                                </div>


                                <div
                                    id="treatmentDates"
                                    class="<%= "CUSTOM".equals(treatmentFilter) ? "flex" : "hidden" %> items-end gap-3">


                                    <div>

                                        <label
                                            class="mb-2 block font-inter text-[10px] font-semibold uppercase tracking-wide text-slate-400">

                                            From

                                        </label>


                                        <input
                                            type="date"
                                            name="treatmentStartDate"
                                            value="<%= treatmentStartDate %>"
                                            class="rounded-lg border border-slate-200 px-3 py-2.5 text-sm outline-none focus:border-blue-500">

                                    </div>


                                    <div>

                                        <label
                                            class="mb-2 block font-inter text-[10px] font-semibold uppercase tracking-wide text-slate-400">

                                            To

                                        </label>


                                        <input
                                            type="date"
                                            name="treatmentEndDate"
                                            value="<%= treatmentEndDate %>"
                                            class="rounded-lg border border-slate-200 px-3 py-2.5 text-sm outline-none focus:border-blue-500">

                                    </div>

                                </div>


                                <button
                                    type="submit"
                                    class="rounded-lg bg-[#2563EB] px-5 py-2.5 text-sm font-semibold text-white shadow-sm transition hover:bg-[#1D4ED8]">

                                    Apply

                                </button>


                                <button
                                    type="button"
                                    onclick="printReport('treatments')"
                                    class="rounded-lg border border-slate-200 bg-white px-5 py-2.5 text-sm font-semibold text-slate-700 transition hover:border-blue-200 hover:bg-blue-50 hover:text-blue-600">

                                    Print Report

                                </button>

                            </div>

                        </div>

                    </form>

                </div>


                <!-- TREATMENT SUMMARY -->

                <div
                    class="mb-7 grid grid-cols-1 gap-4 sm:grid-cols-2">


                    <div
                        class="rounded-xl border border-slate-200 bg-white p-5">

                        <p
                            class="font-inter text-[10px] font-semibold uppercase tracking-wide text-slate-400">

                            Treatment Types

                        </p>


                        <p
                            class="mt-2 font-manrope text-2xl font-extrabold text-[#172033]">

                            <%= treatmentStats.getTreatments() != null
                                    ? treatmentStats.getTreatments().size()
                                    : 0 %>

                        </p>


                        <p
                            class="mt-1 font-inter text-[10px] text-slate-400">

                            Types recorded in this period

                        </p>

                    </div>


                    <div
                        class="rounded-xl border border-slate-200 bg-white p-5">

                        <p
                            class="font-inter text-[10px] font-semibold uppercase tracking-wide text-slate-400">

                            Total Completed

                        </p>


                        <p
                            class="mt-2 font-manrope text-2xl font-extrabold text-emerald-700">


                            <%
                                List<ReportTreatment> summaryTreatments =
                                        treatmentStats.getTreatments();

                                int summaryTotal = 0;


                                if (summaryTreatments != null) {

                                    for (ReportTreatment item :
                                            summaryTreatments) {

                                        summaryTotal +=
                                                item.getCompletedCount();
                                    }
                                }
                            %>


                            <%= summaryTotal %>

                        </p>


                        <p
                            class="mt-1 font-inter text-[10px] text-slate-400">

                            Completed treatments

                        </p>

                    </div>

                </div>


                <!-- TREATMENT TABLE -->

                <div
                    class="rounded-xl border border-slate-200 bg-white">


                    <div
                        class="border-b border-slate-100 px-6 py-5">

                        <h2
                            class="font-manrope text-sm font-extrabold text-[#172033]">

                            Completed Treatments

                        </h2>


                        <p
                            class="mt-1 font-inter text-[10px] text-slate-400">

                            Number of completed treatments by treatment type.

                        </p>

                    </div>


                    <div class="overflow-x-auto">

                        <table class="w-full text-left text-sm">


                            <thead>

                                <tr
                                    class="border-b border-slate-100 bg-slate-50/60 font-inter text-[10px] font-semibold uppercase tracking-wide text-slate-400">

                                    <th class="px-6 py-3">

                                        Treatment Type

                                    </th>


                                    <th class="px-6 py-3 text-right">

                                        Completed

                                    </th>

                                </tr>

                            </thead>


                            <tbody>

                            <%
                                List<ReportTreatment> treatments =
                                        treatmentStats.getTreatments();

                                int treatmentTotal = 0;


                                if (treatments == null ||
                                    treatments.isEmpty()) {
                            %>

                                <tr>

                                    <td
                                        colspan="2"
                                        class="px-6 py-12 text-center font-inter text-xs text-slate-400">

                                        No completed treatments found for this period.

                                    </td>

                                </tr>

                            <%
                                } else {

                                    for (ReportTreatment treatment :
                                            treatments) {

                                        treatmentTotal +=
                                                treatment.getCompletedCount();
                            %>

                                <tr
                                    class="border-b border-slate-50 transition hover:bg-slate-50/60">


                                    <td
                                        class="px-6 py-4 font-semibold text-slate-700">

                                        <%= treatment.getTreatmentName() %>

                                    </td>


                                    <td
                                        class="px-6 py-4 text-right">

                                        <span
                                            class="status-badge status-completed">

                                            <%= treatment.getCompletedCount() %>

                                        </span>

                                    </td>

                                </tr>

                            <%
                                    }
                                }
                            %>

                            </tbody>


                            <tfoot>

                                <tr class="bg-slate-50/60">

                                    <td
                                        class="px-6 py-4 text-right font-inter text-xs font-bold uppercase tracking-wide text-slate-500">

                                        Total Completed

                                    </td>


                                    <td
                                        class="px-6 py-4 text-right font-manrope text-base font-extrabold text-[#172033]">

                                        <%= treatmentTotal %>

                                    </td>

                                </tr>

                            </tfoot>

                        </table>

                    </div>

                </div>

            </section>


        </div>

    </main>


    <!-- =========================================================
         JAVASCRIPT
    ========================================================== -->

    <script>


        // =========================================================
        // SHOW REPORT TAB
        // =========================================================

        function showReport(name) {

            const sections =
                document.querySelectorAll(
                    '.report-section'
                );


            sections.forEach(
                function(section) {

                    section.classList.remove(
                        'active'
                    );

                }
            );


            const tabs =
                document.querySelectorAll(
                    '.report-tab'
                );


            tabs.forEach(
                function(tab) {

                    tab.classList.remove(
                        'active'
                    );

                }
            );


            const selectedSection =
                document.getElementById(name);


            let tabId = "";


            if (name === "revenue") {

                tabId = "RevenueTab";

            }

            else if (name === "appointments") {

                tabId = "AppointmentsTab";

            }

            else if (name === "treatments") {

                tabId = "TreatmentsTab";

            }


            const selectedTab =
                document.getElementById(tabId);


            if (selectedSection) {

                selectedSection.classList.add(
                    'active'
                );

            }


            if (selectedTab) {

                selectedTab.classList.add(
                    'active'
                );

            }

        }


        // =========================================================
        // DATE FIELDS
        // =========================================================

        function toggleDates(prefix) {

            const select =
                document.getElementById(
                    prefix + 'Filter'
                );


            const container =
                document.getElementById(
                    prefix + 'Dates'
                );


            if (!select || !container) {

                return;

            }


            if (select.value === 'CUSTOM') {

                container.classList.remove(
                    'hidden'
                );

                container.classList.add(
                    'flex'
                );

            }

            else {

                container.classList.remove(
                    'flex'
                );

                container.classList.add(
                    'hidden'
                );

            }

        }


        // =========================================================
        // PRINT REPORT
        // =========================================================

        function printReport(name) {

            const sections =
                document.querySelectorAll(
                    '.report-section'
                );


            sections.forEach(
                function(section) {

                    section.classList.remove(
                        'printing'
                    );

                }
            );


            const section =
                document.getElementById(name);


            if (!section) {

                return;

            }


            section.classList.add(
                'printing'
            );


            window.print();


            setTimeout(
                function() {

                    section.classList.remove(
                        'printing'
                    );

                },
                500
            );

        }


        // =========================================================
        // REVENUE CHART DATA
        // =========================================================

        const revenueDates = [

            <%
                List<String> dates =
                        revenueStats.getRevenueDates();

                if (dates != null) {

                    for (int i = 0;
                         i < dates.size();
                         i++) {

                        if (i > 0) {
            %>
                            ,
            <%
                        }
            %>

            "<%= dates.get(i) %>"

            <%
                    }
                }
            %>

        ];


        const revenueValues = [

            <%
                List<Double> values =
                        revenueStats.getDailyRevenue();

                if (values != null) {

                    for (int i = 0;
                         i < values.size();
                         i++) {

                        if (i > 0) {
            %>
                            ,
            <%
                        }
            %>

            <%= values.get(i) %>

            <%
                    }
                }
            %>

        ];


        // =========================================================
        // CREATE REVENUE CHART
        // =========================================================

        const chart =
            document.getElementById(
                'revenueChart'
            );


        if (chart) {

            new Chart(
                chart,
                {

                    type: 'line',


                    data: {

                        labels: revenueDates,


                        datasets: [

                            {

                                label:
                                    'Daily Revenue',

                                data:
                                    revenueValues,

                                borderWidth:
                                    2,

                                tension:
                                    0.35,

                                fill:
                                    true,

                                pointRadius:
                                    3,

                                pointHoverRadius:
                                    5

                            }

                        ]

                    },


                    options: {

                        responsive:
                            true,

                        maintainAspectRatio:
                            false,


                        interaction: {

                            intersect:
                                false,

                            mode:
                                'index'

                        },


                        plugins: {

                            legend: {

                                display:
                                    false

                            },


                            tooltip: {

                                callbacks: {

                                    label:
                                        function(context) {

                                            return ' Rs. ' +

                                                Number(
                                                    context.raw
                                                ).toLocaleString(
                                                    'en-LK',
                                                    {
                                                        minimumFractionDigits: 2,
                                                        maximumFractionDigits: 2
                                                    }
                                                );

                                        }

                                }

                            }

                        },


                        scales: {

                            x: {

                                grid: {

                                    display:
                                        false

                                },


                                ticks: {

                                    font: {

                                        size: 10

                                    }

                                }

                            },


                            y: {

                                beginAtZero:
                                    true,


                                grid: {

                                    color:
                                        '#f1f5f9'

                                },


                                ticks: {

                                    font: {

                                        size: 10

                                    },


                                    callback:
                                        function(value) {

                                            return 'Rs. ' +

                                                Number(
                                                    value
                                                ).toLocaleString(
                                                    'en-LK'
                                                );

                                        }

                                }

                            }

                        }

                    }

                }
            );

        }


    </script>


</body>

</html>