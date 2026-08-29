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
<html lang="en">

<head>

    <meta charset="UTF-8">

    <meta
        name="viewport"
        content="width=device-width, initial-scale=1.0">

    <title>Create Bill | Sunrise Dental</title>


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
        href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&family=Manrope:wght@500;600;700;800&display=swap"
        rel="stylesheet">


    <style>

        .font-manrope {
            font-family: 'Manrope', sans-serif;
        }

        .font-inter {
            font-family: 'Inter', sans-serif;
        }

        input:focus,
        select:focus {
            outline: none;
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


        <div class="mx-auto max-w-[1100px]">


            <!-- =================================================
                 HEADER
            ================================================== -->

            <div
                class="mb-7 flex items-end justify-between">


                <div>

                    <p
                        class="mb-1 font-inter text-[10px] font-semibold uppercase tracking-[0.12em] text-blue-600">

                        Billing

                    </p>


                    <h1
                        class="font-manrope text-2xl font-extrabold tracking-tight text-[#172033]">

                        Create Bill

                    </h1>


                    <p
                        class="mt-1.5 font-inter text-xs text-slate-500">

                        Create an appointment or walk-in bill.

                    </p>

                </div>


                <!-- BILL NUMBER -->

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

                        <%= generatedBillNumber != null
                                ? generatedBillNumber
                                : "New Bill" %>

                    </span>

                </div>

            </div>



            <!-- =================================================
                 ERROR MESSAGE
            ================================================== -->

            <% if (error != null && !error.trim().isEmpty()) { %>

                <div
                    class="mb-5 flex items-start gap-3 rounded-xl border border-red-200 bg-red-50 px-5 py-4">


                    <svg
                        class="mt-0.5 h-5 w-5 shrink-0 text-red-500"
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
                            d="M12 8v5M12 16h.01"/>

                    </svg>


                    <div>

                        <p
                            class="font-manrope text-xs font-bold text-red-700">

                            Unable to create bill

                        </p>


                        <p
                            class="mt-1 font-inter text-[11px] text-red-600">

                            <%= error %>

                        </p>

                    </div>

                </div>

            <% } %>



            <!-- =================================================
                 MAIN CARD
            ================================================== -->

            <div
                class="overflow-hidden rounded-xl border border-slate-200 bg-white">


                <!-- =================================================
                     BILL NUMBER
                ================================================== -->

                <div
                    class="border-b border-slate-100 px-6 py-6">


                    <div class="max-w-[520px]">


                        <label
                            class="mb-2 block font-inter text-[10px] font-semibold uppercase tracking-wide text-slate-400">

                            Bill Number

                        </label>


                        <input
                            type="text"
                            value="<%= generatedBillNumber != null ? generatedBillNumber : "" %>"
                            readonly
                            class="w-full rounded-lg border border-slate-200 bg-slate-50 px-4 py-3 font-inter text-sm font-medium text-slate-600"
                        />


                        <p
                            class="mt-1.5 font-inter text-[10px] text-slate-400">

                            Automatically generated by the billing system.

                        </p>

                    </div>

                </div>



                <!-- =================================================
                     BILL TYPE
                ================================================== -->

                <div
                    class="border-b border-slate-100 px-6 py-6">


                    <div class="mb-4">


                        <h2
                            class="font-manrope text-sm font-bold text-[#172033]">

                            Bill Type

                        </h2>


                        <p
                            class="mt-1 font-inter text-[10px] text-slate-400">

                            Choose whether this bill is linked to an appointment or created for a walk-in patient.

                        </p>

                    </div>



                    <div
                        class="grid grid-cols-1 gap-4 md:grid-cols-2">


                        <!-- =================================================
                             APPOINTMENT
                        ================================================== -->

                        <label
                            id="appointmentTypeCard"
                            class="cursor-pointer rounded-xl border-2 border-[#2563EB] bg-blue-50 p-5 transition hover:border-blue-500">


                            <div class="flex items-start gap-3">


                                <input
                                    type="radio"
                                    name="billTypeChoice"
                                    value="APPOINTMENT"
                                    checked
                                    onclick="switchBillType('APPOINTMENT')"
                                    class="mt-1 h-4 w-4 accent-[#2563EB]"
                                />


                                <div>

                                    <p
                                        class="font-manrope text-sm font-bold text-slate-800">

                                        Appointment Bill

                                    </p>


                                    <p
                                        class="mt-1 font-inter text-[11px] leading-5 text-slate-500">

                                        Create a bill from an existing appointment.

                                    </p>

                                </div>

                            </div>

                        </label>



                        <!-- =================================================
                             WALK-IN
                        ================================================== -->

                        <label
                            id="walkInTypeCard"
                            class="cursor-pointer rounded-xl border-2 border-slate-200 bg-white p-5 transition hover:border-blue-300">


                            <div class="flex items-start gap-3">


                                <input
                                    type="radio"
                                    name="billTypeChoice"
                                    value="WALK_IN"
                                    onclick="switchBillType('WALK_IN')"
                                    class="mt-1 h-4 w-4 accent-[#2563EB]"
                                />


                                <div>

                                    <p
                                        class="font-manrope text-sm font-bold text-slate-800">

                                        Walk-in / Custom Bill

                                    </p>


                                    <p
                                        class="mt-1 font-inter text-[11px] leading-5 text-slate-500">

                                        Create a bill without an existing appointment.

                                    </p>

                                </div>

                            </div>

                        </label>

                    </div>

                </div>



                <!-- =================================================
                     FORM
                ================================================== -->

                <form
                    method="post"
                    action="<%= contextPath %>/bills/add"
                    id="billForm">


                    <input
                        type="hidden"
                        name="billType"
                        id="billType"
                        value="APPOINTMENT"
                    />



                    <!-- =================================================
                         APPOINTMENT SECTION
                    ================================================== -->

                    <div
                        id="appointmentSection"
                        class="border-b border-slate-100 px-6 py-6">


                        <div class="mb-4">


                            <h2
                                class="font-manrope text-sm font-bold text-[#172033]">

                                Appointment Details

                            </h2>


                            <p
                                class="mt-1 font-inter text-[10px] text-slate-400">

                                Select an appointment to automatically load patient, dentist and treatment information.

                            </p>

                        </div>



                        <!-- APPOINTMENT SELECT -->

                        <div class="mb-5">


                            <label
                                class="mb-2 block font-inter text-[10px] font-semibold uppercase tracking-wide text-slate-400">

                                Appointment

                            </label>


                            <select
                                name="appointmentId"
                                id="appointmentId"
                                onchange="loadAppointmentInfo()"
                                class="w-full rounded-lg border border-slate-200 bg-white px-4 py-3 font-inter text-sm text-slate-700 transition focus:border-blue-500 focus:ring-2 focus:ring-blue-100"
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


                                            if (patients != null) {

                                                for (Patient patient : patients) {

                                                    if (patient.getPatientId()
                                                            == appointment.getPatientId()) {

                                                        appointmentPatient = patient;

                                                        break;

                                                    }

                                                }

                                            }


                                            if (dentists != null) {

                                                for (Dentist dentist : dentists) {

                                                    if (dentist.getDentistId()
                                                            == appointment.getDentistId()) {

                                                        appointmentDentist = dentist;

                                                        break;

                                                    }

                                                }

                                            }


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



                        <!-- APPOINTMENT INFO -->

                        <div
                            class="rounded-xl border border-slate-100 bg-slate-50/70 p-5">


                            <div
                                class="grid grid-cols-1 gap-5 md:grid-cols-3">


                                <!-- PATIENT -->

                                <div>

                                    <p
                                        class="font-inter text-[10px] font-semibold uppercase tracking-wide text-slate-400">

                                        Patient

                                    </p>


                                    <p
                                        id="appointmentPatient"
                                        class="mt-1.5 font-manrope text-sm font-bold text-slate-800">

                                        Select an appointment

                                    </p>

                                </div>



                                <!-- DENTIST -->

                                <div>

                                    <p
                                        class="font-inter text-[10px] font-semibold uppercase tracking-wide text-slate-400">

                                        Dentist

                                    </p>


                                    <p
                                        id="appointmentDentist"
                                        class="mt-1.5 font-manrope text-sm font-bold text-slate-800">

                                        Select an appointment

                                    </p>

                                </div>



                                <!-- TREATMENT -->

                                <div>

                                    <p
                                        class="font-inter text-[10px] font-semibold uppercase tracking-wide text-slate-400">

                                        Treatment

                                    </p>


                                    <p
                                        id="appointmentTreatment"
                                        class="mt-1.5 font-manrope text-sm font-bold text-slate-800">

                                        Select an appointment

                                    </p>

                                </div>

                            </div>

                        </div>

                    </div>



                    <!-- =================================================
                         WALK-IN SECTION
                    ================================================== -->

                    <div
                        id="walkInSection"
                        class="hidden border-b border-slate-100 px-6 py-6">


                        <div class="mb-4">


                            <h2
                                class="font-manrope text-sm font-bold text-[#172033]">

                                Walk-in Details

                            </h2>


                            <p
                                class="mt-1 font-inter text-[10px] text-slate-400">

                                Select the patient and treatment for this walk-in bill.

                            </p>

                        </div>



                        <div
                            class="grid grid-cols-1 gap-5 md:grid-cols-2">


                            <!-- PATIENT -->

                            <div>

                                <label
                                    class="mb-2 block font-inter text-[10px] font-semibold uppercase tracking-wide text-slate-400">

                                    Patient

                                </label>


                                <select
                                    name="patientId"
                                    id="patientId"
                                    class="w-full rounded-lg border border-slate-200 bg-white px-4 py-3 font-inter text-sm text-slate-700 transition focus:border-blue-500 focus:ring-2 focus:ring-blue-100"
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

                                <label
                                    class="mb-2 block font-inter text-[10px] font-semibold uppercase tracking-wide text-slate-400">

                                    Treatment

                                </label>


                                <select
                                    name="treatmentId"
                                    id="treatmentId"
                                    onchange="updateTreatmentFee()"
                                    class="w-full rounded-lg border border-slate-200 bg-white px-4 py-3 font-inter text-sm text-slate-700 transition focus:border-blue-500 focus:ring-2 focus:ring-blue-100"
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



                    <!-- =================================================
                         FEES
                    ================================================== -->

                    <div
                        class="border-b border-slate-100 px-6 py-6">


                        <div class="mb-4">


                            <h2
                                class="font-manrope text-sm font-bold text-[#172033]">

                                Payment Details

                            </h2>


                            <p
                                class="mt-1 font-inter text-[10px] text-slate-400">

                                Review consultation and treatment charges before creating the bill.

                            </p>

                        </div>



                        <div
                            class="grid grid-cols-1 gap-5 md:grid-cols-2">


                            <!-- CONSULTATION -->

                            <div>

                                <label
                                    class="mb-2 block font-inter text-[10px] font-semibold uppercase tracking-wide text-slate-400">

                                    Consultation Fee

                                </label>


                                <div class="relative">

                                    <span
                                        class="pointer-events-none absolute left-4 top-1/2 -translate-y-1/2 font-inter text-xs font-semibold text-slate-400">

                                        LKR

                                    </span>


                                    <input
                                        type="number"
                                        name="consultationFee"
                                        id="consultationFee"
                                        min="0"
                                        step="0.01"
                                        placeholder="0.00"
                                        oninput="calculateTotal()"
                                        class="w-full rounded-lg border border-slate-200 bg-white py-3 pl-14 pr-4 font-inter text-sm text-slate-700 transition focus:border-blue-500 focus:ring-2 focus:ring-blue-100"
                                    />

                                </div>


                                <p
                                    class="mt-1.5 font-inter text-[10px] text-slate-400">

                                    For appointment bills, this is taken from the selected dentist.

                                </p>

                            </div>



                            <!-- TREATMENT FEE -->

                            <div>

                                <label
                                    class="mb-2 block font-inter text-[10px] font-semibold uppercase tracking-wide text-slate-400">

                                    Treatment Fee

                                </label>


                                <div class="relative">

                                    <span
                                        class="pointer-events-none absolute left-4 top-1/2 -translate-y-1/2 font-inter text-xs font-semibold text-slate-400">

                                        LKR

                                    </span>


                                    <input
                                        type="number"
                                        name="treatmentFee"
                                        id="treatmentFee"
                                        min="0"
                                        step="0.01"
                                        readonly
                                        placeholder="0.00"
                                        class="w-full rounded-lg border border-slate-200 bg-slate-50 py-3 pl-14 pr-4 font-inter text-sm text-slate-600"
                                    />

                                </div>


                                <p
                                    class="mt-1.5 font-inter text-[10px] text-slate-400">

                                    Automatically loaded from the selected treatment.

                                </p>

                            </div>

                        </div>



                        <!-- =================================================
                             TOTAL
                        ================================================== -->

                        <div
                            class="mt-6 flex items-center justify-between rounded-xl bg-blue-50 px-5 py-5">


                            <div>

                                <p
                                    class="font-inter text-[10px] font-semibold uppercase tracking-wide text-blue-600">

                                    Total Amount

                                </p>


                                <p
                                    class="mt-1 font-inter text-[10px] text-blue-500">

                                    Consultation + treatment

                                </p>

                            </div>


                            <p
                                id="totalAmount"
                                class="font-manrope text-2xl font-extrabold text-[#2563EB]">

                                LKR 0.00

                            </p>

                        </div>

                    </div>



                    <!-- =================================================
                         FORM ACTIONS
                    ================================================== -->

                    <div
                        class="flex flex-col-reverse gap-3 px-6 py-5 sm:flex-row sm:items-center sm:justify-end">


                        <a
                            href="<%= contextPath %>/bills"
                            class="inline-flex justify-center rounded-lg border border-slate-200 bg-white px-5 py-2.5 font-inter text-xs font-semibold text-slate-700 transition hover:bg-slate-50">

                            Cancel

                        </a>


                        <button
                            type="submit"
                            class="inline-flex justify-center rounded-lg bg-[#2563EB] px-5 py-2.5 font-inter text-xs font-bold text-white shadow-sm transition hover:bg-[#1D4ED8]">

                            Create Bill

                        </button>

                    </div>


                </form>

            </div>



            <!-- =================================================
                 FOOTER
            ================================================== -->

            <div
                class="mt-4 px-1">


                <p
                    class="font-inter text-[10px] text-slate-400">

                    Sunrise Dental Clinic Management System

                </p>

            </div>


        </div>

    </main>

</div>



<!-- =========================================================
     JAVASCRIPT
========================================================= -->

<script>


    // =========================================================
    // SWITCH BILL TYPE
    // =========================================================

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


            appointmentSection.classList.remove(
                "hidden"
            );

            walkInSection.classList.add(
                "hidden"
            );


            appointmentCard.classList.remove(
                "border-slate-200",
                "bg-white"
            );

            appointmentCard.classList.add(
                "border-[#2563EB]",
                "bg-blue-50"
            );


            walkInCard.classList.remove(
                "border-[#2563EB]",
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


            appointmentSection.classList.add(
                "hidden"
            );

            walkInSection.classList.remove(
                "hidden"
            );


            walkInCard.classList.remove(
                "border-slate-200",
                "bg-white"
            );

            walkInCard.classList.add(
                "border-[#2563EB]",
                "bg-blue-50"
            );


            appointmentCard.classList.remove(
                "border-[#2563EB]",
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



    // =========================================================
    // LOAD APPOINTMENT INFORMATION
    // =========================================================

    function loadAppointmentInfo() {

        const select =
            document.getElementById(
                "appointmentId"
            );


        const selected =
            select.options[
                select.selectedIndex
            ];


        const patient =
            document.getElementById(
                "appointmentPatient"
            );


        const dentist =
            document.getElementById(
                "appointmentDentist"
            );


        const treatment =
            document.getElementById(
                "appointmentTreatment"
            );


        const consultationFee =
            document.getElementById(
                "consultationFee"
            );


        const treatmentFee =
            document.getElementById(
                "treatmentFee"
            );


        if (!selected.value) {

            resetAppointmentInfo();

            consultationFee.value = "";

            treatmentFee.value = "";

            calculateTotal();

            return;

        }


        patient.innerText =
            selected.dataset.patient ||
            "Not available";


        dentist.innerText =
            selected.dataset.dentist ||
            "Not available";


        treatment.innerText =
            selected.dataset.treatment ||
            "Not available";


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



    // =========================================================
    // RESET APPOINTMENT INFO
    // =========================================================

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



    // =========================================================
    // UPDATE TREATMENT FEE
    // =========================================================

    function updateTreatmentFee() {

        const select =
            document.getElementById(
                "treatmentId"
            );


        const selected =
            select.options[
                select.selectedIndex
            ];


        const fee =
            selected.getAttribute(
                "data-fee"
            );


        const treatmentFee =
            document.getElementById(
                "treatmentFee"
            );


        if (fee) {

            treatmentFee.value =
                parseFloat(fee).toFixed(2);

        }

        else {

            treatmentFee.value = "";

        }


        calculateTotal();

    }



    // =========================================================
    // CALCULATE TOTAL
    // =========================================================

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



    // =========================================================
    // FORM SUBMIT
    // =========================================================

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