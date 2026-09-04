<%@ page contentType="text/html;charset=UTF-8" %>

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

                        

                        -

                        

                    </p>

                </div>


                <!-- FILTER -->

                <div class="mb-7 no-print">

                    <form
                        method="get"
                        action="#">


                        <input
                            type="hidden"
                            name="appointmentFilter"
                            value="7D">


                        <input
                            type="hidden"
                            name="treatmentFilter"
                            value="MONTH">


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
                                            >

                                            Today

                                        </option>


                                        <option
                                            value="7D"
                                            selected>

                                            Last 7 Days

                                        </option>


                                        <option
                                            value="MONTH"
                                            >

                                            This Month

                                        </option>


                                        <option
                                            value="3M"
                                            >

                                            Last 3 Months

                                        </option>


                                        <option
                                            value="YEAR"
                                            >

                                            This Year

                                        </option>


                                        <option
                                            value="CUSTOM"
                                            >

                                            Custom Range

                                        </option>

                                    </select>

                                </div>


                                <div
                                    id="revenueDates"
                                    class="flex items-end gap-3">


                                    <div>

                                        <label
                                            class="mb-2 block font-inter text-[10px] font-semibold uppercase tracking-wide text-slate-400">

                                            From

                                        </label>


                                        <input
                                            type="date"
                                            name="revenueStartDate"
                                            value=""
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
                                            value=""
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

                            <span id="revenueTotalRevenue">0.00</span>

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

                            <span id="revenueAppointmentRevenue">0.00</span>

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

                            <span id="revenueWalkInRevenue">0.00</span>

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

                                <span id="revenueTotalBills">0</span>

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


                            <tbody id="billsTableBody">
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

                                        <span id="revenueFooterTotal">0.00</span>

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

                        

                        -

                        

                    </p>

                </div>


                <!-- FILTER -->

                <div class="mb-7 no-print">

                    <form
                        method="get"
                        action="#">


                        <input
                            type="hidden"
                            name="revenueFilter"
                            value="7D">


                        <input
                            type="hidden"
                            name="treatmentFilter"
                            value="MONTH">


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
                                            >

                                            Today

                                        </option>


                                        <option
                                            value="7D"
                                            selected>

                                            Last 7 Days

                                        </option>


                                        <option
                                            value="MONTH"
                                            >

                                            This Month

                                        </option>


                                        <option
                                            value="3M"
                                            >

                                            Last 3 Months

                                        </option>


                                        <option
                                            value="YEAR"
                                            >

                                            This Year

                                        </option>


                                        <option
                                            value="CUSTOM"
                                            >

                                            Custom Range

                                        </option>

                                    </select>

                                </div>


                                <div
                                    id="appointmentDates"
                                    class="flex items-end gap-3">


                                    <div>

                                        <label
                                            class="mb-2 block font-inter text-[10px] font-semibold uppercase tracking-wide text-slate-400">

                                            From

                                        </label>


                                        <input
                                            type="date"
                                            name="appointmentStartDate"
                                            value=""
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
                                            value=""
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

                                <span id="scheduledAppointments">0</span>

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

                                <span id="completedAppointments">0</span>

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

                                <span id="cancelledAppointments">0</span>

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

                                <span id="noShowAppointments">0</span>

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

                                <span id="billedAppointments">0</span>

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

                                <span id="totalAppointments">0</span>

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


                            <tbody id="appointmentsTableBody">
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

                        

                        -

                        

                    </p>

                </div>


                <!-- FILTER -->

                <div class="mb-7 no-print">

                    <form
                        method="get"
                        action="#">


                        <input
                            type="hidden"
                            name="revenueFilter"
                            value="7D">


                        <input
                            type="hidden"
                            name="appointmentFilter"
                            value="7D">


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
                                            >

                                            Today

                                        </option>


                                        <option
                                            value="7D"
                                            >

                                            Last 7 Days

                                        </option>


                                        <option
                                            value="MONTH"
                                            selected>

                                            This Month

                                        </option>


                                        <option
                                            value="3M"
                                            >

                                            Last 3 Months

                                        </option>


                                        <option
                                            value="YEAR"
                                            >

                                            This Year

                                        </option>


                                        <option
                                            value="CUSTOM"
                                            >

                                            Custom Range

                                        </option>

                                    </select>

                                </div>


                                <div
                                    id="treatmentDates"
                                    class="flex items-end gap-3">


                                    <div>

                                        <label
                                            class="mb-2 block font-inter text-[10px] font-semibold uppercase tracking-wide text-slate-400">

                                            From

                                        </label>


                                        <input
                                            type="date"
                                            name="treatmentStartDate"
                                            value=""
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
                                            value=""
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

                            <span id="treatmentTypes">0</span>

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


                            <span id="treatmentTotal">0</span>

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


                            <tbody id="treatmentsTableBody">
