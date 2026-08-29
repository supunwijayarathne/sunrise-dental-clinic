<%@ page contentType="text/html;charset=UTF-8" %>

<%@ page import="com.sunrise.model.Bill" %>
<%@ page import="com.sunrise.model.Patient" %>
<%@ page import="com.sunrise.model.Treatment" %>
<%@ page import="com.sunrise.model.Appointment" %>
<%@ page import="com.sunrise.model.Dentist" %>

<%
    String contextPath = request.getContextPath();

    Bill bill =
            (Bill) request.getAttribute("bill");

    Patient patient =
            (Patient) request.getAttribute("patient");

    Treatment treatment =
            (Treatment) request.getAttribute("treatment");

    Appointment appointment =
            (Appointment) request.getAttribute("appointment");

    Dentist dentist =
            (Dentist) request.getAttribute("dentist");
%>

<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="UTF-8">

    <meta
        name="viewport"
        content="width=device-width, initial-scale=1.0">

    <title>
        Bill Details - Sunrise Dental
    </title>


    <!-- =====================================================
         TAILWIND
    ====================================================== -->

    <script src="https://cdn.tailwindcss.com"></script>


    <!-- =====================================================
         FONTS
    ====================================================== -->

    <link
        rel="preconnect"
        href="https://fonts.googleapis.com">

    <link
        rel="preconnect"
        href="https://fonts.gstatic.com"
        crossorigin>

    <link
        href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&family=Manrope:wght@400;500;600;700;800&display=swap"
        rel="stylesheet">


    <!-- =====================================================
         FONT CLASSES
    ====================================================== -->

    <style>

        .font-manrope {
            font-family: 'Manrope', sans-serif;
        }

        .font-inter {
            font-family: 'Inter', sans-serif;
        }

        @media print {

            .no-print {
                display: none !important;
            }

            body {
                background: white !important;
            }

            main {
                margin-left: 0 !important;
                padding: 0 !important;
            }

            .print-card {
                border: none !important;
                box-shadow: none !important;
            }

        }

    </style>

</head>


<body
    class="min-h-screen bg-[#F5F7FB] font-manrope text-[#172033]">


