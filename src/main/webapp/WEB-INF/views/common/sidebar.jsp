<%
    String contextPath = request.getContextPath();

    String currentPage =
            request.getRequestURI().substring(
                    contextPath.length()
            );


    // =========================================================
    // ACTIVE PAGE DETECTION
    // =========================================================

    boolean dashboardActive;

    // Dashboard can be different for admin/receptionist.
    // Keep the existing URL structure.
    dashboardActive =
            currentPage.equals("/dashboard") ||
            currentPage.equals("/admin/dashboard");


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

    <div class="mb-8 px-3">

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
                id="dashboardLink"
                href="<%= contextPath %>/dashboard"
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

    <div id="managementSection">

        <p
            id="managementTitle"
            class="mb-2 px-3 font-inter text-[10px] font-semibold uppercase tracking-[0.12em] text-slate-500">

            Management

        </p>


        <nav class="space-y-1">


            <!-- =================================================
                 USERS
            ================================================== -->

            <a
                id="usersLink"
                href="<%= contextPath %>/admin/users"
                class="hidden flex items-center gap-3 rounded-lg px-3 py-2.5 text-[13px] font-semibold transition"
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


            <!-- =================================================
                 REPORTS
            ================================================== -->

            <a
                id="reportsLink"
                href="<%= contextPath %>/reports"
                class="hidden flex items-center gap-3 rounded-lg px-3 py-2.5 text-[13px] font-semibold transition"
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


        <!-- =================================================
             PROFILE
        ================================================== -->

        <div
            id="sidebarProfile"
            class="mb-3 flex items-center gap-3 rounded-xl border border-white/[0.06] bg-white/[0.04] px-3 py-3">

            <div
                id="profileInitials"
                class="flex h-9 w-9 shrink-0 items-center justify-center rounded-full border border-white/[0.06] bg-[#111827] text-[11px] font-bold text-white">

                U

            </div>

            <div class="min-w-0 flex-1">

                <p
                    id="profileName"
                    class="truncate font-manrope text-[12px] font-semibold text-white">

                    Loading...

                </p>

                <p
                    id="profileRole"
                    class="mt-0.5 truncate font-manrope text-[10px] font-medium text-slate-500">

                    User

                </p>

            </div>

        </div>


        <!-- =================================================
             LOGOUT
        ================================================== -->

        <a
            href="#"
            id="logoutLink"
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


<!-- =========================================================
     SIDEBAR API
========================================================== -->

<script>

