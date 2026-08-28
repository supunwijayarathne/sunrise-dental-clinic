<%@ page language="java"
    contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="java.util.List" %>
<%@ page import="com.sunrise.model.Appointment" %>

<%
    List<Appointment> appointments =
        (List<Appointment>) request.getAttribute("appointments");

    String generatedBillNumber =
        (String) request.getAttribute("generatedBillNumber");
%>

<!DOCTYPE html>

<html lang="en">

<head>

    <meta charset="UTF-8">

    <meta name="viewport"
          content="width=device-width, initial-scale=1.0">

    <title>
        Create Bill | Sunrise Dental Clinic
    </title>

    <!-- Tailwind CSS -->

    <script src="https://cdn.tailwindcss.com"></script>

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

    <!-- Google Fonts -->

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


        <!-- PAGE HEADER -->

        <div class="mb-7">


            <p class="mb-1 font-inter text-[10px] font-semibold uppercase tracking-[0.12em] text-slate-400">
                Billing
            </p>


            <h1 class="text-[25px] font-extrabold tracking-[-0.7px]">
                Create Bill
            </h1>


            <p class="mt-1 font-inter text-xs text-slate-500">
                Generate a bill for a patient appointment.
            </p>


        </div>



        <div class="mx-auto max-w-[850px]">


            <!-- ERROR -->

            <% if (request.getAttribute("error") != null) { %>


                <div class="mb-5 flex items-start gap-3 rounded-lg border border-red-100 bg-red-50 px-4 py-3">


                    <div class="flex h-5 w-5 shrink-0 items-center justify-center rounded-full bg-red-100 font-inter text-[10px] font-bold text-red-600">
                        !
                    </div>


                    <p class="font-inter text-[10px] font-medium leading-5 text-red-700">

                        <%= request.getAttribute("error") %>

                    </p>


                </div>


            <% } %>



            <!-- BILL FORM -->

            <form
                method="post"
                action="<%= request.getContextPath() %>/bills/add"
            >


                <!-- BILL INFORMATION -->

                <div class="mb-5 rounded-xl border border-slate-200 bg-white p-6">


                    <div class="mb-6 flex items-center gap-3">


                        <div class="flex h-9 w-9 items-center justify-center rounded-lg bg-blue-50 text-xs font-extrabold text-blue-600">

                            B

                        </div>


                        <div>

                            <h2 class="text-sm font-extrabold">
                                Bill Information
                            </h2>

                            <p class="mt-0.5 font-inter text-[9px] text-slate-400">
                                Bill number is generated automatically.
                            </p>

                        </div>


                    </div>



                    <!-- BILL NUMBER -->

                    <div>


                        <label
                            for="billNumber"
                            class="mb-1.5 block font-inter text-[10px] font-semibold text-slate-700"
                        >
                            Bill Number
                        </label>


                        <div class="relative">


                            <div class="pointer-events-none absolute inset-y-0 left-3 flex items-center">

                                <svg
                                    class="h-4 w-4 text-slate-400"
                                    fill="none"
                                    stroke="currentColor"
                                    stroke-width="1.7"
                                    viewBox="0 0 24 24"
                                >

                                    <path
                                        stroke-linecap="round"
                                        stroke-linejoin="round"
                                        d="M9 5H5a2 2 0 00-2 2v10a2 2 0 002 2h14a2 2 0 002-2V7a2 2 0 00-2-2h-4"
                                    />

                                    <path
                                        stroke-linecap="round"
                                        d="M9 3h6v4H9z"
                                    />

                                </svg>

                            </div>


                            <input
                                type="text"
                                id="billNumber"
                                value="<%= generatedBillNumber != null
                                    ? generatedBillNumber
                                    : "Generating..." %>"
                                readonly
                                class="w-full cursor-not-allowed rounded-lg border border-slate-200 bg-slate-50 py-3 pl-10 pr-3 font-inter text-[11px] font-semibold text-slate-600 outline-none"
                            >


                        </div>


                        <div class="mt-2 flex items-center gap-1.5">

                            <svg
                                class="h-3 w-3 text-slate-400"
                                fill="none"
                                stroke="currentColor"
                                stroke-width="1.7"
                                viewBox="0 0 24 24"
                            >

                                <circle cx="12" cy="12" r="9"/>

                                <path
                                    stroke-linecap="round"
                                    d="M12 11v5M12 8h.01"
                                />

                            </svg>


                            <span class="font-inter text-[9px] text-slate-400">
                                Automatically generated by the system. This field cannot be edited.
                            </span>

                        </div>


                    </div>


                </div>



                <!-- APPOINTMENT -->

                <div class="mb-5 rounded-xl border border-slate-200 bg-white p-6">


                    <div class="mb-6 flex items-center gap-3">


                        <div class="flex h-9 w-9 items-center justify-center rounded-lg bg-emerald-50 text-xs font-extrabold text-emerald-600">

                            A

                        </div>


                        <div>

                            <h2 class="text-sm font-extrabold">
                                Appointment
                            </h2>

                            <p class="mt-0.5 font-inter text-[9px] text-slate-400">
                                Select the appointment to generate the bill.
                            </p>

                        </div>


                    </div>



                    <label
                        for="appointmentId"
                        class="mb-1.5 block font-inter text-[10px] font-semibold text-slate-700"
                    >

                        Appointment

                        <span class="text-red-500">
                            *
                        </span>

                    </label>


                    <select
                        id="appointmentId"
                        name="appointmentId"
                        required
                        class="w-full rounded-lg border border-slate-200 bg-white px-3 py-3 font-inter text-[11px] outline-none transition focus:border-blue-500 focus:ring-4 focus:ring-blue-50"
                    >


                        <option value="">
                            -- Select Appointment --
                        </option>


                        <%

                        if (appointments != null) {

                            for (Appointment appointment : appointments) {

                        %>


                            <option
                                value="<%= appointment.getAppointmentId() %>"
                            >

                                <%= appointment.getAppointmentNumber() %>

                                -

                                <%= appointment.getAppointmentDate() %>

                                -

                                <%= appointment.getAppointmentTime() %>

                            </option>


                        <%

                            }

                        }

                        %>


                    </select>


                    <div class="mt-2 flex items-start gap-1.5">


                        <svg
                            class="mt-0.5 h-3 w-3 shrink-0 text-slate-400"
                            fill="none"
                            stroke="currentColor"
                            stroke-width="1.7"
                            viewBox="0 0 24 24"
                        >

                            <circle cx="12" cy="12" r="9"/>

                            <path
                                stroke-linecap="round"
                                d="M12 11v5M12 8h.01"
                            />

                        </svg>


                        <span class="font-inter text-[9px] leading-4 text-slate-400">

                            The consultation and treatment fees will be
                            retrieved automatically from the selected appointment.

                        </span>


                    </div>


                </div>



                <!-- AUTOMATIC CALCULATION -->

                <div class="mb-5 overflow-hidden rounded-xl border border-blue-100 bg-white">


                    <div class="bg-blue-50/60 px-6 py-4">


                        <div class="flex items-center gap-3">


                            <div class="flex h-9 w-9 items-center justify-center rounded-lg bg-blue-100 text-blue-600">


                                <svg
                                    class="h-4 w-4"
                                    fill="none"
                                    stroke="currentColor"
                                    stroke-width="1.8"
                                    viewBox="0 0 24 24"
                                >

                                    <path
                                        stroke-linecap="round"
                                        stroke-linejoin="round"
                                        d="M9 7h6M9 12h6M9 17h6"
                                    />

                                    <path
                                        stroke-linecap="round"
                                        stroke-linejoin="round"
                                        d="M5 3h14a2 2 0 012 2v14a2 2 0 01-2 2H5a2 2 0 01-2-2V5a2 2 0 012-2z"
                                    />

                                </svg>


                            </div>


                            <div>


                                <h2 class="text-sm font-extrabold text-blue-900">
                                    Automatic Billing
                                </h2>


                                <p class="mt-0.5 font-inter text-[9px] text-blue-600">
                                    Fees are calculated automatically.
                                </p>


                            </div>


                        </div>


                    </div>


                    <div class="px-6 py-5">


                        <div class="flex items-center justify-between">


                            <div>


                                <p class="font-inter text-[10px] font-medium text-slate-500">
                                    Billing calculation
                                </p>


                                <p class="mt-1 text-xs font-bold text-slate-700">
                                    Consultation Fee + Treatment Fee
                                </p>


                            </div>


                            <span class="text-lg font-extrabold text-blue-600">
                                =
                            </span>


                            <div class="text-right">


                                <p class="font-inter text-[10px] font-medium text-slate-500">
                                    Total Amount
                                </p>


                                <p class="mt-1 text-xs font-bold text-slate-700">
                                    Calculated automatically
                                </p>


                            </div>


                        </div>


                    </div>


                </div>



                <!-- ACTIONS -->

                <div class="flex items-center justify-between">


                    <p class="font-inter text-[9px] text-slate-400">

                        <span class="text-red-500">
                            *
                        </span>

                        Required fields

                    </p>


                    <div class="flex gap-2">


                        <a
                            href="<%= request.getContextPath() %>/bills"
                            class="rounded-lg border border-slate-200 bg-white px-5 py-2.5 text-xs font-semibold text-slate-600 transition hover:bg-slate-50"
                        >
                            Cancel
                        </a>


                        <button
                            type="submit"
                            class="flex items-center gap-2 rounded-lg bg-[#2563EB] px-5 py-2.5 text-xs font-bold text-white shadow-sm transition hover:bg-[#1D4ED8] focus:outline-none focus:ring-4 focus:ring-blue-100"
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
                                    stroke-linejoin="round"
                                    d="M6 2h12v20l-3-2-3 2-3-2-3 2V2z"
                                />

                            </svg>

                            Generate Bill

                        </button>


                    </div>


                </div>


            </form>


        </div>



        <!-- FOOTER -->

        <div class="mx-auto mt-7 flex max-w-[850px] items-center justify-between px-1">

            <p class="font-inter text-[9px] text-slate-400">
                Sunrise Dental Clinic
            </p>

            <p class="font-inter text-[9px] text-slate-400">
                Billing Management
            </p>

        </div>


    </main>


</div>


</body>

</html>