<%@ page contentType="text/html;charset=UTF-8" %>

<%
    String contextPath = request.getContextPath();
    String userId = request.getParameter("id");
%>

<!DOCTYPE html>

<html lang="en">

<head>

    <meta charset="UTF-8">

    <meta name="viewport"
          content="width=device-width, initial-scale=1.0">

    <title>User Details - Sunrise Dental</title>


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

        <div class="mb-7">


            <!-- Breadcrumb -->

            <div class="mb-4 flex items-center gap-2 font-inter text-[11px] font-medium text-slate-400">

                <a
                    href="<%= contextPath %>/admin/users"
                    class="transition hover:text-blue-600">

                    Users

                </a>

                <span>
                    /
                </span>

                <span class="text-slate-500">

                    User Details

                </span>

            </div>



            <div class="flex items-end justify-between">


                <div>

                    <p class="mb-1 font-inter text-[10px] font-semibold uppercase tracking-[0.12em] text-blue-600">

                        User Management

                    </p>


                    <h1 class="font-manrope text-2xl font-extrabold tracking-tight text-[#172033]">

                        User Details

                    </h1>


                    <p class="mt-1.5 font-inter text-xs text-slate-500">

                        View user information and account details.

                    </p>

                </div>



                <!-- Back -->

                <a
                    href="<%= contextPath %>/admin/users"

                    class="inline-flex items-center gap-2 rounded-lg border border-slate-200 bg-white px-4 py-2.5 font-inter text-[11px] font-semibold text-slate-600 shadow-sm transition hover:bg-slate-50">


                    <svg
                        class="h-4 w-4"
                        fill="none"
                        stroke="currentColor"
                        stroke-width="1.8"
                        viewBox="0 0 24 24">

                        <path
                            stroke-linecap="round"
                            stroke-linejoin="round"
                            d="M19 12H5"/>

                        <path
                            stroke-linecap="round"
                            stroke-linejoin="round"
                            d="M12 19l-7-7 7-7"/>

                    </svg>


                    Back to Users

                </a>


            </div>

        </div>



        <!-- =================================================
             USER SUMMARY
             ================================================= -->

        <div class="mb-5 rounded-xl border border-slate-200 bg-white">


            <div class="flex flex-col gap-5 px-6 py-5 sm:flex-row sm:items-center sm:justify-between">


                <!-- User -->

                <div class="flex items-center gap-4">


                    <!-- Initials -->

                    <div class="flex h-12 w-12 shrink-0 items-center justify-center rounded-xl bg-blue-50 font-manrope text-base font-extrabold text-blue-600">

                        <span id="userInitials">U</span>

                    </div>


                    <div>

                        <h2 class="font-manrope text-base font-bold text-[#172033]">

                            <span id="userFullNamePersonal">Loading...</span>

                        </h2>


                        <div class="mt-1 flex flex-wrap items-center gap-2">


                            <!-- User ID -->

                            <span class="font-inter text-[10px] text-slate-400">

                                USR<span id="userIdHeader">---</span>

                            </span>


                            <span class="text-slate-300">
                                •
                            </span>


                            <!-- Position -->

                            <span class="font-inter text-[10px] text-slate-500">

                                <span id="userPosition">Staff</span>

                            </span>

                        </div>

                    </div>

                </div>



                <!-- Status -->

                
<span id="summaryStatus"
      class="inline-flex w-fit items-center gap-1.5 rounded-full bg-emerald-50 px-3 py-1.5 font-inter text-[10px] font-semibold text-emerald-600">
    <span class="h-1.5 w-1.5 rounded-full bg-emerald-500"></span>
    Active
