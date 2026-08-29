<%@ page contentType="text/html;charset=UTF-8" %>

<%@ page import="java.util.List" %>
<%@ page import="com.sunrise.model.Appointment" %>
<%@ page import="com.sunrise.model.Patient" %>
<%@ page import="com.sunrise.model.Treatment" %>
<%@ page import="com.sunrise.model.Dentist" %>

<%
    String contextPath = request.getContextPath();

    String error =
        (String) request.getAttribute("error");

    String generatedBillNumber =
        (String) request.getAttribute("generatedBillNumber");

    List<Appointment> appointments =
        (List<Appointment>) request.getAttribute("appointments");

    List<Patient> patients =
        (List<Patient>) request.getAttribute("patients");

    List<Treatment> treatments =
        (List<Treatment>) request.getAttribute("treatments");

    List<Dentist> dentists =
        (List<Dentist>) request.getAttribute("dentists");
%>

<!DOCTYPE html>
<html>

<head>

    <meta charset="UTF-8">

    <title>Create Bill | Sunrise Dental</title>

    <script src="https://cdn.tailwindcss.com"></script>

</head>

<body class="bg-[#f5f7fb] text-[#172033]">


<!-- ========================================================= -->
<!-- SIDEBAR -->
<!-- ========================================================= -->

<%
    String currentPage =
        request.getRequestURI()
            .substring(contextPath.length());

    boolean dashboardActive =
        currentPage.equals("/dashboard");

    boolean patientsActive =
        currentPage.startsWith("/patients");

    boolean dentistsActive =
        currentPage.startsWith("/dentists");

    boolean treatmentsActive =
        currentPage.startsWith("/treatments");

    boolean appointmentsActive =
        currentPage.startsWith("/appointments");

    boolean billsActive =
        currentPage.startsWith("/bills");

    boolean reportsActive =
        currentPage.startsWith("/reports");
%>


