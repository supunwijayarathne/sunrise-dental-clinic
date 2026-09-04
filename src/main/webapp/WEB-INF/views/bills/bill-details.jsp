<%@ page contentType="text/html;charset=UTF-8" %>

<% String contextPath = request.getContextPath(); %>

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

    <jsp:include page="../common/sidebar.jsp" />

    <main class="ml-[250px] min-h-screen flex-1 px-8 py-7">

        <div class="mx-auto max-w-[1200px]">

            <div class="mb-7 flex items-end justify-between">

                <div>
                    <p class="mb-1 font-inter text-[10px] font-semibold uppercase tracking-[0.12em] text-blue-600">
                        Billing
                    </p>

                    <h1 class="font-manrope text-2xl font-extrabold tracking-tight text-[#172033]">
                        Bill Details
                    </h1>

                    <p class="mt-1.5 font-inter text-xs text-slate-500">
                        View detailed information about this bill.
                    </p>
                </div>

                <div class="hidden items-center gap-2 rounded-lg border border-slate-200 bg-white px-4 py-2.5 md:flex">
                    <svg class="h-4 w-4 text-slate-400" fill="none" stroke="currentColor" stroke-width="1.8" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" d="M6 2h12v20l-3-2-3-2-3 2-3 2V2z"/>
                        <path stroke-linecap="round" d="M9 7h6M9 11h6M9 15h3"/>
                    </svg>
                    <span id="headerBillNumber" class="font-inter text-[11px] font-medium text-slate-500">
                        Bill Details
                    </span>
                </div>

            </div>

            <div class="mb-5 flex flex-wrap items-center gap-2.5 no-print">

                <a href="<%= contextPath %>/bills"
                   class="inline-flex items-center gap-2 rounded-lg border border-slate-200 bg-white px-4 py-2.5 font-inter text-[11px] font-semibold text-slate-700 transition hover:border-slate-300 hover:bg-slate-50">
                    <svg class="h-4 w-4" fill="none" stroke="currentColor" stroke-width="1.8" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" d="M19 12H5"/>
                        <path stroke-linecap="round" stroke-linejoin="round" d="M12 19l-7-7 7-7"/>
                    </svg>
                    Back to Bills
                </a>

                <a id="printBillLink" href="#" target="_blank"
                   class="inline-flex items-center gap-2 rounded-lg bg-[#2563EB] px-4 py-2.5 font-inter text-[11px] font-bold text-white shadow-sm transition hover:bg-[#1D4ED8]">
                    <svg class="h-4 w-4" fill="none" stroke="currentColor" stroke-width="1.8" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" d="M6 9V2h12v7"/>
                        <path stroke-linecap="round" stroke-linejoin="round" d="M6 18H4a2 2 0 01-2-2v-5a2 2 0 012-2h16a2 2 0 012 2v5a2 2 0 01-2 2h-2"/>
                        <path stroke-linecap="round" stroke-linejoin="round" d="M6 14h12v8H6z"/>
                    </svg>
                    Print Bill
                </a>

            </div>

            <div id="billError" class="hidden mb-5 rounded-xl border border-red-200 bg-red-50 px-5 py-4">
                <p class="font-manrope text-xs font-bold text-red-700">Unable to load bill</p>
                <p id="billErrorText" class="mt-1 font-inter text-[11px] text-red-600"></p>
            </div>

            <div class="print-card overflow-hidden rounded-xl border border-slate-200 bg-white">

                <div class="border-b border-slate-100 px-6 py-5">
                    <div class="flex flex-col gap-5 sm:flex-row sm:items-center sm:justify-between">

                        <div>
                            <p class="font-inter text-[10px] font-semibold uppercase tracking-wide text-slate-400">
                                Bill Number
                            </p>
                            <h2 id="billNumber" class="mt-1 font-manrope text-xl font-extrabold text-[#172033]">
                                Loading...
                            </h2>
                        </div>

                        <div>
                            <p class="mb-2 font-inter text-[10px] font-semibold uppercase tracking-wide text-slate-400">
                                Bill Type
                            </p>
                            <span id="billTypeBadge" class="inline-flex items-center rounded-full bg-blue-50 px-3 py-1.5 font-inter text-[10px] font-bold text-blue-700">
                                Appointment
                            </span>
                        </div>

                    </div>
                </div>

                <div class="border-b border-slate-100 px-6 py-6">

                    <div class="mb-4">
                        <h2 class="font-manrope text-sm font-bold text-[#172033]">Patient Information</h2>
                        <p class="mt-0.5 font-inter text-[10px] text-slate-400">Patient associated with this bill.</p>
                    </div>

                    <div class="grid grid-cols-1 gap-4 md:grid-cols-2">

                        <div class="rounded-lg border border-slate-100 bg-slate-50/60 p-4">
                            <p class="font-inter text-[10px] font-semibold uppercase tracking-wide text-slate-400">Patient</p>
                            <p id="patientName" class="mt-1.5 font-manrope text-sm font-bold text-slate-800">Loading...</p>
                        </div>

                        <div class="rounded-lg border border-slate-100 bg-slate-50/60 p-4">
                            <p class="font-inter text-[10px] font-semibold uppercase tracking-wide text-slate-400">Patient ID</p>
                            <p id="patientId" class="mt-1.5 font-manrope text-sm font-bold text-slate-800">-</p>
                        </div>

                    </div>
                </div>

                <div id="appointmentSection" class="hidden border-b border-slate-100 px-6 py-6">

                    <div class="mb-4">
                        <h2 class="font-manrope text-sm font-bold text-[#172033]">Appointment Information</h2>
                        <p class="mt-0.5 font-inter text-[10px] text-slate-400">Appointment, dentist and treatment information.</p>
                    </div>

                    <div class="grid grid-cols-1 gap-4 md:grid-cols-3">

                        <div class="rounded-lg border border-slate-100 bg-slate-50/60 p-4">
                            <p class="font-inter text-[10px] font-semibold uppercase tracking-wide text-slate-400">Appointment</p>
                            <p id="appointmentNumber" class="mt-1.5 font-manrope text-sm font-bold text-slate-800">-</p>
                        </div>

                        <div class="rounded-lg border border-slate-100 bg-slate-50/60 p-4">
                            <p class="font-inter text-[10px] font-semibold uppercase tracking-wide text-slate-400">Dentist</p>
                            <p id="dentistName" class="mt-1.5 font-manrope text-sm font-bold text-slate-800">-</p>
                        </div>

                        <div class="rounded-lg border border-slate-100 bg-slate-50/60 p-4">
                            <p class="font-inter text-[10px] font-semibold uppercase tracking-wide text-slate-400">Treatment</p>
                            <p id="treatmentName" class="mt-1.5 font-manrope text-sm font-bold text-slate-800">-</p>
                        </div>

                    </div>
                </div>

                <div id="walkInTreatmentSection" class="hidden border-b border-slate-100 px-6 py-6">

                    <div class="mb-4">
                        <h2 class="font-manrope text-sm font-bold text-[#172033]">Treatment Information</h2>
                        <p class="mt-0.5 font-inter text-[10px] text-slate-400">Treatment associated with this walk-in bill.</p>
                    </div>

                    <div class="rounded-lg border border-slate-100 bg-slate-50/60 p-4">
                        <p class="font-inter text-[10px] font-semibold uppercase tracking-wide text-slate-400">Treatment</p>
                        <p id="walkInTreatmentName" class="mt-1.5 font-manrope text-sm font-bold text-slate-800">-</p>
                    </div>

                </div>

                <div class="px-6 py-7">

                    <div class="flex flex-col lg:flex-row lg:justify-end">

                        <div class="w-full max-w-[500px]">

                            <div class="mb-4">
                                <h2 class="font-manrope text-sm font-bold text-[#172033]">Payment Summary</h2>
                                <p class="mt-0.5 font-inter text-[10px] text-slate-400">Breakdown of charges for this bill.</p>
                            </div>

                            <div class="flex items-center justify-between border-b border-slate-100 py-3">
                                <span class="font-inter text-xs text-slate-500">Consultation Fee</span>
                                <span id="consultationFee" class="font-manrope text-sm font-semibold text-slate-700">LKR 0.00</span>
                            </div>

                            <div class="flex items-center justify-between border-b border-slate-100 py-3">
                                <span class="font-inter text-xs text-slate-500">Treatment Fee</span>
                                <span id="treatmentFee" class="font-manrope text-sm font-semibold text-slate-700">LKR 0.00</span>
                            </div>

                            <div class="mt-4 flex items-center justify-between rounded-lg bg-blue-50 px-5 py-4">

                                <div>
                                    <p class="font-inter text-[10px] font-semibold uppercase tracking-wide text-blue-600">Total Amount</p>
                                    <p class="mt-0.5 font-inter text-[10px] text-blue-500">Amount payable</p>
                                </div>

                                <p id="totalAmount" class="font-manrope text-xl font-extrabold text-[#2563EB]">LKR 0.00</p>

                            </div>

                        </div>

                    </div>
                </div>

            </div>

            <div class="mt-4 flex items-center justify-between px-1">
                <p class="font-inter text-[10px] text-slate-400">Sunrise Dental Clinic Management System</p>
                <p class="font-inter text-[10px] text-slate-400">Bill ID #<span id="footerBillId">-</span></p>
            </div>

        </div>
    </main>