</span>



            </div>

        </div>



        <!-- =================================================
             DETAILS GRID
             ================================================= -->

        <div class="grid grid-cols-1 gap-5 xl:grid-cols-3">


            <!-- =================================================
                 PERSONAL INFORMATION
                 ================================================= -->

            <div class="rounded-xl border border-slate-200 bg-white xl:col-span-2">


                <!-- Header -->

                <div class="flex items-center gap-3 border-b border-slate-100 px-6 py-5">


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


                    <div>

                        <h2 class="font-manrope text-sm font-bold text-[#172033]">

                            Personal Information

                        </h2>


                        <p class="mt-0.5 font-inter text-[10px] text-slate-400">

                            User contact and profile information.

                        </p>

                    </div>


                </div>



                <!-- Details -->

                <div class="p-6">


                    <div class="grid grid-cols-1 gap-4 md:grid-cols-2">


                        <!-- User ID -->

                        <div class="rounded-lg border border-slate-100 bg-slate-50/60 p-4">


                            <p class="font-inter text-[9px] font-semibold uppercase tracking-wide text-slate-400">

                                User ID

                            </p>


                            <p class="mt-1.5 font-inter text-xs font-semibold text-[#172033]">

                                USR<span id="userIdDisplay">---</span>

                            </p>


                        </div>



                        <!-- Full Name -->

                        <div class="rounded-lg border border-slate-100 bg-slate-50/60 p-4">


                            <p class="font-inter text-[9px] font-semibold uppercase tracking-wide text-slate-400">

                                Full Name

                            </p>


                            <p class="mt-1.5 font-inter text-xs font-semibold text-[#172033]">

                                <span id="userFullName">Loading...</span>

                            </p>


                        </div>



                        <!-- Position -->

                        <div class="rounded-lg border border-slate-100 bg-slate-50/60 p-4">


                            <p class="font-inter text-[9px] font-semibold uppercase tracking-wide text-slate-400">

                                Position

                            </p>


                            <p class="mt-1.5 font-inter text-xs font-semibold text-[#172033]">

                                <span id="userPosition">Staff</span>

                            </p>


                        </div>



                        <!-- Email -->

                        <div class="rounded-lg border border-slate-100 bg-slate-50/60 p-4">


                            <p class="font-inter text-[9px] font-semibold uppercase tracking-wide text-slate-400">

                                Email Address

                            </p>


                            <p class="mt-1.5 break-all font-inter text-xs font-semibold text-[#172033]">

                                <span id="userEmail">Not provided</span>

                            </p>


                        </div>



                        <!-- Phone -->

                        <div class="rounded-lg border border-slate-100 bg-slate-50/60 p-4">


                            <p class="font-inter text-[9px] font-semibold uppercase tracking-wide text-slate-400">

                                Contact Number

                            </p>


                            <p class="mt-1.5 font-inter text-xs font-semibold text-[#172033]">

                                <span id="userPhone">Not provided</span>

                            </p>


                        </div>



                        <!-- Address -->

                        <div class="rounded-lg border border-slate-100 bg-slate-50/60 p-4">


                            <p class="font-inter text-[9px] font-semibold uppercase tracking-wide text-slate-400">

                                Address

                            </p>


                            <p class="mt-1.5 font-inter text-xs font-semibold leading-5 text-[#172033]">

                                <span id="userAddress">Not provided</span>

                            </p>


                        </div>


                    </div>


                </div>

            </div>



            <!-- =================================================
                 ACCOUNT INFORMATION
                 ================================================= -->

            <div class="rounded-xl border border-slate-200 bg-white">


                <!-- Header -->

                <div class="flex items-center gap-3 border-b border-slate-100 px-6 py-5">


                    <div class="flex h-9 w-9 items-center justify-center rounded-lg bg-blue-50 text-blue-600">


                        <svg
                            class="h-4 w-4"
                            fill="none"
                            stroke="currentColor"
                            stroke-width="1.8"
                            viewBox="0 0 24 24">

                            <rect
                                x="3"
                                y="11"
                                width="18"
                                height="10"
                                rx="2"/>

                            <path
                                stroke-linecap="round"
                                stroke-linejoin="round"
                                d="M7 11V7a5 5 0 0110 0v4"/>

                        </svg>


                    </div>


                    <div>

                        <h2 class="font-manrope text-sm font-bold text-[#172033]">

                            Account Information

                        </h2>


                        <p class="mt-0.5 font-inter text-[10px] text-slate-400">

                            System access information.

                        </p>

                    </div>


                </div>



                <!-- Account -->

                <div class="p-6">


                    <!-- Username -->

                    <div class="mb-5">


                        <p class="mb-2 font-inter text-[9px] font-semibold uppercase tracking-wide text-slate-400">

                            Username

                        </p>


                        <div class="rounded-lg border border-slate-200 bg-slate-50 px-3.5 py-3">

                            <p class="font-inter text-xs font-semibold text-slate-700">

                                @<span id="userUsername">Loading...</span>

                            </p>

                        </div>


                    </div>



                    <!-- =================================================
                         SYSTEM ROLE
                         ================================================= -->

                    <div class="mb-5">


                        <p class="mb-2 font-inter text-[9px] font-semibold uppercase tracking-wide text-slate-400">

                            System Role

                        </p>


                        <div class="flex items-center justify-between rounded-lg border border-slate-200 bg-slate-50 px-3.5 py-3">


                            <!-- Dynamic Role Name -->

                            <span class="font-inter text-xs font-semibold text-slate-700">

                                <span id="roleDisplay">Receptionist</span>

                            </span>


                            <!-- Dynamic Database Role -->

                            <span class="rounded-full bg-blue-50 px-2.5 py-1 font-inter text-[9px] font-semibold text-blue-600">

                                <span id="databaseRole">RECEPTIONIST</span>

                            </span>


                        </div>


                    </div>



                    <!-- First Login -->

                    <div class="mb-5">


                        <p class="mb-2 font-inter text-[9px] font-semibold uppercase tracking-wide text-slate-400">

                            First Login

                        </p>


                        