</tbody>


                            <tfoot>

                                <tr class="bg-slate-50/60">

                                    <td
                                        class="px-6 py-4 text-right font-inter text-xs font-bold uppercase tracking-wide text-slate-500">

                                        Total Completed

                                    </td>


                                    <td
                                        class="px-6 py-4 text-right font-manrope text-base font-extrabold text-[#172033]">

                                        <span id="treatmentFooterTotal">0</span>

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
        // REPORT DATA / REST API
        // =========================================================

        var reportData = null;
        var revenueChart = null;


        function getContextPath() {

            var path = window.location.pathname;

            var firstSlash = path.indexOf("/", 1);

            if (firstSlash === -1) {
                return "";
            }

            return path.substring(0, firstSlash);
        }


        function getFilter(prefix) {

            var filterMap = {
                revenue: "revenueFilter",
                appointment: "appointmentFilter",
                appointments: "appointmentFilter",
                treatment: "treatmentFilter",
                treatments: "treatmentFilter"
            };

            var id = filterMap[prefix] || (prefix + "Filter");

            return document.getElementById(id);
        }


        function getDates(prefix) {

            var filterPrefix =
                prefix === "appointments"
                    ? "appointment"
                    : prefix === "treatments"
                        ? "treatment"
                        : prefix;

            var start =
                document.getElementById(
                    filterPrefix + "StartDate"
                );

            var end =
                document.getElementById(
                    filterPrefix + "EndDate"
                );

            return {
                start: start,
                end: end
            };
        }


        function formatDate(date) {

            var year =
                date.getFullYear();

            var month =
                String(
                    date.getMonth() + 1
                ).padStart(2, "0");

            var day =
                String(
                    date.getDate()
                ).padStart(2, "0");

            return year + "-" + month + "-" + day;
        }


        function getRange(prefix) {

            var filter = getFilter(prefix);

            var filterValue =
                filter
                    ? filter.value
                    : (prefix === "treatment"
                        ? "MONTH"
                        : "7D");


            var dates =
                getDates(prefix);


            if (filterValue === "CUSTOM") {

                if (!dates.start || !dates.end) {
                    throw new Error(
                        "Custom date fields could not be found."
                    );
                }

                if (!dates.start.value ||
                    !dates.end.value) {

                    throw new Error(
                        "Please select both start and end dates."
                    );
                }

                return {
                    startDate: dates.start.value,
                    endDate: dates.end.value
                };
            }


            var end = new Date();
            var start = new Date();


            if (filterValue === "TODAY") {

                // same day
            }

            else if (filterValue === "7D") {

                start.setDate(
                    end.getDate() - 6
                );
            }

            else if (filterValue === "MONTH") {

                start =
                    new Date(
                        end.getFullYear(),
                        end.getMonth(),
                        1
                    );
            }

            else if (filterValue === "3M") {

                start.setMonth(
                    end.getMonth() - 2
                );

                start.setDate(1);
            }

            else if (filterValue === "YEAR") {

                start =
                    new Date(
                        end.getFullYear(),
                        0,
                        1
                    );
            }

            else {

                start.setDate(
                    end.getDate() - 6
                );
            }


            return {
                startDate: formatDate(start),
                endDate: formatDate(end)
            };
        }


        function updatePeriodDisplay(prefix, range) {

            var displayPrefix =
                prefix === "appointments"
                    ? "appointment"
                    : prefix === "treatments"
                        ? "treatment"
                        : prefix;

            var start =
                document.getElementById(
                    displayPrefix + "StartDisplay"
                );

            var end =
                document.getElementById(
                    displayPrefix + "EndDisplay"
                );


            if (start) {
                start.textContent =
                    range.startDate;
            }

            if (end) {
                end.textContent =
                    range.endDate;
            }
        }


        function setValue(id, value) {

            var element =
                document.getElementById(id);

            if (element) {
                element.textContent =
                    value === null ||
                    value === undefined
                        ? "0"
                        : value;
            }
        }


        function formatMoney(value) {

            return Number(
                value || 0
            ).toLocaleString(
                "en-LK",
                {
                    minimumFractionDigits: 2,
                    maximumFractionDigits: 2
                }
            );
        }


        // =========================================================
        // SHOW REPORT TAB
        // =========================================================

        function showReport(name) {

            var sections =
                document.querySelectorAll(
                    ".report-section"
                );


            sections.forEach(
                function(section) {

                    section.classList.remove(
                        "active"
                    );

                }
            );


            var tabs =
                document.querySelectorAll(
                    ".report-tab"
                );


            tabs.forEach(
                function(tab) {

                    tab.classList.remove(
                        "active"
                    );

                }
            );


            var selectedSection =
                document.getElementById(name);


            var tabId = "";


            if (name === "revenue") {

                tabId = "RevenueTab";
            }

            else if (name === "appointments") {

                tabId = "AppointmentsTab";
            }

            else if (name === "treatments") {

                tabId = "TreatmentsTab";
            }


            var selectedTab =
                document.getElementById(tabId);


            if (selectedSection) {

                selectedSection.classList.add(
                    "active"
                );

            }


            if (selectedTab) {

                selectedTab.classList.add(
                    "active"
                );

            }


            loadReportFor(
                name === "appointments"
                    ? "appointment"
                    : name === "treatments"
                        ? "treatment"
                        : "revenue"
            );
        }


        // =========================================================
        // DATE FIELDS
        // =========================================================

        function toggleDates(prefix) {

            var realPrefix =
                prefix === "appointments"
                    ? "appointment"
                    : prefix === "treatments"
                        ? "treatment"
                        : prefix;


            var select =
                document.getElementById(
                    realPrefix + "Filter"
                );


            var container =
                document.getElementById(
                    realPrefix + "Dates"
                );


            if (!select || !container) {
                return;
            }


            if (select.value === "CUSTOM") {

                container.classList.remove(
                    "hidden"
                );

                container.classList.add(
                    "flex"
                );

            }

            else {

                container.classList.remove(
                    "flex"
                );

                container.classList.add(
                    "hidden"
                );

            }
        }


        // =========================================================
        // RENDER BILLS
        // =========================================================

        function renderBills(bills) {

            var body =
                document.getElementById(
                    "billsTableBody"
                );

            if (!body) {
                return;
            }


            body.innerHTML = "";


            if (!bills || bills.length === 0) {

                body.innerHTML =
                    '<tr>' +
                    '<td colspan="8" class="px-6 py-8 text-center text-xs text-slate-400">' +
                    'No bills found for this period.' +
                    '</td>' +
                    '</tr>';

                return;
            }


            bills.forEach(
                function(bill) {

                    var row =
                        document.createElement("tr");

                    row.className =
                        "border-b border-slate-100";


                    var typeClass =
                        String(bill.billType || "")
                            .toUpperCase() === "WALK_IN"
                            ? "bg-amber-50 text-amber-700"
                            : "bg-blue-50 text-blue-700";


                    var typeText =
                        String(bill.billType || "")
                            .replace("_", " ");


                    row.innerHTML =
                        '<td class="px-6 py-4 text-xs font-semibold text-slate-700">' +
                            escapeHtml(bill.billNumber || "-") +
                        '</td>' +

                        '<td class="px-6 py-4 text-xs text-slate-600">' +
                            escapeHtml(formatDateTime(bill.createdAt)) +
                        '</td>' +

                        '<td class="px-6 py-4 text-slate-600">' +
                            escapeHtml(bill.patientName || "Not provided") +
                        '</td>' +

                        '<td class="px-6 py-4 text-slate-600">' +
                            escapeHtml(bill.treatmentName || "Not provided") +
                        '</td>' +

                        '<td class="px-6 py-4">' +
                            '<span class="status-badge ' + typeClass + '">' +
                                escapeHtml(typeText) +
                            '</span>' +
                        '</td>' +

                        '<td class="px-6 py-4 text-right text-slate-600">' +
                            'Rs. ' + formatMoney(bill.consultationFee) +
                        '</td>' +

                        '<td class="px-6 py-4 text-right text-slate-600">' +
                            'Rs. ' + formatMoney(bill.treatmentFee) +
                        '</td>' +

                        '<td class="px-6 py-4 text-right font-semibold text-slate-700">' +
                            'Rs. ' + formatMoney(bill.totalAmount) +
                        '</td>';

                    body.appendChild(row);
                }
            );
        }


        // =========================================================
        // RENDER APPOINTMENTS
        // =========================================================

        function renderAppointments(appointments) {

            var body =
                document.getElementById(
                    "appointmentsTableBody"
                );

            if (!body) {
                return;
            }


            body.innerHTML = "";


            if (!appointments || appointments.length === 0) {

                body.innerHTML =
                    '<tr>' +
                    '<td colspan="7" class="px-6 py-8 text-center text-xs text-slate-400">' +
                    'No appointments found for this period.' +
                    '</td>' +
                    '</tr>';

                return;
            }


            appointments.forEach(
                function(appointment) {

                    var row =
                        document.createElement("tr");

                    row.className =
                        "border-b border-slate-100";


                    var status =
                        appointment.status || "UNKNOWN";


                    var statusClass =
                        "bg-slate-50 text-slate-600";


                    if (status === "COMPLETED") {
                        statusClass =
                            "bg-emerald-50 text-emerald-700";
                    }

                    else if (status === "CANCELLED") {
                        statusClass =
                            "bg-red-50 text-red-700";
                    }

                    else if (status === "NO_SHOW") {
                        statusClass =
                            "bg-amber-50 text-amber-700";
                    }

                    else if (status === "BILLED") {
                        statusClass =
                            "bg-blue-50 text-blue-700";
                    }

                    else if (status === "SCHEDULED") {
                        statusClass =
                            "bg-indigo-50 text-indigo-700";
                    }


                    row.innerHTML =
                        '<td class="px-6 py-4 text-xs font-semibold text-slate-700">' +
                            escapeHtml(appointment.appointmentNumber || "-") +
                        '</td>' +

                        '<td class="px-6 py-4 text-xs text-slate-600">' +
                            escapeHtml(appointment.appointmentDate || "-") +
                        '</td>' +

                        '<td class="px-6 py-4 text-xs text-slate-600">' +
                            escapeHtml(appointment.appointmentTime || "-") +
                        '</td>' +

                        '<td class="px-6 py-4 text-slate-600">' +
                            escapeHtml(appointment.patientName || "Not provided") +
                        '</td>' +

                        '<td class="px-6 py-4 text-slate-600">' +
                            escapeHtml(appointment.dentistName || "Not provided") +
                        '</td>' +

                        '<td class="px-6 py-4 text-slate-600">' +
                            escapeHtml(appointment.treatmentName || "Not provided") +
                        '</td>' +

                        '<td class="px-6 py-4">' +
                            '<span class="status-badge ' + statusClass + '">' +
                                escapeHtml(status.replace("_", " ")) +
                            '</span>' +
                        '</td>';

                    body.appendChild(row);
                }
            );
        }


        // =========================================================
        // RENDER TREATMENTS
        // =========================================================

        function renderTreatments(treatments) {

            var body =
                document.getElementById(
                    "treatmentsTableBody"
                );

            if (!body) {
                return;
            }


            body.innerHTML = "";


            var total = 0;


            if (treatments) {

                treatments.forEach(
                    function(item) {

                        total +=
                            Number(
                                item.completedCount || 0
                            );

                    }
                );
            }


            setValue(
                "treatmentTypes",
                treatments
                    ? treatments.length
                    : 0
            );


            setValue(
                "treatmentTotal",
                total
            );

            setValue(
                "treatmentFooterTotal",
                total
            );


            if (!treatments ||
                treatments.length === 0) {

                body.innerHTML =
                    '<tr>' +
                    '<td colspan="2" class="px-6 py-8 text-center text-xs text-slate-400">' +
                    'No treatment data found for this period.' +
                    '</td>' +
                    '</tr>';

                return;
            }


            treatments.forEach(
                function(treatment) {

                    var row =
                        document.createElement("tr");

                    row.className =
                        "border-b border-slate-100";


                    row.innerHTML =
                        '<td class="px-6 py-4 text-slate-600">' +
                            escapeHtml(
                                treatment.treatmentName ||
                                "Not provided"
                            ) +
                        '</td>' +

                        '<td class="px-6 py-4 text-right">' +
                            '<span class="font-semibold text-emerald-700">' +
                                Number(
                                    treatment.completedCount || 0
                                ) +
                            '</span>' +
                        '</td>';


                    body.appendChild(row);
                }
            );
        }


        // =========================================================
        // REVENUE CHART
        // =========================================================

        function renderRevenueChart(data) {

            var canvas =
                document.getElementById(
                    "revenueChart"
                );

            if (!canvas ||
                typeof Chart === "undefined") {
                return;
            }


            if (revenueChart) {

                revenueChart.destroy();

                revenueChart = null;
            }


            var dates =
                data.revenueDates || [];


            var values =
                data.dailyRevenue || [];


            revenueChart =
                new Chart(
                    canvas,
                    {

                        type: "line",

                        data: {

                            labels: dates,

                            datasets: [

                                {

                                    label:
                                        "Daily Revenue",

                                    data:
                                        values,

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
                                    "index"
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

                                                return " Rs. " +
                                                    Number(
                                                        context.raw || 0
                                                    ).toLocaleString(
                                                        "en-LK",
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

                                            size:
                                                10
                                        }
                                    }
                                },

                                y: {

                                    beginAtZero:
                                        true,

                                    grid: {

                                        color:
                                            "#f1f5f9"
                                    },

                                    ticks: {

                                        font: {

                                            size:
                                                10
                                        },

                                        callback:
                                            function(value) {

                                                return "Rs. " +
                                                    Number(
                                                        value || 0
                                                    ).toLocaleString(
                                                        "en-LK"
                                                    );
                                            }
                                    }
                                }
                            }
                        }
                    }
                );
        }


        // =========================================================
        // LOAD REPORT FROM REST API
        // =========================================================

        async function loadReportFor(prefix) {

            try {

                toggleDates(prefix);

                var range =
                    getRange(prefix);


                updatePeriodDisplay(
                    prefix,
                    range
                );


                var url =
                    getContextPath() +
                    "/api/reports?startDate=" +
                    encodeURIComponent(
                        range.startDate
                    ) +
                    "&endDate=" +
                    encodeURIComponent(
                        range.endDate
                    );


                console.log(
                    "Loading report:",
                    url
                );


                var response =
                    await fetch(
                        url,
                        {

                            method:
                                "GET",

                            credentials:
                                "same-origin",

                            headers: {

                                "Accept":
                                    "application/json"
                            }
                        }
                    );


                var data;


                try {

                    data =
                        await response.json();

                }

                catch (jsonError) {

                    throw new Error(
                        "Invalid response received from the report API."
                    );
                }


                if (!response.ok) {

                    throw new Error(
                        data &&
                        data.message
                            ? data.message
                            : "Could not load report."
                    );
                }


                reportData =
                    data;


                // -----------------------------
                // Revenue
                // -----------------------------

                if (prefix === "revenue") {

                    setValue(
                        "revenueTotalBills",
                        data.totalBills
                    );


                    setValue(
                        "revenueTotalRevenue",
                        formatMoney(
                            data.totalRevenue
                        )
                    );


                    setValue(
                        "revenueAppointmentRevenue",
                        formatMoney(
                            data.appointmentRevenue
                        )
                    );


                    setValue(
                        "revenueWalkInRevenue",
                        formatMoney(
                            data.walkInRevenue
                        )
                    );


                    setValue(
                        "revenueFooterTotal",
                        formatMoney(
                            data.totalRevenue
                        )
                    );


                    renderBills(
                        data.bills || []
                    );


                    renderRevenueChart(
                        data
                    );
                }


                // -----------------------------
                // Appointments
                // -----------------------------

                if (prefix === "appointment") {

                    setValue(
                        "scheduledAppointments",
                        data.scheduledAppointments
                    );


                    setValue(
                        "completedAppointments",
                        data.completedAppointments
                    );


                    setValue(
                        "cancelledAppointments",
                        data.cancelledAppointments
                    );


                    setValue(
                        "noShowAppointments",
                        data.noShowAppointments
                    );


                    setValue(
                        "billedAppointments",
                        data.billedAppointments
                    );


                    setValue(
                        "totalAppointments",
                        data.totalAppointments
                    );


                    renderAppointments(
                        data.appointments || []
                    );
                }


                // -----------------------------
                // Treatments
                // -----------------------------

                if (prefix === "treatment") {

                    renderTreatments(
                        data.treatments || []
                    );
                }


            }

            catch (error) {

                console.error(
                    "Report API error:",
                    error
                );


                alert(
                    error.message ||
                    "Could not load the report."
                );
            }
        }


        // =========================================================
        // SAFE HTML
        // =========================================================

        function escapeHtml(value) {

            return String(
                value === null ||
                value === undefined
                    ? ""
                    : value
            )
            .replace(/&/g, "&amp;")
            .replace(/</g, "&lt;")
            .replace(/>/g, "&gt;")
            .replace(/"/g, "&quot;")
            .replace(/'/g, "&#039;");
        }


        function formatDateTime(value) {

            if (!value) {
                return "-";
            }

            return String(value)
                .replace("T", " ")
                .substring(0, 19);
        }


        // =========================================================
        // PRINT REPORT
        // =========================================================

        function printReport(name) {

            var sections =
                document.querySelectorAll(
                    ".report-section"
                );


            sections.forEach(
                function(section) {

                    section.classList.remove(
                        "printing"
                    );

                }
            );


            var section =
                document.getElementById(name);


            if (!section) {
                return;
            }


            section.classList.add(
                "printing"
            );


            window.print();


            setTimeout(
                function() {

                    section.classList.remove(
                        "printing"
                    );

                },
                500
            );
        }


        // =========================================================
        // INITIALISE
        // =========================================================

        document.addEventListener(
            "DOMContentLoaded",
            function() {

                var forms =
                    document.querySelectorAll(
                        "form"
                    );


                forms.forEach(
                    function(form) {

                        form.addEventListener(
                            "submit",
                            function(event) {

                                event.preventDefault();

                                var select =
                                    form.querySelector(
                                        "select"
                                    );

                                if (!select) {
                                    return;
                                }


                                var id =
                                    select.id;


                                if (id === "revenueFilter") {

                                    loadReportFor(
                                        "revenue"
                                    );
                                }

                                else if (
                                    id === "appointmentFilter"
                                ) {

                                    loadReportFor(
                                        "appointment"
                                    );
                                }

                                else if (
                                    id === "treatmentFilter"
                                ) {

                                    loadReportFor(
                                        "treatment"
                                    );
                                }
                            }
                        );
                    }
                );


                // Preserve original first tab.
                showReport(
                    "revenue"
                );

            }
        );

    </script>



</body>

</html>