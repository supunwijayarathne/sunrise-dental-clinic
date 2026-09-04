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

    <title>User Management - Sunrise Dental</title>


    <!-- Tailwind CSS -->

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
             PAGE HEADER
             ================================================= -->

        <div class="mb-7 flex items-end justify-between">


            <div>

                <p class="mb-1 font-inter text-[10px] font-semibold uppercase tracking-[0.12em] text-blue-600">

                    Administration

                </p>


                <h1 class="font-manrope text-2xl font-extrabold tracking-tight text-[#172033]">

                    User Management

                </h1>


                <p class="mt-1.5 font-inter text-xs text-slate-500">

                    Manage system users, roles, and access.

                </p>

            </div>



            <!-- Add User -->

            <a
                href="<%= contextPath %>/admin/add-user"

                class="inline-flex items-center gap-2 rounded-lg bg-[#2563EB] px-4 py-2.5 font-inter text-[11px] font-bold text-white shadow-sm transition hover:bg-[#1D4ED8]">


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



        <!-- =================================================
             SUCCESS MESSAGES
             ================================================= -->

        <div
            id="successAddedMessage"
            class="hidden mb-5 flex items-center gap-3 rounded-xl border border-emerald-100 bg-emerald-50 px-4 py-3.5">

            <div class="flex h-7 w-7 shrink-0 items-center justify-center rounded-lg bg-emerald-100 text-emerald-600">

                <svg
                    class="h-4 w-4"
                    fill="none"
                    stroke="currentColor"
                    stroke-width="2"
                    viewBox="0 0 24 24">

                    <path
                        stroke-linecap="round"
                        stroke-linejoin="round"
                        d="M5 12l4 4L19 6"/>

                </svg>

            </div>

            <div>

                <p class="font-inter text-xs font-semibold text-emerald-700">

                    User account created successfully.

                </p>

            </div>

        </div>


        <div
            id="successUpdatedMessage"
            class="hidden mb-5 flex items-center gap-3 rounded-xl border border-emerald-100 bg-emerald-50 px-4 py-3.5">

            <div class="flex h-7 w-7 shrink-0 items-center justify-center rounded-lg bg-emerald-100 text-emerald-600">

                <svg
                    class="h-4 w-4"
                    fill="none"
                    stroke="currentColor"
                    stroke-width="2"
                    viewBox="0 0 24 24">

                    <path
                        stroke-linecap="round"
                        stroke-linejoin="round"
                        d="M5 12l4 4L19 6"/>

                </svg>

            </div>

            <div>

                <p class="font-inter text-xs font-semibold text-emerald-700">

                    User details updated successfully.

                </p>

            </div>

        </div>


        <!-- =================================================
             SUMMARY CARDS
             ================================================= -->

        <div class="mb-5 grid grid-cols-1 gap-4 md:grid-cols-3">


            <!-- Total -->

            <div class="rounded-xl border border-slate-200 bg-white p-5">


                <div class="flex items-start justify-between">


                    <div>

                        <p class="font-inter text-[10px] font-semibold uppercase tracking-wide text-slate-400">

                            Total Users

                        </p>


                        <p class="mt-2 font-manrope text-2xl font-extrabold text-[#172033]">

                            <span id="totalUsers">0</span>

                        </p>


                        <p class="mt-1 font-inter text-[10px] text-slate-400">

                            Registered accounts

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
                                d="M19 8v6M22 11h-6"/>

                        </svg>

                    </div>


                </div>


            </div>



            <!-- Active -->

            <div class="rounded-xl border border-slate-200 bg-white p-5">


                <div class="flex items-start justify-between">


                    <div>

                        <p class="font-inter text-[10px] font-semibold uppercase tracking-wide text-slate-400">

                            Active

                        </p>


                        <p class="mt-2 font-manrope text-2xl font-extrabold text-[#172033]">

                            <span id="activeUsers">0</span>

                        </p>


                        <p class="mt-1 font-inter text-[10px] text-slate-400">

                            Active accounts

                        </p>

                    </div>


                    <div class="flex h-9 w-9 items-center justify-center rounded-lg bg-emerald-50 text-emerald-600">

                        <svg
                            class="h-4 w-4"
                            fill="none"
                            stroke="currentColor"
                            stroke-width="1.8"
                            viewBox="0 0 24 24">

                            <path
                                stroke-linecap="round"
                                stroke-linejoin="round"
                                d="M5 12l4 4L19 6"/>

                        </svg>

                    </div>


                </div>


            </div>



            <!-- Inactive -->

            <div class="rounded-xl border border-slate-200 bg-white p-5">


                <div class="flex items-start justify-between">


                    <div>

                        <p class="font-inter text-[10px] font-semibold uppercase tracking-wide text-slate-400">

                            Inactive

                        </p>


                        <p class="mt-2 font-manrope text-2xl font-extrabold text-[#172033]">

                            <span id="inactiveUsers">0</span>

                        </p>


                        <p class="mt-1 font-inter text-[10px] text-slate-400">

                            Disabled accounts

                        </p>

                    </div>


                    <div class="flex h-9 w-9 items-center justify-center rounded-lg bg-red-50 text-red-600">

                        <svg
                            class="h-4 w-4"
                            fill="none"
                            stroke="currentColor"
                            stroke-width="1.8"
                            viewBox="0 0 24 24">

                            <circle
                                cx="12"
                                cy="12"
                                r="9"/>

                            <path
                                stroke-linecap="round"
                                d="M9 9l6 6M15 9l-6 6"/>

                        </svg>

                    </div>


                </div>


            </div>


        </div>



        <!-- =================================================
             EMPLOYEE TABLE
             ================================================= -->

        <div class="overflow-hidden rounded-xl border border-slate-200 bg-white">


            <!-- Table Header -->

            <div class="flex items-center justify-between border-b border-slate-100 px-6 py-5">


                <div>

                    <h2 class="font-manrope text-sm font-bold text-[#172033]">

                        Receptionists

                    </h2>


                    <p class="mt-0.5 font-inter text-[10px] text-slate-400">

                        View and manage registered clinic staff.

                    </p>

                </div>


                <div class="font-inter text-[10px] text-slate-400">

                    <span id="tableUserCount">0</span> user<span id="userPlural">s</span>

                </div>


            </div>



            <!-- Table -->

            <div class="overflow-x-auto" id="usersTableContainer">

                <table class="w-full min-w-[950px]">

                    <thead>

                    <tr class="border-b border-slate-100 bg-slate-50/70">

                        <th class="px-5 py-3 text-left font-inter text-[9px] font-semibold uppercase tracking-wide text-slate-400">

                            User ID

                        </th>

                        <th class="px-5 py-3 text-left font-inter text-[9px] font-semibold uppercase tracking-wide text-slate-400">

                            User

                        </th>

                        <th class="px-5 py-3 text-left font-inter text-[9px] font-semibold uppercase tracking-wide text-slate-400">

                            Position

                        </th>

                        <th class="px-5 py-3 text-left font-inter text-[9px] font-semibold uppercase tracking-wide text-slate-400">

                            Contact

                        </th>

                        <th class="px-5 py-3 text-left font-inter text-[9px] font-semibold uppercase tracking-wide text-slate-400">

                            Status

                        </th>

                        <th class="px-5 py-3 text-right font-inter text-[9px] font-semibold uppercase tracking-wide text-slate-400">

                            Actions

                        </th>

                    </tr>

                    </thead>

                    <tbody id="usersTableBody"></tbody>

                </table>

            </div>


            <!-- =================================================
                 EMPTY STATE
                 ================================================= -->

            <div
                id="emptyState"
                class="hidden px-6 py-16 text-center">

                <div class="mx-auto flex h-12 w-12 items-center justify-center rounded-xl bg-blue-50 text-blue-600">

                    <svg
                        class="h-5 w-5"
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

                    </svg>

                </div>

                <h3 class="mt-4 font-manrope text-sm font-bold text-[#172033]">

                    No receptionists found

                </h3>

                <p class="mx-auto mt-1.5 max-w-sm font-inter text-[10px] leading-5 text-slate-400">

                    Create your first receptionist account to give staff access to the system.

                </p>

                <a
                    href="<%= contextPath %>/admin/add-user"

                    class="mt-5 inline-flex items-center gap-2 rounded-lg bg-[#2563EB] px-4 py-2.5 font-inter text-[10px] font-bold text-white shadow-sm transition hover:bg-[#1D4ED8]">

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


        <!-- =================================================
             ADMIN TABLE
             ================================================= -->

        <div class="mt-5 overflow-hidden rounded-xl border border-slate-200 bg-white">


            <!-- Table Header -->

            <div class="flex items-center justify-between border-b border-slate-100 px-6 py-5">


                <div>

                    <h2 class="font-manrope text-sm font-bold text-[#172033]">

                        Administrators

                    </h2>


                    <p class="mt-0.5 font-inter text-[10px] text-slate-400">

                        View and manage registered system administrators.

                    </p>

                </div>


                <div class="font-inter text-[10px] text-slate-400">

                    <span id="adminTableUserCount">0</span> admin<span id="adminUserPlural">s</span>

                </div>


            </div>



            <!-- Table -->

            <div class="overflow-x-auto" id="adminTableContainer">

                <table class="w-full min-w-[950px]">

                    <thead>

                    <tr class="border-b border-slate-100 bg-slate-50/70">

                        <th class="px-5 py-3 text-left font-inter text-[9px] font-semibold uppercase tracking-wide text-slate-400">

                            User ID

                        </th>

                        <th class="px-5 py-3 text-left font-inter text-[9px] font-semibold uppercase tracking-wide text-slate-400">

                            User

                        </th>

                        <th class="px-5 py-3 text-left font-inter text-[9px] font-semibold uppercase tracking-wide text-slate-400">

                            Position

                        </th>

                        <th class="px-5 py-3 text-left font-inter text-[9px] font-semibold uppercase tracking-wide text-slate-400">

                            Contact

                        </th>

                        <th class="px-5 py-3 text-left font-inter text-[9px] font-semibold uppercase tracking-wide text-slate-400">

                            Status

                        </th>

                        <th class="px-5 py-3 text-right font-inter text-[9px] font-semibold uppercase tracking-wide text-slate-400">

                            Actions

                        </th>

                    </tr>

                    </thead>

                    <tbody id="adminTableBody"></tbody>

                </table>

            </div>


            <!-- =================================================
                 EMPTY STATE
                 ================================================= -->

            <div
                id="adminEmptyState"
                class="hidden px-6 py-16 text-center">

                <div class="mx-auto flex h-12 w-12 items-center justify-center rounded-xl bg-blue-50 text-blue-600">

                    <svg
                        class="h-5 w-5"
                        fill="none"
                        stroke="currentColor"
                        stroke-width="1.8"
                        viewBox="0 0 24 24">

                        <path
                            stroke-linecap="round"
                            stroke-linejoin="round"
                            d="M12 15v2M8 11V7a4 4 0 118 0v4"/>

                        <rect
                            x="4"
                            y="11"
                            width="16"
                            height="10"
                            rx="2"/>

                    </svg>

                </div>

                <h3 class="mt-4 font-manrope text-sm font-bold text-[#172033]">

                    No administrators found

                </h3>

                <p class="mx-auto mt-1.5 max-w-sm font-inter text-[10px] leading-5 text-slate-400">

                    No administrator accounts are currently available.

                </p>

            </div>

        </div>


    </main>


