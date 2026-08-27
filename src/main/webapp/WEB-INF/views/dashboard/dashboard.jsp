<%@ page language="java"
    contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
    /*
     * Expected dashboard attributes:
     *
     * totalPatients
     * totalDentists
     * totalTreatments
     * totalAppointments
     * scheduledAppointments
     * completedAppointments
     * cancelledAppointments
     * totalBills
     *
     * If your controller uses different attribute names,
     * change them here.
     */

    Object totalPatientsObj =
        request.getAttribute("totalPatients");

    Object totalDentistsObj =
        request.getAttribute("totalDentists");

    Object totalTreatmentsObj =
        request.getAttribute("totalTreatments");

    Object totalAppointmentsObj =
        request.getAttribute("totalAppointments");

    Object scheduledAppointmentsObj =
        request.getAttribute("scheduledAppointments");

    Object completedAppointmentsObj =
        request.getAttribute("completedAppointments");

    Object cancelledAppointmentsObj =
        request.getAttribute("cancelledAppointments");

    Object totalBillsObj =
        request.getAttribute("totalBills");


    int totalPatients =
        totalPatientsObj != null
            ? ((Number) totalPatientsObj).intValue()
            : 0;

    int totalDentists =
        totalDentistsObj != null
            ? ((Number) totalDentistsObj).intValue()
            : 0;

    int totalTreatments =
        totalTreatmentsObj != null
            ? ((Number) totalTreatmentsObj).intValue()
            : 0;

    int totalAppointments =
        totalAppointmentsObj != null
            ? ((Number) totalAppointmentsObj).intValue()
            : 0;

    int scheduledAppointments =
        scheduledAppointmentsObj != null
            ? ((Number) scheduledAppointmentsObj).intValue()
            : 0;

    int completedAppointments =
        completedAppointmentsObj != null
            ? ((Number) completedAppointmentsObj).intValue()
            : 0;

    int cancelledAppointments =
        cancelledAppointmentsObj != null
            ? ((Number) cancelledAppointmentsObj).intValue()
            : 0;

    int totalBills =
        totalBillsObj != null
            ? ((Number) totalBillsObj).intValue()
            : 0;
%>


<!DOCTYPE html>

<html lang="en">

