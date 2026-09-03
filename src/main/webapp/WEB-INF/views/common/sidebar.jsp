<%@ page import="com.sunrise.model.User" %>

<%

    String contextPath = request.getContextPath();

    String currentPage =
            request.getRequestURI().substring(
                    contextPath.length()
            );


    // =========================================================
    // LOGGED-IN USER
    // =========================================================

    User loggedUser =
            (User) session.getAttribute("loggedUser");


    boolean isAdmin =
            loggedUser != null &&
            "ADMIN".equalsIgnoreCase(
                    loggedUser.getRole()
            );


    // =========================================================
    // DASHBOARD URL
    // =========================================================

    String dashboardUrl;

    if (isAdmin) {

        dashboardUrl =
                contextPath + "/admin/dashboard";

    } else {

        dashboardUrl =
                contextPath + "/dashboard";

    }


    // =========================================================
    // ACTIVE PAGE DETECTION
    // =========================================================

    boolean dashboardActive;

    if (isAdmin) {

        dashboardActive =
                currentPage.equals(
                        "/admin/dashboard"
                );

    } else {

        dashboardActive =
                currentPage.equals(
                        "/dashboard"
                );

    }


    boolean patientsActive =
            currentPage.startsWith(
                    "/patients"
            );


    boolean dentistsActive =
            currentPage.startsWith(
                    "/dentists"
            );


    boolean treatmentsActive =
            currentPage.startsWith(
                    "/treatments"
            );


    boolean appointmentsActive =
            currentPage.startsWith(
                    "/appointments"
            );


    boolean billsActive =
            currentPage.startsWith(
                    "/bills"
            );


    boolean reportsActive =
            currentPage.startsWith(
                    "/reports"
            );
    boolean helpActive =
            currentPage.startsWith(
                    "/help"
            );


    boolean usersActive =
            currentPage.startsWith(
                    "/admin/users"
            ) ||
            currentPage.startsWith(
                    "/admin/add-user"
            ) ||
            currentPage.startsWith(
                    "/admin/edit-user"
            );

%>


<aside
    class="fixed left-0 top-0 z-50 flex h-screen w-[250px] flex-col bg-[#111827] px-4 py-6">


    <!-- =====================================================
         BRAND
    ====================================================== -->

    <!-- =====================================================
     BRAND
====================================================== -->

<div class="mb-8 px-3">

    <!-- Logo + Brand Name -->

    <div class="flex items-center gap-3">

        <img
            src="<%= contextPath %>/assets/images/sunrise-logo.png"
            alt="Sunrise Dental Logo"
            class="h-9 w-9 object-contain"
        />

        <div class="min-w-0">

            <h1
                class="font-manrope text-[16px] font-extrabold
                       tracking-tight text-white leading-tight">

                Sunrise Dental

            </h1>

            <p
                class="mt-0.5 font-inter text-[9px] font-medium
                       text-slate-500">

                Clinic Management System

            </p>

        </div>

    </div>