<div id="firstLoginStatus"
     class="flex items-center gap-2 rounded-lg border border-amber-100 bg-amber-50 px-3.5 py-3">
    <span class="h-2 w-2 rounded-full bg-amber-500"></span>
    <span class="font-inter text-xs font-semibold text-amber-700">Pending</span>
</div>



                    </div>



                    <!-- Status -->

                    <div>


                        <p class="mb-2 font-inter text-[9px] font-semibold uppercase tracking-wide text-slate-400">

                            Account Status

                        </p>


                        
<div id="accountStatus"
     class="flex items-center gap-2 rounded-lg border border-emerald-100 bg-emerald-50 px-3.5 py-3">
    <span class="h-2 w-2 rounded-full bg-emerald-500"></span>
    <span class="font-inter text-xs font-semibold text-emerald-700">Active</span>
</div>



                    </div>


                </div>

            </div>


        </div>



        <!-- =================================================
             ACTIONS
             ================================================= -->

        <div class="mt-5 flex items-center justify-end gap-3 rounded-xl border border-slate-200 bg-white px-6 py-4">


            <a
                href="<%= contextPath %>/admin/users"

                class="rounded-lg border border-slate-200 bg-white px-5 py-2.5 font-inter text-[11px] font-semibold text-slate-600 transition hover:bg-slate-50">

                Back

            </a>


            <a
                href="<%= contextPath %>/admin/edit-user?id=<%= userId %>"

                class="inline-flex items-center gap-2 rounded-lg bg-[#2563EB] px-5 py-2.5 font-inter text-[11px] font-bold text-white shadow-sm transition hover:bg-[#1D4ED8]">


                <svg
                    class="h-4 w-4"
                    fill="none"
                    stroke="currentColor"
                    stroke-width="1.8"
                    viewBox="0 0 24 24">

                    <path
                        stroke-linecap="round"
                        stroke-linejoin="round"
                        d="M12 20h9"/>

                    <path
                        stroke-linecap="round"
                        stroke-linejoin="round"
                        d="M16.5 3.5a2.12 2.12 0 013 3L8 18l-4 1 1-4L16.5 3.5z"/>

                </svg>


                Edit User

            </a>


        </div>


    </main>

</div>



