<%@ page contentType="text/html;charset=UTF-8" %>

<%
    String contextPath =
            request.getContextPath();
%>

<!DOCTYPE html>

<html lang="en">

<head>

    <meta charset="UTF-8">

    <meta name="viewport"
          content="width=device-width, initial-scale=1.0">

    <title>Admin Dashboard - Sunrise Dental</title>


    <!-- Tailwind -->

    <script src="https://cdn.tailwindcss.com"></script>


    <!-- Fonts -->

    <link rel="preconnect"
          href="https://fonts.googleapis.com">

    <link rel="preconnect"
          href="https://fonts.gstatic.com"
          crossorigin>

    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&family=Manrope:wght@400;500;600;700;800&display=swap"
          rel="stylesheet">


    <style>

        .font-manrope {
            font-family: 'Manrope', sans-serif;
        }

        .font-inter {
            font-family: 'Inter', sans-serif;
        }

    </style>

</head>


<body class="min-h-screen bg-[#F5F7FB] font-manrope text-[#172033]">


<div class="flex min-h-screen">


    <!-- =====================================================
         COMMON SIDEBAR
         ===================================================== -->

    <jsp:include page="../common/sidebar.jsp" />


    <!-- =====================================================
         MAIN CONTENT
         ===================================================== -->

    <main class="ml-[250px] min-h-screen flex-1 px-8 py-7">


        <!-- =================================================
             HEADER
             ================================================= -->

        <div class="mb-7 flex items-end justify-between">


            <div>

                <p class="mb-1 font-inter text-[10px] font-semibold uppercase tracking-[0.12em] text-blue-600">

                    Administration

                </p>


                <h1 class="font-manrope text-2xl font-extrabold tracking-tight text-[#172033]">

                    Admin Dashboard

                </h1>


                <p class="mt-1.5 font-inter text-xs text-slate-500">

                    Welcome back,

                    <span class="font-semibold text-slate-700">

                        <span id="adminWelcomeName">Administrator</span>

                    </span>

                </p>

            </div>


            <!-- Date -->

            <div class="hidden items-center gap-2 rounded-lg border border-slate-200 bg-white px-4 py-2.5 md:flex">

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

                <span class="font-inter text-[11px] font-medium text-slate-500">

                    Clinic Overview

                </span>

            </div>


        </div>



        <!-- =================================================
             STATISTICS
             ================================================= -->

        <div class="mb-6 grid grid-cols-1 gap-4 sm:grid-cols-2 xl:grid-cols-4">


            <!-- ACTIVE USERS -->

            <div class="rounded-xl border border-slate-200 bg-white p-5">

                <div class="flex items-start justify-between">


                    <div>

                        <p class="font-inter text-[10px] font-semibold uppercase tracking-wide text-slate-400">

                            Active Users

                        </p>


                        <p class="mt-2 font-manrope text-2xl font-extrabold text-[#172033]">

                            <span id="activeUserCount">0</span>

                        </p>


                        <p class="mt-1 font-inter text-[10px] text-slate-400">

                            Currently active accounts

                        </p>

                    </div>


                    <div class="flex h-9 w-9 items-center justify-center rounded-lg bg-blue-50 text-blue-600">

                        <svg
                            class="h-4 w-4"
                            fill="none"
                            stroke="currentColor"
                            stroke-width="1.8"
                            viewBox="0 0 24 24">

                            <path
                                stroke-linecap="round"
                                stroke-linejoin="round"
                                d="M16 21v-2a4 4 0 00-4-4H6a4 4 0 00-4 4v2"/>

                            <circle
                                cx="9"
                                cy="7"
                                r="4"/>

                            <path
                                stroke-linecap="round"
                                stroke-linejoin="round"
                                d="M19 8v6M22 11h-6"/>

                        </svg>

                    </div>

                </div>

            </div>



            <!-- TODAY'S APPOINTMENTS -->

            <div class="rounded-xl border border-slate-200 bg-white p-5">

                <div class="flex items-start justify-between">


                    <div>

                        <p class="font-inter text-[10px] font-semibold uppercase tracking-wide text-slate-400">

                            Today's Appointments

                        </p>


                        <p class="mt-2 font-manrope text-2xl font-extrabold text-[#172033]">

                            <span id="todayAppointmentCount">0</span>

                        </p>


                        <p class="mt-1 font-inter text-[10px] text-slate-400">

                            Scheduled for today

                        </p>

                    </div>


                    <div class="flex h-9 w-9 items-center justify-center rounded-lg bg-blue-50 text-blue-600">

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

                </div>

            </div>



            <!-- TODAY'S BILLS -->

            <div class="rounded-xl border border-slate-200 bg-white p-5">

                <div class="flex items-start justify-between">


                    <div>

                        <p class="font-inter text-[10px] font-semibold uppercase tracking-wide text-slate-400">

                            Today's Bills

                        </p>


                        <p class="mt-2 font-manrope text-2xl font-extrabold text-[#172033]">

                            <span id="todayBillCount">0</span>

                        </p>


                        <p class="mt-1 font-inter text-[10px] text-slate-400">

                            Bills generated today

                        </p>

                    </div>


                    <div class="flex h-9 w-9 items-center justify-center rounded-lg bg-blue-50 text-blue-600">

                        <svg
                            class="h-4 w-4"
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

                </div>

            </div>



            <!-- TODAY'S REVENUE -->

            <div class="rounded-xl border border-slate-200 bg-white p-5">

                <div class="flex items-start justify-between">


                    <div>

                        <p class="font-inter text-[10px] font-semibold uppercase tracking-wide text-slate-400">

                            Today's Revenue

                        </p>


                        <p class="mt-2 font-manrope text-2xl font-extrabold text-[#172033]">

                            Rs. <span id="todayRevenue">0.00</span>

                        </p>


                        <p class="mt-1 font-inter text-[10px] text-slate-400">

                            Total revenue today

                        </p>

                    </div>


                    <div class="flex h-9 w-9 items-center justify-center rounded-lg bg-blue-50 text-blue-600">

                        <svg
                            class="h-4 w-4"
                            fill="none"
                            stroke="currentColor"
                            stroke-width="1.8"
                            viewBox="0 0 24 24">

                            <path
                                stroke-linecap="round"
                                d="M12 3v18"/>

                            <path
                                stroke-linecap="round"
                                d="M17 7.5c0-1.5-2.2-2.5-5-2.5s-5 1-5 2.5 2.2 2.5 5 2.5 5 1 5 2.5-2.2 2.5-5 2.5-5-1-5-2.5"/>

                            <path
                                stroke-linecap="round"
                                d="M7 17c0 1.5 2.2 2.5 5 2.5s5-1 5-2.5"/>

                        </svg>

                    </div>

                </div>

            </div>


        </div>



        <!-- =================================================
             MANAGEMENT SECTION
             ================================================= -->

        <div class="grid grid-cols-1 gap-5 lg:grid-cols-3">


            <!-- =================================================
                 USER MANAGEMENT
                 ================================================= -->

            <div class="rounded-xl border border-slate-200 bg-white lg:col-span-2">


                <div class="flex items-center justify-between border-b border-slate-100 px-6 py-5">


                    <div class="flex items-center gap-3">


                        <div class="flex h-9 w-9 items-center justify-center rounded-lg bg-blue-50 text-blue-600">

                            <svg
                                class="h-4 w-4"
                                fill="none"
                                stroke="currentColor"
                                stroke-width="1.8"
                                viewBox="0 0 24 24">

                                <path
                                    stroke-linecap="round"
                                    stroke-linejoin="round"
                                    d="M16 21v-2a4 4 0 00-4-4H6a4 4 0 00-4 4v2"/>

                                <circle
                                    cx="9"
                                    cy="7"
                                    r="4"/>

                                <path
                                    stroke-linecap="round"
                                    d="M19 8v6M22 11h-6"/>

                            </svg>

                        </div>


                        <div>

                            <h2 class="font-manrope text-sm font-bold text-[#172033]">

                                User Management

                            </h2>

                            <p class="mt-0.5 font-inter text-[10px] text-slate-400">

                                Manage clinic users and system access.

                            </p>

                        </div>

                    </div>


                    <a
                        href="<%= contextPath %>/admin/users"

                        class="font-inter text-[10px] font-semibold text-blue-600 transition hover:text-blue-700">

                        View all

                    </a>


                </div>



                <div class="p-6">


                    <div class="rounded-lg border border-slate-100 bg-slate-50/60 p-5">


                        <div class="flex flex-col justify-between gap-5 sm:flex-row sm:items-center">


                            <div>

                                <p class="font-inter text-[10px] font-semibold uppercase tracking-wide text-slate-400">

                                    User Accounts

                                </p>


                                <p class="mt-1.5 font-manrope text-xl font-extrabold text-[#172033]">

                                    <span id="userAccountCount">0</span>

                                </p>


                                <p class="mt-1 font-inter text-[10px] text-slate-400">

                                    Active user accounts in the system.

                                </p>

                            </div>


                            <a
                                href="<%= contextPath %>/admin/add-user"

                                class="inline-flex shrink-0 items-center justify-center gap-2 rounded-lg bg-[#2563EB] px-4 py-2.5 font-inter text-[11px] font-bold text-white shadow-sm transition hover:bg-[#1D4ED8]">

                                <svg
                                    class="h-4 w-4"
                                    fill="none"
                                    stroke="currentColor"
                                    stroke-width="2"
                                    viewBox="0 0 24 24">

                                    <path
                                        stroke-linecap="round"
                                        d="M12 5v14M5 12h14"/>

                                </svg>

                                Add User

                            </a>

                        </div>

                    </div>


                </div>

            </div>



            <!-- =================================================
                 QUICK ACTIONS
                 ================================================= -->

            <div class="rounded-xl border border-slate-200 bg-white">


                <div class="border-b border-slate-100 px-6 py-5">

                    <h2 class="font-manrope text-sm font-bold text-[#172033]">

                        Quick Actions

                    </h2>

                    <p class="mt-0.5 font-inter text-[10px] text-slate-400">

                        Frequently used management actions.

                    </p>

                </div>



                <div class="p-4">


                    <!-- Users -->

                    <a
                        href="<%= contextPath %>/admin/users"

                        class="group flex items-center gap-3 rounded-lg px-3 py-3 transition hover:bg-slate-50">


                        <div class="flex h-8 w-8 items-center justify-center rounded-lg bg-blue-50 text-blue-600">

                            <svg
                                class="h-4 w-4"
                                fill="none"
                                stroke="currentColor"
                                stroke-width="1.8"
                                viewBox="0 0 24 24">

                                <path
                                    stroke-linecap="round"
                                    stroke-linejoin="round"
                                    d="M16 21v-2a4 4 0 00-4-4H6a4 4 0 00-4 4v2"/>

                                <circle
                                    cx="9"
                                    cy="7"
                                    r="4"/>

                                <path
                                    stroke-linecap="round"
                                    stroke-linejoin="round"
                                    d="M19 8v6M22 11h-6"/>

                            </svg>

                        </div>


                        <div class="flex-1">

                            <p class="font-inter text-[11px] font-semibold text-slate-700">

                                Manage Users

                            </p>

                            <p class="font-inter text-[9px] text-slate-400">

                                View and manage system users

                            </p>

                        </div>


                        <svg
                            class="h-4 w-4 text-slate-300 transition group-hover:translate-x-0.5 group-hover:text-blue-500"
                            fill="none"
                            stroke="currentColor"
                            stroke-width="1.8"
                            viewBox="0 0 24 24">

                            <path
                                stroke-linecap="round"
                                stroke-linejoin="round"
                                d="M9 18l6-6-6-6"/>

                        </svg>

                    </a>



                    <!-- Appointments -->

                    <a
                        href="<%= contextPath %>/appointments"

                        class="group flex items-center gap-3 rounded-lg px-3 py-3 transition hover:bg-slate-50">


                        <div class="flex h-8 w-8 items-center justify-center rounded-lg bg-blue-50 text-blue-600">

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


                        <div class="flex-1">

                            <p class="font-inter text-[11px] font-semibold text-slate-700">

                                Appointments

                            </p>

                            <p class="font-inter text-[9px] text-slate-400">

                                View today's appointments

                            </p>

                        </div>


                        <svg
                            class="h-4 w-4 text-slate-300 transition group-hover:translate-x-0.5 group-hover:text-blue-500"
                            fill="none"
                            stroke="currentColor"
                            stroke-width="1.8"
                            viewBox="0 0 24 24">

                            <path
                                stroke-linecap="round"
                                stroke-linejoin="round"
                                d="M9 18l6-6-6-6"/>

                        </svg>

                    </a>



                    <!-- Billing -->

                    <a
                        href="<%= contextPath %>/bills"

                        class="group flex items-center gap-3 rounded-lg px-3 py-3 transition hover:bg-slate-50">


                        <div class="flex h-8 w-8 items-center justify-center rounded-lg bg-blue-50 text-blue-600">

                            <svg
                                class="h-4 w-4"
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


                        <div class="flex-1">

                            <p class="font-inter text-[11px] font-semibold text-slate-700">

                                Billing

                            </p>

                            <p class="font-inter text-[9px] text-slate-400">

                                View clinic billing

                            </p>

                        </div>


                        <svg
                            class="h-4 w-4 text-slate-300 transition group-hover:translate-x-0.5 group-hover:text-blue-500"
                            fill="none"
                            stroke="currentColor"
                            stroke-width="1.8"
                            viewBox="0 0 24 24">

                            <path
                                stroke-linecap="round"
                                stroke-linejoin="round"
                                d="M9 18l6-6-6-6"/>

                        </svg>

                    </a>



                    <!-- Reports -->

                    <a
                        href="<%= contextPath %>/reports"

                        class="group flex items-center gap-3 rounded-lg px-3 py-3 transition hover:bg-slate-50">


                        <div class="flex h-8 w-8 items-center justify-center rounded-lg bg-blue-50 text-blue-600">

                            <svg
                                class="h-4 w-4"
                                fill="none"
                                stroke="currentColor"
                                stroke-width="1.8"
                                viewBox="0 0 24 24">

                                <path
                                    stroke-linecap="round"
                                    stroke-linejoin="round"
                                    d="M4 19V5M4 19h17"/>

                                <path
                                    stroke-linecap="round"
                                    d="M8 16v-5M12 16V7M16 16v-8"/>

                            </svg>

                        </div>


                        <div class="flex-1">

                            <p class="font-inter text-[11px] font-semibold text-slate-700">

                                Reports

                            </p>

                            <p class="font-inter text-[9px] text-slate-400">

                                View clinic reports

                            </p>

                        </div>


                        <svg
                            class="h-4 w-4 text-slate-300 transition group-hover:translate-x-0.5 group-hover:text-blue-500"
                            fill="none"
                            stroke="currentColor"
                            stroke-width="1.8"
                            viewBox="0 0 24 24">

                            <path
                                stroke-linecap="round"
                                stroke-linejoin="round"
                                d="M9 18l6-6-6-6"/>

                        </svg>

                    </a>


                </div>

            </div>


        </div>


    </main>

