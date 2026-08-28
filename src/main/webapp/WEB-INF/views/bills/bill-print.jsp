<%@ page language="java"
    contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="com.sunrise.model.Bill" %>
<%@ page import="com.sunrise.model.Appointment" %>
<%@ page import="com.sunrise.model.Patient" %>
<%@ page import="com.sunrise.model.Dentist" %>
<%@ page import="com.sunrise.model.Treatment" %>

<%
    Bill bill =
        (Bill) request.getAttribute("bill");

    Appointment appointment =
        (Appointment) request.getAttribute("appointment");

    Patient patient =
        (Patient) request.getAttribute("patient");

    Dentist dentist =
        (Dentist) request.getAttribute("dentist");

    Treatment treatment =
        (Treatment) request.getAttribute("treatment");
%>

<!DOCTYPE html>

<html lang="en">

<head>

    <meta charset="UTF-8">

    <meta name="viewport"
          content="width=device-width, initial-scale=1.0">

    <title>
        Receipt - <%= bill.getBillNumber() %>
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


    <style>

        @media print {

            .no-print {
                display: none !important;
            }

            body {
                background: white !important;
            }

            .receipt {
                box-shadow: none !important;
                border: none !important;
                margin: 0 !important;
                width: 100% !important;
                max-width: none !important;
            }

        }

    </style>

</head>


