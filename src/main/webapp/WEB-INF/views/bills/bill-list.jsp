<%@ page contentType="text/html;charset=UTF-8" %>

<% String contextPath = request.getContextPath(); %>

<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="UTF-8">

    <meta
        name="viewport"
        content="width=device-width, initial-scale=1.0">

    <title>Billing | Sunrise Dental</title>


    <!-- Tailwind -->

    <script src="https://cdn.tailwindcss.com"></script>


    <!-- Fonts -->

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

    </style>

</head>


<body
    class="min-h-screen bg-[#F5F7FB] font-manrope text-[#172033]">


<div class="flex min-h-screen">


    <!-- =====================================================
         SHARED SIDEBAR
    ====================================================== -->

    <jsp:include page="../common/sidebar.jsp" />



    <!-- =====================================================
         MAIN CONTENT
    ====================================================== -->

    <main
        class="ml-[250px] min-h-screen flex-1 px-8 py-7">


        <div
            class="mx-auto max-w-[1200px]">


            <!-- =================================================
                 PAGE HEADER
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

                        Billing

                    </h1>


                    <p
                        class="mt-1.5 font-inter text-xs text-slate-500">

                        Manage patient bills and payments.

                    </p>

                </div>



                <!-- CREATE BILL -->

                <a
                    href="<%= contextPath %>/bills/add"
                    class="inline-flex items-center gap-2 rounded-lg bg-[#2563EB] px-5 py-2.5 font-inter text-xs font-bold text-white shadow-sm transition hover:bg-[#1D4ED8]">


                    <svg
                        class="h-4 w-4"
                        fill="none"
                        stroke="currentColor"
                        stroke-width="1.8"
                        viewBox="0 0 24 24">

                        <path
                            stroke-linecap="round"
                            stroke-linejoin="round"
                            d="M12 5v14M5 12h14"/>

                    </svg>


                    Create Bill

                </a>

            </div>



            <!-- =================================================
                 SEARCH / FILTER CARD
            ================================================== -->

            <div
                class="mb-6 rounded-xl border border-slate-200 bg-white p-5">


                <div class="mb-4">


                    <h2
                        class="font-manrope text-sm font-bold text-[#172033]">

                        Search Bills

                    </h2>


                    <p
                        class="mt-1 font-inter text-[10px] text-slate-400">

                        Search by bill number, patient or appointment.

                    </p>

                </div>



                <div
                    id="billingSearchForm"
                    class="flex flex-col gap-3 md:flex-row">


                    <!-- SEARCH -->

                    <div class="relative flex-1">


                        <svg
                            class="pointer-events-none absolute left-4 top-1/2 h-4 w-4 -translate-y-1/2 text-slate-400"
                            fill="none"
                            stroke="currentColor"
                            stroke-width="1.8"
                            viewBox="0 0 24 24">

                            <circle cx="11" cy="11" r="7"/>

                            <path
                                stroke-linecap="round"
                                d="m20 20-4-4"/>

                        </svg>


                        <input
                            type="text"
                            id="keyword"
                            placeholder="Search bill number, patient, appointment..."
                            class="w-full rounded-lg border border-slate-200 bg-white py-3 pl-11 pr-4 font-inter text-xs text-slate-700 placeholder:text-slate-400 focus:border-blue-500 focus:ring-2 focus:ring-blue-100"
                        />

                    </div>


                    <!-- BILL TYPE -->

                    <select
                        id="billType"
                        class="rounded-lg border border-slate-200 bg-white px-4 py-3 font-inter text-xs font-medium text-slate-700 focus:border-blue-500 focus:ring-2 focus:ring-blue-100 md:w-[190px]"
                    >

                        <option value="ALL">All Bills</option>

                        <option value="APPOINTMENT">Appointment Bills</option>

                        <option value="WALK_IN">Walk-in Bills</option>

                    </select>


                    <!-- SEARCH BUTTON -->

                    <button
                        type="button"
                        id="searchButton"
                        class="inline-flex items-center justify-center rounded-lg bg-[#2563EB] px-6 py-3 font-inter text-xs font-bold text-white transition hover:bg-[#1D4ED8]">

                        Search

                    </button>


                    <!-- CLEAR -->

                    <button
                        type="button"
                        id="clearButton"
                        class="inline-flex items-center justify-center rounded-lg border border-slate-200 bg-white px-5 py-3 font-inter text-xs font-semibold text-slate-600 transition hover:bg-slate-50">

                        Clear

                    </button>

                </div>

            </div>



            <!-- =================================================
                 BILLS TABLE CARD
            ================================================== -->

            <div
                class="overflow-hidden rounded-xl border border-slate-200 bg-white">


                <!-- TABLE HEADER -->

                <div
                    class="flex items-center justify-between border-b border-slate-100 px-6 py-5">


                    <div>


                        <h2
                            class="font-manrope text-sm font-bold text-[#172033]">

                            Bills

                        </h2>


                        <p id="billCount" class="mt-1 font-inter text-[10px] text-slate-400">0 bill(s) found</p>

                    </div>


                    <!-- CURRENT FILTER -->

                    <span
                            id="currentFilter"
                            class="hidden rounded-full bg-blue-50 px-3 py-1.5 font-inter text-[10px] font-bold text-blue-700">
                        </span>

                </div>



                <!-- =================================================
                     TABLE
                ================================================== -->

                <div class="overflow-x-auto">


                    <table class="w-full text-left">


                        <!-- TABLE HEAD -->

                        <thead
                            class="border-b border-slate-100 bg-slate-50/70">


                            <tr>


                                <th
                                    class="px-6 py-3.5 font-inter text-[10px] font-semibold uppercase tracking-[0.08em] text-slate-400">

                                    Bill

                                </th>


                                <th
                                    class="px-6 py-3.5 font-inter text-[10px] font-semibold uppercase tracking-[0.08em] text-slate-400">

                                    Patient

                                </th>


                                <th
                                    class="px-6 py-3.5 font-inter text-[10px] font-semibold uppercase tracking-[0.08em] text-slate-400">

                                    Type

                                </th>


                                <th
                                    class="px-6 py-3.5 font-inter text-[10px] font-semibold uppercase tracking-[0.08em] text-slate-400">

                                    Total

                                </th>


                                <th
                                    class="px-6 py-3.5 text-right font-inter text-[10px] font-semibold uppercase tracking-[0.08em] text-slate-400">

                                    Action

                                </th>


                            </tr>

                        </thead>



                        <!-- TABLE BODY -->

                        <tbody
                            id="billingTableBody"
                            class="divide-y divide-slate-100">

                        <tr>
                            <td colspan="5" class="px-6 py-16 text-center">
                                <p class="font-inter text-xs text-slate-400">Loading bills...</p>
                            </td>
                        </tr>

                    </tbody>

                    </table>

                </div>

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



