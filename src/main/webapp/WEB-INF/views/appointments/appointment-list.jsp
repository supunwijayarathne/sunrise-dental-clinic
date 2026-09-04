<%@ page language="java"
    contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
    String contextPath = request.getContextPath();
%>

<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="UTF-8">

    <meta name="viewport"
          content="width=device-width, initial-scale=1.0">

    <title>Appointments | Sunrise Dental Clinic</title>

    <script src="https://cdn.tailwindcss.com"></script>

    <script>
        tailwind.config = {
            theme: {
                extend: {
                    fontFamily: {
                        manrope: ['Manrope', 'sans-serif'],
                        inter: ['Inter', 'sans-serif']
                    }
                }
            }
        }
    </script>

    <link rel="preconnect"
          href="https://fonts.googleapis.com">

    <link rel="preconnect"
          href="https://fonts.gstatic.com"
          crossorigin>

    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600&family=Manrope:wght@400;500;600;700;800&display=swap"
          rel="stylesheet">

</head>


<body class="min-h-screen bg-[#F5F7FB] font-manrope text-[#172033]">


<div class="flex min-h-screen">

    <jsp:include page="../common/sidebar.jsp" />


    <main class="ml-[250px] min-h-screen flex-1 px-8 py-7">


        <!-- HEADER -->

        <div class="mb-7 flex items-center justify-between">

            <div>

                <h1 class="text-[24px] font-extrabold tracking-[-0.6px]">
                    Appointments
                </h1>

                <p class="mt-1 font-inter text-xs text-slate-500">
                    Manage patient appointments and schedules
                </p>

            </div>


            <a
                href="<%= request.getContextPath() %>/appointments/add"
                class="rounded-lg bg-[#2563EB] px-4 py-2.5 text-xs font-bold text-white transition hover:bg-[#1D4ED8]"
            >
                + Book Appointment
            </a>

        </div>


        <!-- SEARCH -->

        <div class="mb-5 rounded-xl border border-slate-200 bg-white p-4">

            <form
                id="searchForm"
                class="flex gap-2"
            >

                <div class="relative flex-1">

                    <input
                        id="keyword"
                        type="text"
                        name="keyword"
                        value=""
                        placeholder="Search appointment number, patient, dentist, treatment or status..."
                        class="w-full rounded-lg border border-slate-200 bg-white px-3 py-2.5 text-xs outline-none transition placeholder:text-slate-400 focus:border-blue-500 focus:ring-4 focus:ring-blue-50"
                    >

                </div>


                <button
                    type="submit"
                    class="rounded-lg bg-[#2563EB] px-5 py-2.5 text-xs font-bold text-white hover:bg-[#1D4ED8]"
                >
                    Search
                </button>


                <button
                    id="clearSearch"
                    type="button"
                    class="hidden rounded-lg border border-slate-200 bg-white px-4 py-2.5 text-xs font-semibold text-slate-600 hover:bg-slate-50"
                >
                    Clear
                </button>

            </form>

        </div>


        <!-- TABLE -->

        <div class="overflow-hidden rounded-xl border border-slate-200 bg-white">


            <div class="flex items-center justify-between border-b border-slate-100 px-5 py-4">

                <h2 class="text-sm font-extrabold">
                    Appointment List
                </h2>

                <span class="font-inter text-[10px] text-slate-500">

                    Total:
                    <strong id="totalAppointments" class="text-slate-700">
                        0
                    </strong>

                </span>

            </div>


            <div id="loadingState" class="px-5 py-16 text-center">

                <div class="mx-auto mb-3 flex h-11 w-11 items-center justify-center rounded-xl bg-slate-100 text-slate-400">
                    ...
                </div>

                <h3 class="text-sm font-extrabold">
                    Loading appointments
                </h3>

                <p class="mt-1 font-inter text-[10px] text-slate-500">
                    Please wait while appointment records are loaded.
                </p>

            </div>


            <div id="tableContainer" class="hidden overflow-x-auto">

                <table class="w-full min-w-[900px]">

                    <thead class="bg-slate-50">

                        <tr>

                            <th class="px-4 py-3 text-left font-inter text-[9px] font-semibold uppercase tracking-wide text-slate-500">
                                Appointment No.
                            </th>

                            <th class="px-4 py-3 text-left font-inter text-[9px] font-semibold uppercase tracking-wide text-slate-500">
                                Patient
                            </th>

                            <th class="px-4 py-3 text-left font-inter text-[9px] font-semibold uppercase tracking-wide text-slate-500">
                                Dentist
                            </th>

                            <th class="px-4 py-3 text-left font-inter text-[9px] font-semibold uppercase tracking-wide text-slate-500">
                                Treatment
                            </th>

                            <th class="px-4 py-3 text-left font-inter text-[9px] font-semibold uppercase tracking-wide text-slate-500">
                                Date
                            </th>

                            <th class="px-4 py-3 text-left font-inter text-[9px] font-semibold uppercase tracking-wide text-slate-500">
                                Time
                            </th>

                            <th class="px-4 py-3 text-left font-inter text-[9px] font-semibold uppercase tracking-wide text-slate-500">
                                Status
                            </th>

                            <th class="px-4 py-3 text-left font-inter text-[9px] font-semibold uppercase tracking-wide text-slate-500">
                                Actions
                            </th>

                        </tr>

                    </thead>


                    <tbody id="appointmentsTableBody"></tbody>

                </table>

            </div>


            <div id="emptyState" class="hidden px-5 py-16 text-center">

                <div class="mx-auto mb-3 flex h-11 w-11 items-center justify-center rounded-xl bg-slate-100 text-slate-400">
                    &#9638;
                </div>

                <h3 class="text-sm font-extrabold">
                    No appointments found
                </h3>

                <p id="emptyMessage" class="mt-1 font-inter text-[10px] text-slate-500">
                    No appointments have been booked yet.
                </p>

            </div>


            <div id="errorState" class="hidden px-5 py-16 text-center">

                <div class="mx-auto mb-3 flex h-11 w-11 items-center justify-center rounded-xl bg-red-50 text-red-500">
                    !
                </div>

                <h3 class="text-sm font-extrabold">
                    Unable to load appointments
                </h3>

                <p id="errorMessage" class="mt-1 font-inter text-[10px] text-red-500">
                    Please try again.
                </p>

                <button
                    id="retryButton"
                    type="button"
                    class="mt-4 rounded-lg bg-[#2563EB] px-4 py-2 text-xs font-bold text-white hover:bg-[#1D4ED8]"
                >
                    Try Again
                </button>

            </div>


        </div>


    </main>