<body class="min-h-screen bg-[#F5F7FB] font-manrope text-[#172033]">


    <!-- RECEIPT -->

    <div class="receipt mx-auto my-8 w-full max-w-[720px] rounded-xl border border-slate-200 bg-white px-10 py-9 shadow-[0_10px_35px_rgba(15,23,42,0.06)]">


        <!-- HEADER -->

        <div class="border-b border-slate-200 pb-7">


            <div class="flex items-start justify-between">


                <!-- CLINIC -->

                <div class="flex items-center gap-3">


                    <div class="flex h-11 w-11 items-center justify-center rounded-xl bg-[#2563EB]">

                        <svg
                            class="h-5 w-5 text-white"
                            fill="none"
                            stroke="currentColor"
                            stroke-width="1.8"
                            viewBox="0 0 24 24"
                        >

                            <path
                                stroke-linecap="round"
                                stroke-linejoin="round"
                                d="M12 3v18M3 12h18"
                            />

                        </svg>

                    </div>


                    <div>

                        <h1 class="text-base font-extrabold tracking-[-0.3px]">
                            Sunrise Dental Clinic
                        </h1>

                        <p class="mt-0.5 font-inter text-[9px] text-slate-400">
                            Dental Care &amp; Treatment
                        </p>

                    </div>


                </div>



                <!-- RECEIPT LABEL -->

                <div class="text-right">


                    <p class="font-inter text-[9px] font-semibold uppercase tracking-[0.15em] text-slate-400">
                        Patient Receipt
                    </p>


                    <p class="mt-1 text-lg font-extrabold text-[#2563EB]">
                        <%= bill.getBillNumber() %>
                    </p>


                </div>


            </div>


        </div>



        <!-- PATIENT + APPOINTMENT -->

        <div class="grid grid-cols-2 gap-8 border-b border-slate-200 py-6">


            <!-- PATIENT -->

            <div>


                <p class="mb-3 font-inter text-[9px] font-semibold uppercase tracking-[0.12em] text-slate-400">
                    Patient Information
                </p>


                <div class="space-y-2.5">


                    <div>

                        <p class="font-inter text-[8px] text-slate-400">
                            Patient Code
                        </p>

                        <p class="mt-0.5 text-[11px] font-bold">

                            <%= patient != null
                                ? patient.getPatientCode()
                                : "N/A" %>

                        </p>

                    </div>


                    <div>

                        <p class="font-inter text-[8px] text-slate-400">
                            Patient Name
                        </p>

                        <p class="mt-0.5 text-[11px] font-bold">

                            <%= patient != null
                                ? patient.getName()
                                : "N/A" %>

                        </p>

                    </div>


                </div>


            </div>



            <!-- APPOINTMENT -->

            <div>


                <p class="mb-3 font-inter text-[9px] font-semibold uppercase tracking-[0.12em] text-slate-400">
                    Appointment Information
                </p>


                <div class="space-y-2.5">


                    <div>

                        <p class="font-inter text-[8px] text-slate-400">
                            Appointment No.
                        </p>

                        <p class="mt-0.5 text-[11px] font-bold">

                            <%= appointment != null
                                ? appointment.getAppointmentNumber()
                                : "N/A" %>

                        </p>

                    </div>


                    <div>

                        <p class="font-inter text-[8px] text-slate-400">
                            Date &amp; Time
                        </p>

                        <p class="mt-0.5 text-[11px] font-bold">

                            <%= appointment != null
                                ? appointment.getAppointmentDate()
                                : "N/A" %>

                            <% if (appointment != null) { %>

                                ·

                                <%= appointment.getAppointmentTime() %>

                            <% } %>

                        </p>

                    </div>


                </div>


            </div>


        </div>



        <!-- DENTIST / TREATMENT -->

        <div class="grid grid-cols-2 gap-8 border-b border-slate-200 py-6">


            <div>


                <p class="font-inter text-[8px] font-semibold uppercase tracking-wide text-slate-400">
                    Dentist
                </p>


                <p class="mt-1 text-[11px] font-bold">

                    <%= dentist != null
                        ? dentist.getDentistName()
                        : "N/A" %>

                </p>


                <% if (dentist != null
                        && dentist.getSpecialization() != null) { %>


                    <p class="mt-0.5 font-inter text-[9px] text-slate-400">

                        <%= dentist.getSpecialization() %>

                    </p>


                <% } %>


            </div>



            <div>


                <p class="font-inter text-[8px] font-semibold uppercase tracking-wide text-slate-400">
                    Treatment
                </p>


                <p class="mt-1 text-[11px] font-bold">

                    <%= treatment != null
                        ? treatment.getTreatmentName()
                        : "N/A" %>

                </p>


            </div>


        </div>



        <!-- CHARGES -->

        <div class="py-6">


            <p class="mb-4 font-inter text-[9px] font-semibold uppercase tracking-[0.12em] text-slate-400">
                Charges
            </p>



            <!-- CONSULTATION -->

            <div class="flex items-center justify-between border-b border-slate-100 py-3">


                <div>

                    <p class="text-[11px] font-semibold">
                        Consultation Fee
                    </p>

                    <p class="mt-0.5 font-inter text-[9px] text-slate-400">
                        Dental consultation
                    </p>

                </div>


                <p class="font-inter text-[11px] font-semibold">

                    LKR
                    <%= String.format(
                        "%.2f",
                        bill.getConsultationFee()
                    ) %>

                </p>


            </div>



            <!-- TREATMENT -->

            <div class="flex items-center justify-between border-b border-slate-100 py-3">


                <div>

                    <p class="text-[11px] font-semibold">
                        Treatment Fee
                    </p>

                    <p class="mt-0.5 font-inter text-[9px] text-slate-400">

                        <%= treatment != null
                            ? treatment.getTreatmentName()
                            : "Dental treatment" %>

                    </p>

                </div>


                <p class="font-inter text-[11px] font-semibold">

                    LKR
                    <%= String.format(
                        "%.2f",
                        bill.getTreatmentFee()
                    ) %>

                </p>


            </div>


        </div>



        <!-- TOTAL -->

        <div class="rounded-xl bg-[#111827] px-6 py-5 text-white">


            <div class="flex items-center justify-between">


                <div>


                    <p class="text-sm font-extrabold">
                        Total Amount
                    </p>


                    <p class="mt-0.5 font-inter text-[9px] text-slate-400">
                        Amount payable
                    </p>


                </div>


                <p class="text-xl font-extrabold">

                    LKR
                    <%= String.format(
                        "%.2f",
                        bill.getTotalAmount()
                    ) %>

                </p>


            </div>


        </div>



        <!-- FOOTER -->

        <div class="mt-8 text-center">


            <p class="text-[11px] font-bold">
                Thank you for choosing Sunrise Dental Clinic.
            </p>


            <p class="mt-1 font-inter text-[9px] text-slate-400">
                We appreciate your trust in our care.
            </p>


            <p class="mt-4 font-inter text-[8px] text-slate-400">

                Generated on:
                <%= bill.getCreatedAt() %>

            </p>


        </div>



        <!-- ACTIONS -->

        <div class="no-print mt-7 flex justify-center gap-2">


            <button
                onclick="window.print()"
                class="flex items-center gap-2 rounded-lg bg-[#2563EB] px-5 py-2.5 font-inter text-[10px] font-semibold text-white transition hover:bg-[#1D4ED8]"
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
                        d="M6 9V2h12v7M6 18H4a2 2 0 01-2-2v-5a2 2 0 012-2h16a2 2 0 012 2v5a2 2 0 01-2 2h-2"
                    />

                    <path
                        stroke-linecap="round"
                        stroke-linejoin="round"
                        d="M6 14h12v8H6z"
                    />

                </svg>

                Print Receipt

            </button>


            <button
                onclick="window.close()"
                class="rounded-lg border border-slate-200 bg-white px-5 py-2.5 font-inter text-[10px] font-semibold text-slate-600 transition hover:bg-slate-50"
            >

                Close

            </button>


        </div>


    </div>


</body>

</html>