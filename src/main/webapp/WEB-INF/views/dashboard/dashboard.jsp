<%@ page language="java"
    contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>

<!DOCTYPE html>

<html lang="en">

<head>

    <meta charset="UTF-8">

    <meta
        name="viewport"
        content="width=device-width, initial-scale=1.0">

    <title>
        Dashboard | Sunrise Dental Clinic
    </title>


    <!-- =====================================================
         TAILWIND
    ====================================================== -->

    <script src="https://cdn.tailwindcss.com"></script>


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

        };

    </script>


    <!-- =====================================================
         GOOGLE FONTS
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

    </style>

</head>


<body
    class="min-h-screen bg-[#F5F7FB] font-manrope text-[#172033]">


<div class="flex min-h-screen">


    <!-- =====================================================
         SIDEBAR
    ====================================================== -->

    <jsp:include page="../common/sidebar.jsp" />



    <!-- =====================================================
         MAIN CONTENT
    ====================================================== -->

    <main
        class="ml-[250px] min-h-screen flex-1 px-8 py-7">


        <div class="mx-auto max-w-[1400px]">


            <!-- =================================================
                 HEADER
            ================================================== -->

            <div
                class="mb-7 flex items-end justify-between">


                <div>

                    <p
                        class="mb-1 font-inter text-[10px] font-semibold uppercase tracking-[0.12em] text-blue-600">

                        Overview

                    </p>


                    <h1
                        class="font-manrope text-2xl font-extrabold tracking-tight text-[#172033]">

                        Dashboard

                    </h1>


                    <p
                        class="mt-1.5 font-inter text-xs text-slate-500">

                        Welcome back. Here's what's happening at the clinic.

                    </p>

                </div>


                <a
                    href="<%= request.getContextPath() %>/appointments/add"
                    class="flex items-center gap-2 rounded-lg bg-[#2563EB] px-4 py-2.5 font-inter text-xs font-semibold text-white shadow-sm transition hover:bg-[#1D4ED8]"
                >

                    <span class="text-base leading-none">
                        +
                    </span>

                    Book Appointment

                </a>


            </div>



            <!-- =================================================
                 STAT CARDS
            ================================================== -->

            <div
                class="mb-6 grid grid-cols-4 gap-4">


                <!-- =================================================
                     PATIENTS
                ================================================== -->

                <div
                    class="rounded-xl border border-slate-200 bg-white p-5">


                    <div
                        class="mb-5 flex items-center justify-between">


                        <div
                            class="flex h-9 w-9 items-center justify-center rounded-lg bg-blue-50">

                            <svg
                                class="h-[18px] w-[18px] text-blue-600"
                                fill="none"
                                stroke="currentColor"
                                stroke-width="1.8"
                                viewBox="0 0 24 24">

                                <path
                                    stroke-linecap="round"
                                    stroke-linejoin="round"
                                    d="M16 21v-2a4 4 0 00-4-4H6a4 4 0 00-4 4v2M9 11a4 4 0 100-8 4 4 0 000 8zM22 21v-2a4 4 0 00-3-3.87M16 3.13a4 4 0 010 7.75"/>

                            </svg>

                        </div>


                        <span
                            class="font-inter text-[9px] font-semibold text-slate-400">

                            Total

                        </span>

                    </div>


                    <p
                        class="font-inter text-[10px] font-medium text-slate-500">

                        Total Patients

                    </p>


                    <!-- NUMBER + VIEW -->

                    <div
                        class="mt-1 flex items-end justify-between gap-3">


                        <p
                            id="totalPatients"
                            class="font-manrope text-[25px] font-extrabold tracking-[-0.5px] text-[#172033]">

                            —

                        </p>


                        <a
                            href="<%= request.getContextPath() %>/patients"
                            class="mb-0.5 inline-flex items-center rounded-lg border border-slate-200 bg-white px-3 py-1.5 font-inter text-[10px] font-semibold text-slate-600 transition hover:border-blue-200 hover:bg-blue-50 hover:text-blue-600">

                            View

                        </a>


                    </div>

                </div>



                <!-- =================================================
                     DENTISTS
                ================================================== -->

                <div
                    class="rounded-xl border border-slate-200 bg-white p-5">


                    <div
                        class="mb-5 flex items-center justify-between">


                        <div
                            class="flex h-9 w-9 items-center justify-center rounded-lg bg-blue-50">

                            <svg
                                class="h-[18px] w-[18px] text-blue-600"
                                fill="none"
                                stroke="currentColor"
                                stroke-width="1.8"
                                viewBox="0 0 24 24">

                                <path
                                    stroke-linecap="round"
                                    d="M12 3v18M3 12h18"/>

                            </svg>

                        </div>


                        <span
                            class="font-inter text-[9px] font-semibold text-slate-400">

                            Active

                        </span>

                    </div>


                    <p
                        class="font-inter text-[10px] font-medium text-slate-500">

                        Dentists

                    </p>


                    <!-- NUMBER + VIEW -->

                    <div
                        class="mt-1 flex items-end justify-between gap-3">


                        <p
                            id="totalDentists"
                            class="font-manrope text-[25px] font-extrabold tracking-[-0.5px] text-[#172033]">

                            —

                        </p>


                        <a
                            href="<%= request.getContextPath() %>/dentists"
                            class="mb-0.5 inline-flex items-center rounded-lg border border-slate-200 bg-white px-3 py-1.5 font-inter text-[10px] font-semibold text-slate-600 transition hover:border-blue-200 hover:bg-blue-50 hover:text-blue-600">

                            View

                        </a>


                    </div>

                </div>



                <!-- =================================================
                     TREATMENTS
                ================================================== -->

                <div
                    class="rounded-xl border border-slate-200 bg-white p-5">


                    <div
                        class="mb-5 flex items-center justify-between">


                        <div
                            class="flex h-9 w-9 items-center justify-center rounded-lg bg-blue-50">

                            <svg
                                class="h-[18px] w-[18px] text-blue-600"
                                fill="none"
                                stroke="currentColor"
                                stroke-width="1.8"
                                viewBox="0 0 24 24">

                                <rect
                                    x="4"
                                    y="4"
                                    width="16"
                                    height="16"
                                    rx="3"/>

                                <path
                                    stroke-linecap="round"
                                    d="M8 9h8M8 13h8M8 17h5"/>

                            </svg>

                        </div>


                        <span
                            class="font-inter text-[9px] font-semibold text-slate-400">

                            Available

                        </span>

                    </div>


                    <p
                        class="font-inter text-[10px] font-medium text-slate-500">

                        Treatments

                    </p>


                    <!-- NUMBER + VIEW -->

                    <div
                        class="mt-1 flex items-end justify-between gap-3">


                        <p
                            id="totalTreatments"
                            class="font-manrope text-[25px] font-extrabold tracking-[-0.5px] text-[#172033]">

                            —

                        </p>


                        <a
                            href="<%= request.getContextPath() %>/treatments"
                            class="mb-0.5 inline-flex items-center rounded-lg border border-slate-200 bg-white px-3 py-1.5 font-inter text-[10px] font-semibold text-slate-600 transition hover:border-blue-200 hover:bg-blue-50 hover:text-blue-600">

                            View

                        </a>


                    </div>

                </div>



                <!-- =================================================
                     BILLS
                ================================================== -->

                <div
                    class="rounded-xl border border-slate-200 bg-white p-5">


                    <div
                        class="mb-5 flex items-center justify-between">


                        <div
                            class="flex h-9 w-9 items-center justify-center rounded-lg bg-blue-50">

                            <svg
                                class="h-[18px] w-[18px] text-blue-600"
                                fill="none"
                                stroke="currentColor"
                                stroke-width="1.8"
                                viewBox="0 0 24 24">

                                <path
                                    stroke-linecap="round"
                                    stroke-linejoin="round"
                                    d="M6 2h12v20l-3-2-3 2-3-2-3 2V2z"/>

                                <path
                                    stroke-linecap="round"
                                    d="M9 7h6M9 11h6M9 15h3"/>

                            </svg>

                        </div>


                        <span
                            class="font-inter text-[9px] font-semibold text-slate-400">

                            Generated

                        </span>

                    </div>


                    <p
                        class="font-inter text-[10px] font-medium text-slate-500">

                        Total Bills

                    </p>


                    <!-- NUMBER + VIEW -->

                    <div
                        class="mt-1 flex items-end justify-between gap-3">


                        <p
                            id="totalBills"
                            class="font-manrope text-[25px] font-extrabold tracking-[-0.5px] text-[#172033]">

                            —

                        </p>


                        <a
                            href="<%= request.getContextPath() %>/bills"
                            class="mb-0.5 inline-flex items-center rounded-lg border border-slate-200 bg-white px-3 py-1.5 font-inter text-[10px] font-semibold text-slate-600 transition hover:border-blue-200 hover:bg-blue-50 hover:text-blue-600">

                            View

                        </a>


                    </div>

                </div>


            </div>



            <!-- =================================================
                 LOWER CONTENT
            ================================================== -->

            <div
                class="grid grid-cols-3 gap-5">


                <!-- =================================================
                     APPOINTMENT OVERVIEW
                ================================================== -->

                <div
                    class="col-span-2 rounded-xl border border-slate-200 bg-white">


                    <!-- HEADER -->

                    <div
                        class="flex items-center justify-between border-b border-slate-100 px-5 py-4">


                        <div>

                            <h2
                                class="font-manrope text-sm font-extrabold text-[#172033]">

                                Appointment Overview

                            </h2>


                            <p
                                class="mt-0.5 font-inter text-[9px] text-slate-400">

                                Current appointment status

                            </p>

                        </div>


                        <a
                            href="<%= request.getContextPath() %>/appointments"
                            class="font-inter text-[9px] font-semibold text-blue-600 hover:underline">

                            View all →

                        </a>

                    </div>



                    <!-- APPOINTMENT STATUS -->

                    <div
                        class="grid grid-cols-3 gap-4 p-5">


                        <!-- SCHEDULED -->

                        <div
                            class="rounded-lg border border-slate-200 bg-slate-50 p-4">


                            <div
                                class="mb-3 flex h-8 w-8 items-center justify-center rounded-lg bg-blue-50 text-blue-600">

                                <svg
                                    class="h-4 w-4"
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

                            </div>


                            <p
                                class="font-inter text-[9px] font-semibold text-slate-500">

                                Scheduled

                            </p>


                            <p
                                id="scheduledAppointments"
                                class="mt-1 font-manrope text-xl font-extrabold text-[#172033]">

                                —

                            </p>

                        </div>



                        <!-- COMPLETED -->

                        <div
                            class="rounded-lg border border-slate-200 bg-slate-50 p-4">


                            <div
                                class="mb-3 flex h-8 w-8 items-center justify-center rounded-lg bg-blue-50 text-blue-600">

                                <svg
                                    class="h-4 w-4"
                                    fill="none"
                                    stroke="currentColor"
                                    stroke-width="1.8"
                                    viewBox="0 0 24 24">

                                    <path
                                        stroke-linecap="round"
                                        stroke-linejoin="round"
                                        d="M5 13l4 4L19 7"/>

                                </svg>

                            </div>


                            <p
                                class="font-inter text-[9px] font-semibold text-slate-500">

                                Completed

                            </p>


                            <p
                                id="completedAppointments"
                                class="mt-1 font-manrope text-xl font-extrabold text-[#172033]">

                                —

                            </p>

                        </div>



                        <!-- CANCELLED -->

                        <div
                            class="rounded-lg border border-slate-200 bg-slate-50 p-4">


                            <div
                                class="mb-3 flex h-8 w-8 items-center justify-center rounded-lg bg-blue-50 text-blue-600">

                                <svg
                                    class="h-4 w-4"
                                    fill="none"
                                    stroke="currentColor"
                                    stroke-width="1.8"
                                    viewBox="0 0 24 24">

                                    <path
                                        stroke-linecap="round"
                                        d="M6 6l12 12M18 6L6 18"/>

                                </svg>

                            </div>


                            <p
                                class="font-inter text-[9px] font-semibold text-slate-500">

                                Cancelled

                            </p>


                            <p
                                id="cancelledAppointments"
                                class="mt-1 font-manrope text-xl font-extrabold text-[#172033]">

                                —

                            </p>

                        </div>


                    </div>



                    <!-- TOTAL -->

                    <div
                        class="border-t border-slate-100 px-5 py-4">


                        <div
                            class="flex items-center justify-between">


                            <div>

                                <p
                                    class="font-inter text-[9px] font-semibold text-slate-400">

                                    Total Appointments

                                </p>


                                <p
                                    id="totalAppointments"
                                    class="mt-1 font-manrope text-sm font-extrabold text-[#172033]">

                                    —

                                </p>

                            </div>


                            <a
                                href="<%= request.getContextPath() %>/appointments/add"
                                class="rounded-lg border border-slate-200 bg-white px-3 py-2 font-inter text-[9px] font-semibold text-slate-600 transition hover:border-blue-200 hover:bg-blue-50 hover:text-blue-600">

                                + New Appointment

                            </a>

                        </div>

                    </div>


                </div>



                <!-- =================================================
                     QUICK ACTIONS
                ================================================== -->

                <div
                    class="rounded-xl border border-slate-200 bg-white">


                    <div
                        class="border-b border-slate-100 px-5 py-4">


                        <h2
                            class="font-manrope text-sm font-extrabold text-[#172033]">

                            Quick Actions

                        </h2>


                        <p
                            class="mt-0.5 font-inter text-[9px] text-slate-400">

                            Common clinic tasks

                        </p>

                    </div>



                    <div
                        class="space-y-1 p-3">


                        <!-- BOOK APPOINTMENT -->

                        <a
                            href="<%= request.getContextPath() %>/appointments/add"
                            class="flex items-center gap-3 rounded-lg p-3 transition hover:bg-blue-50">


                            <span
                                class="flex h-8 w-8 items-center justify-center rounded-lg bg-blue-50 text-sm font-bold text-blue-600">

                                +

                            </span>


                            <span>

                                <span
                                    class="block text-[11px] font-bold text-[#172033]">

                                    Book Appointment

                                </span>


                                <span
                                    class="font-inter text-[9px] text-slate-400">

                                    Schedule a patient

                                </span>

                            </span>


                        </a>



                        <!-- ADD PATIENT -->

                        <a
                            href="<%= request.getContextPath() %>/patients/add"
                            class="flex items-center gap-3 rounded-lg p-3 transition hover:bg-blue-50">


                            <span
                                class="flex h-8 w-8 items-center justify-center rounded-lg bg-blue-50 text-sm font-bold text-blue-600">

                                +

                            </span>


                            <span>

                                <span
                                    class="block text-[11px] font-bold text-[#172033]">

                                    Add Patient

                                </span>


                                <span
                                    class="font-inter text-[9px] text-slate-400">

                                    Register a new patient

                                </span>

                            </span>


                        </a>



                        <!-- BILLING -->

                        <a
                            href="<%= request.getContextPath() %>/bills"
                            class="flex items-center gap-3 rounded-lg p-3 transition hover:bg-blue-50">


                            <span
                                class="flex h-8 w-8 items-center justify-center rounded-lg bg-blue-50 text-sm font-bold text-blue-600">

                                $

                            </span>


                            <span>

                                <span
                                    class="block text-[11px] font-bold text-[#172033]">

                                    Billing

                                </span>


                                <span
                                    class="font-inter text-[9px] text-slate-400">

                                    Manage clinic bills

                                </span>

                            </span>


                        </a>



                        <!-- TREATMENTS -->

                        <a
                            href="<%= request.getContextPath() %>/treatments"
                            class="flex items-center gap-3 rounded-lg p-3 transition hover:bg-blue-50">


                            <span
                                class="flex h-8 w-8 items-center justify-center rounded-lg bg-blue-50 text-sm font-bold text-blue-600">

                                T

                            </span>


                            <span>

                                <span
                                    class="block text-[11px] font-bold text-[#172033]">

                                    Treatments

                                </span>


                                <span
                                    class="font-inter text-[9px] text-slate-400">

                                    Manage treatments

                                </span>

                            </span>


                        </a>


                    </div>


                </div>


            </div>



            <!-- =================================================
                 FOOTER
            ================================================== -->

            <div
                class="mt-6 flex items-center justify-between px-1">


                <p
                    class="font-inter text-[9px] text-slate-400">

                    Sunrise Dental Clinic

                </p>


                <p
                    class="font-inter text-[9px] text-slate-400">

                    Clinic Management System

                </p>


            </div>


        </div>

    </main>


