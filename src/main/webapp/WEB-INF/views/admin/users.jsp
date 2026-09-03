<%@ page contentType="text/html;charset=UTF-8" %>

<%@ page import="java.util.List" %>
<%@ page import="com.sunrise.model.User" %>

<%
    List<User> users =
            (List<User>) request.getAttribute("users");

    String success =
            request.getParameter("success");

    String contextPath =
            request.getContextPath();


    // =========================================================
    // SUMMARY COUNTS
    // =========================================================

    int totalUsers = 0;
    int activeUsers = 0;
    int inactiveUsers = 0;

    if (users != null) {

        totalUsers = users.size();

        for (User user : users) {

            if (user.isActive()) {
                activeUsers++;
            } else {
                inactiveUsers++;
            }
        }
    }
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

        <% if ("added".equals(success)) { %>

            <div class="mb-5 flex items-center gap-3 rounded-xl border border-emerald-100 bg-emerald-50 px-4 py-3.5">


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

        <% } %>



        <% if ("updated".equals(success)) { %>

            <div class="mb-5 flex items-center gap-3 rounded-xl border border-emerald-100 bg-emerald-50 px-4 py-3.5">


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

        <% } %>



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

                            <%= totalUsers %>

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

                            <%= activeUsers %>

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

                            <%= inactiveUsers %>

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

                    <%= totalUsers %> user<%= totalUsers == 1 ? "" : "s" %>

                </div>


            </div>



            <!-- Table -->

            <% if (users != null && !users.isEmpty()) { %>


                <div class="overflow-x-auto">


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



                        <tbody>


                        <%

                            for (User user : users) {

                        %>


                        <tr class="border-b border-slate-100 last:border-0 transition hover:bg-slate-50/50">


                            <!-- User ID -->

                            <td class="px-5 py-4">


                                <span class="font-inter text-[11px] font-semibold text-blue-600">

                                    EMP<%= String.format(
                                            "%03d",
                                            user.getUserId()) %>

                                </span>


                            </td>



                            <!-- User -->

                            <td class="px-5 py-4">


                                <div class="flex items-center gap-3">


                                    <div class="flex h-8 w-8 shrink-0 items-center justify-center rounded-lg bg-blue-50 font-manrope text-[11px] font-bold text-blue-600">

                                        <%= user.getFullName() != null
                                                ? user.getFullName()
                                                    .substring(0, 1)
                                                    .toUpperCase()
                                                : "R" %>

                                    </div>


                                    <div>

                                        <p class="font-inter text-[11px] font-semibold text-[#172033]">

                                            <%= user.getFullName() %>

                                        </p>


                                        <p class="mt-0.5 font-inter text-[9px] text-slate-400">

                                            @<%= user.getUsername() %>

                                        </p>

                                    </div>


                                </div>


                            </td>



                            <!-- Position -->

                            <td class="px-5 py-4">


                                <span class="font-inter text-[11px] font-medium text-slate-600">

                                    <%= user.getPosition() != null
                                            && !user.getPosition().isEmpty()
                                                ? user.getPosition()
                                                : "Receptionist" %>

                                </span>


                            </td>



                            <!-- Contact -->

                            <td class="px-5 py-4">


                                <p class="font-inter text-[10px] font-medium text-slate-600">

                                    <%= user.getEmail() != null
                                            && !user.getEmail().isEmpty()
                                                ? user.getEmail()
                                                : "No email" %>

                                </p>


                                <p class="mt-1 font-inter text-[9px] text-slate-400">

                                    <%= user.getPhone() != null
                                            && !user.getPhone().isEmpty()
                                                ? user.getPhone()
                                                : "No phone" %>

                                </p>


                            </td>



                            <!-- Status -->

                            <td class="px-5 py-4">


                                <% if (user.isActive()) { %>


                                    <span class="inline-flex items-center gap-1.5 rounded-full bg-emerald-50 px-2.5 py-1 font-inter text-[9px] font-semibold text-emerald-600">

                                        <span class="h-1.5 w-1.5 rounded-full bg-emerald-500"></span>

                                        Active

                                    </span>


                                <% } else { %>


                                    <span class="inline-flex items-center gap-1.5 rounded-full bg-red-50 px-2.5 py-1 font-inter text-[9px] font-semibold text-red-600">

                                        <span class="h-1.5 w-1.5 rounded-full bg-red-500"></span>

                                        Inactive

                                    </span>


                                <% } %>


                            </td>



                            <!-- Actions -->

                            <td class="px-5 py-4">


                                <div class="flex items-center justify-end gap-2">


                                    <!-- View -->

                                    <a
                                        href="<%= contextPath %>/admin/users?action=view&id=<%= user.getUserId() %>"

                                        class="rounded-lg bg-blue-50 px-3 py-1.5 font-inter text-[9px] font-semibold text-blue-600 transition hover:bg-blue-100">

                                        View

                                    </a>



                                    <!-- Edit -->

                                    <a
                                        href="<%= contextPath %>/admin/edit-user?id=<%= user.getUserId() %>"

                                        class="rounded-lg bg-slate-100 px-3 py-1.5 font-inter text-[9px] font-semibold text-slate-600 transition hover:bg-slate-200">

                                        Edit

                                    </a>



                                    <!-- Activate / Deactivate -->

                                    <form
                                        method="post"
                                        action="<%= contextPath %>/admin/user-status"
                                        class="m-0">


                                        <input
                                            type="hidden"
                                            name="id"
                                            value="<%= user.getUserId() %>">


                                        <% if (user.isActive()) { %>


                                            <input
                                                type="hidden"
                                                name="status"
                                                value="deactivate">


                                            <button
                                                type="submit"

                                                class="rounded-lg bg-red-50 px-3 py-1.5 font-inter text-[9px] font-semibold text-red-600 transition hover:bg-red-100"

                                                onclick="return confirm('Are you sure you want to deactivate this receptionist?');">

                                                Deactivate

                                            </button>


                                        <% } else { %>


                                            <input
                                                type="hidden"
                                                name="status"
                                                value="activate">


                                            <button
                                                type="submit"

                                                class="rounded-lg bg-emerald-50 px-3 py-1.5 font-inter text-[9px] font-semibold text-emerald-600 transition hover:bg-emerald-100">

                                                Activate

                                            </button>


                                        <% } %>


                                    </form>


                                </div>


                            </td>


                        </tr>


                        <%

                            }

                        %>


                        </tbody>


                    </table>


                </div>


            <% } else { %>


                <!-- =================================================
                     EMPTY STATE
                     ================================================= -->

                <div class="px-6 py-16 text-center">


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


            <% } %>


        </div>


    </main>


</div>


</body>

</html>