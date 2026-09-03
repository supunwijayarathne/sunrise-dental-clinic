<%@ page contentType="text/html;charset=UTF-8" %>

<%@ page import="com.sunrise.model.User" %>

<%
    User user = (User) request.getAttribute("user");

    String error = (String) request.getAttribute("error");

    String contextPath = request.getContextPath();

    if (user == null) {
        response.sendRedirect(contextPath + "/admin/users");
        return;
    }

    String currentRole = user.getRole();

    if (currentRole == null || currentRole.trim().isEmpty()) {
        currentRole = "RECEPTIONIST";
    }

    currentRole = currentRole.toUpperCase();

    String roleDisplay;

    if ("ADMIN".equalsIgnoreCase(currentRole)) {
        roleDisplay = "Administrator";
    } else {
        roleDisplay = "Receptionist";
    }
%>

<!DOCTYPE html>

<html lang="en">

<head>

    <meta charset="UTF-8">

    <meta name="viewport"
          content="width=device-width, initial-scale=1.0">

    <title>Edit User - Sunrise Dental</title>


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

                    Edit User

                </span>

            </div>



            <div class="flex items-end justify-between">


                <div>

                    <p class="mb-1 font-inter text-[10px] font-semibold uppercase tracking-[0.12em] text-blue-600">

                        User Management

                    </p>


                    <h1 class="font-manrope text-2xl font-extrabold tracking-tight text-[#172033]">

                        Edit User

                    </h1>


                    <p class="mt-1.5 font-inter text-xs text-slate-500">

                        Update the user's personal information and system role.

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
             ERROR MESSAGE
             ================================================= -->

        <% if (error != null) { %>

            <div class="mb-6 flex items-start gap-3 rounded-xl border border-red-100 bg-red-50 px-4 py-3.5">


                <div class="mt-0.5 shrink-0 text-red-500">

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
                            d="M12 8v4"/>

                        <path
                            stroke-linecap="round"
                            d="M12 16h.01"/>

                    </svg>

                </div>


                <div>

                    <p class="font-inter text-xs font-semibold text-red-700">

                        Unable to update user

                    </p>


                    <p class="mt-0.5 font-inter text-[11px] text-red-600">

                        <%= error %>

                    </p>

                </div>


            </div>

        <% } %>



        <!-- =================================================
             FORM
             ================================================= -->

        <form
            method="post"
            action="<%= contextPath %>/admin/edit-user">


            <!-- Hidden ID -->

            <input
                type="hidden"
                name="userId"
                value="<%= user.getUserId() %>">



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

                                Update the user's basic information.

                            </p>

                        </div>


                    </div>



                    <!-- Fields -->

                    <div class="p-6">


                        <div class="grid grid-cols-1 gap-5 md:grid-cols-2">


                            <!-- Full Name -->

                            <div>

                                <label
                                    for="fullName"
                                    class="mb-2 block font-inter text-[10px] font-semibold uppercase tracking-wide text-slate-500">

                                    Full Name

                                    <span class="text-red-500">
                                        *
                                    </span>

                                </label>


                                <input
                                    type="text"
                                    id="fullName"
                                    name="fullName"

                                    value="<%= user.getFullName() != null
                                            ? user.getFullName()
                                            : "" %>"

                                    required

                                    class="w-full rounded-lg border border-slate-200 bg-white px-3.5 py-2.5 font-inter text-xs text-[#172033] transition focus:border-blue-500 focus:ring-2 focus:ring-blue-100">

                            </div>



                            <!-- Position -->

                            <div>

                                <label
                                    for="position"
                                    class="mb-2 block font-inter text-[10px] font-semibold uppercase tracking-wide text-slate-500">

                                    Position

                                </label>


                                <input
                                    type="text"
                                    id="position"
                                    name="position"

                                    value="<%= user.getPosition() != null &&
                                             !user.getPosition().trim().isEmpty()
                                                ? user.getPosition()
                                                : "Staff" %>"

                                    class="w-full rounded-lg border border-slate-200 bg-white px-3.5 py-2.5 font-inter text-xs text-[#172033] transition focus:border-blue-500 focus:ring-2 focus:ring-blue-100">

                            </div>



                            <!-- System Role -->

                            <div>

                                <label
                                    for="role"
                                    class="mb-2 block font-inter text-[10px] font-semibold uppercase tracking-wide text-slate-500">

                                    System Role

                                    <span class="text-red-500">*</span>

                                </label>


                                <select
                                    id="role"
                                    name="role"
                                    required

                                    class="w-full rounded-lg border border-slate-200 bg-white px-3.5 py-2.5 font-inter text-xs text-[#172033] transition focus:border-blue-500 focus:ring-2 focus:ring-blue-100">


                                    <option
                                        value="RECEPTIONIST"
                                        <%= "RECEPTIONIST".equalsIgnoreCase(currentRole)
                                                ? "selected"
                                                : "" %>>

                                        Receptionist

                                    </option>


                                    <option
                                        value="ADMIN"
                                        <%= "ADMIN".equalsIgnoreCase(currentRole)
                                                ? "selected"
                                                : "" %>>

                                        Administrator

                                    </option>


                                </select>

                                <p class="mt-1.5 font-inter text-[10px] text-slate-400">

                                    Controls the user's system permissions.

                                </p>

                            </div>



                            <!-- Email -->

                            <div>

                                <label
                                    for="email"
                                    class="mb-2 block font-inter text-[10px] font-semibold uppercase tracking-wide text-slate-500">

                                    Email Address

                                </label>


                                <input
                                    type="email"
                                    id="email"
                                    name="email"

                                    value="<%= user.getEmail() != null
                                            ? user.getEmail()
                                            : "" %>"

                                    class="w-full rounded-lg border border-slate-200 bg-white px-3.5 py-2.5 font-inter text-xs text-[#172033] transition focus:border-blue-500 focus:ring-2 focus:ring-blue-100">

                            </div>



                            <!-- Phone -->

                            <div>

                                <label
                                    for="phone"
                                    class="mb-2 block font-inter text-[10px] font-semibold uppercase tracking-wide text-slate-500">

                                    Contact Number

                                </label>


                                <input
                                    type="text"
                                    id="phone"
                                    name="phone"

                                    value="<%= user.getPhone() != null
                                            ? user.getPhone()
                                            : "" %>"

                                    class="w-full rounded-lg border border-slate-200 bg-white px-3.5 py-2.5 font-inter text-xs text-[#172033] transition focus:border-blue-500 focus:ring-2 focus:ring-blue-100">

                            </div>



                            <!-- Address -->

                            <div class="md:col-span-2">

                                <label
                                    for="address"
                                    class="mb-2 block font-inter text-[10px] font-semibold uppercase tracking-wide text-slate-500">

                                    Address

                                </label>


                                <textarea
                                    id="address"
                                    name="address"
                                    rows="3"

                                    class="w-full resize-none rounded-lg border border-slate-200 bg-white px-3.5 py-2.5 font-inter text-xs text-[#172033] transition focus:border-blue-500 focus:ring-2 focus:ring-blue-100"><%= user.getAddress() != null
                                            ? user.getAddress()
                                            : "" %></textarea>

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

                                Current account details.

                            </p>

                        </div>


                    </div>



                    <!-- Account Details -->

                    <div class="p-6">


                        <!-- Username -->

                        <div class="mb-5">


                            <p class="mb-2 font-inter text-[10px] font-semibold uppercase tracking-wide text-slate-500">

                                Username

                            </p>


                            <div class="rounded-lg border border-slate-200 bg-slate-50 px-3.5 py-2.5">

                                <p class="font-inter text-xs font-medium text-slate-600">

                                    @<%= user.getUsername() %>

                                </p>

                            </div>


                            <p class="mt-1.5 font-inter text-[10px] text-slate-400">

                                Username cannot be changed here.

                            </p>


                        </div>



                        <!-- =================================================
                             CURRENT ROLE
                             ================================================= -->

                        <div class="mb-5">


                            <p class="mb-2 font-inter text-[10px] font-semibold uppercase tracking-wide text-slate-500">

                                Current System Role

                            </p>


                            <div
                                id="currentRoleBox"
                                class="flex items-center justify-between rounded-lg border border-slate-200 bg-slate-50 px-3.5 py-2.5">


                                <span
                                    id="currentRoleDisplay"
                                    class="font-inter text-xs font-medium text-slate-600">

                                    <%= roleDisplay %>

                                </span>


                                <span
                                    id="currentRoleBadge"
                                    class="rounded-full bg-blue-50 px-2.5 py-1 font-inter text-[9px] font-semibold text-blue-600">

                                    <%= currentRole %>

                                </span>


                            </div>


                            <p
                                id="roleChangeDescription"
                                class="mt-1.5 font-inter text-[10px] text-slate-400">

                                The selected role controls the user's system permissions.

                            </p>


                        </div>



                        <!-- Status -->

                        <div>


                            <p class="mb-2 font-inter text-[10px] font-semibold uppercase tracking-wide text-slate-500">

                                Account Status

                            </p>


                            <% if (user.isActive()) { %>

                                <div class="flex items-center gap-2 rounded-lg border border-emerald-100 bg-emerald-50 px-3.5 py-2.5">


                                    <span class="h-2 w-2 rounded-full bg-emerald-500"></span>


                                    <span class="font-inter text-xs font-semibold text-emerald-700">

                                        Active

                                    </span>

                                </div>

                            <% } else { %>

                                <div class="flex items-center gap-2 rounded-lg border border-red-100 bg-red-50 px-3.5 py-2.5">


                                    <span class="h-2 w-2 rounded-full bg-red-500"></span>


                                    <span class="font-inter text-xs font-semibold text-red-700">

                                        Inactive

                                    </span>

                                </div>

                            <% } %>


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

                    Cancel

                </a>


                <button
                    type="submit"

                    class="inline-flex items-center gap-2 rounded-lg bg-[#2563EB] px-5 py-2.5 font-inter text-[11px] font-bold text-white shadow-sm transition hover:bg-[#1D4ED8]">


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


                    Save Changes

                </button>


            </div>


        </form>


    </main>

</div>



<!-- =========================================================
     ROLE DISPLAY SCRIPT
     ========================================================= -->

<script>

    const roleSelect = document.getElementById("role");

    const currentRoleDisplay =
        document.getElementById("currentRoleDisplay");

    const currentRoleBadge =
        document.getElementById("currentRoleBadge");

    const roleChangeDescription =
        document.getElementById("roleChangeDescription");


    function updateRoleDisplay() {

        const role = roleSelect.value;


        if (role === "ADMIN") {

            currentRoleDisplay.textContent =
                "Administrator";

            currentRoleBadge.textContent =
                "ADMIN";

            roleChangeDescription.textContent =
                "Administrator access to system management and reports.";

        } else {

            currentRoleDisplay.textContent =
                "Receptionist";

            currentRoleBadge.textContent =
                "RECEPTIONIST";

            roleChangeDescription.textContent =
                "Receptionist access for clinic operational tasks.";

        }

    }


    roleSelect.addEventListener(
        "change",
        updateRoleDisplay
    );


    updateRoleDisplay();

</script>


</body>

</html>