(function () {

    const contextPath = "<%= contextPath %>";


    /*
     * ========================================================
     * LOAD CURRENT USER
     * GET /api/auth/me
     * ========================================================
     */

    async function loadCurrentUser() {

        try {

            const response = await fetch(
                contextPath + "/api/auth/me",
                {
                    method: "GET",
                    credentials: "same-origin",
                    headers: {
                        "Accept": "application/json"
                    }
                }
            );


            if (!response.ok) {

                if (response.status === 401) {

                    window.location.href =
                        contextPath + "/login";

                    return;

                }

                throw new Error(
                    "Failed to load current user"
                );

            }


            const data =
                await response.json();


            /*
             * API response can contain the user
             * directly or inside "user".
             */

            const user =
                data.user || data;


            if (!user) {
                return;
            }


            /*
             * =================================================
             * USER NAME
             * =================================================
             */

            let profileName =
                user.fullName ||
                user.username ||
                "User";


            /*
             * =================================================
             * ROLE
             * =================================================
             */

            let role =
                user.role ||
                "User";


            let displayRole =
                role;


            if (
                role.toUpperCase() ===
                "ADMIN"
            ) {

                displayRole =
                    "Administrator";

            }
            else if (
                role.toUpperCase() ===
                "RECEPTIONIST"
            ) {

                displayRole =
                    "Receptionist";

            }


            /*
             * =================================================
             * INITIALS
             * =================================================
             */

            const nameParts =
                profileName
                    .trim()
                    .split(/\s+/);


            let initials = "";


            if (
                nameParts.length > 0 &&
                nameParts[0]
            ) {

                initials +=
                    nameParts[0]
                        .substring(0, 1)
                        .toUpperCase();

            }


            if (
                nameParts.length > 1 &&
                nameParts[nameParts.length - 1]
            ) {

                initials +=
                    nameParts[nameParts.length - 1]
                        .substring(0, 1)
                        .toUpperCase();

            }


            if (!initials) {

                initials = "U";

            }


            /*
             * =================================================
             * UPDATE PROFILE
             * =================================================
             */

            const profileNameElement =
                document.getElementById(
                    "profileName"
                );


            const profileRoleElement =
                document.getElementById(
                    "profileRole"
                );


            const profileInitialsElement =
                document.getElementById(
                    "profileInitials"
                );


            if (profileNameElement) {

                profileNameElement.textContent =
                    profileName;

            }


            if (profileRoleElement) {

                profileRoleElement.textContent =
                    displayRole;

            }


            if (profileInitialsElement) {

                profileInitialsElement.textContent =
                    initials;

            }


            /*
             * =================================================
             * ADMIN MENU
             * =================================================
             */

            const usersLink =
                document.getElementById(
                    "usersLink"
                );


            const reportsLink =
                document.getElementById(
                    "reportsLink"
                );


            const managementTitle =
                document.getElementById(
                    "managementTitle"
                );


            const isAdmin =
                role.toUpperCase() ===
                "ADMIN";


            if (isAdmin) {

                /*
                 * Users
                 */

                if (usersLink) {

                    usersLink.classList.remove(
                        "hidden"
                    );


                    usersLink.classList.add(
                        "text-slate-400",
                        "hover:bg-[#1f2937]",
                        "hover:text-white"
                    );


                    <% if (usersActive) { %>

                    usersLink.classList.remove(
                        "text-slate-400"
                    );

                    usersLink.classList.add(
                        "text-white"
                    );

                    usersLink.style.backgroundColor =
                        "#2563EB";

                    <% } %>

                }


                /*
                 * Reports
                 */

                if (reportsLink) {

                    reportsLink.classList.remove(
                        "hidden"
                    );


                    reportsLink.classList.add(
                        "text-slate-400",
                        "hover:bg-[#1f2937]",
                        "hover:text-white"
                    );


                    <% if (reportsActive) { %>

                    reportsLink.classList.remove(
                        "text-slate-400"
                    );

                    reportsLink.classList.add(
                        "text-white"
                    );

                    reportsLink.style.backgroundColor =
                        "#2563EB";

                    <% } %>

                }


                if (managementTitle) {

                    managementTitle.classList.remove(
                        "hidden"
                    );

                }


                /*
                 * Admin dashboard
                 */

                const dashboardLink =
                    document.getElementById(
                        "dashboardLink"
                    );


                if (dashboardLink) {

                    dashboardLink.href =
                        contextPath +
                        "/admin/dashboard";

                }

            }
            else {

                /*
                 * Hide management title when
                 * there are no management items.
                 */

                if (managementTitle) {

                    managementTitle.classList.add(
                        "hidden"
                    );

                }

            }

        }
        catch (error) {

            console.error(
                "Sidebar user API error:",
                error
            );

        }

    }


    /*
     * ========================================================
     * LOGOUT
     * POST /api/auth/logout
     * ========================================================
     */

    const logoutLink =
        document.getElementById(
            "logoutLink"
        );


    if (logoutLink) {

        logoutLink.addEventListener(
            "click",
            async function (event) {

                event.preventDefault();


                try {

                    const response =
                        await fetch(
                            contextPath +
                            "/api/auth/logout",
                            {
                                method: "POST",
                                credentials: "same-origin",
                                headers: {
                                    "Accept":
                                        "application/json"
                                }
                            }
                        );


                    /*
                     * Redirect regardless of
                     * successful API response.
                     */

                    if (
                        response.ok ||
                        response.status === 401
                    ) {

                        window.location.href =
                            contextPath + "/login";

                        return;

                    }


                    /*
                     * If API returned an error,
                     * still redirect to login.
                     */

                    window.location.href =
                        contextPath + "/login";

                }
                catch (error) {

                    console.error(
                        "Logout API error:",
                        error
                    );


                    /*
                     * Fallback
                     */

                    window.location.href =
                        contextPath + "/login";

                }

            }
        );

    }


    /*
     * ========================================================
     * START
     * ========================================================
     */

    loadCurrentUser();

})();

</script>