<script>
(function () {

    const contextPath = "<%= contextPath %>";
    const requestedUserId =
        "<%= userId == null ? "" : userId %>" ||
        new URLSearchParams(
            window.location.search
        ).get("userId") ||
        new URLSearchParams(
            window.location.search
        ).get("id") ||
        "";


    /*
     * =========================================================
     * API REQUEST
     * GET /api/users/{id}
     * =========================================================
     */

    async function loadUser() {

        if (!requestedUserId) {

            window.location.href =
                contextPath + "/admin/users";

            return;

        }


        try {

            const response =
                await fetch(
                    contextPath +
                    "/api/users/" +
                    encodeURIComponent(
                        requestedUserId
                    ),
                    {
                        method: "GET",
                        credentials: "same-origin",
                        headers: {
                            "Accept":
                                "application/json"
                        }
                    }
                );


            if (response.status === 401) {

                window.location.href =
                    contextPath + "/login";

                return;

            }


            if (response.status === 403) {

                window.location.href =
                    contextPath + "/admin/users";

                return;

            }


            if (response.status === 404) {

                window.location.href =
                    contextPath + "/admin/users";

                return;

            }


            if (!response.ok) {

                throw new Error(
                    "Failed to load user."
                );

            }


            const data =
                await response.json();


            const user =
                data.user || data;


            if (!user) {

                window.location.href =
                    contextPath + "/admin/users";

                return;

            }


            renderUser(user);

        }
        catch (error) {

            console.error(
                "User details API error:",
                error
            );

            window.location.href =
                contextPath + "/admin/users";

        }

    }


    /*
     * =========================================================
     * SAFE TEXT
     * =========================================================
     */

    function valueOrDefault(
        value,
        fallback
    ) {

        if (
            value === null ||
            value === undefined ||
            String(value).trim() === ""
        ) {

            return fallback;

        }

        return String(value);

    }


    /*
     * =========================================================
     * INITIALS
     * =========================================================
     */

    function getInitials(fullName) {

        const name =
            valueOrDefault(
                fullName,
                "User"
            ).trim();


        const parts =
            name.split(/\s+/);


        if (parts.length >= 2) {

            return (
                parts[0].charAt(0) +
                parts[parts.length - 1].charAt(0)
            ).toUpperCase();

        }


        return (
            parts[0].charAt(0) ||
            "U"
        ).toUpperCase();

    }


    /*
     * =========================================================
     * SUMMARY STATUS
     * =========================================================
     */

    function renderSummaryStatus(
        isActive
    ) {

        const container =
            document.getElementById(
                "summaryStatus"
            );


        if (!container) {
            return;
        }


        if (isActive) {

            container.className =
                "inline-flex w-fit items-center gap-1.5 rounded-full bg-emerald-50 px-3 py-1.5 font-inter text-[10px] font-semibold text-emerald-600";


            container.innerHTML =
                '<span class="h-1.5 w-1.5 rounded-full bg-emerald-500"></span>' +
                'Active';

        }
        else {

            container.className =
                "inline-flex w-fit items-center gap-1.5 rounded-full bg-red-50 px-3 py-1.5 font-inter text-[10px] font-semibold text-red-600";


            container.innerHTML =
                '<span class="h-1.5 w-1.5 rounded-full bg-red-500"></span>' +
                'Inactive';

        }

    }


    /*
     * =========================================================
     * FIRST LOGIN STATUS
     * =========================================================
     */

    function renderFirstLogin(
        firstLogin
    ) {

        const container =
            document.getElementById(
                "firstLoginStatus"
            );


        if (!container) {
            return;
        }


        if (firstLogin) {

            container.className =
                "flex items-center gap-2 rounded-lg border border-amber-100 bg-amber-50 px-3.5 py-3";


            container.innerHTML =
                '<span class="h-2 w-2 rounded-full bg-amber-500"></span>' +
                '<span class="font-inter text-xs font-semibold text-amber-700">' +
                'Pending' +
                '</span>';

        }
        else {

            container.className =
                "flex items-center gap-2 rounded-lg border border-emerald-100 bg-emerald-50 px-3.5 py-3";


            container.innerHTML =
                '<span class="h-2 w-2 rounded-full bg-emerald-500"></span>' +
                '<span class="font-inter text-xs font-semibold text-emerald-700">' +
                'Completed' +
                '</span>';

        }

    }


    /*
     * =========================================================
     * ACCOUNT STATUS
     * =========================================================
     */

    function renderAccountStatus(
        isActive
    ) {

        const container =
            document.getElementById(
                "accountStatus"
            );


        if (!container) {
            return;
        }


        if (isActive) {

            container.className =
                "flex items-center gap-2 rounded-lg border border-emerald-100 bg-emerald-50 px-3.5 py-3";


            container.innerHTML =
                '<span class="h-2 w-2 rounded-full bg-emerald-500"></span>' +
                '<span class="font-inter text-xs font-semibold text-emerald-700">' +
                'Active' +
                '</span>';

        }
        else {

            container.className =
                "flex items-center gap-2 rounded-lg border border-red-100 bg-red-50 px-3.5 py-3";


            container.innerHTML =
                '<span class="h-2 w-2 rounded-full bg-red-500"></span>' +
                '<span class="font-inter text-xs font-semibold text-red-700">' +
                'Inactive' +
                '</span>';

        }

    }


    /*
     * =========================================================
     * RENDER USER
     * =========================================================
     */

    function renderUser(user) {

        const userId =
            Number(
                user.userId || requestedUserId
            );


        const fullName =
            valueOrDefault(
                user.fullName,
                "User"
            );


        const position =
            valueOrDefault(
                user.position,
                "Staff"
            );


        const email =
            valueOrDefault(
                user.email,
                "Not provided"
            );


        const phone =
            valueOrDefault(
                user.phone,
                "Not provided"
            );


        const address =
            valueOrDefault(
                user.address,
                "Not provided"
            );


        const username =
            valueOrDefault(
                user.username,
                ""
            );


        const currentRole =
            valueOrDefault(
                user.role,
                "RECEPTIONIST"
            ).toUpperCase();


        const roleDisplay =
            currentRole === "ADMIN"
                ? "Administrator"
                : "Receptionist";


        const isActive =
            user.active === true;


        const firstLogin =
            user.firstLogin === true;


        /*
         * =====================================================
         * UPDATE PAGE VALUES
         * =====================================================
         */

        document.title =
            fullName +
            " - User Details - Sunrise Dental";


        const initialsElement =
            document.getElementById(
                "userInitials"
            );


        const fullNameElement =
            document.getElementById(
                "userFullName"
            );


        const fullNamePersonalElement =
            document.getElementById(
                "userFullNamePersonal"
            );


        const userIdElement =
            document.getElementById(
                "userIdDisplay"
            );


        const userIdHeaderElement =
            document.getElementById(
                "userIdHeader"
            );


        const positionElement =
            document.getElementById(
                "userPosition"
            );


        const emailElement =
            document.getElementById(
                "userEmail"
            );


        const phoneElement =
            document.getElementById(
                "userPhone"
            );


        const addressElement =
            document.getElementById(
                "userAddress"
            );


        const usernameElement =
            document.getElementById(
                "userUsername"
            );


        const roleDisplayElement =
            document.getElementById(
                "roleDisplay"
            );


        const databaseRoleElement =
            document.getElementById(
                "databaseRole"
            );


        if (initialsElement) {

            initialsElement.textContent =
                getInitials(fullName);

        }


        if (fullNameElement) {

            fullNameElement.textContent =
                fullName;

        }


        if (fullNamePersonalElement) {

            fullNamePersonalElement.textContent =
                fullName;

        }


        const formattedUserId =
            String(userId).padStart(
                3,
                "0"
            );


        if (userIdElement) {

            userIdElement.textContent =
                formattedUserId;

        }


        if (userIdHeaderElement) {

            userIdHeaderElement.textContent =
                formattedUserId;

        }


        if (positionElement) {

            positionElement.textContent =
                position;

        }


        if (emailElement) {

            emailElement.textContent =
                email;

        }


        if (phoneElement) {

            phoneElement.textContent =
                phone;

        }


        if (addressElement) {

            addressElement.textContent =
                address;

        }


        if (usernameElement) {

            usernameElement.textContent =
                username;

        }


        if (roleDisplayElement) {

            roleDisplayElement.textContent =
                roleDisplay;

        }


        if (databaseRoleElement) {

            databaseRoleElement.textContent =
                currentRole;

        }


        /*
         * =====================================================
         * UPDATE STATUS
         * =====================================================
         */

        renderSummaryStatus(
            isActive
        );


        renderFirstLogin(
            firstLogin
        );


        renderAccountStatus(
            isActive
        );


        /*
         * =====================================================
         * UPDATE EDIT LINK
         * =====================================================
         */

        const editLink =
            document.querySelector(
                'a[href*="/admin/edit-user"]'
            );


        if (editLink) {

            editLink.href =
                contextPath +
                "/admin/edit-user?id=" +
                encodeURIComponent(
                    userId
                );

        }

    }


    /*
     * =========================================================
     * START
     * =========================================================
     */

    loadUser();

})();
</script>

</body>

</html>