<aside class="fixed left-0 top-0 z-50 flex h-screen w-[250px] flex-col bg-[#111827] px-4 py-6">


    <!-- BRAND -->

    <div class="mb-8 px-3">

        <h1 class="font-manrope text-lg font-extrabold tracking-tight text-white">
            Sunrise Dental
        </h1>

        <p class="mt-1 font-inter text-[10px] font-medium text-slate-500">
            Clinic Management System
        </p>

    </div>


    <!-- MAIN MENU -->

    <div class="mb-6">

        <p class="mb-2 px-3 font-inter text-[10px] font-semibold uppercase tracking-[0.12em] text-slate-500">
            Main Menu
        </p>


        <nav class="space-y-1">


            <!-- Dashboard -->

            <a
                href="<%= contextPath %>/dashboard"
                class="flex items-center gap-3 rounded-lg px-3 py-2.5 text-[13px] font-semibold transition
                <%= dashboardActive
                    ? "bg-[#1d4ed8] text-white"
                    : "text-slate-400 hover:bg-[#1f2937] hover:text-white" %>"
            >

                <svg
                    class="h-[17px] w-[17px] shrink-0"
                    fill="none"
                    stroke="currentColor"
                    stroke-width="1.8"
                    viewBox="0 0 24 24"
                >

                    <path
                        stroke-linecap="round"
                        stroke-linejoin="round"
                        d="M3 12l9-9 9 9M5 10v10h14V10"
                    />

                </svg>

                Dashboard

            </a>


            <!-- Patients -->

            <a
                href="<%= contextPath %>/patients"
                class="flex items-center gap-3 rounded-lg px-3 py-2.5 text-[13px] font-semibold transition
                <%= patientsActive
                    ? "bg-[#1d4ed8] text-white"
                    : "text-slate-400 hover:bg-[#1f2937] hover:text-white" %>"
            >

                <svg
                    class="h-[17px] w-[17px]"
                    fill="none"
                    stroke="currentColor"
                    stroke-width="1.8"
                    viewBox="0 0 24 24"
                >

                    <path
                        stroke-linecap="round"
                        stroke-linejoin="round"
                        d="M16 21v-2a4 4 0 00-4-4H6a4 4 0 00-4 4v2M9 11a4 4 0 100-8 4 4 0 000 8zM22 21v-2a4 4 0 00-3-3.87M16 3.13a4 4 0 010 7.75"
                    />

                </svg>

                Patients

            </a>


            <!-- Dentists -->

            <a
                href="<%= contextPath %>/dentists"
                class="flex items-center gap-3 rounded-lg px-3 py-2.5 text-[13px] font-semibold transition
                <%= dentistsActive
                    ? "bg-[#1d4ed8] text-white"
                    : "text-slate-400 hover:bg-[#1f2937] hover:text-white" %>"
            >

                <svg
                    class="h-[17px] w-[17px]"
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

                Dentists

            </a>


            <!-- Treatments -->

            <a
                href="<%= contextPath %>/treatments"
                class="flex items-center gap-3 rounded-lg px-3 py-2.5 text-[13px] font-semibold transition
                <%= treatmentsActive
                    ? "bg-[#1d4ed8] text-white"
                    : "text-slate-400 hover:bg-[#1f2937] hover:text-white" %>"
            >

                <svg
                    class="h-[17px] w-[17px]"
                    fill="none"
                    stroke="currentColor"
                    stroke-width="1.8"
                    viewBox="0 0 24 24"
                >

                    <rect
                        x="4"
                        y="4"
                        width="16"
                        height="16"
                        rx="3"
                    />

                    <path
                        stroke-linecap="round"
                        d="M8 9h8M8 13h8M8 17h5"
                    />

                </svg>

                Treatments

            </a>


            <!-- Appointments -->

            <a
                href="<%= contextPath %>/appointments"
                class="flex items-center gap-3 rounded-lg px-3 py-2.5 text-[13px] font-semibold transition
                <%= appointmentsActive
                    ? "bg-[#1d4ed8] text-white"
                    : "text-slate-400 hover:bg-[#1f2937] hover:text-white" %>"
            >

                <svg
                    class="h-[17px] w-[17px]"
                    fill="none"
                    stroke="currentColor"
                    stroke-width="1.8"
                    viewBox="0 0 24 24"
                >

                    <rect
                        x="3"
                        y="4"
                        width="18"
                        height="17"
                        rx="2"
                    />

                    <path
                        stroke-linecap="round"
                        d="M16 2v4M8 2v4M3 10h18"
                    />

                </svg>

                Appointments

            </a>


            <!-- BILLING -->

            <a
                href="<%= contextPath %>/bills"
                class="flex items-center gap-3 rounded-lg px-3 py-2.5 text-[13px] font-semibold transition
                <%= billsActive
                    ? "bg-[#1d4ed8] text-white"
                    : "text-slate-400 hover:bg-[#1f2937] hover:text-white" %>"
            >

                <svg
                    class="h-[17px] w-[17px]"
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

                    <path
                        stroke-linecap="round"
                        d="M9 7h6M9 11h6M9 15h3"
                    />

                </svg>

                Billing

            </a>

        </nav>

    </div>


    <!-- MANAGEMENT -->

    <div>

        <p class="mb-2 px-3 font-inter text-[10px] font-semibold uppercase tracking-[0.12em] text-slate-500">
            Management
        </p>


        <nav class="space-y-1">

            <a
                href="<%= contextPath %>/reports"
                class="flex items-center gap-3 rounded-lg px-3 py-2.5 text-[13px] font-semibold transition
                <%= reportsActive
                    ? "bg-[#1d4ed8] text-white"
                    : "text-slate-400 hover:bg-[#1f2937] hover:text-white" %>"
            >

                <svg
                    class="h-[17px] w-[17px]"
                    fill="none"
                    stroke="currentColor"
                    stroke-width="1.8"
                    viewBox="0 0 24 24"
                >

                    <path
                        stroke-linecap="round"
                        stroke-linejoin="round"
                        d="M4 19V5M4 19h17"
                    />

                    <path
                        stroke-linecap="round"
                        d="M8 16v-5M12 16V7M16 16v-8"
                    />

                </svg>

                Reports

            </a>

        </nav>

    </div>


    <!-- LOGOUT -->

    <div class="mt-auto border-t border-white/[0.06] pt-4">

        <a
            href="<%= contextPath %>/logout"
            class="flex items-center gap-3 rounded-lg px-3 py-2.5 text-[13px] font-semibold text-slate-400 transition hover:bg-[#1f2937] hover:text-white"
        >

            <svg
                class="h-[17px] w-[17px]"
                fill="none"
                stroke="currentColor"
                stroke-width="1.8"
                viewBox="0 0 24 24"
            >

                <path
                    stroke-linecap="round"
                    stroke-linejoin="round"
                    d="M10 17l5-5-5-5M15 12H3"
                />

                <path
                    stroke-linecap="round"
                    stroke-linejoin="round"
                    d="M21 19V5a2 2 0 00-2-2h-7"
                />

            </svg>

            Logout

        </a>

    </div>