<script>
(function () {
    "use strict";

    var contextPath = "<%= contextPath %>";
    var billingApiUrl = contextPath + "/api/billing";

    var tableBody = document.getElementById("billingTableBody");
    var billCount = document.getElementById("billCount");
    var keywordInput = document.getElementById("keyword");
    var billTypeSelect = document.getElementById("billType");
    var searchButton = document.getElementById("searchButton");
    var clearButton = document.getElementById("clearButton");
    var currentFilter = document.getElementById("currentFilter");

    function escapeHtml(value) {
        return String(value == null ? "" : value)
            .replace(/&/g, "&amp;")
            .replace(/</g, "&lt;")
            .replace(/>/g, "&gt;")
            .replace(/"/g, "&quot;")
            .replace(/'/g, "&#039;");
    }

    function getBillId(bill) {
        return bill.billId != null ? bill.billId : "";
    }

    function getBillNumber(bill) {
        return bill.billNumber != null ? bill.billNumber : "-";
    }

    function getPatientId(bill) {
        return bill.patientId != null ? bill.patientId : "-";
    }

    function getBillType(bill) {
        return String(bill.billType || "").toUpperCase();
    }

    function getTotalAmount(bill) {
        var amount = Number(bill.totalAmount);
        return isNaN(amount) ? "0.00" : amount.toFixed(2);
    }

    function showEmpty(message) {
        tableBody.innerHTML =
            '<tr>' +
                '<td colspan="5" class="px-6 py-16 text-center">' +
                    '<div class="mx-auto flex h-12 w-12 items-center justify-center rounded-xl bg-slate-100">' +
                        '<svg class="h-6 w-6 text-slate-400" fill="none" stroke="currentColor" stroke-width="1.7" viewBox="0 0 24 24">' +
                            '<path stroke-linecap="round" stroke-linejoin="round" d="M6 2h12v20l-3-2-3 2-3-2-3 2V2z"/>' +
                            '<path stroke-linecap="round" d="M9 7h6M9 11h6"/>' +
                        '</svg>' +
                    '</div>' +
                    '<p class="mt-4 font-manrope text-sm font-bold text-slate-700">' +
                        escapeHtml(message) +
                    '</p>' +
                    '<p class="mt-1 font-inter text-[11px] text-slate-400">' +
                        'Try changing your search or create a new bill.' +
                    '</p>' +
                    '<a href="' + contextPath + '/bills/add" class="mt-5 inline-flex items-center gap-2 rounded-lg bg-[#2563EB] px-4 py-2.5 font-inter text-xs font-bold text-white hover:bg-[#1D4ED8]">' +
                        'Create Bill' +
                    '</a>' +
                '</td>' +
            '</tr>';
    }

    function renderBills(bills) {
        if (!Array.isArray(bills) || bills.length === 0) {
            billCount.textContent = "0 bill(s) found";
            showEmpty("No bills found");
            return;
        }

        billCount.textContent = bills.length + " bill(s) found";

        var html = "";

        bills.forEach(function (bill) {
            var billId = getBillId(bill);
            var type = getBillType(bill);
            var typeLabel = type === "WALK_IN" ? "Walk-in" : "Appointment";
            var typeClass = type === "WALK_IN"
                ? "bg-amber-50 text-amber-700"
                : "bg-blue-50 text-blue-700";

            html +=
                '<tr class="transition hover:bg-slate-50/70">' +

                    '<td class="px-6 py-4">' +
                        '<div class="font-manrope text-xs font-bold text-slate-800">' +
                            escapeHtml(getBillNumber(bill)) +
                        '</div>' +
                        '<div class="mt-1 font-inter text-[10px] text-slate-400">' +
                            'Bill ID #' + escapeHtml(billId) +
                        '</div>' +
                    '</td>' +

                    '<td class="px-6 py-4">' +
                        '<div class="font-inter text-xs font-medium text-slate-700">' +
                            'Patient #' + escapeHtml(getPatientId(bill)) +
                        '</div>' +
                    '</td>' +

                    '<td class="px-6 py-4">' +
                        '<span class="inline-flex items-center rounded-full ' + typeClass + ' px-3 py-1.5 font-inter text-[10px] font-bold">' +
                            typeLabel +
                        '</span>' +
                    '</td>' +

                    '<td class="px-6 py-4">' +
                        '<span class="font-manrope text-xs font-bold text-slate-800">' +
                            'LKR ' + escapeHtml(getTotalAmount(bill)) +
                        '</span>' +
                    '</td>' +

                    '<td class="px-6 py-4 text-right">' +
                        '<a href="' + contextPath + '/bills/view?id=' + encodeURIComponent(billId) + '"' +
                           ' class="inline-flex items-center gap-1.5 rounded-lg border border-slate-200 bg-white px-3.5 py-2 font-inter text-[10px] font-bold text-slate-600 transition hover:border-blue-200 hover:bg-blue-50 hover:text-blue-700">' +
                            'View' +
                            '<svg class="h-3.5 w-3.5" fill="none" stroke="currentColor" stroke-width="1.8" viewBox="0 0 24 24">' +
                                '<path stroke-linecap="round" stroke-linejoin="round" d="M9 5l7 7-7 7"/>' +
                            '</svg>' +
                        '</a>' +
                    '</td>' +

                '</tr>';
        });

        tableBody.innerHTML = html;
    }

    function updateFilterBadge(type) {
        if (!currentFilter) {
            return;
        }

        if (type === "WALK_IN") {
            currentFilter.textContent = "Walk-in";
            currentFilter.classList.remove("hidden");
        } else if (type === "APPOINTMENT") {
            currentFilter.textContent = "Appointment";
            currentFilter.classList.remove("hidden");
        } else {
            currentFilter.textContent = "";
            currentFilter.classList.add("hidden");
        }
    }

    function loadBills() {
        var keyword = keywordInput.value.trim();
        var billType = billTypeSelect.value;

        tableBody.innerHTML =
            '<tr>' +
                '<td colspan="5" class="px-6 py-16 text-center">' +
                    '<p class="font-inter text-xs text-slate-400">Loading bills...</p>' +
                '</td>' +
            '</tr>';

        updateFilterBadge(billType);

        var params = new URLSearchParams();

        if (keyword !== "") {
            params.set("keyword", keyword);
        }

        if (billType !== "ALL") {
            params.set("billType", billType);
        }

        var url = billingApiUrl;

        if (params.toString() !== "") {
            url += "?" + params.toString();
        }

        fetch(url, {
            method: "GET",
            credentials: "same-origin",
            headers: {
                "Accept": "application/json"
            }
        })
        .then(function (response) {
            if (!response.ok) {
                return response.text().then(function (body) {
                    throw new Error("Billing API returned " + response.status + (body ? ": " + body : ""));
                });
            }

            return response.json();
        })
        .then(function (data) {
            renderBills(Array.isArray(data) ? data : []);
        })
        .catch(function (error) {
            console.error("Failed to load bills:", error);
            billCount.textContent = "Unable to load bills";
            tableBody.innerHTML =
                '<tr>' +
                    '<td colspan="5" class="px-6 py-16 text-center">' +
                        '<p class="font-manrope text-sm font-bold text-red-600">Unable to load bills</p>' +
                        '<p class="mt-1 font-inter text-[11px] text-slate-400">' +
                            'Please check the REST API and try again.' +
                        '</p>' +
                    '</td>' +
                '</tr>';
        });
    }

    searchButton.addEventListener("click", loadBills);

    clearButton.addEventListener("click", function () {
        keywordInput.value = "";
        billTypeSelect.value = "ALL";
        loadBills();
    });

    keywordInput.addEventListener("keydown", function (event) {
        if (event.key === "Enter") {
            event.preventDefault();
            loadBills();
        }
    });

    billTypeSelect.addEventListener("change", loadBills);

    loadBills();
})();
</script>

</body>

</html>