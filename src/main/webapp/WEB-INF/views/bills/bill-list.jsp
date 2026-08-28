<%@ page language="java"
    contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="java.util.List" %>
<%@ page import="com.sunrise.model.Bill" %>
<%@ page import="com.sunrise.model.Appointment" %>
<%@ page import="com.sunrise.model.Patient" %>
<%@ page import="com.sunrise.dao.AppointmentDAO" %>
<%@ page import="com.sunrise.dao.PatientDAO" %>

<%
    List<Bill> bills =
        (List<Bill>) request.getAttribute("bills");

    String keyword =
        (String) request.getAttribute("keyword");

    AppointmentDAO appointmentDAO =
        new AppointmentDAO();

    PatientDAO patientDAO =
        new PatientDAO();
%>

<!DOCTYPE html>

<html lang="en">

<head>

    <meta charset="UTF-8">

    <meta name="viewport"
          content="width=device-width, initial-scale=1.0">

    <title>
        Bills | Sunrise Dental Clinic
    </title>


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
                    Billing
                </p>

                <h1 class="text-[25px] font-extrabold tracking-[-0.7px]">
                    Bills
                </h1>

                <p class="mt-1 font-inter text-xs text-slate-500">
                    Manage patient bills and receipts.
                </p>

            </div>


            <a
                href="<%= request.getContextPath() %>/bills/add"
                class="flex items-center gap-2 rounded-lg bg-[#2563EB] px-4 py-2.5 text-xs font-bold text-white shadow-sm transition hover:bg-[#1D4ED8]"
            >

                <span class="text-base leading-none">
                    +
                </span>

                Create Bill

            </a>


        </div>



        <!-- SUCCESS -->

        <% if ("1".equals(request.getParameter("success"))) { %>

            <div class="mb-5 flex items-center gap-3 rounded-lg border border-emerald-100 bg-emerald-50 px-4 py-3 text-xs font-semibold text-emerald-700">

                <span class="flex h-5 w-5 items-center justify-center rounded-full bg-emerald-100">
                    ✓
                </span>

                Bill created successfully.

            </div>

        <% } %>



        <!-- SEARCH -->

        <div class="mb-5 rounded-xl border border-slate-200 bg-white p-4">


            <form
                method="get"
                action="<%= request.getContextPath() %>/bills"
                class="flex gap-2"
            >


                <div class="relative flex-1">


                    <div class="pointer-events-none absolute inset-y-0 left-3 flex items-center">

                        <svg
                            class="h-4 w-4 text-slate-400"
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
                                d="M20 20l-4-4"
                            />

                        </svg>

                    </div>


                    <input
                        type="text"
                        name="keyword"
                        value="<%= keyword != null ? keyword : "" %>"
                        placeholder="Search bill number, appointment or patient..."
                        class="w-full rounded-lg border border-slate-200 bg-white py-2.5 pl-10 pr-3 font-inter text-xs outline-none transition placeholder:text-slate-400 focus:border-blue-500 focus:ring-4 focus:ring-blue-50"
                    >


                </div>


                <button
                    type="submit"
                    class="rounded-lg bg-[#2563EB] px-5 py-2.5 font-inter text-[11px] font-semibold text-white transition hover:bg-[#1D4ED8]"
                >
                    Search
                </button>


                <% if (keyword != null
                        && !keyword.trim().isEmpty()) { %>


                    <a
                        href="<%= request.getContextPath() %>/bills"
                        class="rounded-lg border border-slate-200 bg-white px-4 py-2.5 font-inter text-[11px] font-semibold text-slate-600 transition hover:bg-slate-50"
                    >
                        Clear
                    </a>


                <% } %>


            </form>


        </div>



        <!-- TABLE CARD -->

        <div class="overflow-hidden rounded-xl border border-slate-200 bg-white">


            <!-- TABLE HEADER -->

            <div class="flex items-center justify-between border-b border-slate-100 px-5 py-4">


                <div>

                    <h2 class="text-sm font-extrabold">
                        Bill List
                    </h2>

                    <p class="mt-0.5 font-inter text-[9px] text-slate-400">
                        Generated patient bills
                    </p>

                </div>


                <div class="rounded-full bg-slate-50 px-3 py-1.5">

                    <span class="font-inter text-[9px] font-semibold text-slate-500">
                        Total Bills
                    </span>

                    <span class="ml-1 font-inter text-[9px] font-bold text-slate-800">

                        <%= bills != null
                            ? bills.size()
                            : 0 %>

                    </span>

                </div>


            </div>



            <% if (bills != null && !bills.isEmpty()) { %>


                <!-- TABLE -->

                <div class="overflow-x-auto">


                    <table class="w-full min-w-[950px]">


                        <thead class="bg-slate-50">


                            <tr>


                                <th class="px-5 py-3 text-left font-inter text-[9px] font-semibold uppercase tracking-wide text-slate-400">
                                    Bill Number
                                </th>


                                <th class="px-5 py-3 text-left font-inter text-[9px] font-semibold uppercase tracking-wide text-slate-400">
                                    Appointment
                                </th>


                                <th class="px-5 py-3 text-left font-inter text-[9px] font-semibold uppercase tracking-wide text-slate-400">
                                    Patient
                                </th>


                                <th class="px-5 py-3 text-right font-inter text-[9px] font-semibold uppercase tracking-wide text-slate-400">
                                    Consultation
                                </th>


                                <th class="px-5 py-3 text-right font-inter text-[9px] font-semibold uppercase tracking-wide text-slate-400">
                                    Treatment
                                </th>


                                <th class="px-5 py-3 text-right font-inter text-[9px] font-semibold uppercase tracking-wide text-slate-400">
                                    Total
                                </th>


                                <th class="px-5 py-3 text-left font-inter text-[9px] font-semibold uppercase tracking-wide text-slate-400">
                                    Created
                                </th>


                                <th class="px-5 py-3 text-left font-inter text-[9px] font-semibold uppercase tracking-wide text-slate-400">
                                    Actions
                                </th>


                            </tr>


                        </thead>



                        <tbody>


                        <%

                        for (Bill bill : bills) {


                            Appointment appointment =
                                appointmentDAO.getAppointmentById(
                                    bill.getAppointmentId()
                                );


                            Patient patient = null;


                            if (appointment != null) {

                                patient =
                                    patientDAO.getPatientById(
                                        appointment.getPatientId()
                                    );

                            }

                        %>


                            <tr class="border-t border-slate-100 transition hover:bg-slate-50/70">


                                <!-- BILL NUMBER -->

                                <td class="px-5 py-4">


                                    <a
                                        href="<%= request.getContextPath() %>/bills/view?id=<%= bill.getBillId() %>"
                                        class="text-[10px] font-extrabold text-blue-600 hover:underline"
                                    >

                                        <%= bill.getBillNumber() %>

                                    </a>


                                </td>



                                <!-- APPOINTMENT -->

                                <td class="px-5 py-4">


                                    <% if (appointment != null) { %>


                                        <p class="text-[10px] font-semibold">

                                            <%= appointment.getAppointmentNumber() %>

                                        </p>


                                        <p class="mt-0.5 font-inter text-[9px] text-slate-400">

                                            <%= appointment.getAppointmentDate() %>

                                        </p>


                                    <% } else { %>


                                        <span class="font-inter text-[10px] text-slate-400">
                                            N/A
                                        </span>


                                    <% } %>


                                </td>



                                <!-- PATIENT -->

                                <td class="px-5 py-4">


                                    <% if (patient != null) { %>


                                        <p class="text-[10px] font-semibold">

                                            <%= patient.getName() %>

                                        </p>


                                        <p class="mt-0.5 font-inter text-[9px] text-slate-400">

                                            <%= patient.getPatientCode() %>

                                        </p>


                                    <% } else { %>


                                        <span class="font-inter text-[10px] text-slate-400">
                                            N/A
                                        </span>


                                    <% } %>


                                </td>



                                <!-- CONSULTATION -->

                                <td class="px-5 py-4 text-right">


                                    <span class="font-inter text-[10px] font-medium text-slate-600">

                                        LKR
                                        <%= String.format(
                                            "%.2f",
                                            bill.getConsultationFee()
                                        ) %>

                                    </span>


                                </td>



                                <!-- TREATMENT -->

                                <td class="px-5 py-4 text-right">


                                    <span class="font-inter text-[10px] font-medium text-slate-600">

                                        LKR
                                        <%= String.format(
                                            "%.2f",
                                            bill.getTreatmentFee()
                                        ) %>

                                    </span>


                                </td>



                                <!-- TOTAL -->

                                <td class="px-5 py-4 text-right">


                                    <span class="font-inter text-[10px] font-bold text-slate-900">

                                        LKR
                                        <%= String.format(
                                            "%.2f",
                                            bill.getTotalAmount()
                                        ) %>

                                    </span>


                                </td>



                                <!-- CREATED -->

                                <td class="px-5 py-4">


                                    <span class="font-inter text-[9px] text-slate-500">

                                        <%= bill.getCreatedAt() != null
                                            ? bill.getCreatedAt()
                                            : "N/A" %>

                                    </span>


                                </td>



                                <!-- ACTIONS -->

                                <td class="px-5 py-4">


                                    <div class="flex items-center gap-1">


                                        <a
                                            href="<%= request.getContextPath() %>/bills/view?id=<%= bill.getBillId() %>"
                                            class="rounded-md px-2 py-1.5 font-inter text-[9px] font-semibold text-slate-500 transition hover:bg-blue-50 hover:text-blue-600"
                                        >
                                            View
                                        </a>


                                        <a
                                            href="<%= request.getContextPath() %>/bills/print?id=<%= bill.getBillId() %>"
                                            target="_blank"
                                            class="rounded-md px-2 py-1.5 font-inter text-[9px] font-semibold text-slate-500 transition hover:bg-slate-100 hover:text-slate-700"
                                        >
                                            Print
                                        </a>


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


                <!-- EMPTY -->

                <div class="px-5 py-16 text-center">


                    <div class="mx-auto mb-4 flex h-12 w-12 items-center justify-center rounded-xl bg-slate-100 text-slate-400">


                        <svg
                            class="h-5 w-5"
                            fill="none"
                            stroke="currentColor"
                            stroke-width="1.6"
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


                    <h3 class="text-sm font-extrabold">
                        No bills found
                    </h3>


                    <p class="mx-auto mt-1 max-w-[350px] font-inter text-[10px] leading-5 text-slate-400">


                        <% if (keyword != null
                                && !keyword.trim().isEmpty()) { %>


                            No bills found for
                            "<strong><%= keyword %></strong>".


                        <% } else { %>


                            No bills have been created yet.


                        <% } %>


                    </p>


                    <% if (keyword == null
                            || keyword.trim().isEmpty()) { %>


                        <a
                            href="<%= request.getContextPath() %>/bills/add"
                            class="mt-4 inline-flex items-center gap-1.5 rounded-lg bg-[#2563EB] px-4 py-2.5 font-inter text-[10px] font-semibold text-white hover:bg-[#1D4ED8]"
                        >

                            + Create Bill

                        </a>


                    <% } %>


                </div>


            <% } %>


        </div>



        <!-- FOOTER -->

        <div class="mt-6 flex items-center justify-between px-1">


            <p class="font-inter text-[9px] text-slate-400">
                Sunrise Dental Clinic
            </p>


            <a
                href="<%= request.getContextPath() %>/dashboard"
                class="font-inter text-[9px] font-semibold text-blue-600 hover:underline"
            >
                ← Back to Dashboard
            </a>


        </div>


    </main>


</div>


</body>

</html>