</div>



<script>
(function () {

    const contextPath = "<%= contextPath %>";

    let users = [];


    /*
     * =========================================================
     * API REQUEST HELPER
     * =========================================================
     */

    async function apiRequest(url, options) {

        const response = await fetch(
            contextPath + url,
            Object.assign(
                {
                    credentials: "same-origin",
                    headers: {
                        "Accept": "application/json"
                    }
                },
                options || {}
            )
        );


        if (response.status === 401) {

            window.location.href =
                contextPath + "/login";

            return null;

        }


        if (response.status === 403) {

            throw new Error(
                "You do not have permission to perform this action."
            );

        }


        let data = null;

        const contentType =
            response.headers.get("content-type") || "";


        if (contentType.includes("application/json")) {

            data = await response.json();

        }


        if (!response.ok) {

            let message =
                "Request failed.";

            if (data) {

                message =
                    data.message ||
                    data.error ||
                    message;

            }

            throw new Error(message);

        }


        return data;

    }


    /*
     * =========================================================
     * LOAD RECEPTIONISTS
     *
     * GET /api/users/receptionists
     * =========================================================
     */

    async function loadUsers() {

        try {

            const data =
                await apiRequest(
                    "/api/users/receptionists"
                );


            users =
                Array.isArray(data)
                    ? data
                    : (
                        data && Array.isArray(data.users)
                            ? data.users
                            : []
                    );


            updateSummary();

            renderUsers();

        }
        catch (error) {

            console.error(
                "Failed to load users:",
                error
            );

            users = [];

            updateSummary();

            renderUsers();

        }

    }


    /*
     * =========================================================
     * UPDATE SUMMARY
     * =========================================================
     */

    function updateSummary() {

        const total =
            users.length;


        const active =
            users.filter(function (user) {

                return user.active === true;

            }).length;


        const inactive =
            total - active;


        const totalElement =
            document.getElementById(
                "totalUsers"
            );


        const activeElement =
            document.getElementById(
                "activeUsers"
            );


        const inactiveElement =
            document.getElementById(
                "inactiveUsers"
            );


        const tableCountElement =
            document.getElementById(
                "tableUserCount"
            );


        if (totalElement) {

            totalElement.textContent =
                total;

        }


        if (activeElement) {

            activeElement.textContent =
                active;

        }


        if (inactiveElement) {

            inactiveElement.textContent =
                inactive;

        }


        if (tableCountElement) {

            tableCountElement.textContent =
                total;

        }

    }


    /*
     * =========================================================
     * ESCAPE HTML
     * =========================================================
     */

    function escapeHtml(value) {

        if (
            value === null ||
            value === undefined
        ) {

            return "";

        }


        return String(value)
            .replace(/&/g, "&amp;")
            .replace(/</g, "&lt;")
            .replace(/>/g, "&gt;")
            .replace(/"/g, "&quot;")
            .replace(/'/g, "&#039;");

    }


    /*
     * =========================================================
     * RENDER USERS
     * =========================================================
     */

    function renderUsers() {

        const tbody =
            document.getElementById(
                "usersTableBody"
            );


        const tableContainer =
            document.getElementById(
                "usersTableContainer"
            );


        const emptyState =
            document.getElementById(
                "emptyState"
            );


        if (!tbody) {
            return;
        }


        tbody.innerHTML = "";


        if (!users.length) {

            if (tableContainer) {

                tableContainer.classList.add(
                    "hidden"
                );

            }


            if (emptyState) {

                emptyState.classList.remove(
                    "hidden"
                );

            }

            return;

        }


        if (tableContainer) {

            tableContainer.classList.remove(
                "hidden"
            );

        }


        if (emptyState) {

            emptyState.classList.add(
                "hidden"
            );

        }


        users.forEach(function (user) {

            const id =
                Number(user.userId || 0);


            const fullName =
                user.fullName ||
                "Unknown User";


            const username =
                user.username ||
                "";


            const position =
                user.position ||
                "Receptionist";


            const email =
                user.email ||
                "No email";


            const phone =
                user.phone ||
                "No phone";


            const isActive =
                user.active === true;


            const initial =
                fullName
                    .trim()
                    .charAt(0)
                    .toUpperCase() || "R";


            const row =
                document.createElement("tr");


            row.className =
                "border-b border-slate-100 last:border-0 transition hover:bg-slate-50/50";


            const statusHtml =
                isActive

                    ? '<span class="inline-flex items-center gap-1.5 rounded-full bg-emerald-50 px-2.5 py-1 font-inter text-[9px] font-semibold text-emerald-600">' +
                      '<span class="h-1.5 w-1.5 rounded-full bg-emerald-500"></span>' +
                      'Active' +
                      '</span>'

                    : '<span class="inline-flex items-center gap-1.5 rounded-full bg-red-50 px-2.5 py-1 font-inter text-[9px] font-semibold text-red-600">' +
                      '<span class="h-1.5 w-1.5 rounded-full bg-red-500"></span>' +
                      'Inactive' +
                      '</span>';


            const actionText =
                isActive
                    ? "Deactivate"
                    : "Activate";


            const actionClasses =
                isActive
                    ? "rounded-lg bg-red-50 px-3 py-1.5 font-inter text-[9px] font-semibold text-red-600 transition hover:bg-red-100"
                    : "rounded-lg bg-emerald-50 px-3 py-1.5 font-inter text-[9px] font-semibold text-emerald-600 transition hover:bg-emerald-100";


            row.innerHTML =

                '<td class="px-5 py-4">' +

                    '<span class="font-inter text-[11px] font-semibold text-blue-600">' +

                        'EMP' +
                        String(id).padStart(3, "0") +

                    '</span>' +

                '</td>' +


                '<td class="px-5 py-4">' +

                    '<div class="flex items-center gap-3">' +

                        '<div class="flex h-8 w-8 shrink-0 items-center justify-center rounded-lg bg-blue-50 font-manrope text-[11px] font-bold text-blue-600">' +

                            escapeHtml(initial) +

                        '</div>' +

                        '<div>' +

                            '<p class="font-inter text-[11px] font-semibold text-[#172033]">' +

                                escapeHtml(fullName) +

                            '</p>' +

                            '<p class="mt-0.5 font-inter text-[9px] text-slate-400">' +

                                '@' +
                                escapeHtml(username) +

                            '</p>' +

                        '</div>' +

                    '</div>' +

                '</td>' +


                '<td class="px-5 py-4">' +

                    '<span class="font-inter text-[11px] font-medium text-slate-600">' +

                        escapeHtml(position) +

                    '</span>' +

                '</td>' +


                '<td class="px-5 py-4">' +

                    '<p class="font-inter text-[10px] font-medium text-slate-600">' +

                        escapeHtml(email) +

                    '</p>' +

                    '<p class="mt-1 font-inter text-[9px] text-slate-400">' +

                        escapeHtml(phone) +

                    '</p>' +

                '</td>' +


                '<td class="px-5 py-4">' +

                    statusHtml +

                '</td>' +


                '<td class="px-5 py-4">' +

                    '<div class="flex items-center justify-end gap-2">' +

                        '<a href="' +
                            contextPath +
                            '/admin/users?action=view&id=' +
                            encodeURIComponent(id) +
                            '"' +

                            ' class="rounded-lg bg-blue-50 px-3 py-1.5 font-inter text-[9px] font-semibold text-blue-600 transition hover:bg-blue-100">' +

                            'View' +

                        '</a>' +


                        '<a href="' +
                            contextPath +
                            '/admin/edit-user?id=' +
                            encodeURIComponent(id) +
                            '"' +

                            ' class="rounded-lg bg-slate-100 px-3 py-1.5 font-inter text-[9px] font-semibold text-slate-600 transition hover:bg-slate-200">' +

                            'Edit' +

                        '</a>' +


                        '<button type="button"' +

                            ' class="' +
                            actionClasses +
                            '"' +

                            ' data-user-id="' +
                            id +
                            '"' +

                            ' data-active="' +
                            isActive +
                            '">' +

                            actionText +

                        '</button>' +

                    '</div>' +

                '</td>';


            tbody.appendChild(row);

        });

    }


    /*
     * =========================================================
     * LOAD ADMINISTRATORS
     *
     * GET /api/users
     * Filter role = ADMIN
     * =========================================================
     */

    async function loadAdministrators() {

        try {

            const data =
                await apiRequest(
                    "/api/users"
                );


            const allUsers =
                Array.isArray(data)
                    ? data
                    : (
                        data &&
                        Array.isArray(data.users)
                            ? data.users
                            : []
                    );


            const administrators =
                allUsers.filter(
                    function (user) {

                        return (
                            String(
                                user.role || ""
                            ).toUpperCase() ===
                            "ADMIN"
                        );

                    }
                );


            renderAdministrators(
                administrators
            );

        }
        catch (error) {

            console.error(
                "Failed to load administrators:",
                error
            );


            renderAdministrators([]);

        }

    }


    /*
     * =========================================================
     * RENDER ADMINISTRATORS
     * =========================================================
     */

    function renderAdministrators(
        administrators
    ) {

        const tbody =
            document.getElementById(
                "adminTableBody"
            );


        const tableContainer =
            document.getElementById(
                "adminTableContainer"
            );


        const emptyState =
            document.getElementById(
                "adminEmptyState"
            );


        const countElement =
            document.getElementById(
                "adminTableUserCount"
            );


        const pluralElement =
            document.getElementById(
                "adminUserPlural"
            );


        if (!tbody) {
            return;
        }


        tbody.innerHTML = "";


        const total =
            administrators.length;


        if (countElement) {

            countElement.textContent =
                total;

        }


        if (pluralElement) {

            pluralElement.textContent =
                total === 1
                    ? ""
                    : "s";

        }


        if (!total) {

            if (tableContainer) {

                tableContainer.classList.add(
                    "hidden"
                );

            }


            if (emptyState) {

                emptyState.classList.remove(
                    "hidden"
                );

            }

            return;

        }


        if (tableContainer) {

            tableContainer.classList.remove(
                "hidden"
            );

        }


        if (emptyState) {

            emptyState.classList.add(
                "hidden"
            );

        }


        administrators.forEach(
            function (user) {

                const id =
                    Number(
                        user.userId || 0
                    );


                const fullName =
                    user.fullName ||
                    "Unknown User";


                const username =
                    user.username ||
                    "";


                const position =
                    user.position ||
                    "Administrator";


                const email =
                    user.email ||
                    "No email";


                const phone =
                    user.phone ||
                    "No phone";


                const isActive =
                    user.active === true;


                const initial =
                    fullName
                        .trim()
                        .charAt(0)
                        .toUpperCase() ||
                    "A";


                const row =
                    document.createElement(
                        "tr"
                    );


                row.className =
                    "border-b border-slate-100 last:border-0 transition hover:bg-slate-50/50";


                const statusHtml =
                    isActive

                        ? '<span class="inline-flex items-center gap-1.5 rounded-full bg-emerald-50 px-2.5 py-1 font-inter text-[9px] font-semibold text-emerald-600">' +
                          '<span class="h-1.5 w-1.5 rounded-full bg-emerald-500"></span>' +
                          'Active' +
                          '</span>'

                        : '<span class="inline-flex items-center gap-1.5 rounded-full bg-red-50 px-2.5 py-1 font-inter text-[9px] font-semibold text-red-600">' +
                          '<span class="h-1.5 w-1.5 rounded-full bg-red-500"></span>' +
                          'Inactive' +
                          '</span>';


                const actionText =
                    isActive
                        ? "Deactivate"
                        : "Activate";


                const actionClasses =
                    isActive
                        ? "rounded-lg bg-red-50 px-3 py-1.5 font-inter text-[9px] font-semibold text-red-600 transition hover:bg-red-100"
                        : "rounded-lg bg-emerald-50 px-3 py-1.5 font-inter text-[9px] font-semibold text-emerald-600 transition hover:bg-emerald-100";


                row.innerHTML =

                    '<td class="px-5 py-4">' +

                        '<span class="font-inter text-[11px] font-semibold text-blue-600">' +

                            'EMP' +
                            String(id).padStart(3, "0") +

                        '</span>' +

                    '</td>' +


                    '<td class="px-5 py-4">' +

                        '<div class="flex items-center gap-3">' +

                            '<div class="flex h-8 w-8 shrink-0 items-center justify-center rounded-lg bg-blue-50 font-manrope text-[11px] font-bold text-blue-600">' +

                                escapeHtml(initial) +

                            '</div>' +

                            '<div>' +

                                '<p class="font-inter text-[11px] font-semibold text-[#172033]">' +

                                    escapeHtml(fullName) +

                                '</p>' +

                                '<p class="mt-0.5 font-inter text-[9px] text-slate-400">' +

                                    '@' +
                                    escapeHtml(username) +

                                '</p>' +

                            '</div>' +

                        '</div>' +

                    '</td>' +


                    '<td class="px-5 py-4">' +

                        '<span class="font-inter text-[11px] font-medium text-slate-600">' +

                            escapeHtml(position) +

                        '</span>' +

                    '</td>' +


                    '<td class="px-5 py-4">' +

                        '<p class="font-inter text-[10px] font-medium text-slate-600">' +

                            escapeHtml(email) +

                        '</p>' +

                        '<p class="mt-1 font-inter text-[9px] text-slate-400">' +

                            escapeHtml(phone) +

                        '</p>' +

                    '</td>' +


                    '<td class="px-5 py-4">' +

                        statusHtml +

                    '</td>' +


                    '<td class="px-5 py-4">' +

                        '<div class="flex items-center justify-end gap-2">' +

                            '<a href="' +
                                contextPath +
                                '/admin/users?action=view&id=' +
                                encodeURIComponent(id) +
                                '"' +

                                ' class="rounded-lg bg-blue-50 px-3 py-1.5 font-inter text-[9px] font-semibold text-blue-600 transition hover:bg-blue-100">' +

                                'View' +

                            '</a>' +


                            '<a href="' +
                                contextPath +
                                '/admin/edit-user?id=' +
                                encodeURIComponent(id) +
                                '"' +

                                ' class="rounded-lg bg-slate-100 px-3 py-1.5 font-inter text-[9px] font-semibold text-slate-600 transition hover:bg-slate-200">' +

                                'Edit' +

                            '</a>' +


                            '<button type="button"' +

                                ' class="' +
                                actionClasses +
                                '"' +

                                ' data-admin-user-id="' +
                                id +
                                '"' +

                                ' data-admin-active="' +
                                isActive +
                                '">' +

                                actionText +

                            '</button>' +

                        '</div>' +

                    '</td>';


                tbody.appendChild(row);

            }
        );

    }


    /*
     * =========================================================
     * ADMIN STATUS EVENTS
     * =========================================================
     */

    document.addEventListener(
        "click",
        function (event) {

            const button =
                event.target.closest(
                    "[data-admin-user-id]"
                );


            if (!button) {
                return;
            }


            const userId =
                Number(
                    button.getAttribute(
                        "data-admin-user-id"
                    )
                );


            const currentlyActive =
                button.getAttribute(
                    "data-admin-active"
                ) === "true";


            updateUserStatus(
                userId,
                currentlyActive
            );

        }
    );



    /*
     * =========================================================
     * ACTIVATE / DEACTIVATE
     *
     * PATCH /api/users/{id}?active=true|false
     * =========================================================
     */

    async function updateUserStatus(
        userId,
        currentlyActive
    ) {

        const action =
            currentlyActive
                ? "deactivate"
                : "activate";


        const message =
            currentlyActive
                ? "Are you sure you want to deactivate this receptionist?"
                : "Are you sure you want to activate this receptionist?";


        if (!window.confirm(message)) {
            return;
        }


        try {

            await apiRequest(
                "/api/users/" +
                encodeURIComponent(userId) +
                "?active=" +
                encodeURIComponent(
                    !currentlyActive
                ),
                {
                    method: "PATCH",
                    headers: {
                        "Accept":
                            "application/json"
                    }
                }
            );


            document
                .getElementById(
                    "successUpdatedMessage"
                )
                .classList.remove("hidden");


            document
                .getElementById(
                    "successAddedMessage"
                )
                .classList.add("hidden");


            await loadUsers();

        }
        catch (error) {

            console.error(
                "Failed to " +
                action +
                " user:",
                error
            );


            alert(
                error.message ||
                "Unable to update user status."
            );

        }

    }


    /*
     * =========================================================
     * STATUS BUTTON EVENTS
     * =========================================================
     */

    document.addEventListener(
        "click",
        function (event) {

            const button =
                event.target.closest(
                    "[data-user-id]"
                );


            if (!button) {
                return;
            }


            const userId =
                Number(
                    button.getAttribute(
                        "data-user-id"
                    )
                );


            const currentlyActive =
                button.getAttribute(
                    "data-active"
                ) === "true";


            updateUserStatus(
                userId,
                currentlyActive
            );

        }
    );


    /*
     * =========================================================
     * START
     * =========================================================
     */

    loadUsers();

    loadAdministrators();

})();
</script>

</body>

</html>