<div class="flex min-h-screen">


    <!-- =====================================================
         COMMON SIDEBAR
    ====================================================== -->

    <jsp:include page="../common/sidebar.jsp" />



    <!-- =====================================================
         MAIN CONTENT
    ====================================================== -->

    <main
        class="ml-[250px] min-h-screen flex-1 px-8 py-7">


        <div class="mx-auto max-w-[1200px]">


            <!-- =================================================
                 PAGE HEADER
            ================================================== -->

            <div
                class="mb-7 flex items-end justify-between">


                <!-- LEFT -->

                <div>

                    <p
                        class="mb-1 font-inter text-[10px] font-semibold uppercase tracking-[0.12em] text-blue-600">

                        Billing

                    </p>


                    <h1
                        class="font-manrope text-2xl font-extrabold tracking-tight text-[#172033]">

                        Bill Details

                    </h1>


                    <p
                        class="mt-1.5 font-inter text-xs text-slate-500">

                        View detailed information about this bill.

                    </p>

                </div>



                <!-- RIGHT -->

                <div
                    class="hidden items-center gap-2 rounded-lg border border-slate-200 bg-white px-4 py-2.5 md:flex">

                    <svg
                        class="h-4 w-4 text-slate-400"
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


                    <span
                        class="font-inter text-[11px] font-medium text-slate-500">

                        <%= bill != null
                                ? bill.getBillNumber()
                                : "Bill Details" %>

                    </span>

                </div>

            </div>



            <!-- =================================================
                 ACTION BUTTONS
            ================================================== -->

            <div
                class="mb-5 flex flex-wrap items-center gap-2.5 no-print">


                <!-- BACK -->

                <a
                    href="<%= contextPath %>/bills"
                    class="inline-flex items-center gap-2 rounded-lg border border-slate-200 bg-white px-4 py-2.5 font-inter text-[11px] font-semibold text-slate-700 transition hover:border-slate-300 hover:bg-slate-50">

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

                    Back to Bills

                </a>



                <!-- PRINT -->

                <a
                    href="<%= contextPath %>/bills/print?id=<%= bill.getBillId() %>"
                    target="_blank"
                    class="inline-flex items-center gap-2 rounded-lg bg-[#2563EB] px-4 py-2.5 font-inter text-[11px] font-bold text-white shadow-sm transition hover:bg-[#1D4ED8]">

                    <svg
                        class="h-4 w-4"
                        fill="none"
                        stroke="currentColor"
                        stroke-width="1.8"
                        viewBox="0 0 24 24">

                        <path
                            stroke-linecap="round"
                            stroke-linejoin="round"
                            d="M6 9V2h12v7"/>

                        <path
                            stroke-linecap="round"
                            stroke-linejoin="round"
                            d="M6 18H4a2 2 0 01-2-2v-5a2 2 0 012-2h16a2 2 0 012 2v5a2 2 0 01-2 2h-2"/>

                        <path
                            stroke-linecap="round"
                            stroke-linejoin="round"
                            d="M6 14h12v8H6z"/>

                    </svg>

                    Print Bill

                </a>

            </div>



            <!-- =================================================
                 BILL MAIN CARD
            ================================================== -->

            <div
                class="print-card overflow-hidden rounded-xl border border-slate-200 bg-white">


                <!-- =================================================
                     BILL TOP HEADER
                ================================================== -->

                <div
                    class="border-b border-slate-100 px-6 py-5">


                    <div
                        class="flex flex-col gap-5 sm:flex-row sm:items-center sm:justify-between">


                        <!-- BILL NUMBER -->

                        <div>

                            <p
                                class="font-inter text-[10px] font-semibold uppercase tracking-wide text-slate-400">

                                Bill Number

                            </p>


                            <h2
                                class="mt-1 font-manrope text-xl font-extrabold text-[#172033]">

                                <%= bill.getBillNumber() %>

                            </h2>

                        </div>



                        <!-- BILL TYPE -->

                        <div>

                            <p
                                class="mb-2 font-inter text-[10px] font-semibold uppercase tracking-wide text-slate-400">

                                Bill Type

                            </p>


                            <% if ("WALK_IN".equals(bill.getBillType())) { %>

                                <span
                                    class="inline-flex items-center rounded-full bg-amber-50 px-3 py-1.5 font-inter text-[10px] font-bold text-amber-700">

                                    Walk-in

                                </span>

                            <% } else { %>

                                <span
                                    class="inline-flex items-center rounded-full bg-blue-50 px-3 py-1.5 font-inter text-[10px] font-bold text-blue-700">

                                    Appointment

                                </span>

                            <% } %>

                        </div>

                    </div>

                </div>



                <!-- =================================================
                     PATIENT SECTION
                ================================================== -->

                <div
                    class="border-b border-slate-100 px-6 py-6">


                    <div
                        class="mb-4">


                        <h2
                            class="font-manrope text-sm font-bold text-[#172033]">

                            Patient Information

                        </h2>


                        <p
                            class="mt-0.5 font-inter text-[10px] text-slate-400">

                            Patient associated with this bill.

                        </p>

                    </div>



                    <div
                        class="grid grid-cols-1 gap-4 md:grid-cols-2">


                        <!-- PATIENT NAME -->

                        <div
                            class="rounded-lg border border-slate-100 bg-slate-50/60 p-4">


                            <p
                                class="font-inter text-[10px] font-semibold uppercase tracking-wide text-slate-400">

                                Patient

                            </p>


                            <p
                                class="mt-1.5 font-manrope text-sm font-bold text-slate-800">

                                <%
                                    if (patient != null) {
                                %>

                                    <%= patient.getName() %>

                                <%
                                    } else {
                                %>

                                    Patient #<%= bill.getPatientId() %>

                                <%
                                    }
                                %>

                            </p>

                        </div>



                        <!-- PATIENT ID -->

                        <div
                            class="rounded-lg border border-slate-100 bg-slate-50/60 p-4">


                            <p
                                class="font-inter text-[10px] font-semibold uppercase tracking-wide text-slate-400">

                                Patient ID

                            </p>


                            <p
                                class="mt-1.5 font-manrope text-sm font-bold text-slate-800">

                                #<%= bill.getPatientId() %>

                            </p>

                        </div>

                    </div>

                </div>



                <!-- =================================================
                     APPOINTMENT SECTION
                ================================================== -->

                <% if (appointment != null) { %>


                <div
                    class="border-b border-slate-100 px-6 py-6">


                    <div
                        class="mb-4">


                        <h2
                            class="font-manrope text-sm font-bold text-[#172033]">

                            Appointment Information

                        </h2>


                        <p
                            class="mt-0.5 font-inter text-[10px] text-slate-400">

                            Appointment, dentist and treatment information.

                        </p>

                    </div>



                    <div
                        class="grid grid-cols-1 gap-4 md:grid-cols-3">


                        <!-- APPOINTMENT -->

                        <div
                            class="rounded-lg border border-slate-100 bg-slate-50/60 p-4">


                            <p
                                class="font-inter text-[10px] font-semibold uppercase tracking-wide text-slate-400">

                                Appointment

                            </p>


                            <p
                                class="mt-1.5 font-manrope text-sm font-bold text-slate-800">

                                <%= appointment.getAppointmentNumber() %>

                            </p>

                        </div>



                        <!-- DENTIST -->

                        <div
                            class="rounded-lg border border-slate-100 bg-slate-50/60 p-4">


                            <p
                                class="font-inter text-[10px] font-semibold uppercase tracking-wide text-slate-400">

                                Dentist

                            </p>


                            <p
                                class="mt-1.5 font-manrope text-sm font-bold text-slate-800">

                                <%= dentist != null
                                        ? dentist.getDentistName()
                                        : "Not available" %>

                            </p>

                        </div>



                        <!-- TREATMENT -->

                        <div
                            class="rounded-lg border border-slate-100 bg-slate-50/60 p-4">


                            <p
                                class="font-inter text-[10px] font-semibold uppercase tracking-wide text-slate-400">

                                Treatment

                            </p>


                            <p
                                class="mt-1.5 font-manrope text-sm font-bold text-slate-800">

                                <%= treatment != null
                                        ? treatment.getTreatmentName()
                                        : "Not available" %>

                            </p>

                        </div>

                    </div>

                </div>


                <% } else { %>


                <!-- =================================================
                     WALK-IN TREATMENT
                ================================================== -->

                <div
                    class="border-b border-slate-100 px-6 py-6">


                    <div
                        class="mb-4">


                        <h2
                            class="font-manrope text-sm font-bold text-[#172033]">

                            Treatment Information

                        </h2>


                        <p
                            class="mt-0.5 font-inter text-[10px] text-slate-400">

                            Treatment associated with this walk-in bill.

                        </p>

                    </div>



                    <div
                        class="rounded-lg border border-slate-100 bg-slate-50/60 p-4">


                        <p
                            class="font-inter text-[10px] font-semibold uppercase tracking-wide text-slate-400">

                            Treatment

                        </p>


                        <p
                            class="mt-1.5 font-manrope text-sm font-bold text-slate-800">

                            <%= treatment != null
                                    ? treatment.getTreatmentName()
                                    : "Not available" %>

                        </p>

                    </div>

                </div>


                <% } %>



                <!-- =================================================
                     PAYMENT SUMMARY
                ================================================== -->

                <div
                    class="px-6 py-7">


                    <div
                        class="flex flex-col lg:flex-row lg:justify-end">


                        <div
                            class="w-full max-w-[500px]">


                            <div
                                class="mb-4">


                                <h2
                                    class="font-manrope text-sm font-bold text-[#172033]">

                                    Payment Summary

                                </h2>


                                <p
                                    class="mt-0.5 font-inter text-[10px] text-slate-400">

                                    Breakdown of charges for this bill.

                                </p>

                            </div>



                            <!-- CONSULTATION -->

                            <div
                                class="flex items-center justify-between border-b border-slate-100 py-3">


                                <span
                                    class="font-inter text-xs text-slate-500">

                                    Consultation Fee

                                </span>


                                <span
                                    class="font-manrope text-sm font-semibold text-slate-700">

                                    LKR
                                    <%= String.format(
                                        "%.2f",
                                        bill.getConsultationFee()
                                    ) %>

                                </span>

                            </div>



                            <!-- TREATMENT -->

                            <div
                                class="flex items-center justify-between border-b border-slate-100 py-3">


                                <span
                                    class="font-inter text-xs text-slate-500">

                                    Treatment Fee

                                </span>


                                <span
                                    class="font-manrope text-sm font-semibold text-slate-700">

                                    LKR
                                    <%= String.format(
                                        "%.2f",
                                        bill.getTreatmentFee()
                                    ) %>

                                </span>

                            </div>



                            <!-- TOTAL -->

                            <div
                                class="mt-4 flex items-center justify-between rounded-lg bg-blue-50 px-5 py-4">


                                <div>

                                    <p
                                        class="font-inter text-[10px] font-semibold uppercase tracking-wide text-blue-600">

                                        Total Amount

                                    </p>


                                    <p
                                        class="mt-0.5 font-inter text-[10px] text-blue-500">

                                        Amount payable

                                    </p>

                                </div>


                                <p
                                    class="font-manrope text-xl font-extrabold text-[#2563EB]">

                                    LKR
                                    <%= String.format(
                                        "%.2f",
                                        bill.getTotalAmount()
                                    ) %>

                                </p>

                            </div>


                        </div>

                    </div>

                </div>


            </div>



            <!-- =================================================
                 FOOTER
            ================================================== -->

            <div
                class="mt-4 flex items-center justify-between px-1">


                <p
                    class="font-inter text-[10px] text-slate-400">

                    Sunrise Dental Clinic Management System

                </p>


                <p
                    class="font-inter text-[10px] text-slate-400">

                    Bill ID #<%= bill.getBillId() %>

                </p>

            </div>


        </div>

    </main>


</div>


</body>

</html>