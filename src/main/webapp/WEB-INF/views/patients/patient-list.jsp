<%@ page language="java"
    contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="java.util.List" %>
<%@ page import="com.sunrise.model.Patient" %>

<%
    List<Patient> patients =
        (List<Patient>) request.getAttribute("patients");

    String keyword =
        (String) request.getAttribute("keyword");
%>

<!DOCTYPE html>

<html lang="en">

<head>

    <meta charset="UTF-8">

    <meta name="viewport"
          content="width=device-width, initial-scale=1.0">

    <title>Patients | Sunrise Dental Clinic</title>


    <!-- Tailwind -->

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
                    Patient Management
                </p>


                <h1 class="text-[25px] font-extrabold tracking-[-0.7px]">
                    Patients
                </h1>


                <p class="mt-1 font-inter text-xs text-slate-500">
                    Manage registered clinic patients.
                </p>

            </div>



            <!-- ADD PATIENT -->

            <a
                href="<%= request.getContextPath() %>/patients/add"
                class="inline-flex items-center gap-2 rounded-lg bg-[#2563EB] px-4 py-2.5 font-inter text-[10px] font-bold text-white shadow-sm transition hover:bg-[#1D4ED8]"
            >

                <svg
                    class="h-3.5 w-3.5"
                    fill="none"
                    stroke="currentColor"
                    stroke-width="1.8"
                    viewBox="0 0 24 24"
                >

                    <path
                        stroke-linecap="round"
                        d="M12 5v14M5 12h14"
                    />

                </svg>

                Add Patient

            </a>


        </div>



        <!-- SUCCESS MESSAGE -->

        <% if ("1".equals(request.getParameter("success"))) { %>


            <div class="mb-5 flex items-center gap-3 rounded-xl border border-emerald-100 bg-emerald-50 px-4 py-3">


                <div class="flex h-7 w-7 items-center justify-center rounded-lg bg-emerald-100">


                    <svg
                        class="h-4 w-4 text-emerald-600"
                        fill="none"
                        stroke="currentColor"
                        stroke-width="2"
                        viewBox="0 0 24 24"
                    >

                        <path
                            stroke-linecap="round"
                            stroke-linejoin="round"
                            d="M5 12l4 4L19 6"
                        />

                    </svg>


                </div>


                <p class="font-inter text-[10px] font-semibold text-emerald-700">
                    Patient registered successfully.
                </p>


            </div>


        <% } %>



        <!-- UPDATED MESSAGE -->

        <% if ("1".equals(request.getParameter("updated"))) { %>


            <div class="mb-5 flex items-center gap-3 rounded-xl border border-blue-100 bg-blue-50 px-4 py-3">


                <div class="flex h-7 w-7 items-center justify-center rounded-lg bg-blue-100">


                    <svg
                        class="h-4 w-4 text-blue-600"
                        fill="none"
                        stroke="currentColor"
                        stroke-width="2"
                        viewBox="0 0 24 24"
                    >

                        <path
                            stroke-linecap="round"
                            stroke-linejoin="round"
                            d="M5 12l4 4L19 6"
                        />

                    </svg>


                </div>


                <p class="font-inter text-[10px] font-semibold text-blue-700">
                    Patient updated successfully.
                </p>


            </div>


        <% } %>



        <!-- SEARCH CARD -->

        <div class="mb-5 rounded-xl border border-slate-200 bg-white p-4">


            <form
                method="get"
                action="<%= request.getContextPath() %>/patients"
                class="flex gap-3"
            >


                <!-- SEARCH INPUT -->

                <div class="relative flex-1">


                    <svg
                        class="absolute left-3.5 top-1/2 h-4 w-4 -translate-y-1/2 text-slate-400"
                        fill="none"
                        stroke="currentColor"
                        stroke-width="1.7"
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
                        placeholder="Search by patient code, name or contact number..."
                        value="<%= keyword != null ? keyword : "" %>"
                        class="h-11 w-full rounded-lg border border-slate-200 bg-slate-50 pl-10 pr-4 font-inter text-xs text-slate-700 outline-none transition placeholder:text-slate-400 focus:border-blue-500 focus:bg-white focus:ring-2 focus:ring-blue-50"
                    >


                </div>



                <!-- SEARCH BUTTON -->

                <button
                    type="submit"
                    class="rounded-lg bg-[#2563EB] px-5 font-inter text-[10px] font-bold text-white transition hover:bg-[#1D4ED8]"
                >

                    Search

                </button>



                <!-- CLEAR -->

                <% if (keyword != null
                        && !keyword.trim().isEmpty()) { %>


                    <a
                        href="<%= request.getContextPath() %>/patients"
                        class="flex items-center rounded-lg border border-slate-200 bg-white px-5 font-inter text-[10px] font-semibold text-slate-600 transition hover:bg-slate-50"
                    >

                        Clear

                    </a>


                <% } %>


            </form>


        </div>



        <!-- RESULTS HEADER -->

        <div class="mb-4 flex items-center justify-between">


            <div>


                <% if (keyword != null
                        && !keyword.trim().isEmpty()) { %>


                    <p class="font-inter text-[10px] text-slate-500">

                        Search results for

                        <span class="font-semibold text-slate-700">
                            "<%= keyword %>"
                        </span>

                    </p>


                <% } else { %>


                    <p class="font-inter text-[10px] text-slate-500">
                        All registered patients
                    </p>


                <% } %>


            </div>



            <!-- COUNT -->

            <div class="rounded-full bg-slate-100 px-3 py-1.5">


                <span class="font-inter text-[9px] font-semibold text-slate-500">

                    <%= patients != null ? patients.size() : 0 %>

                    patient<%= patients != null && patients.size() == 1 ? "" : "s" %>

                </span>


            </div>


        </div>



        <!-- TABLE CARD -->

        <div class="overflow-hidden rounded-xl border border-slate-200 bg-white">


            <% if (patients != null && !patients.isEmpty()) { %>


                <div class="overflow-x-auto">


                    <table class="w-full min-w-[900px]">


                        <!-- TABLE HEADER -->

                        <thead class="border-b border-slate-100 bg-slate-50/70">


                            <tr>


                                <th class="px-5 py-3.5 text-left font-inter text-[9px] font-semibold uppercase tracking-wide text-slate-400">
                                    Patient
                                </th>


                                <th class="px-5 py-3.5 text-left font-inter text-[9px] font-semibold uppercase tracking-wide text-slate-400">
                                    Patient Code
                                </th>


                                <th class="px-5 py-3.5 text-left font-inter text-[9px] font-semibold uppercase tracking-wide text-slate-400">
                                    Contact
                                </th>


                                <th class="px-5 py-3.5 text-left font-inter text-[9px] font-semibold uppercase tracking-wide text-slate-400">
                                    Email
                                </th>


                                <th class="px-5 py-3.5 text-left font-inter text-[9px] font-semibold uppercase tracking-wide text-slate-400">
                                    Address
                                </th>


                                <th class="px-5 py-3.5 text-right font-inter text-[9px] font-semibold uppercase tracking-wide text-slate-400">
                                    Actions
                                </th>


                            </tr>


                        </thead>



                        <!-- TABLE BODY -->

                        <tbody class="divide-y divide-slate-100">


                        <% for (Patient patient : patients) { %>


                            <tr class="transition hover:bg-slate-50/70">


                                <!-- PATIENT -->

                                <td class="px-5 py-4">


                                    <div class="flex items-center gap-3">


                                        <!-- AVATAR -->

                                        <div class="flex h-9 w-9 shrink-0 items-center justify-center rounded-lg bg-blue-50 text-[11px] font-extrabold text-blue-600">


                                            <%= patient.getName() != null
                                                && !patient.getName().isBlank()
                                                ? patient.getName()
                                                    .substring(0, 1)
                                                    .toUpperCase()
                                                : "P" %>


                                        </div>


                                        <div>


                                            <p class="text-xs font-bold text-slate-700">

                                                <%= patient.getName() %>

                                            </p>


                                            <p class="mt-0.5 font-inter text-[9px] text-slate-400">

                                                ID #<%= patient.getPatientId() %>

                                            </p>


                                        </div>


                                    </div>


                                </td>



                                <!-- CODE -->

                                <td class="px-5 py-4">


                                    <span class="rounded-md bg-blue-50 px-2.5 py-1.5 font-inter text-[9px] font-semibold text-blue-600">

                                        <%= patient.getPatientCode() %>

                                    </span>


                                </td>



                                <!-- CONTACT -->

                                <td class="px-5 py-4">


                                    <p class="font-inter text-[10px] font-medium text-slate-600">

                                        <%= patient.getContactNumber() %>

                                    </p>


                                </td>



                                <!-- EMAIL -->

                                <td class="max-w-[180px] px-5 py-4">


                                    <p class="truncate font-inter text-[10px] text-slate-600">


                                        <%= patient.getEmail() == null
                                            || patient.getEmail().isBlank()
                                            ? "-"
                                            : patient.getEmail() %>


                                    </p>


                                </td>



                                <!-- ADDRESS -->

                                <td class="max-w-[220px] px-5 py-4">


                                    <p class="truncate font-inter text-[10px] text-slate-500">

                                        <%= patient.getAddress() %>

                                    </p>


                                </td>



                                <!-- ACTIONS -->

                                <td class="px-5 py-4">


                                    <div class="flex items-center justify-end gap-2">


                                        <!-- VIEW -->

                                        <a
                                            href="<%= request.getContextPath() %>/patients/view?id=<%= patient.getPatientId() %>"
                                            class="rounded-md border border-slate-200 bg-white px-3 py-1.5 font-inter text-[9px] font-semibold text-slate-600 transition hover:border-blue-200 hover:bg-blue-50 hover:text-blue-600"
                                        >

                                            View

                                        </a>



                                        <!-- EDIT -->

                                        <a
                                            href="<%= request.getContextPath() %>/patients/edit?id=<%= patient.getPatientId() %>"
                                            class="rounded-md bg-slate-100 px-3 py-1.5 font-inter text-[9px] font-semibold text-slate-600 transition hover:bg-blue-50 hover:text-blue-600"
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
                            stroke-width="1.6"
                            viewBox="0 0 24 24"
                        >

                            <circle
                                cx="9"
                                cy="7"
                                r="4"
                            />

                            <path
                                stroke-linecap="round"
                                d="M3 21a6 6 0 0112 0M16 11a4 4 0 014 4M16 18a5 5 0 015 3"
                            />

                        </svg>


                    </div>


                    <% if (keyword != null
                            && !keyword.trim().isEmpty()) { %>


                        <h3 class="text-sm font-extrabold">
                            No patients found
                        </h3>


                        <p class="mt-1 max-w-[350px] font-inter text-[10px] leading-5 text-slate-400">

                            No patients were found matching

                            "<span class="font-semibold text-slate-500">
                                <%= keyword %>
                            </span>".

                        </p>


                        <a
                            href="<%= request.getContextPath() %>/patients"
                            class="mt-4 font-inter text-[10px] font-semibold text-blue-600 hover:text-blue-700"
                        >

                            Clear search

                        </a>


                    <% } else { %>


                        <h3 class="text-sm font-extrabold">
                            No patients yet
                        </h3>


                        <p class="mt-1 font-inter text-[10px] text-slate-400">
                            Start by registering a new patient.
                        </p>


                        <a
                            href="<%= request.getContextPath() %>/patients/add"
                            class="mt-4 rounded-lg bg-[#2563EB] px-4 py-2 font-inter text-[10px] font-bold text-white transition hover:bg-[#1D4ED8]"
                        >

                            + Add Patient

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


            <p class="font-inter text-[9px] text-slate-400">
                Patient Management
            </p>


        </div>


    </main>


</div>


</body>

</html>