</div>



<script>
(function () {

    const contextPath = "<%= contextPath %>";

    /*
     * =========================================================
     * API HELPERS
     * =========================================================
     */

    async function getJson(url) {

        const response = await fetch(
            contextPath + url,
            {
                method: "GET",
                credentials: "same-origin",
                headers: {
                    "Accept": "application/json"
                }
            }
        );

        if (response.status === 401) {
            window.location.href =
                contextPath + "/login";
            return null;
        }

        if (response.status === 403) {
            console.error("Access denied:", url);
            return null;
        }

        if (!response.ok) {
            throw new Error(
                "API request failed: " +
                response.status
            );
        }

        return await response.json();
    }


    /*
     * =========================================================
     * CURRENT ADMIN
     *
     * GET /api/auth/me
     * =========================================================
     */

    async function loadCurrentAdmin() {

        try {

            const data =
                await getJson("/api/auth/me");

            if (!data) {
                return;
            }

            const user =
                data.user || data;

            if (!user) {
                return;
            }

            const name =
                user.fullName ||
                user.username ||
                "Administrator";

            const nameElement =
                document.getElementById(
                    "adminWelcomeName"
                );

            if (nameElement) {
                nameElement.textContent = name;
            }

        }
        catch (error) {

            console.error(
                "Could not load current admin:",
                error
            );

        }

    }


    /*
     * =========================================================
     * USER STATISTICS
     *
     * GET /api/users
     *
     * UserApi returns:
     * userId
     * fullName
     * username
     * role
     * active
     * etc.
     * =========================================================
     */

    async function loadUserStatistics() {

        try {

            const users =
                await getJson("/api/users");

            if (!users || !Array.isArray(users)) {
                return;
            }

            const activeUsers =
                users.filter(function (user) {
                    return user.active === true;
                }).length;


            const activeUserCount =
                document.getElementById(
                    "activeUserCount"
                );

            const userAccountCount =
                document.getElementById(
                    "userAccountCount"
                );


            if (activeUserCount) {
                activeUserCount.textContent =
                    activeUsers;
            }

            if (userAccountCount) {
                userAccountCount.textContent =
                    activeUsers;
            }

        }
        catch (error) {

            console.error(
                "Could not load user statistics:",
                error
            );

        }

    }


    /*
     * =========================================================
     * TODAY'S APPOINTMENTS
     *
     * GET /api/appointments/today
     * =========================================================
     */

    async function loadTodayAppointments() {

        try {

            const appointments =
                await getJson(
                    "/api/appointments/today"
                );

            if (
                !appointments ||
                !Array.isArray(appointments)
            ) {
                return;
            }

            const countElement =
                document.getElementById(
                    "todayAppointmentCount"
                );

            if (countElement) {

                countElement.textContent =
                    appointments.length;

            }

        }
        catch (error) {

            console.error(
                "Could not load today's appointments:",
                error
            );

        }

    }


    /*
     * =========================================================
     * TODAY'S BILLING STATISTICS
     *
     * GET /api/reports?startDate=YYYY-MM-DD&endDate=YYYY-MM-DD
     *
     * The report API provides:
     * totalBills
     * totalRevenue
     *
     * Using today's date as both start and end gives
     * today's billing statistics without changing the
     * dashboard design.
     * =========================================================
     */

    async function loadTodayBilling() {

        try {

            const today =
                new Date();

            const year =
                today.getFullYear();

            const month =
                String(
                    today.getMonth() + 1
                ).padStart(2, "0");

            const day =
                String(
                    today.getDate()
                ).padStart(2, "0");

            const date =
                year + "-" +
                month + "-" +
                day;


            const data =
                await getJson(
                    "/api/reports" +
                    "?startDate=" +
                    encodeURIComponent(date) +
                    "&endDate=" +
                    encodeURIComponent(date)
                );


            if (!data) {
                return;
            }


            const billCountElement =
                document.getElementById(
                    "todayBillCount"
                );

            const revenueElement =
                document.getElementById(
                    "todayRevenue"
                );


            if (billCountElement) {

                billCountElement.textContent =
                    Number(
                        data.totalBills || 0
                    );

            }


            if (revenueElement) {

                revenueElement.textContent =
                    Number(
                        data.totalRevenue || 0
                    ).toLocaleString(
                        "en-LK",
                        {
                            minimumFractionDigits: 2,
                            maximumFractionDigits: 2
                        }
                    );

            }

        }
        catch (error) {

            console.error(
                "Could not load today's billing statistics:",
                error
            );

        }

    }


    /*
     * =========================================================
     * LOAD DASHBOARD
     * =========================================================
     */

    async function loadDashboard() {

        await Promise.all([
            loadCurrentAdmin(),
            loadUserStatistics(),
            loadTodayAppointments(),
            loadTodayBilling()
        ]);

    }


    /*
     * =========================================================
     * START
     * =========================================================
     */

    loadDashboard();

})();
</script>

</body>

</html>