</aside>



<!-- ========================================================= -->
<!-- MAIN -->
<!-- ========================================================= -->

<main class="ml-[250px] min-h-screen px-8 py-8">

    <div class="mx-auto max-w-[1100px]">


        <!-- HEADER -->

        <div class="mb-7 flex items-center justify-between">

            <div>

                <h1 class="text-2xl font-bold tracking-tight text-[#172033]">
                    Create Bill
                </h1>

                <p class="mt-1 text-sm text-slate-500">
                    Create an appointment or walk-in bill
                </p>

            </div>


            <a
                href="<%= contextPath %>/bills"
                class="rounded-lg bg-slate-200 px-4 py-2.5 text-sm font-semibold text-slate-700 hover:bg-slate-300"
            >
                Back to Billing
            </a>

        </div>


        <!-- ERROR -->

        <% if (error != null) { %>

            <div class="mb-5 rounded-lg border border-red-200 bg-red-50 px-4 py-3 text-sm text-red-700">

                <%= error %>

            </div>

        <% } %>


        <!-- CARD -->

        <div class="rounded-xl bg-white p-7 shadow-sm">


            <!-- BILL NUMBER -->

            <div class="mb-7">

                <label class="mb-2 block text-sm font-semibold text-slate-700">
                    Bill Number
                </label>

                <input
                    type="text"
                    value="<%= generatedBillNumber != null ? generatedBillNumber : "" %>"
                    readonly
                    class="w-full rounded-lg border border-slate-200 bg-slate-50 px-4 py-3 text-sm text-slate-500"
                >

            </div>


            <!-- BILL TYPE -->

            <div class="mb-7">

                <label class="mb-3 block text-sm font-semibold text-slate-700">
                    Bill Type
                </label>


                <div class="grid grid-cols-1 gap-4 md:grid-cols-2">


                    <!-- APPOINTMENT -->

                    <label
                        id="appointmentTypeCard"
                        class="cursor-pointer rounded-xl border-2 border-[#1d4ed8] bg-blue-50 p-5 transition"
                    >

                        <div class="flex items-center gap-3">

                            <input
                                type="radio"
                                name="billTypeChoice"
                                value="APPOINTMENT"
                                checked
                                class="h-4 w-4"
                                onclick="switchBillType('APPOINTMENT')"
                            >

                            <div>

                                <div class="text-sm font-bold text-slate-800">
                                    Appointment Bill
                                </div>

                                <div class="mt-1 text-xs text-slate-500">
                                    Create a bill from an existing appointment
                                </div>

                            </div>

                        </div>

                    </label>


                    <!-- WALK IN -->

                    <label
                        id="walkInTypeCard"
                        class="cursor-pointer rounded-xl border-2 border-slate-200 bg-white p-5 transition"
                    >

                        <div class="flex items-center gap-3">

                            <input
                                type="radio"
                                name="billTypeChoice"
                                value="WALK_IN"
                                class="h-4 w-4"
                                onclick="switchBillType('WALK_IN')"
                            >

                            <div>

                                <div class="text-sm font-bold text-slate-800">
                                    Walk-in / Custom Bill
                                </div>

                                <div class="mt-1 text-xs text-slate-500">
                                    Create a bill without an appointment
                                </div>

                            </div>

                        </div>

                    </label>

                </div>

            </div>


            <!-- FORM -->

            <form
                method="post"
                action="<%= contextPath %>/bills/add"
                id="billForm"
            >

                <input
                    type="hidden"
                    name="billType"
                    id="billType"
                    value="APPOINTMENT"
                >


                <!-- ================================================= -->
                <!-- APPOINTMENT -->
                <!-- ================================================= -->

                <div id="appointmentSection">


                    <div class="mb-6">

                        <label class="mb-2 block text-sm font-semibold text-slate-700">
                            Appointment
                        </label>


                        <select
                            name="appointmentId"
                            id="appointmentId"
                            onchange="loadAppointmentInfo()"
                            class="w-full rounded-lg border border-slate-200 px-4 py-3 text-sm outline-none focus:border-[#2563eb]"
                        >

                            <option value="">
                                Select an appointment
                            </option>


                            <%

                                if (appointments != null) {

                                    for (Appointment appointment : appointments) {


                                        Patient appointmentPatient = null;

                                        Dentist appointmentDentist = null;

                                        Treatment appointmentTreatment = null;


                                        // FIND PATIENT

                                        if (patients != null) {

                                            for (Patient patient : patients) {

                                                if (patient.getPatientId()
                                                        == appointment.getPatientId()) {

                                                    appointmentPatient = patient;

                                                    break;
                                                }
                                            }
                                        }


                                        // FIND DENTIST

                                        if (dentists != null) {

                                            for (Dentist dentist : dentists) {

                                                if (dentist.getDentistId()
                                                        == appointment.getDentistId()) {

                                                    appointmentDentist = dentist;

                                                    break;
                                                }
                                            }
                                        }


                                        // FIND TREATMENT

                                        if (treatments != null) {

                                            for (Treatment treatment : treatments) {

                                                if (treatment.getTreatmentId()
                                                        == appointment.getTreatmentId()) {

                                                    appointmentTreatment = treatment;

                                                    break;
                                                }
                                            }
                                        }


                                        String patientName =
                                            appointmentPatient != null
                                                ? appointmentPatient.getName()
                                                : "Patient #" + appointment.getPatientId();


                                        String dentistName =
                                            appointmentDentist != null
                                                ? appointmentDentist.getDentistName()
                                                : "Dentist #" + appointment.getDentistId();


                                        String treatmentName =
                                            appointmentTreatment != null
                                                ? appointmentTreatment.getTreatmentName()
                                                : "Treatment #" + appointment.getTreatmentId();


                                        double treatmentFee =
                                            appointmentTreatment != null
                                                ? appointmentTreatment.getTreatmentFee()
                                                : 0;


                                        double consultationFee =
                                            appointmentDentist != null
                                                ? appointmentDentist.getConsultationFee()
                                                : 0;

                            %>


                            <option
                                value="<%= appointment.getAppointmentId() %>"

                                data-patient="<%= patientName %>"

                                data-dentist="<%= dentistName %>"

                                data-treatment="<%= treatmentName %>"

                                data-treatment-fee="<%= treatmentFee %>"

                                data-consultation-fee="<%= consultationFee %>"
                            >

                                <%= appointment.getAppointmentNumber() %>
                                -
                                <%= patientName %>
                                -
                                <%= appointment.getAppointmentDate() %>
                                <%= appointment.getAppointmentTime() %>

                            </option>


                            <%

                                    }

                                }

                            %>

                        </select>

                    </div>


                    <!-- APPOINTMENT INFORMATION -->

                    <div class="rounded-xl bg-slate-50 p-5">

                        <div class="grid grid-cols-1 gap-5 md:grid-cols-3">


                            <!-- PATIENT -->

                            <div>

                                <div class="text-xs text-slate-500">
                                    Patient
                                </div>

                                <div
                                    id="appointmentPatient"
                                    class="mt-1 text-sm font-semibold text-slate-800"
                                >
                                    Select an appointment
                                </div>

                            </div>


                            <!-- DENTIST -->

                            <div>

                                <div class="text-xs text-slate-500">
                                    Dentist
                                </div>

                                <div
                                    id="appointmentDentist"
                                    class="mt-1 text-sm font-semibold text-slate-800"
                                >
                                    Select an appointment
                                </div>

                            </div>


                            <!-- TREATMENT -->

                            <div>

                                <div class="text-xs text-slate-500">
                                    Treatment
                                </div>

                                <div
                                    id="appointmentTreatment"
                                    class="mt-1 text-sm font-semibold text-slate-800"
                                >
                                    Select an appointment
                                </div>

                            </div>

                        </div>

                    </div>

                </div>


                <!-- ================================================= -->
                <!-- WALK-IN -->
                <!-- ================================================= -->

                <div
                    id="walkInSection"
                    class="hidden"
                >

                    <div class="grid grid-cols-1 gap-6 md:grid-cols-2">


                        <!-- PATIENT -->

                        <div>

                            <label class="mb-2 block text-sm font-semibold text-slate-700">
                                Patient
                            </label>

                            <select
                                name="patientId"
                                id="patientId"
                                class="w-full rounded-lg border border-slate-200 px-4 py-3 text-sm outline-none focus:border-[#2563eb]"
                            >

                                <option value="">
                                    Select patient
                                </option>


                                <%

                                    if (patients != null) {

                                        for (Patient patient : patients) {

                                %>

                                <option
                                    value="<%= patient.getPatientId() %>"
                                >

                                    <%= patient.getPatientCode() %>
                                    -
                                    <%= patient.getName() %>

                                </option>

                                <%

                                        }

                                    }

                                %>

                            </select>

                        </div>


                        <!-- TREATMENT -->

                        <div>

                            <label class="mb-2 block text-sm font-semibold text-slate-700">
                                Treatment
                            </label>

                            <select
                                name="treatmentId"
                                id="treatmentId"
                                onchange="updateTreatmentFee()"
                                class="w-full rounded-lg border border-slate-200 px-4 py-3 text-sm outline-none focus:border-[#2563eb]"
                            >

                                <option value="">
                                    Select treatment
                                </option>


                                <%

                                    if (treatments != null) {

                                        for (Treatment treatment : treatments) {

                                %>

                                <option
                                    value="<%= treatment.getTreatmentId() %>"
                                    data-fee="<%= treatment.getTreatmentFee() %>"
                                >

                                    <%= treatment.getTreatmentName() %>

                                </option>

                                <%

                                        }

                                    }

                                %>

                            </select>

                        </div>

                    </div>

                </div>


                <!-- ================================================= -->
                <!-- FEES -->
                <!-- ================================================= -->

                <div class="mt-7 border-t border-slate-100 pt-7">


                    <div class="grid grid-cols-1 gap-6 md:grid-cols-2">


                        <!-- CONSULTATION -->

                        <div>

                            <label class="mb-2 block text-sm font-semibold text-slate-700">
                                Consultation Fee
                            </label>

                            <input
                                type="number"
                                name="consultationFee"
                                id="consultationFee"
                                min="0"
                                step="0.01"
                                placeholder="0.00"
                                class="w-full rounded-lg border border-slate-200 px-4 py-3 text-sm outline-none focus:border-[#2563eb]"
                                oninput="calculateTotal()"
                            >

                            <p class="mt-1 text-xs text-slate-400">
                                For appointment bills this is taken from the dentist.
                            </p>

                        </div>


                        <!-- TREATMENT -->

                        <div>

                            <label class="mb-2 block text-sm font-semibold text-slate-700">
                                Treatment Fee
                            </label>

                            <input
                                type="number"
                                name="treatmentFee"
                                id="treatmentFee"
                                min="0"
                                step="0.01"
                                readonly
                                placeholder="0.00"
                                class="w-full rounded-lg border border-slate-200 bg-slate-50 px-4 py-3 text-sm text-slate-600"
                            >

                        </div>

                    </div>


                    <!-- TOTAL -->

                    <div class="mt-7 flex items-center justify-between rounded-xl bg-slate-50 px-5 py-5">

                        <span class="text-sm font-semibold text-slate-600">
                            Total Amount
                        </span>

                        <span
                            id="totalAmount"
                            class="text-2xl font-bold text-[#172033]"
                        >
                            LKR 0.00
                        </span>

                    </div>

                </div>


                <!-- BUTTONS -->

                <div class="mt-7 flex justify-end gap-3">

                    <a
                        href="<%= contextPath %>/bills"
                        class="rounded-lg bg-slate-200 px-5 py-3 text-sm font-semibold text-slate-700 hover:bg-slate-300"
                    >
                        Cancel
                    </a>


                    <button
                        type="submit"
                        class="rounded-lg bg-[#2563eb] px-5 py-3 text-sm font-semibold text-white hover:bg-[#1d4ed8]"
                    >
                        Create Bill
                    </button>

                </div>

            </form>

        </div>

    </div>