</div>



    <!-- =====================================================
         MAIN MENU
    ====================================================== -->

    <div class="mb-6">

        <p
            class="mb-2 px-3 font-inter text-[10px] font-semibold uppercase tracking-[0.12em] text-slate-500">

            Main Menu

        </p>


        <nav class="space-y-1">


            <!-- =================================================
                 DASHBOARD
            ================================================== -->

            <a
                href="<%= dashboardUrl %>"
                class="flex items-center gap-3 rounded-lg px-3 py-2.5 text-[13px] font-semibold transition
                <%= dashboardActive
                    ? "text-white"
                    : "text-slate-400 hover:bg-[#1f2937] hover:text-white" %>"
                style="<%= dashboardActive
                    ? "background-color: #2563EB;"
                    : "" %>"
            >

                <svg
                    class="h-[17px] w-[17px] shrink-0"
                    fill="none"
                    stroke="currentColor"
                    stroke-width="1.8"
                    viewBox="0 0 24 24">

                    <path
                        stroke-linecap="round"
                        stroke-linejoin="round"
                        d="M3 12l9-9 9 9M5 10v10h14V10"/>

                </svg>

                Dashboard

            </a>



            <!-- =================================================
                 PATIENTS
            ================================================== -->

            <a
                href="<%= contextPath %>/patients"
                class="flex items-center gap-3 rounded-lg px-3 py-2.5 text-[13px] font-semibold transition
                <%= patientsActive
                    ? "text-white"
                    : "text-slate-400 hover:bg-[#1f2937] hover:text-white" %>"
                style="<%= patientsActive
                    ? "background-color: #2563EB;"
                    : "" %>"
            >

                <svg
                    class="h-[17px] w-[17px] shrink-0"
                    fill="none"
                    stroke="currentColor"
                    stroke-width="1.8"
                    viewBox="0 0 24 24">

                    <path
                        stroke-linecap="round"
                        stroke-linejoin="round"
                        d="M16 21v-2a4 4 0 00-4-4H6a4 4 0 00-4 4v2M9 11a4 4 0 100-8 4 4 0 000 8zM22 21v-2a4 4 0 00-3-3.87M16 3.13a4 4 0 010 7.75"/>

                </svg>

                Patients

            </a>



            <!-- =================================================
                 DENTISTS
            ================================================== -->

            <a
                href="<%= contextPath %>/dentists"
                class="flex items-center gap-3 rounded-lg px-3 py-2.5 text-[13px] font-semibold transition
                <%= dentistsActive
                    ? "text-white"
                    : "text-slate-400 hover:bg-[#1f2937] hover:text-white" %>"
                style="<%= dentistsActive
                    ? "background-color: #2563EB;"
                    : "" %>"
            >

                <svg
                    class="h-[17px] w-[17px] shrink-0"
                    fill="none"
                    stroke="currentColor"
                    stroke-width="1.8"
                    viewBox="0 0 24 24">

                    <path
                        stroke-linecap="round"
                        stroke-linejoin="round"
                        d="M12 3v18M3 12h18"/>

                </svg>

                Dentists

            </a>



            <!-- =================================================
                 TREATMENTS
            ================================================== -->

            <a
                href="<%= contextPath %>/treatments"
                class="flex items-center gap-3 rounded-lg px-3 py-2.5 text-[13px] font-semibold transition
                <%= treatmentsActive
                    ? "text-white"
                    : "text-slate-400 hover:bg-[#1f2937] hover:text-white" %>"
                style="<%= treatmentsActive
                    ? "background-color: #2563EB;"
                    : "" %>"
            >

                <svg
                    class="h-[17px] w-[17px] shrink-0"
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

                Treatments

            </a>



            <!-- =================================================
                 APPOINTMENTS
            ================================================== -->

            <a
                href="<%= contextPath %>/appointments"
                class="flex items-center gap-3 rounded-lg px-3 py-2.5 text-[13px] font-semibold transition
                <%= appointmentsActive
                    ? "text-white"
                    : "text-slate-400 hover:bg-[#1f2937] hover:text-white" %>"
                style="<%= appointmentsActive
                    ? "background-color: #2563EB;"
                    : "" %>"
            >

                <svg
                    class="h-[17px] w-[17px] shrink-0"
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

                Appointments

            </a>



            <!-- =================================================
                 BILLING
            ================================================== -->

            <a
                href="<%= contextPath %>/bills"
                class="flex items-center gap-3 rounded-lg px-3 py-2.5 text-[13px] font-semibold transition
                <%= billsActive
                    ? "text-white"
                    : "text-slate-400 hover:bg-[#1f2937] hover:text-white" %>"
                style="<%= billsActive
                    ? "background-color: #2563EB;"
                    : "" %>"
            >

                <svg
                    class="h-[17px] w-[17px] shrink-0"
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

                Billing

            </a>


        </nav>

    </div>



    <!-- =====================================================
         MANAGEMENT
    ====================================================== -->

    <div>

        <% if (isAdmin) { %>

    <p
        class="mb-2 px-3 font-inter text-[10px] font-semibold uppercase tracking-[0.12em] text-slate-500">

        Management

    </p>

<% } %>


        <nav class="space-y-1">


            <!-- =================================================
                 USERS
            ================================================== -->

            <% if (isAdmin) { %>

                <a
                    href="<%= contextPath %>/admin/users"
                    class="flex items-center gap-3 rounded-lg px-3 py-2.5 text-[13px] font-semibold transition
                    <%= usersActive
                        ? "text-white"
                        : "text-slate-400 hover:bg-[#1f2937] hover:text-white" %>"
                    style="<%= usersActive
                        ? "background-color: #2563EB;"
                        : "" %>"
                >

                    <svg
                        class="h-[17px] w-[17px] shrink-0"
                        fill="none"
                        stroke="currentColor"
                        stroke-width="1.8"
                        viewBox="0 0 24 24">

                        <path
                            stroke-linecap="round"
                            stroke-linejoin="round"
                            d="M16 21v-2a4 4 0 00-4-4H6a4 4 0 00-4 4v2M9 11a4 4 0 100-8 4 4 0 000 8zM19 8v6M22 11h-6"/>

                    </svg>

                    Users

                </a>

            <% } %>



            <!-- =================================================
     REPORTS
================================================== -->