<head>

    <meta charset="UTF-8">

    <meta name="viewport"
          content="width=device-width, initial-scale=1.0">

    <title>
        Dashboard | Sunrise Dental Clinic
    </title>


    <!-- TAILWIND -->

    <script src="https://cdn.tailwindcss.com"></script>


    <!-- TAILWIND CONFIG -->

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


    <!-- GOOGLE FONTS -->

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


    <!-- MAIN CONTENT -->

    <main class="ml-[250px] min-h-screen flex-1 px-8 py-7">


        <!-- HEADER -->

        <div class="mb-8 flex items-start justify-between">


            <div>

                <p class="mb-1 font-inter text-[10px] font-semibold uppercase tracking-[0.12em] text-slate-400">
                    Overview
                </p>

                <h1 class="text-[26px] font-extrabold tracking-[-0.7px]">
                    Dashboard
                </h1>

                <p class="mt-1 font-inter text-xs text-slate-500">
                    Welcome back. Here's what's happening at the clinic.
                </p>

            </div>


            <!-- QUICK ACTION -->

            <a
                href="<%= request.getContextPath() %>/appointments/add"
                class="flex items-center gap-2 rounded-lg bg-[#2563EB] px-4 py-2.5 text-xs font-bold text-white shadow-sm transition hover:bg-[#1D4ED8]"
            >

                <span class="text-base leading-none">
                    +
                </span>

                Book Appointment

            </a>


        </div>



        <!-- STAT CARDS -->

        <div class="mb-6 grid grid-cols-4 gap-4">


            <!-- PATIENTS -->

            <div class="rounded-xl border border-slate-200 bg-white p-5">


                <div class="mb-5 flex items-center justify-between">


                    <div class="flex h-9 w-9 items-center justify-center rounded-lg bg-blue-50">

                        <svg
                            class="h-[18px] w-[18px] text-blue-600"
                            fill="none"
                            stroke="currentColor"
                            stroke-width="1.8"
                            viewBox="0 0 24 24"
                        >

                            <path
                                stroke-linecap="round"
                                stroke-linejoin="round"
                                d="M16 21v-2a4 4 0 00-4-4H6a4 4 0 00-4 4v2M9 11a4 4 0 100-8 4 4 0 000 8zM22 21v-2a4 4 0 00-3-3.87M16 3.13a4 4 0 010 7.75"
                            />

                        </svg>

                    </div>


                    <span class="font-inter text-[9px] font-semibold text-slate-400">
                        Total
                    </span>


                </div>


                <p class="font-inter text-[10px] font-medium text-slate-500">
                    Total Patients
                </p>


                <p class="mt-1 text-[25px] font-extrabold tracking-[-0.5px]">
                    <%= totalPatients %>
                </p>


                <a
                    href="<%= request.getContextPath() %>/patients"
                    class="mt-3 inline-block font-inter text-[9px] font-semibold text-blue-600 hover:underline"
                >
                    View patients →
                </a>


            </div>



            <!-- DENTISTS -->

            <div class="rounded-xl border border-slate-200 bg-white p-5">


                <div class="mb-5 flex items-center justify-between">


                    <div class="flex h-9 w-9 items-center justify-center rounded-lg bg-violet-50">

                        <svg
                            class="h-[18px] w-[18px] text-violet-600"
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


                    <span class="font-inter text-[9px] font-semibold text-slate-400">
                        Active
                    </span>


                </div>


                <p class="font-inter text-[10px] font-medium text-slate-500">
                    Dentists
                </p>


                <p class="mt-1 text-[25px] font-extrabold tracking-[-0.5px]">
                    <%= totalDentists %>
                </p>


                <a
                    href="<%= request.getContextPath() %>/dentists"
                    class="mt-3 inline-block font-inter text-[9px] font-semibold text-violet-600 hover:underline"
                >
                    View dentists →
                </a>


            </div>



            <!-- TREATMENTS -->

            <div class="rounded-xl border border-slate-200 bg-white p-5">


                <div class="mb-5 flex items-center justify-between">


                    <div class="flex h-9 w-9 items-center justify-center rounded-lg bg-emerald-50">

                        <svg
                            class="h-[18px] w-[18px] text-emerald-600"
                            fill="none"
                            stroke="currentColor"
                            stroke-width="1.8"
                            viewBox="0 0 24 24"
                        >

                            <rect
                                x="4"
                                y="4"
                                width="16"
                                height="16"
                                rx="3"
                            />

                            <path
                                stroke-linecap="round"
                                d="M8 9h8M8 13h8M8 17h5"
                            />

                        </svg>

                    </div>


                    <span class="font-inter text-[9px] font-semibold text-slate-400">
                        Available
                    </span>


                </div>


                <p class="font-inter text-[10px] font-medium text-slate-500">
                    Treatments
                </p>


                <p class="mt-1 text-[25px] font-extrabold tracking-[-0.5px]">
                    <%= totalTreatments %>
                </p>


                <a
                    href="<%= request.getContextPath() %>/treatments"
                    class="mt-3 inline-block font-inter text-[9px] font-semibold text-emerald-600 hover:underline"
                >
                    View treatments →
                </a>


            </div>



            <!-- BILLS -->

            <div class="rounded-xl border border-slate-200 bg-white p-5">


                <div class="mb-5 flex items-center justify-between">


                    <div class="flex h-9 w-9 items-center justify-center rounded-lg bg-amber-50">

                        <svg
                            class="h-[18px] w-[18px] text-amber-600"
                            fill="none"
                            stroke="currentColor"
                            stroke-width="1.8"
                            viewBox="0 0 24 24"
                        >

                            <path
                                stroke-linecap="round"
                                stroke-linejoin="round"
                                d="M6 2h12v20l-3-2-3 2-3-2-3 2V2z"
                            />

                            <path
                                stroke-linecap="round"
                                d="M9 7h6M9 11h6M9 15h3"
                            />

                        </svg>

                    </div>


                    <span class="font-inter text-[9px] font-semibold text-slate-400">
                        Generated
                    </span>


                </div>


                <p class="font-inter text-[10px] font-medium text-slate-500">
                    Total Bills
                </p>


                <p class="mt-1 text-[25px] font-extrabold tracking-[-0.5px]">
                    <%= totalBills %>
                </p>


                <a
                    href="<%= request.getContextPath() %>/bills"
                    class="mt-3 inline-block font-inter text-[9px] font-semibold text-amber-600 hover:underline"
                >
                    View billing →
                </a>


            </div>


        </div>



        <!-- SECOND ROW -->

        <div class="grid grid-cols-3 gap-5">


            <!-- APPOINTMENT OVERVIEW -->

            <div class="col-span-2 rounded-xl border border-slate-200 bg-white">


                <div class="flex items-center justify-between border-b border-slate-100 px-5 py-4">


                    <div>

                        <h2 class="text-sm font-extrabold">
                            Appointment Overview
                        </h2>

                        <p class="mt-0.5 font-inter text-[9px] text-slate-400">
                            Current appointment status
                        </p>

                    </div>


                    <a
                        href="<%= request.getContextPath() %>/appointments"
                        class="font-inter text-[9px] font-semibold text-blue-600 hover:underline"
                    >
                        View all →
                    </a>


                </div>



                <div class="grid grid-cols-3 gap-4 p-5">


                    <!-- SCHEDULED -->

                    <div class="rounded-lg bg-blue-50/70 p-4">

                        <div class="mb-3 flex h-8 w-8 items-center justify-center rounded-lg bg-blue-100 text-blue-600">

                            <svg
                                class="h-4 w-4"
                                fill="none"
                                stroke="currentColor"
                                stroke-width="1.8"
                                viewBox="0 0 24 24"
                            >

                                <rect
                                    x="3"
                                    y="4"
                                    width="18"
                                    height="17"
                                    rx="2"
                                />

                                <path
                                    stroke-linecap="round"
                                    d="M16 2v4M8 2v4M3 10h18"
                                />

                            </svg>

                        </div>


                        <p class="font-inter text-[9px] font-semibold text-blue-600">
                            Scheduled
                        </p>


                        <p class="mt-1 text-xl font-extrabold text-blue-700">
                            <%= scheduledAppointments %>
                        </p>

                    </div>



                    <!-- COMPLETED -->

                    <div class="rounded-lg bg-emerald-50/70 p-4">

                        <div class="mb-3 flex h-8 w-8 items-center justify-center rounded-lg bg-emerald-100 text-emerald-600">

                            ✓

                        </div>


                        <p class="font-inter text-[9px] font-semibold text-emerald-600">
                            Completed
                        </p>


                        <p class="mt-1 text-xl font-extrabold text-emerald-700">
                            <%= completedAppointments %>
                        </p>

                    </div>



                    <!-- CANCELLED -->

                    <div class="rounded-lg bg-red-50/70 p-4">

                        <div class="mb-3 flex h-8 w-8 items-center justify-center rounded-lg bg-red-100 text-red-600">

                            ×

                        </div>


                        <p class="font-inter text-[9px] font-semibold text-red-600">
                            Cancelled
                        </p>


                        <p class="mt-1 text-xl font-extrabold text-red-700">
                            <%= cancelledAppointments %>
                        </p>

                    </div>


                </div>


                <!-- TOTAL -->

                <div class="border-t border-slate-100 px-5 py-4">

                    <div class="flex items-center justify-between">


                        <div>

                            <p class="font-inter text-[9px] font-semibold text-slate-400">
                                Total Appointments
                            </p>

                            <p class="mt-1 text-sm font-extrabold">
                                <%= totalAppointments %>
                            </p>

                        </div>


                        <a
                            href="<%= request.getContextPath() %>/appointments/add"
                            class="rounded-lg border border-slate-200 px-3 py-2 font-inter text-[9px] font-semibold text-slate-600 hover:bg-slate-50"
                        >
                            + New Appointment
                        </a>


                    </div>

                </div>


            </div>



            <!-- QUICK ACTIONS -->

            <div class="rounded-xl border border-slate-200 bg-white">


                <div class="border-b border-slate-100 px-5 py-4">

                    <h2 class="text-sm font-extrabold">
                        Quick Actions
                    </h2>

                    <p class="mt-0.5 font-inter text-[9px] text-slate-400">
                        Common clinic tasks
                    </p>

                </div>


                <div class="space-y-1 p-3">


                    <a
                        href="<%= request.getContextPath() %>/appointments/add"
                        class="flex items-center gap-3 rounded-lg p-3 transition hover:bg-blue-50"
                    >

                        <span class="flex h-8 w-8 items-center justify-center rounded-lg bg-blue-50 text-sm font-bold text-blue-600">
                            +
                        </span>

                        <span>

                            <span class="block text-[11px] font-bold">
                                Book Appointment
                            </span>

                            <span class="font-inter text-[9px] text-slate-400">
                                Schedule a patient
                            </span>

                        </span>

                    </a>



                    <a
                        href="<%= request.getContextPath() %>/patients/add"
                        class="flex items-center gap-3 rounded-lg p-3 transition hover:bg-emerald-50"
                    >

                        <span class="flex h-8 w-8 items-center justify-center rounded-lg bg-emerald-50 text-sm font-bold text-emerald-600">
                            +
                        </span>

                        <span>

                            <span class="block text-[11px] font-bold">
                                Add Patient
                            </span>

                            <span class="font-inter text-[9px] text-slate-400">
                                Register a new patient
                            </span>

                        </span>

                    </a>



                    <a
                        href="<%= request.getContextPath() %>/bills"
                        class="flex items-center gap-3 rounded-lg p-3 transition hover:bg-amber-50"
                    >

                        <span class="flex h-8 w-8 items-center justify-center rounded-lg bg-amber-50 text-sm font-bold text-amber-600">
                            $
                        </span>

                        <span>

                            <span class="block text-[11px] font-bold">
                                Billing
                            </span>

                            <span class="font-inter text-[9px] text-slate-400">
                                Manage clinic bills
                            </span>

                        </span>

                    </a>



                    <a
                        href="<%= request.getContextPath() %>/treatments"
                        class="flex items-center gap-3 rounded-lg p-3 transition hover:bg-violet-50"
                    >

                        <span class="flex h-8 w-8 items-center justify-center rounded-lg bg-violet-50 text-sm font-bold text-violet-600">
                            T
                        </span>

                        <span>

                            <span class="block text-[11px] font-bold">
                                Treatments
                            </span>

                            <span class="font-inter text-[9px] text-slate-400">
                                Manage treatments
                            </span>

                        </span>

                    </a>


                </div>


            </div>


        </div>



        <!-- FOOTER -->

        <div class="mt-6 flex items-center justify-between px-1">

            <p class="font-inter text-[9px] text-slate-400">
                Sunrise Dental Clinic
            </p>

            <p class="font-inter text-[9px] text-slate-400">
                Clinic Management System
            </p>

        </div>


    </main>


</div>


</body>

</html>