</main>



<!-- ========================================================= -->
<!-- JAVASCRIPT -->
<!-- ========================================================= -->

<script>


function switchBillType(type) {

    const appointmentSection =
        document.getElementById("appointmentSection");

    const walkInSection =
        document.getElementById("walkInSection");

    const billType =
        document.getElementById("billType");

    const appointmentCard =
        document.getElementById("appointmentTypeCard");

    const walkInCard =
        document.getElementById("walkInTypeCard");

    const appointmentId =
        document.getElementById("appointmentId");

    const patientId =
        document.getElementById("patientId");

    const treatmentId =
        document.getElementById("treatmentId");

    const consultationFee =
        document.getElementById("consultationFee");

    const treatmentFee =
        document.getElementById("treatmentFee");


    billType.value = type;


    if (type === "APPOINTMENT") {


        appointmentSection.classList.remove("hidden");

        walkInSection.classList.add("hidden");


        appointmentCard.classList.remove(
            "border-slate-200",
            "bg-white"
        );

        appointmentCard.classList.add(
            "border-[#1d4ed8]",
            "bg-blue-50"
        );


        walkInCard.classList.remove(
            "border-[#1d4ed8]",
            "bg-blue-50"
        );

        walkInCard.classList.add(
            "border-slate-200",
            "bg-white"
        );


        appointmentId.required = true;

        patientId.required = false;

        treatmentId.required = false;


        consultationFee.readOnly = true;

        treatmentFee.readOnly = true;


        consultationFee.value = "";

        treatmentFee.value = "";


        calculateTotal();

    }

    else {


        appointmentSection.classList.add("hidden");

        walkInSection.classList.remove("hidden");


        walkInCard.classList.remove(
            "border-slate-200",
            "bg-white"
        );

        walkInCard.classList.add(
            "border-[#1d4ed8]",
            "bg-blue-50"
        );


        appointmentCard.classList.remove(
            "border-[#1d4ed8]",
            "bg-blue-50"
        );

        appointmentCard.classList.add(
            "border-slate-200",
            "bg-white"
        );


        appointmentId.required = false;

        patientId.required = true;

        treatmentId.required = true;


        consultationFee.readOnly = false;

        treatmentFee.readOnly = true;


        appointmentId.value = "";

        consultationFee.value = "";

        treatmentFee.value = "";


        resetAppointmentInfo();

        calculateTotal();

    }

}