<% if (isAdmin) { %>

    <a
        href="<%= contextPath %>/reports"
        class="flex items-center gap-3 rounded-lg px-3 py-2.5 text-[13px] font-semibold transition
        <%= reportsActive
            ? "text-white"
            : "text-slate-400 hover:bg-[#1f2937] hover:text-white" %>"
        style="<%= reportsActive
            ? "background-color: #2563EB;"
            : "" %>"
    >

        <svg
            class="h-[17px] w-[17px] shrink-0"
            fill="none"
            stroke="currentColor"
            stroke-width="1.8"
            viewBox="0 0 24 24">

            <path
                stroke-linecap="round"
                stroke-linejoin="round"
                d="M4 19V5M4 19h17"
            />

            <path
                stroke-linecap="round"
                d="M8 16v-5M12 16V7M16 16v-8"
            />

        </svg>

        Reports

    </a>

<% } %>


        </nav>

    </div>
    
    <!-- =================================================
     HELP
================================================== -->

<a
    href="<%= contextPath %>/help"
    class="flex items-center gap-3 rounded-lg px-3 py-2.5 text-[13px] font-semibold transition
    <%= helpActive
        ? "text-white"
        : "text-slate-400 hover:bg-[#1f2937] hover:text-white" %>"
    style="<%= helpActive
        ? "background-color: #2563EB;"
        : "" %>"
>

    <svg
        class="h-[17px] w-[17px] shrink-0"
        fill="none"
        stroke="currentColor"
        stroke-width="1.8"
        viewBox="0 0 24 24">

        <circle
            cx="12"
            cy="12"
            r="9">
        </circle>

        <path
            stroke-linecap="round"
            stroke-linejoin="round"
            d="M9.5 9a2.5 2.5 0 015 0c0 1.5-2.5 2-2.5 3.5">
        </path>

        <path
            stroke-linecap="round"
            d="M12 16.5h.01">
        </path>

    </svg>

    Help

</a>



    <!-- =====================================================
         PROFILE + LOGOUT
    ====================================================== -->

    <div
        class="mt-auto border-t border-white/[0.06] pt-4">

        <% if (loggedUser != null) { %>

            <%
                String profileName = loggedUser.getFullName();

                if (profileName == null || profileName.trim().isEmpty()) {
                    profileName = loggedUser.getUsername();
                }

                String[] nameParts = profileName.trim().split("\\s+");
                String initials = "";

                if (nameParts.length > 0 && !nameParts[0].isEmpty()) {
                    initials += nameParts[0].substring(0, 1).toUpperCase();
                }

                if (nameParts.length > 1 && !nameParts[nameParts.length - 1].isEmpty()) {
                    initials += nameParts[nameParts.length - 1].substring(0, 1).toUpperCase();
                }

                if (initials.isEmpty()) {
                    initials = "U";
                }

                String displayRole = loggedUser.getRole();

                if (displayRole == null || displayRole.trim().isEmpty()) {
                    displayRole = "User";
                } else if ("ADMIN".equalsIgnoreCase(displayRole.trim())) {
                    displayRole = "Administrator";
                } else if ("RECEPTIONIST".equalsIgnoreCase(displayRole.trim())) {
                    displayRole = "Receptionist";
                }
            %>

            <!-- PROFILE -->

            <div
                class="mb-3 flex items-center gap-3 rounded-xl border border-white/[0.06] bg-white/[0.04] px-3 py-3">

                <div
                    class="flex h-9 w-9 shrink-0 items-center justify-center rounded-full border border-white/[0.06] bg-[#111827] text-[11px] font-bold text-white">

                    <%= initials %>

                </div>

                <div class="min-w-0 flex-1">

                    <p
                        class="truncate font-manrope text-[12px] font-semibold text-white">

                        <%= profileName %>

                    </p>

                    <p
                        class="mt-0.5 truncate font-manrope text-[10px] font-medium text-slate-500">

                        <%= displayRole %>

                    </p>

                </div>

            </div>

        <% } %>


        <!-- LOGOUT -->

        <a
            href="<%= contextPath %>/logout"
            class="flex items-center gap-3 rounded-lg px-3 py-2.5 text-[13px] font-semibold text-slate-400 transition hover:bg-[#1f2937] hover:text-white"
        >

            <svg
                class="h-[17px] w-[17px]"
                fill="none"
                stroke="currentColor"
                stroke-width="1.8"
                viewBox="0 0 24 24">

                <path
                    stroke-linecap="round"
                    stroke-linejoin="round"
                    d="M10 17l5-5-5-5M15 12H3"/>

                <path
                    stroke-linecap="round"
                    stroke-linejoin="round"
                    d="M21 19V5a2 2 0 00-2-2h-7"/>

            </svg>

            Logout

        </a>


    </div>
    
    <jsp:include page="/WEB-INF/views/common/cookie-banner.jsp" />


</aside>