</div>



<!-- =========================================================
     REST API DASHBOARD
========================================================= -->

<script>

    const contextPath =
        "<%= request.getContextPath() %>";


    // =========================================================
    // ELEMENTS
    // =========================================================

    const totalPatientsElement =
        document.getElementById("totalPatients");

    const totalDentistsElement =
        document.getElementById("totalDentists");

    const totalTreatmentsElement =
        document.getElementById("totalTreatments");

    const totalBillsElement =
        document.getElementById("totalBills");

    const totalAppointmentsElement =
        document.getElementById("totalAppointments");

    const scheduledAppointmentsElement =
        document.getElementById("scheduledAppointments");

    const completedAppointmentsElement =
        document.getElementById("completedAppointments");

    const cancelledAppointmentsElement =
        document.getElementById("cancelledAppointments");


    // =========================================================
    // GET API DATA
    // =========================================================

    async function getApiData(url) {

        const response =
            await fetch(
                url,
                {
                    method: "GET",
                    credentials: "same-origin",
                    headers: {
                        "Accept": "application/json"
                    }
                }
            );


        if (!response.ok) {

            throw new Error(
                "API request failed: " +
                response.status
            );
        }


        return await response.json();
    }


    // =========================================================
    // LOAD DASHBOARD
    // =========================================================

    async function loadDashboard() {

        try {

            const results =
                await Promise.all([

                    getApiData(
                        contextPath +
                        "/api/patients"
                    ),

                    getApiData(
                        contextPath +
                        "/api/dentists"
                    ),

                    getApiData(
                        contextPath +
                        "/api/treatments"
                    ),

                    getApiData(
                        contextPath +
                        "/api/billing"
                    ),

                    getApiData(
                        contextPath +
                        "/api/appointments"
                    )

                ]);


            const patients =
                Array.isArray(results[0])
                    ? results[0]
                    : [];


            const dentists =
                Array.isArray(results[1])
                    ? results[1]
                    : [];


            const treatments =
                Array.isArray(results[2])
                    ? results[2]
                    : [];


            const bills =
                Array.isArray(results[3])
                    ? results[3]
                    : [];


            const appointments =
                Array.isArray(results[4])
                    ? results[4]
                    : [];


            // =================================================
            // BASIC COUNTS
            // =================================================

            totalPatientsElement.textContent =
                patients.length;


            totalDentistsElement.textContent =
                dentists.length;


            totalTreatmentsElement.textContent =
                treatments.length;


            totalBillsElement.textContent =
                bills.length;


            // =================================================
            // APPOINTMENT COUNTS
            // =================================================

            totalAppointmentsElement.textContent =
                appointments.length;


            scheduledAppointmentsElement.textContent =
                appointments.filter(
                    appointment =>
                        String(
                            appointment.status || ""
                        ).toUpperCase() === "SCHEDULED"
                ).length;


            completedAppointmentsElement.textContent =
                appointments.filter(
                    appointment =>
                        String(
                            appointment.status || ""
                        ).toUpperCase() === "COMPLETED"
                ).length;


            cancelledAppointmentsElement.textContent =
                appointments.filter(
                    appointment =>
                        String(
                            appointment.status || ""
                        ).toUpperCase() === "CANCELLED"
                ).length;


        } catch (error) {

            console.error(
                "Dashboard API error:",
                error
            );


            totalPatientsElement.textContent =
                "—";

            totalDentistsElement.textContent =
                "—";

            totalTreatmentsElement.textContent =
                "—";

            totalBillsElement.textContent =
                "—";

            totalAppointmentsElement.textContent =
                "—";

            scheduledAppointmentsElement.textContent =
                "—";

            completedAppointmentsElement.textContent =
                "—";

            cancelledAppointmentsElement.textContent =
                "—";
        }
    }


    // =========================================================
    // START
    // =========================================================

    document.addEventListener(
        "DOMContentLoaded",
        loadDashboard
    );

</script>


</body>

</html>