function loadAppointmentInfo() {


    const select =
        document.getElementById("appointmentId");


    const selected =
        select.options[select.selectedIndex];


    const patient =
        document.getElementById("appointmentPatient");


    const dentist =
        document.getElementById("appointmentDentist");


    const treatment =
        document.getElementById("appointmentTreatment");


    const consultationFee =
        document.getElementById("consultationFee");


    const treatmentFee =
        document.getElementById("treatmentFee");


    if (!selected.value) {


        resetAppointmentInfo();

        consultationFee.value = "";

        treatmentFee.value = "";

        calculateTotal();

        return;

    }


    patient.innerText =
        selected.dataset.patient || "Not available";


    dentist.innerText =
        selected.dataset.dentist || "Not available";


    treatment.innerText =
        selected.dataset.treatment || "Not available";


    const consultation =
        parseFloat(
            selected.dataset.consultationFee
        ) || 0;


    const treatmentAmount =
        parseFloat(
            selected.dataset.treatmentFee
        ) || 0;


    consultationFee.value =
        consultation.toFixed(2);


    treatmentFee.value =
        treatmentAmount.toFixed(2);


    calculateTotal();

}



function resetAppointmentInfo() {


    document.getElementById(
        "appointmentPatient"
    ).innerText =
        "Select an appointment";


    document.getElementById(
        "appointmentDentist"
    ).innerText =
        "Select an appointment";


    document.getElementById(
        "appointmentTreatment"
    ).innerText =
        "Select an appointment";

}



function updateTreatmentFee() {


    const select =
        document.getElementById("treatmentId");


    const selected =
        select.options[select.selectedIndex];


    const fee =
        selected.getAttribute("data-fee");


    const treatmentFee =
        document.getElementById("treatmentFee");


    if (fee) {

        treatmentFee.value =
            parseFloat(fee).toFixed(2);

    }

    else {

        treatmentFee.value = "";

    }


    calculateTotal();

}



function calculateTotal() {


    const consultation =
        parseFloat(
            document.getElementById(
                "consultationFee"
            ).value
        ) || 0;


    const treatment =
        parseFloat(
            document.getElementById(
                "treatmentFee"
            ).value
        ) || 0;


    const total =
        consultation + treatment;


    document.getElementById(
        "totalAmount"
    ).innerText =
        "LKR " + total.toFixed(2);

}



document.getElementById(
    "billForm"
).addEventListener(
    "submit",
    function () {


        const type =
            document.getElementById(
                "billType"
            ).value;


        if (type === "WALK_IN") {


            const treatment =
                document.getElementById(
                    "treatmentId"
                );


            if (treatment.value) {

                updateTreatmentFee();

            }

        }

    }
);

</script>


</body>

</html>