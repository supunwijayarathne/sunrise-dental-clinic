<%@ page language="java"
    contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="com.sunrise.model.Dentist" %>

<%
    Dentist dentist =
        (Dentist) request.getAttribute("dentist");
%>

<!DOCTYPE html>

<html lang="en">

<head>

    <meta charset="UTF-8">

    <meta name="viewport"
          content="width=device-width, initial-scale=1.0">

    <title>
        Dentist Details | Sunrise Dental Clinic
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

        <div class="mb-7 flex items-center justify-between">


            <div>


                <p class="mb-1 font-inter text-[10px] font-semibold uppercase tracking-[0.12em] text-slate-400">
                    Dentists
                </p>


                <h1 class="text-[25px] font-extrabold tracking-[-0.7px]">
                    Dentist Details
                </h1>


                <p class="mt-1 font-inter text-xs text-slate-500">
                    Complete information about this dentist.
                </p>


            </div>


            <!-- ID -->

            <div class="rounded-lg border border-slate-200 bg-white px-4 py-2.5">


                <p class="font-inter text-[8px] font-semibold uppercase tracking-[0.1em] text-slate-400">
                    Dentist ID
                </p>


                <p class="mt-0.5 text-xs font-extrabold text-blue-600">
                    #<%= dentist.getDentistId() %>
                </p>


            </div>


        </div>



        <!-- SUCCESS -->

        <% if ("1".equals(request.getParameter("updated"))) { %>


            <div class="mb-5 flex items-center gap-3 rounded-lg border border-emerald-100 bg-emerald-50 px-4 py-3 text-xs font-semibold text-emerald-700">


                <span class="flex h-5 w-5 items-center justify-center rounded-full bg-emerald-100">
                    ✓
                </span>


                Dentist updated successfully.


            </div>


        <% } %>



        <!-- CONTENT -->

        <div class="mx-auto max-w-[900px]">


            <!-- PROFILE CARD -->

            <div class="overflow-hidden rounded-xl border border-slate-200 bg-white">


                <!-- PROFILE HEADER -->

                <div class="flex items-center gap-5 border-b border-slate-100 px-7 py-6">


                    <!-- AVATAR -->

                    <div class="flex h-16 w-16 items-center justify-center rounded-2xl bg-blue-50 text-xl font-extrabold text-blue-600">


                        <%= dentist.getDentistName()
                            != null
                            && !dentist.getDentistName().isBlank()
                            ? dentist.getDentistName()
                                .substring(0, 1)
                                .toUpperCase()
                            : "D" %>


                    </div>


                    <div class="flex-1">


                        <h2 class="text-lg font-extrabold tracking-[-0.4px]">

                            <%= dentist.getDentistName() %>

                        </h2>


                        <p class="mt-1 font-inter text-[10px] text-slate-500">

                            <%= dentist.getSpecialization() %>

                        </p>


                    </div>



                    <!-- STATUS -->

                    <% if (dentist.isActive()) { %>


                        <span class="rounded-full bg-emerald-50 px-3 py-1.5 font-inter text-[9px] font-semibold text-emerald-600">

                            Active

                        </span>


                    <% } else { %>


                        <span class="rounded-full bg-slate-100 px-3 py-1.5 font-inter text-[9px] font-semibold text-slate-500">

                            Inactive

                        </span>


                    <% } %>


                </div>



                <!-- DETAILS -->

                <div class="grid grid-cols-2">


                    <!-- NAME -->

                    <div class="border-b border-r border-slate-100 px-7 py-5">


                        <p class="font-inter text-[9px] font-semibold uppercase tracking-wide text-slate-400">
                            Dentist Name
                        </p>


                        <p class="mt-2 text-sm font-bold">

                            <%= dentist.getDentistName() %>

                        </p>


                    </div>



                    <!-- SPECIALIZATION -->

                    <div class="border-b border-slate-100 px-7 py-5">


                        <p class="font-inter text-[9px] font-semibold uppercase tracking-wide text-slate-400">
                            Specialization
                        </p>


                        <p class="mt-2 text-sm font-bold">

                            <%= dentist.getSpecialization() %>

                        </p>


                    </div>



                    <!-- CONSULTATION FEE -->

                    <div class="border-b border-r border-slate-100 px-7 py-5">


                        <p class="font-inter text-[9px] font-semibold uppercase tracking-wide text-slate-400">
                            Consultation Fee
                        </p>


                        <p class="mt-2 text-sm font-extrabold text-[#2563EB]">

                            LKR
                            <%= String.format(
                                "%.2f",
                                dentist.getConsultationFee()
                            ) %>

                        </p>


                    </div>



                    <!-- PHONE -->

                    <div class="border-b border-slate-100 px-7 py-5">


                        <p class="font-inter text-[9px] font-semibold uppercase tracking-wide text-slate-400">
                            Phone Number
                        </p>


                        <p class="mt-2 text-sm font-bold">

                            <%= dentist.getPhoneNumber() %>

                        </p>


                    </div>



                    <!-- EMAIL -->

                    <div class="border-r border-slate-100 px-7 py-5">


                        <p class="font-inter text-[9px] font-semibold uppercase tracking-wide text-slate-400">
                            Email
                        </p>


                        <p class="mt-2 break-all text-sm font-bold">


                            <%= dentist.getEmail() == null
                                || dentist.getEmail().isBlank()
                                ? "-"
                                : dentist.getEmail() %>


                        </p>


                    </div>



                    <!-- STATUS -->

                    <div class="px-7 py-5">


                        <p class="font-inter text-[9px] font-semibold uppercase tracking-wide text-slate-400">
                            Account Status
                        </p>


                        <div class="mt-2">


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


                        </div>


                    </div>


                </div>


            </div>



            <!-- QUICK SUMMARY -->

            <div class="mt-5 grid grid-cols-3 gap-4">


                <!-- SPECIALIZATION -->

                <div class="rounded-xl border border-slate-200 bg-white p-5">


                    <div class="mb-3 flex h-8 w-8 items-center justify-center rounded-lg bg-blue-50">


                        <svg
                            class="h-4 w-4 text-blue-600"
                            fill="none"
                            stroke="currentColor"
                            stroke-width="1.7"
                            viewBox="0 0 24 24"
                        >

                            <path
                                stroke-linecap="round"
                                stroke-linejoin="round"
                                d="M12 3v18M3 12h18"
                            />

                        </svg>


                    </div>


                    <p class="font-inter text-[9px] text-slate-400">
                        Specialty
                    </p>


                    <p class="mt-1 text-[11px] font-bold">

                        <%= dentist.getSpecialization() %>

                    </p>


                </div>



                <!-- FEE -->

                <div class="rounded-xl border border-slate-200 bg-white p-5">


                    <div class="mb-3 flex h-8 w-8 items-center justify-center rounded-lg bg-emerald-50">


                        <svg
                            class="h-4 w-4 text-emerald-600"
                            fill="none"
                            stroke="currentColor"
                            stroke-width="1.7"
                            viewBox="0 0 24 24"
                        >

                            <path
                                stroke-linecap="round"
                                stroke-linejoin="round"
                                d="M12 2v20M17 5H9.5a3.5 3.5 0 000 7H14a3.5 3.5 0 010 7H6"
                            />

                        </svg>


                    </div>


                    <p class="font-inter text-[9px] text-slate-400">
                        Consultation Fee
                    </p>


                    <p class="mt-1 text-[11px] font-extrabold">

                        LKR
                        <%= String.format(
                            "%.2f",
                            dentist.getConsultationFee()
                        ) %>

                    </p>


                </div>



                <!-- STATUS -->

                <div class="rounded-xl border border-slate-200 bg-white p-5">


                    <div class="mb-3 flex h-8 w-8 items-center justify-center rounded-lg bg-slate-100">


                        <svg
                            class="h-4 w-4 text-slate-600"
                            fill="none"
                            stroke="currentColor"
                            stroke-width="1.7"
                            viewBox="0 0 24 24"
                        >

                            <circle
                                cx="12"
                                cy="12"
                                r="9"
                            />

                            <path
                                stroke-linecap="round"
                                d="M8 12l2.5 2.5L16 9"
                            />

                        </svg>


                    </div>


                    <p class="font-inter text-[9px] text-slate-400">
                        Current Status
                    </p>


                    <p class="mt-1 text-[11px] font-bold">

                        <%= dentist.isActive()
                            ? "Available"
                            : "Inactive" %>

                    </p>


                </div>


            </div>



            <!-- ACTIONS -->

            <div class="mt-6 flex items-center justify-between">


                <a
                    href="<%= request.getContextPath() %>/dentists"
                    class="flex items-center gap-2 rounded-lg border border-slate-200 bg-white px-4 py-2.5 font-inter text-[10px] font-semibold text-slate-600 transition hover:bg-slate-50"
                >

                    ← Back to Dentists

                </a>


                <a
                    href="<%= request.getContextPath() %>/dentists/edit?id=<%= dentist.getDentistId() %>"
                    class="flex items-center gap-2 rounded-lg bg-[#2563EB] px-5 py-2.5 font-inter text-[10px] font-bold text-white shadow-sm transition hover:bg-[#1D4ED8]"
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
                            d="M12 20h9"
                        />

                        <path
                            stroke-linecap="round"
                            stroke-linejoin="round"
                            d="M16.5 3.5a2.1 2.1 0 013 3L8 18l-4 1 1-4z"
                        />

                    </svg>

                    Edit Dentist

                </a>


            </div>


        </div>



        <!-- FOOTER -->

        <div class="mt-8 flex items-center justify-between px-1">


            <p class="font-inter text-[9px] text-slate-400">
                Sunrise Dental Clinic
            </p>


            <p class="font-inter text-[9px] text-slate-400">
                Dentist Management
            </p>


        </div>


    </main>


</div>


</body>

</html>