</div>

</body>
</html>
<script>
(function () {

    const contextPath = "<%= contextPath %>";

    const searchForm = document.getElementById("searchForm");
    const keywordInput = document.getElementById("keyword");
    const clearSearch = document.getElementById("clearSearch");

    const totalAppointments =
        document.getElementById("totalAppointments");

    const loadingState =
        document.getElementById("loadingState");

    const tableContainer =
        document.getElementById("tableContainer");

    const appointmentsTableBody =
        document.getElementById("appointmentsTableBody");

    const emptyState =
        document.getElementById("emptyState");

    const emptyMessage =
        document.getElementById("emptyMessage");

    const errorState =
        document.getElementById("errorState");

    const errorMessage =
        document.getElementById("errorMessage");

    const retryButton =
        document.getElementById("retryButton");


    let lastKeyword = "";


    function escapeHtml(value) {

        if (value === null || value === undefined) {
            return "";
        }

        return String(value)
            .replace(/&/g, "&amp;")
            .replace(/</g, "&lt;")
            .replace(/>/g, "&gt;")
            .replace(/"/g, "&quot;")
            .replace(/'/g, "&#039;");
    }


    function getJson(url) {

        return fetch(
            contextPath + url,
            {
                method: "GET",
                credentials: "same-origin",
                headers: {
                    "Accept": "application/json"
                }
            }
        ).then(function (response) {

            if (response.status === 401) {
                window.location.href =
                    contextPath + "/login";
                return null;
            }

            if (!response.ok) {
                throw new Error(
                    "API request failed: " +
                    response.status
                );
            }

            return response.json();
        });
    }


    function showLoading() {

        loadingState.classList.remove("hidden");
        tableContainer.classList.add("hidden");
        emptyState.classList.add("hidden");
        errorState.classList.add("hidden");

    }


    function showTable() {

        loadingState.classList.add("hidden");
        tableContainer.classList.remove("hidden");
        emptyState.classList.add("hidden");
        errorState.classList.add("hidden");

    }


    function showEmpty(message) {

        loadingState.classList.add("hidden");
        tableContainer.classList.add("hidden");
        errorState.classList.add("hidden");
        emptyState.classList.remove("hidden");

        emptyMessage.textContent = message;

    }


    function showError(message) {

        loadingState.classList.add("hidden");
        tableContainer.classList.add("hidden");
        emptyState.classList.add("hidden");
        errorState.classList.remove("hidden");

        errorMessage.textContent = message;

    }


    function getPatientName(patientId, patients) {

        const patient =
            patients.find(function (item) {
                return Number(item.patientId) === Number(patientId);
            });

        return patient
            ? (patient.name || patient.fullName || "Unknown Patient")
            : "Unknown Patient";
    }


    function getDentistName(dentistId, dentists) {

        const dentist =
            dentists.find(function (item) {
                return Number(item.dentistId) === Number(dentistId);
            });

        return dentist
            ? (dentist.dentistName || dentist.name || "Unknown Dentist")
            : "Unknown Dentist";
    }


    function getTreatmentName(treatmentId, treatments) {

        const treatment =
            treatments.find(function (item) {
                return Number(item.treatmentId) === Number(treatmentId);
            });

        return treatment
            ? (treatment.treatmentName || treatment.name || "Unknown Treatment")
            : "Unknown Treatment";
    }


    function statusClass(status) {

        const value =
            String(status || "").toUpperCase();

        if (value === "COMPLETED") {
            return "bg-emerald-50 text-emerald-700";
        }

        if (value === "CANCELLED") {
            return "bg-red-50 text-red-700";
        }

        if (value === "NO_SHOW") {
            return "bg-amber-50 text-amber-700";
        }

        if (value === "BILLED") {
            return "bg-violet-50 text-violet-700";
        }

        return "bg-blue-50 text-blue-700";
    }


    function formatTime(value) {

        if (!value) {
            return "";
        }

        return String(value).substring(0, 5);

    }


    function renderAppointments(
        appointments,
        patients,
        dentists,
        treatments
    ) {

        appointmentsTableBody.innerHTML = "";

        totalAppointments.textContent =
            appointments.length;


        if (!appointments.length) {

            const message =
                lastKeyword
                    ? 'No appointments found for "' +
                      lastKeyword +
                      '".'
                    : "No appointments have been booked yet.";

            showEmpty(message);

            return;
        }


        appointments.forEach(function (appointment) {

            const appointmentId =
                appointment.appointmentId;

            const appointmentNumber =
                appointment.appointmentNumber || "N/A";

            const patientName =
                getPatientName(
                    appointment.patientId,
                    patients
                );

            const dentistName =
                getDentistName(
                    appointment.dentistId,
                    dentists
                );

            const treatmentName =
                getTreatmentName(
                    appointment.treatmentId,
                    treatments
                );

            const date =
                appointment.appointmentDate || "";

            const time =
                formatTime(
                    appointment.appointmentTime
                );

            const status =
                String(
                    appointment.status || "BOOKED"
                ).toUpperCase();

            const displayStatus =
                status.replace(/_/g, " ");


            const row =
                document.createElement("tr");

            row.className =
                "border-t border-slate-100 transition hover:bg-slate-50/70";


            row.innerHTML =
                '<td class="px-4 py-3">' +

                    '<a href="' +
                    contextPath +
                    '/appointments/view?id=' +
                    encodeURIComponent(appointmentId) +
                    '" class="text-[10px] font-extrabold text-blue-600 hover:underline">' +
                    escapeHtml(appointmentNumber) +
                    '</a>' +

                '</td>' +


                '<td class="px-4 py-3 text-[10px] font-medium">' +
                    escapeHtml(patientName) +
                '</td>' +


                '<td class="px-4 py-3 text-[10px] font-medium">' +
                    escapeHtml(dentistName) +
                '</td>' +


                '<td class="px-4 py-3 text-[10px] font-medium">' +
                    escapeHtml(treatmentName) +
                '</td>' +


                '<td class="px-4 py-3 font-inter text-[10px] text-slate-500">' +
                    escapeHtml(date) +
                '</td>' +


                '<td class="px-4 py-3 font-inter text-[10px] text-slate-500">' +
                    escapeHtml(time) +
                '</td>' +


                '<td class="px-4 py-3">' +

                    '<span class="inline-flex rounded-full px-2.5 py-1 font-inter text-[9px] font-semibold ' +
                    statusClass(status) +
                    '">' +

                        escapeHtml(displayStatus) +

                    '</span>' +

                '</td>' +


                '<td class="px-4 py-3 align-middle">' +

                    '<div class="flex items-center justify-start gap-2 whitespace-nowrap">' +

                        '<a href="' +
                        contextPath +
                        '/appointments/view?id=' +
                        encodeURIComponent(appointmentId) +
                        '" class="inline-flex items-center justify-center rounded-lg bg-blue-50 px-3 py-1.5 font-inter text-[9px] font-semibold leading-none text-blue-600 transition hover:bg-blue-100">' +
                            'View' +
                        '</a>' +

                        '<a href="' +
                        contextPath +
                        '/appointments/edit?id=' +
                        encodeURIComponent(appointmentId) +
                        '" class="inline-flex items-center justify-center rounded-lg bg-slate-100 px-3 py-1.5 font-inter text-[9px] font-semibold leading-none text-slate-600 transition hover:bg-slate-200">' +
                            'Edit' +
                        '</a>' +

                    '</div>' +

                '</td>';


            appointmentsTableBody.appendChild(row);

        });


        showTable();

    }


    async function loadAppointments(keyword) {

        showLoading();

        lastKeyword =
            keyword ? keyword.trim() : "";

        try {

            let appointmentUrl =
                "/api/appointments";

            if (lastKeyword) {

                appointmentUrl +=
                    "?keyword=" +
                    encodeURIComponent(lastKeyword);

            }


            /*
             * Appointment API returns IDs for patient,
             * dentist and treatment. Load the related
             * REST resources once and use them to display
             * the same names as the original JSP.
             */

            const results =
                await Promise.all([
                    getJson(appointmentUrl),
                    getJson("/api/patients"),
                    getJson("/api/dentists"),
                    getJson("/api/treatments")
                ]);


            const appointments =
                Array.isArray(results[0])
                    ? results[0]
                    : [];

            const patients =
                Array.isArray(results[1])
                    ? results[1]
                    : [];

            const dentists =
                Array.isArray(results[2])
                    ? results[2]
                    : [];

            const treatments =
                Array.isArray(results[3])
                    ? results[3]
                    : [];


            renderAppointments(
                appointments,
                patients,
                dentists,
                treatments
            );


        } catch (error) {

            console.error(
                "Could not load appointments:",
                error
            );

            showError(
                "Could not load appointment records. " +
                "Please check that the REST APIs are running."
            );

        }

    }


    searchForm.addEventListener(
        "submit",
        function (event) {

            event.preventDefault();

            const keyword =
                keywordInput.value.trim();

            if (keyword) {

                clearSearch.classList.remove("hidden");

            } else {

                clearSearch.classList.add("hidden");

            }

            loadAppointments(keyword);

        }
    );


    clearSearch.addEventListener(
        "click",
        function () {

            keywordInput.value = "";

            clearSearch.classList.add("hidden");

            loadAppointments("");

        }
    );


    retryButton.addEventListener(
        "click",
        function () {

            loadAppointments(lastKeyword);

        }
    );


    /*
     * Preserve the original success-message behaviour.
     * Messages are displayed only from the query string;
     * appointment data itself always comes from REST APIs.
     */

    const urlParams =
        new URLSearchParams(
            window.location.search
        );

    const success =
        urlParams.get("success");

    const updated =
        urlParams.get("updated");


    if (success === "1") {

        const message =
            document.createElement("div");

        message.className =
            "mb-5 flex items-center gap-3 rounded-lg border border-emerald-100 bg-emerald-50 px-4 py-3 text-xs font-semibold text-emerald-700";

        message.innerHTML =
            '<span class="flex h-5 w-5 items-center justify-center rounded-full bg-emerald-100">✓</span>' +
            "Appointment created successfully.";

        const searchBox =
            document.getElementById("searchForm").parentElement;

        searchBox.parentNode.insertBefore(
            message,
            searchBox
        );

    } else if (updated === "1") {

        const message =
            document.createElement("div");

        message.className =
            "mb-5 flex items-center gap-3 rounded-lg border border-emerald-100 bg-emerald-50 px-4 py-3 text-xs font-semibold text-emerald-700";

        message.innerHTML =
            '<span class="flex h-5 w-5 items-center justify-center rounded-full bg-emerald-100">✓</span>' +
            "Appointment updated successfully.";

        const searchBox =
            document.getElementById("searchForm").parentElement;

        searchBox.parentNode.insertBefore(
            message,
            searchBox
        );

    }


    loadAppointments("");


})();
</script>
