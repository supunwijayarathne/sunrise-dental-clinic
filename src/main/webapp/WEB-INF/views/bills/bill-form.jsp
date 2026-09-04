<%@ page contentType="text/html;charset=UTF-8" %>

<% String contextPath = request.getContextPath(); %>
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

                        New Bill

                    </span>

                </div>

            </div>



            <!-- =================================================
                 ERROR MESSAGE
            ================================================== -->

            



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
                            value=""
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
(function () {
    "use strict";

    var contextPath = "<%= contextPath %>";

    var billForm = document.getElementById("billForm");
    var billType = document.getElementById("billType");
    var appointmentSelect = document.getElementById("appointmentId");
    var patientSelect = document.getElementById("patientId");
    var treatmentSelect = document.getElementById("treatmentId");
    var consultationFee = document.getElementById("consultationFee");
    var treatmentFee = document.getElementById("treatmentFee");
    var totalAmount = document.getElementById("totalAmount");

    function escapeHtml(value) {
        return String(value == null ? "" : value)
            .replace(/&/g, "&amp;")
            .replace(/</g, "&lt;")
            .replace(/>/g, "&gt;")
            .replace(/"/g, "&quot;")
            .replace(/'/g, "&#039;");
    }

    function getJson(url) {
        return fetch(contextPath + url, {
            method: "GET",
            credentials: "same-origin",
            headers: { "Accept": "application/json" }
        }).then(function (response) {
            if (response.status === 401) {
                window.location.href = contextPath + "/login";
                throw new Error("Not authenticated");
            }

            if (!response.ok) {
                throw new Error("Unable to load data.");
            }

            return response.json();
        });
    }

    function showApiError(message) {
        var existing = document.getElementById("restApiError");

        if (!existing) {
            existing = document.createElement("div");
            existing.id = "restApiError";
            existing.className = "mb-5 rounded-xl border border-red-200 bg-red-50 px-5 py-4";

            var title = document.createElement("p");
            title.className = "font-manrope text-xs font-bold text-red-700";
            title.textContent = "Unable to create bill";

            var detail = document.createElement("p");
            detail.id = "restApiErrorText";
            detail.className = "mt-1 font-inter text-[11px] text-red-600";

            existing.appendChild(title);
            existing.appendChild(detail);

            var card = document.getElementById("billForm").parentElement;
            card.parentNode.insertBefore(existing, card);
        }

        document.getElementById("restApiErrorText").textContent = message;
    }

    function money(value) {
        var n = Number(value);
        return isNaN(n) ? "0.00" : n.toFixed(2);
    }

    function calculateTotal() {
        var consultation = parseFloat(consultationFee.value) || 0;
        var treatment = parseFloat(treatmentFee.value) || 0;
        totalAmount.innerText = "LKR " + (consultation + treatment).toFixed(2);
    }

    function fillAppointments(appointments) {
        appointmentSelect.innerHTML = '<option value="">Select an appointment</option>';

        appointments.forEach(function (appointment) {
            var option = document.createElement("option");
            option.value = appointment.appointmentId;

            var number = appointment.appointmentNumber || ("Appointment #" + appointment.appointmentId);
            var date = appointment.appointmentDate || "";
            var time = appointment.appointmentTime || "";

            option.textContent = number + " - " + date + " " + time;
            appointmentSelect.appendChild(option);
        });
    }

    function fillPatients(patients) {
        patientSelect.innerHTML = '<option value="">Select patient</option>';

        patients.forEach(function (patient) {
            var option = document.createElement("option");
            option.value = patient.patientId;

            var code = patient.patientCode || ("Patient #" + patient.patientId);
            var name = patient.name || patient.fullName || patient.patientName || "";

            option.textContent = code + " - " + name;
            patientSelect.appendChild(option);
        });
    }

    function fillTreatments(treatments) {
        treatmentSelect.innerHTML = '<option value="">Select treatment</option>';

        treatments.forEach(function (treatment) {
            var option = document.createElement("option");
            option.value = treatment.treatmentId;
            option.setAttribute("data-fee", treatment.treatmentFee == null ? "0" : treatment.treatmentFee);
            option.textContent = treatment.treatmentName || treatment.name || ("Treatment #" + treatment.treatmentId);
            treatmentSelect.appendChild(option);
        });
    }

    function generateBillNumber(bills) {
        var maxId = 0;

        if (Array.isArray(bills)) {
            bills.forEach(function (bill) {
                var id = Number(bill.billId);
                if (!isNaN(id) && id > maxId) {
                    maxId = id;
                }
            });
        }

        var nextId = maxId + 1;
        var year = new Date().getFullYear();

        return "BILL-" + year + "-" + String(nextId).padStart(4, "0");
    }

    function loadFormData() {
        return Promise.all([
            getJson("/api/appointments"),
            getJson("/api/patients"),
            getJson("/api/treatments"),
            getJson("/api/billing")
        ]).then(function (data) {
            fillAppointments(data[0] || []);
            fillPatients(data[1] || []);
            fillTreatments(data[2] || []);

            var billNumber = generateBillNumber(data[3] || []);
            var billNumberInput = document.querySelector('input[readonly]');

            if (billNumberInput) {
                billNumberInput.value = billNumber;
            }

            var headerBillNumber = document.querySelector(".md\\:flex span");
            if (headerBillNumber) {
                headerBillNumber.textContent = billNumber;
            }
        });
    }

    function loadAppointmentInfo() {
        var id = appointmentSelect.value;

        if (!id) {
            document.getElementById("appointmentPatient").innerText = "Select an appointment";
            document.getElementById("appointmentDentist").innerText = "Select an appointment";
            document.getElementById("appointmentTreatment").innerText = "Select an appointment";
            consultationFee.value = "";
            treatmentFee.value = "";
            calculateTotal();
            return;
        }

        getJson("/api/appointments/" + encodeURIComponent(id))
            .then(function (appointment) {
                var requests = [
                    getJson("/api/patients/" + encodeURIComponent(appointment.patientId)),
                    getJson("/api/dentists/" + encodeURIComponent(appointment.dentistId)),
                    getJson("/api/treatments/" + encodeURIComponent(appointment.treatmentId))
                ];

                return Promise.all(requests);
            })
            .then(function (data) {
                var patient = data[0];
                var dentist = data[1];
                var treatment = data[2];

                document.getElementById("appointmentPatient").innerText =
                    patient ? (patient.name || patient.fullName || "Not available") : "Not available";

                document.getElementById("appointmentDentist").innerText =
                    dentist ? (dentist.dentistName || dentist.name || "Not available") : "Not available";

                document.getElementById("appointmentTreatment").innerText =
                    treatment ? (treatment.treatmentName || treatment.name || "Not available") : "Not available";

                consultationFee.value =
                    dentist && dentist.consultationFee != null
                        ? money(dentist.consultationFee)
                        : "0.00";

                treatmentFee.value =
                    treatment && treatment.treatmentFee != null
                        ? money(treatment.treatmentFee)
                        : "0.00";

                calculateTotal();
            })
            .catch(function (error) {
                console.error(error);
                showApiError(error.message || "Unable to load appointment details.");
            });
    }

    function updateTreatmentFee() {
        var option = treatmentSelect.options[treatmentSelect.selectedIndex];

        if (option && option.value) {
            treatmentFee.value = money(option.getAttribute("data-fee"));
        } else {
            treatmentFee.value = "";
        }

        calculateTotal();
    }

    window.switchBillType = function (type) {
        var appointmentSection = document.getElementById("appointmentSection");
        var walkInSection = document.getElementById("walkInSection");
        var appointmentCard = document.getElementById("appointmentTypeCard");
        var walkInCard = document.getElementById("walkInTypeCard");

        billType.value = type;

        if (type === "APPOINTMENT") {
            appointmentSection.classList.remove("hidden");
            walkInSection.classList.add("hidden");

            appointmentCard.classList.remove("border-slate-200", "bg-white");
            appointmentCard.classList.add("border-[#2563EB]", "bg-blue-50");

            walkInCard.classList.remove("border-[#2563EB]", "bg-blue-50");
            walkInCard.classList.add("border-slate-200", "bg-white");

            appointmentSelect.required = true;
            patientSelect.required = false;
            treatmentSelect.required = false;

            consultationFee.readOnly = true;
            treatmentFee.readOnly = true;

            patientSelect.value = "";
            treatmentSelect.value = "";
            consultationFee.value = "";
            treatmentFee.value = "";

            calculateTotal();
        } else {
            appointmentSection.classList.add("hidden");
            walkInSection.classList.remove("hidden");

            walkInCard.classList.remove("border-slate-200", "bg-white");
            walkInCard.classList.add("border-[#2563EB]", "bg-blue-50");

            appointmentCard.classList.remove("border-[#2563EB]", "bg-blue-50");
            appointmentCard.classList.add("border-slate-200", "bg-white");

            appointmentSelect.required = false;
            patientSelect.required = true;
            treatmentSelect.required = true;

            consultationFee.readOnly = false;
            treatmentFee.readOnly = true;

            appointmentSelect.value = "";
            consultationFee.value = "";
            treatmentFee.value = "";

            document.getElementById("appointmentPatient").innerText = "Select an appointment";
            document.getElementById("appointmentDentist").innerText = "Select an appointment";
            document.getElementById("appointmentTreatment").innerText = "Select an appointment";

            calculateTotal();
        }
    };

    appointmentSelect.addEventListener("change", loadAppointmentInfo);
    treatmentSelect.addEventListener("change", updateTreatmentFee);
    consultationFee.addEventListener("input", calculateTotal);

    billForm.addEventListener("submit", function (event) {
        event.preventDefault();

        var button = billForm.querySelector('button[type="submit"]');
        var billNumberInput = billForm.querySelector('input[readonly]');
        var type = billType.value;

        if (!billNumberInput || !billNumberInput.value.trim()) {
            showApiError("Unable to generate bill number.");
            return;
        }

        var patientId = type === "APPOINTMENT"
            ? ""
            : patientSelect.value;

        if (type === "APPOINTMENT" && !appointmentSelect.value) {
            showApiError("Please select an appointment.");
            return;
        }

        if (type === "WALK_IN" && (!patientSelect.value || !treatmentSelect.value)) {
            showApiError("Please select a patient and treatment.");
            return;
        }

        var payload = {
            billNumber: billNumberInput.value.trim(),
            billType: type,
            appointmentId: type === "APPOINTMENT" ? appointmentSelect.value : "",
            patientId: type === "APPOINTMENT" ? "" : patientSelect.value,
            treatmentId: type === "APPOINTMENT" ? "" : treatmentSelect.value,
            consultationFee: consultationFee.value || "0",
            treatmentFee: treatmentFee.value || "0"
        };

        if (type === "APPOINTMENT") {
            // The appointment API is used to obtain the patient/treatment IDs.
            getJson("/api/appointments/" + encodeURIComponent(appointmentSelect.value))
                .then(function (appointment) {
                    payload.patientId = appointment.patientId;
                    payload.treatmentId = appointment.treatmentId;
                    return createBill(payload);
                })
                .catch(function (error) {
                    showApiError(error.message || "Unable to load appointment.");
                });
        } else {
            createBill(payload);
        }

        function createBill(data) {
            button.disabled = true;
            button.textContent = "Creating...";

            return fetch(contextPath + "/api/billing", {
                method: "POST",
                credentials: "same-origin",
                headers: {
                    "Content-Type": "application/x-www-form-urlencoded",
                    "Accept": "application/json"
                },
                body: new URLSearchParams(data).toString()
            })
            .then(function (response) {
                return response.text().then(function (body) {
                    var json = null;

                    try {
                        json = body ? JSON.parse(body) : null;
                    } catch (e) {}

                    if (!response.ok) {
                        throw new Error(
                            json && (json.message || json.error)
                                ? (json.message || json.error)
                                : body || "Unable to create bill."
                        );
                    }

                    return json;
                });
            })
            .then(function (createdBill) {
                var createdId = createdBill && createdBill.billId;

                if (createdId) {
                    window.location.href =
                        contextPath +
                        "/bills/view?id=" +
                        encodeURIComponent(createdId) +
                        "&success=1";
                } else {
                    window.location.href = contextPath + "/bills?success=1";
                }
            })
            .catch(function (error) {
                console.error("Bill creation failed:", error);
                showApiError(error.message || "Unable to create bill.");

                button.disabled = false;
                button.textContent = "Create Bill";
            });
        }
    });

    loadFormData().catch(function (error) {
        console.error("Could not load billing form data:", error);
        showApiError(error.message || "Could not load appointments, patients, treatments or bills.");
    });

    window.calculateTotal = calculateTotal;
    window.updateTreatmentFee = updateTreatmentFee;

})();
</script>

</body>

</html>