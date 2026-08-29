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
<html>

<head>

    <meta charset="UTF-8">

    <title>Bill Details | Sunrise Dental</title>

    <script src="https://cdn.tailwindcss.com"></script>

</head>

<body class="bg-[#f5f7fb]">

    <aside class="fixed left-0 top-0 z-50 flex h-screen w-[250px] flex-col bg-[#111827] px-4 py-6">

        <div class="mb-8 px-3">

            <h1 class="font-manrope text-lg font-extrabold tracking-tight text-white">
                Sunrise Dental
            </h1>

            <p class="mt-1 font-inter text-[10px] font-medium text-slate-500">
                Clinic Management System
            </p>

        </div>


        <div class="mb-6">

            <p class="mb-2 px-3 font-inter text-[10px] font-semibold uppercase tracking-[0.12em] text-slate-500">
                Main Menu
            </p>

            <nav class="space-y-1">

                <a href="<%= contextPath %>/dashboard"
                   class="flex items-center gap-3 rounded-lg px-3 py-2.5 text-[13px] font-semibold text-slate-400 hover:bg-[#1f2937] hover:text-white">
                    Dashboard
                </a>

                <a href="<%= contextPath %>/patients"
                   class="flex items-center gap-3 rounded-lg px-3 py-2.5 text-[13px] font-semibold text-slate-400 hover:bg-[#1f2937] hover:text-white">
                    Patients
                </a>

                <a href="<%= contextPath %>/dentists"
                   class="flex items-center gap-3 rounded-lg px-3 py-2.5 text-[13px] font-semibold text-slate-400 hover:bg-[#1f2937] hover:text-white">
                    Dentists
                </a>

                <a href="<%= contextPath %>/treatments"
                   class="flex items-center gap-3 rounded-lg px-3 py-2.5 text-[13px] font-semibold text-slate-400 hover:bg-[#1f2937] hover:text-white">
                    Treatments
                </a>

                <a href="<%= contextPath %>/appointments"
                   class="flex items-center gap-3 rounded-lg px-3 py-2.5 text-[13px] font-semibold text-slate-400 hover:bg-[#1f2937] hover:text-white">
                    Appointments
                </a>

                <a href="<%= contextPath %>/bills"
                   class="flex items-center gap-3 rounded-lg bg-[#1d4ed8] px-3 py-2.5 text-[13px] font-semibold text-white">
                    Billing
                </a>

            </nav>

        </div>


        <div>

            <p class="mb-2 px-3 font-inter text-[10px] font-semibold uppercase tracking-[0.12em] text-slate-500">
                Management
            </p>

            <a href="<%= contextPath %>/reports"
               class="flex items-center gap-3 rounded-lg px-3 py-2.5 text-[13px] font-semibold text-slate-400 hover:bg-[#1f2937] hover:text-white">
                Reports
            </a>

        </div>


        <div class="mt-auto border-t border-white/[0.06] pt-4">

            <a href="<%= contextPath %>/logout"
               class="flex items-center gap-3 rounded-lg px-3 py-2.5 text-[13px] font-semibold text-slate-400 hover:bg-[#1f2937] hover:text-white">

                Logout

            </a>

        </div>

    </aside>


    <main class="ml-[250px] min-h-screen px-8 py-8">

        <div class="mx-auto max-w-[1000px]">

            <div class="mb-7 flex items-center justify-between">

                <div>

                    <h1 class="text-2xl font-bold text-[#172033]">
                        Bill Details
                    </h1>

                    <p class="mt-1 text-sm text-slate-500">
                        <%= bill.getBillNumber() %>
                    </p>

                </div>


                <div class="flex gap-3">

                    <a href="<%= contextPath %>/bills/print?id=<%= bill.getBillId() %>"
                       target="_blank"
                       class="rounded-lg bg-[#2563eb] px-5 py-3 text-sm font-semibold text-white hover:bg-[#1d4ed8]">

                        Print Bill

                    </a>

                    <a href="<%= contextPath %>/bills"
                       class="rounded-lg bg-slate-200 px-5 py-3 text-sm font-semibold text-slate-700 hover:bg-slate-300">

                        Back

                    </a>

                </div>

            </div>


            <div class="rounded-xl bg-white p-7 shadow-sm">


                <!-- BILL HEADER -->

                <div class="flex flex-col justify-between gap-5 border-b border-slate-100 pb-6 md:flex-row">

                    <div>

                        <p class="text-xs uppercase tracking-wide text-slate-400">
                            Bill Number
                        </p>

                        <p class="mt-1 text-xl font-bold text-[#172033]">
                            <%= bill.getBillNumber() %>
                        </p>

                    </div>


                    <div>

                        <p class="text-xs uppercase tracking-wide text-slate-400">
                            Bill Type
                        </p>

                        <div class="mt-2">

                            <% if ("WALK_IN".equals(bill.getBillType())) { %>

                                <span class="rounded-full bg-amber-50 px-3 py-1 text-xs font-semibold text-amber-700">
                                    Walk-in / Custom
                                </span>

                            <% } else { %>

                                <span class="rounded-full bg-blue-50 px-3 py-1 text-xs font-semibold text-blue-700">
                                    Appointment
                                </span>

                            <% } %>

                        </div>

                    </div>

                </div>


                <!-- PATIENT -->

                <div class="mt-7">

                    <h2 class="text-sm font-bold text-[#172033]">
                        Patient Information
                    </h2>

                    <div class="mt-4 grid grid-cols-1 gap-4 md:grid-cols-2">

                        <div class="rounded-lg bg-slate-50 p-4">

                            <p class="text-xs text-slate-400">
                                Patient
                            </p>

                            <p class="mt-1 text-sm font-semibold text-slate-800">

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


                        <div class="rounded-lg bg-slate-50 p-4">

                            <p class="text-xs text-slate-400">
                                Patient ID
                            </p>

                            <p class="mt-1 text-sm font-semibold text-slate-800">
                                #<%= bill.getPatientId() %>
                            </p>

                        </div>

                    </div>

                </div>


                <!-- APPOINTMENT INFO -->

                <% if (appointment != null) { %>

                <div class="mt-7">

                    <h2 class="text-sm font-bold text-[#172033]">
                        Appointment Information
                    </h2>

                    <div class="mt-4 grid grid-cols-1 gap-4 md:grid-cols-3">

                        <div class="rounded-lg bg-slate-50 p-4">

                            <p class="text-xs text-slate-400">
                                Appointment
                            </p>

                            <p class="mt-1 text-sm font-semibold text-slate-800">
                                <%= appointment.getAppointmentNumber() %>
                            </p>

                        </div>


                        <div class="info">

<div class="info">

    <p class="text-xs text-slate-400">
        Dentist
    </p>

    <p class="mt-1 text-sm font-semibold text-slate-800">

        <%= dentist != null
            ? dentist.getDentistName()
            : "Not available" %>

    </p>

</div>


                        <div class="rounded-lg bg-slate-50 p-4">

                            <p class="text-xs text-slate-400">
                                Treatment
                            </p>

                            <p class="mt-1 text-sm font-semibold text-slate-800">

                                <%= treatment != null
                                    ? treatment.getTreatmentName()
                                    : "Not available" %>

                            </p>

                        </div>

                    </div>

                </div>

                <% } else { %>

                <!-- WALK-IN TREATMENT -->

                <div class="mt-7">

                    <h2 class="text-sm font-bold text-[#172033]">
                        Treatment
                    </h2>

                    <div class="mt-4 rounded-lg bg-slate-50 p-4">

                        <p class="text-xs text-slate-400">
                            Treatment
                        </p>

                        <p class="mt-1 text-sm font-semibold text-slate-800">

                            <%= treatment != null
                                ? treatment.getTreatmentName()
                                : "Not available" %>

                        </p>

                    </div>

                </div>

                <% } %>


                <!-- FEES -->

                <div class="mt-7 border-t border-slate-100 pt-7">

                    <div class="space-y-4">

                        <div class="flex justify-between">

                            <span class="text-sm text-slate-500">
                                Consultation Fee
                            </span>

                            <span class="text-sm font-semibold text-slate-800">
                                LKR <%= String.format("%.2f", bill.getConsultationFee()) %>
                            </span>

                        </div>


                        <div class="flex justify-between">

                            <span class="text-sm text-slate-500">
                                Treatment Fee
                            </span>

                            <span class="text-sm font-semibold text-slate-800">
                                LKR <%= String.format("%.2f", bill.getTreatmentFee()) %>
                            </span>

                        </div>


                        <div class="flex justify-between border-t border-slate-100 pt-5">

                            <span class="text-base font-bold text-[#172033]">
                                Total
                            </span>

                            <span class="text-xl font-bold text-[#172033]">
                                LKR <%= String.format("%.2f", bill.getTotalAmount()) %>
                            </span>

                        </div>

                    </div>

                </div>


            </div>

        </div>

    </main>

</body>

</html>