</div>

<script>
(function () {
    "use strict";

    var contextPath = "<%= contextPath %>";
    var params = new URLSearchParams(window.location.search);
    var billId = params.get("id") || params.get("billId") || "";

    function setText(id, value) {
        var el = document.getElementById(id);
        if (el) {
            el.textContent = value == null || value === "" ? "N/A" : String(value);
        }
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
                return response.text().then(function (body) {
                    throw new Error(body || "Request failed");
                });
            }
            return response.json();
        });
    }

    function money(value) {
        var n = Number(value);
        return isNaN(n) ? "LKR 0.00" : "LKR " + n.toFixed(2);
    }

    function showError(message) {
        document.getElementById("billError").classList.remove("hidden");
        document.getElementById("billErrorText").textContent = message;
    }

    function loadBill() {
        if (!billId) {
            showError("No bill ID was provided.");
            return;
        }

        getJson("/api/billing/" + encodeURIComponent(billId))
            .then(function (bill) {
                setText("headerBillNumber", bill.billNumber);
                setText("billNumber", bill.billNumber);
                setText("patientId", "#" + bill.patientId);
                setText("footerBillId", bill.billId);

                var type = String(bill.billType || "").toUpperCase();
                var badge = document.getElementById("billTypeBadge");

                if (type === "WALK_IN") {
                    badge.textContent = "Walk-in";
                    badge.className = "inline-flex items-center rounded-full bg-amber-50 px-3 py-1.5 font-inter text-[10px] font-bold text-amber-700";
                    document.getElementById("walkInTreatmentSection").classList.remove("hidden");
                } else {
                    badge.textContent = "Appointment";
                    badge.className = "inline-flex items-center rounded-full bg-blue-50 px-3 py-1.5 font-inter text-[10px] font-bold text-blue-700";
                    document.getElementById("appointmentSection").classList.remove("hidden");
                }

                setText("consultationFee", money(bill.consultationFee));
                setText("treatmentFee", money(bill.treatmentFee));
                setText("totalAmount", money(bill.totalAmount));

                var printLink = document.getElementById("printBillLink");
                printLink.href = contextPath + "/bills/print?id=" + encodeURIComponent(bill.billId);

                return Promise.all([
                    getJson("/api/patients/" + encodeURIComponent(bill.patientId)),
                    bill.treatmentId
                        ? getJson("/api/treatments/" + encodeURIComponent(bill.treatmentId))
                        : Promise.resolve(null),
                    bill.appointmentId
                        ? getJson("/api/appointments/" + encodeURIComponent(bill.appointmentId))
                        : Promise.resolve(null)
                ]).then(function (data) {
                    var patient = data[0];
                    var treatment = data[1];
                    var appointment = data[2];

                    setText("patientName", patient && (patient.name || patient.fullName || patient.patientName));
                    if (treatment) {
                        setText("treatmentName", treatment.treatmentName || treatment.name);
                        setText("walkInTreatmentName", treatment.treatmentName || treatment.name);
                    }

                    if (appointment) {
                        setText("appointmentNumber", appointment.appointmentNumber);

                        if (appointment.dentistId) {
                            return getJson("/api/dentists/" + encodeURIComponent(appointment.dentistId))
                                .then(function (dentist) {
                                    setText("dentistName", dentist && (dentist.dentistName || dentist.name));
                                });
                        }
                    }
                });
            })
            .catch(function (error) {
                console.error("Could not load bill details:", error);
                showError(error.message || "Could not load bill details.");
            });
    }

    loadBill();
})();
</script>

</body>
</html>