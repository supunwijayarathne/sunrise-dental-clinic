<%@ page language="java"
    contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="java.util.List" %>
<%@ page import="com.sunrise.model.Dentist" %>

<%
    List<Dentist> dentists =
        (List<Dentist>) request.getAttribute("dentists");

    String keyword =
        (String) request.getAttribute("keyword");
%>

<!DOCTYPE html>

<html lang="en">

<head>

    <meta charset="UTF-8">

    <meta name="viewport"
          content="width=device-width, initial-scale=1.0">

    <title>
        Dentists | Sunrise Dental Clinic
    </title>


    <!-- Tailwind CSS -->

    <script src="https://cdn.tailwindcss.com"></script>


    <!-- Tailwind Config -->

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


    <!-- Fonts -->

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

        <div class="mb-7 flex items-center justify-between">


            <div>


                <p class="mb-1 font-inter text-[10px] font-semibold uppercase tracking-[0.12em] text-slate-400">
                    Clinic Management
                </p>


                <h1 class="text-[25px] font-extrabold tracking-[-0.7px]">
                    Dentists
                </h1>


                <p class="mt-1 font-inter text-xs text-slate-500">
                    Manage dentists and their clinic information.
                </p>


            </div>



            <!-- ADD BUTTON -->

            <a
                href="<%= request.getContextPath() %>/dentists/add"
                class="flex items-center gap-2 rounded-lg bg-[#2563EB] px-4 py-2.5 font-inter text-[10px] font-bold text-white shadow-sm transition hover:bg-[#1D4ED8]"
            >


                <svg
                    class="h-3.5 w-3.5"
                    fill="none"
                    stroke="currentColor"
                    stroke-width="2"
                    viewBox="0 0 24 24"
                >

                    <path
                        stroke-linecap="round"
                        stroke-linejoin="round"
                        d="M12 5v14M5 12h14"
                    />

                </svg>


                Add Dentist


            </a>


        </div>



        <!-- SUCCESS -->

        <% if ("1".equals(request.getParameter("success"))) { %>


            <div class="mb-5 flex items-center gap-3 rounded-lg border border-emerald-100 bg-emerald-50 px-4 py-3">


                <div class="flex h-5 w-5 items-center justify-center rounded-full bg-emerald-100 font-inter text-[10px] font-bold text-emerald-600">
                    ✓
                </div>


                <p class="font-inter text-[10px] font-semibold text-emerald-700">
                    Dentist added successfully.
                </p>


            </div>


        <% } %>



        <% if ("1".equals(request.getParameter("updated"))) { %>


            <div class="mb-5 flex items-center gap-3 rounded-lg border border-emerald-100 bg-emerald-50 px-4 py-3">


                <div class="flex h-5 w-5 items-center justify-center rounded-full bg-emerald-100 font-inter text-[10px] font-bold text-emerald-600">
                    ✓
                </div>


                <p class="font-inter text-[10px] font-semibold text-emerald-700">
                    Dentist updated successfully.
                </p>


            </div>


        <% } %>



        <!-- SEARCH CARD -->

        <div class="mb-5 rounded-xl border border-slate-200 bg-white p-4">


            <form
                method="get"
                action="<%= request.getContextPath() %>/dentists"
                class="flex items-center gap-3"
            >


                <!-- SEARCH INPUT -->

                <div class="relative flex-1">


                    <svg
                        class="pointer-events-none absolute left-3 top-1/2 h-4 w-4 -translate-y-1/2 text-slate-400"
                        fill="none"
                        stroke="currentColor"
                        stroke-width="1.8"
                        viewBox="0 0 24 24"
                    >

                        <circle
                            cx="11"
                            cy="11"
                            r="7"
                        />

                        <path
                            stroke-linecap="round"
                            d="m20 20-4-4"
                        />

                    </svg>


                    <input
                        type="text"
                        name="keyword"
                        placeholder="Search by name, specialization, phone or email..."
                        value="<%= keyword != null ? keyword : "" %>"
                        class="w-full rounded-lg border border-slate-200 bg-slate-50 py-2.5 pl-10 pr-3 font-inter text-[10px] outline-none transition placeholder:text-slate-400 focus:border-blue-500 focus:bg-white focus:ring-4 focus:ring-blue-50"
                    >


                </div>



                <!-- SEARCH -->

                <button
                    type="submit"
                    class="rounded-lg bg-[#172033] px-5 py-2.5 font-inter text-[10px] font-semibold text-white transition hover:bg-[#263248]"
                >
                    Search
                </button>



                <!-- CLEAR -->

                <% if (keyword != null
                        && !keyword.trim().isEmpty()) { %>


                    <a
                        href="<%= request.getContextPath() %>/dentists"
                        class="rounded-lg border border-slate-200 bg-white px-4 py-2.5 font-inter text-[10px] font-semibold text-slate-600 transition hover:bg-slate-50"
                    >
                        Clear
                    </a>


                <% } %>


            </form>


        </div>



        <!-- STATS -->

        <div class="mb-4 flex items-center justify-between">


            <div>


                <p class="font-inter text-[10px] text-slate-400">
                    Total Dentists
                </p>


                <p class="mt-0.5 text-lg font-extrabold">

                    <%= dentists != null
                        ? dentists.size()
                        : 0 %>

                </p>


            </div>


            <% if (keyword != null
                    && !keyword.trim().isEmpty()) { %>


                <p class="font-inter text-[10px] text-slate-400">

                    Search results for

                    <span class="font-semibold text-slate-600">
                        "<%= keyword %>"
                    </span>

                </p>


            <% } %>


        </div>



        <!-- TABLE CARD -->

        <div class="overflow-hidden rounded-xl border border-slate-200 bg-white">


            <% if (dentists != null && !dentists.isEmpty()) { %>


                <div class="overflow-x-auto">


                    <table class="w-full min-w-[950px]">


                        <!-- TABLE HEADER -->

                        <thead>


                            <tr class="border-b border-slate-100 bg-slate-50/70">


                                <th class="px-5 py-3 text-left font-inter text-[9px] font-semibold uppercase tracking-wide text-slate-400">
                                    Dentist
                                </th>


                                <th class="px-5 py-3 text-left font-inter text-[9px] font-semibold uppercase tracking-wide text-slate-400">
                                    Specialization
                                </th>


                                <th class="px-5 py-3 text-left font-inter text-[9px] font-semibold uppercase tracking-wide text-slate-400">
                                    Consultation
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



                        <!-- TABLE BODY -->

                        <tbody class="divide-y divide-slate-100">


                        <% for (Dentist dentist : dentists) { %>


                            <tr class="transition hover:bg-slate-50/60">


                                <!-- DENTIST -->

                                <td class="px-5 py-4">


                                    <div class="flex items-center gap-3">


                                        <!-- AVATAR -->

                                        <div class="flex h-9 w-9 shrink-0 items-center justify-center rounded-lg bg-blue-50 text-[11px] font-extrabold text-blue-600">


                                            <%= dentist.getDentistName()
                                                != null
                                                && !dentist.getDentistName().isBlank()
                                                ? dentist.getDentistName()
                                                    .substring(0, 1)
                                                    .toUpperCase()
                                                : "D" %>


                                        </div>


                                        <div>


                                            <p class="text-[11px] font-bold text-slate-800">

                                                <%= dentist.getDentistName() %>

                                            </p>


                                            <p class="mt-0.5 font-inter text-[8px] text-slate-400">

                                                ID #<%= dentist.getDentistId() %>

                                            </p>


                                        </div>


                                    </div>


                                </td>



                                <!-- SPECIALIZATION -->

                                <td class="px-5 py-4">


                                    <span class="font-inter text-[10px] font-medium text-slate-600">

                                        <%= dentist.getSpecialization() %>

                                    </span>


                                </td>



                                <!-- FEE -->

                                <td class="px-5 py-4">


                                    <p class="font-inter text-[10px] font-semibold text-slate-700">


                                        LKR
                                        <%= String.format(
                                            "%.2f",
                                            dentist.getConsultationFee()
                                        ) %>


                                    </p>


                                </td>



                                <!-- CONTACT -->

                                <td class="px-5 py-4">


                                    <p class="font-inter text-[10px] text-slate-600">

                                        <%= dentist.getPhoneNumber() %>

                                    </p>


                                    <% if (dentist.getEmail() != null
                                            && !dentist.getEmail().isBlank()) { %>


                                        <p class="mt-0.5 max-w-[190px] truncate font-inter text-[8px] text-slate-400">

                                            <%= dentist.getEmail() %>

                                        </p>


                                    <% } else { %>


                                        <p class="mt-0.5 font-inter text-[8px] text-slate-400">
                                            No email
                                        </p>


                                    <% } %>


                                </td>



                                <!-- STATUS -->

                                <td class="px-5 py-4">


                                    <% if (dentist.isActive()) { %>


                                        <span class="inline-flex items-center gap-1.5 rounded-full bg-emerald-50 px-2.5 py-1 font-inter text-[9px] font-semibold text-emerald-600">


                                            <span class="h-1.5 w-1.5 rounded-full bg-emerald-400"></span>


                                            Active


                                        </span>


                                    <% } else { %>


                                        <span class="inline-flex items-center gap-1.5 rounded-full bg-slate-100 px-2.5 py-1 font-inter text-[9px] font-semibold text-slate-500">


                                            <span class="h-1.5 w-1.5 rounded-full bg-slate-400"></span>


                                            Inactive


                                        </span>


                                    <% } %>


                                </td>



                                <!-- ACTIONS -->

                                <td class="px-5 py-4">


                                    <div class="flex justify-end gap-1.5">


                                        <a
                                            href="<%= request.getContextPath() %>/dentists/view?id=<%= dentist.getDentistId() %>"
                                            class="rounded-md border border-slate-200 bg-white px-3 py-1.5 font-inter text-[9px] font-semibold text-slate-600 transition hover:border-blue-200 hover:bg-blue-50 hover:text-blue-600"
                                        >
                                            View
                                        </a>


                                        <a
                                            href="<%= request.getContextPath() %>/dentists/edit?id=<%= dentist.getDentistId() %>"
                                            class="rounded-md bg-blue-50 px-3 py-1.5 font-inter text-[9px] font-semibold text-blue-600 transition hover:bg-blue-100"
                                        >
                                            Edit
                                        </a>


                                    </div>


                                </td>


                            </tr>


                        <% } %>


                        </tbody>


                    </table>


                </div>


            <% } else { %>


                <!-- EMPTY STATE -->

                <div class="flex min-h-[350px] flex-col items-center justify-center px-6 text-center">


                    <div class="mb-4 flex h-12 w-12 items-center justify-center rounded-xl bg-slate-100">


                        <svg
                            class="h-5 w-5 text-slate-400"
                            fill="none"
                            stroke="currentColor"
                            stroke-width="1.7"
                            viewBox="0 0 24 24"
                        >

                            <path
                                stroke-linecap="round"
                                stroke-linejoin="round"
                                d="M16 21v-2a4 4 0 00-4-4H6a4 4 0 00-4 4v2"
                            />

                            <circle
                                cx="9"
                                cy="7"
                                r="4"
                            />

                            <path
                                stroke-linecap="round"
                                d="M19 8v6M22 11h-6"
                            />

                        </svg>


                    </div>


                    <% if (keyword != null
                            && !keyword.trim().isEmpty()) { %>


                        <h3 class="text-sm font-extrabold">
                            No dentists found
                        </h3>


                        <p class="mt-1 max-w-[350px] font-inter text-[10px] leading-5 text-slate-400">

                            No dentists matched
                            "<%= keyword %>".

                            Try a different search term.

                        </p>


                        <a
                            href="<%= request.getContextPath() %>/dentists"
                            class="mt-4 rounded-lg border border-slate-200 bg-white px-4 py-2 font-inter text-[10px] font-semibold text-slate-600 hover:bg-slate-50"
                        >
                            Clear Search
                        </a>


                    <% } else { %>


                        <h3 class="text-sm font-extrabold">
                            No dentists yet
                        </h3>


                        <p class="mt-1 max-w-[350px] font-inter text-[10px] leading-5 text-slate-400">

                            No dentists have been registered
                            in the clinic system yet.

                        </p>


                        <a
                            href="<%= request.getContextPath() %>/dentists/add"
                            class="mt-4 rounded-lg bg-[#2563EB] px-4 py-2 font-inter text-[10px] font-semibold text-white hover:bg-[#1D4ED8]"
                        >
                            Add First Dentist
                        </a>


                    <% } %>


                </div>


            <% } %>


        </div>



        <!-- FOOTER -->

        <div class="mt-7 flex items-center justify-between px-1">


            <p class="font-inter text-[9px] text-slate-400">
                Sunrise Dental Clinic
            </p>


            <a
                href="<%= request.getContextPath() %>/dashboard"
                class="font-inter text-[9px] font-medium text-slate-400 transition hover:text-blue-600"
            >
                ← Dashboard
            </a>


        </div>


    </main>


</div>


</body>

</html>