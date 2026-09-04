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

    <title>Patients | Sunrise Dental Clinic</title>


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

</head>


<body class="min-h-screen bg-[#F5F7FB] font-manrope text-[#172033]">


<div class="flex min-h-screen">


    <!-- SIDEBAR -->

    <jsp:include page="../common/sidebar.jsp" />


    <!-- MAIN CONTENT -->

    <main class="ml-[250px] min-h-screen flex-1 px-8 py-7">


        <!-- HEADER -->

        <div class="mb-7 flex items-center justify-between">


            <div>

                <p class="mb-1 font-inter text-[10px] font-semibold uppercase tracking-[0.12em] text-slate-400">
                    Patient Management
                </p>


                <h1 class="text-[25px] font-extrabold tracking-[-0.7px]">
                    Patients
                </h1>


                <p class="mt-1 font-inter text-xs text-slate-500">
                    Manage registered clinic patients.
                </p>

            </div>



            <!-- ADD PATIENT -->

            <a
                href="<%= contextPath %>/patients/add"
                class="inline-flex items-center gap-2 rounded-lg bg-[#2563EB] px-4 py-2.5 font-inter text-[10px] font-bold text-white shadow-sm transition hover:bg-[#1D4ED8]"
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
                        d="M12 5v14M5 12h14"
                    />

                </svg>

                Add Patient

            </a>


        </div>
        <!-- API MESSAGES -->

        <div id="successMessage"
             class="mb-5 hidden flex items-center gap-3 rounded-xl border border-emerald-100 bg-emerald-50 px-4 py-3">
            <div class="flex h-7 w-7 items-center justify-center rounded-lg bg-emerald-100">
                <svg class="h-4 w-4 text-emerald-600" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24">
                    <path stroke-linecap="round" stroke-linejoin="round" d="M5 12l4 4L19 6" />
                </svg>
            </div>
            <p id="successText" class="font-inter text-[10px] font-semibold text-emerald-700"></p>
        </div>

        <div id="errorMessage"
             class="mb-5 hidden flex items-center gap-3 rounded-xl border border-red-100 bg-red-50 px-4 py-3">
            <div class="flex h-7 w-7 items-center justify-center rounded-lg bg-red-100">
                <svg class="h-4 w-4 text-red-600" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24">
                    <path stroke-linecap="round" stroke-linejoin="round" d="M6 6l12 12M18 6L6 18" />
                </svg>
            </div>
            <p id="errorText" class="font-inter text-[10px] font-semibold text-red-700"></p>
        </div>




        <!-- SEARCH CARD -->

        <div class="mb-5 rounded-xl border border-slate-200 bg-white p-4">


            <form
                id="searchForm"
                class="flex gap-3"
            >


                <!-- SEARCH INPUT -->

                <div class="relative flex-1">


                    <svg
                        class="absolute left-3.5 top-1/2 h-4 w-4 -translate-y-1/2 text-slate-400"
                        fill="none"
                        stroke="currentColor"
                        stroke-width="1.7"
                        viewBox="0 0 24 24"
                    >

                        <circle
                            cx="11"
                            cy="11"
                            r="7"
                        />

                        <path
                            stroke-linecap="round"
                            d="m20 20-4-4"
                        />

                    </svg>


                    <input
                        type="text"
                        id="searchInput" name="keyword" placeholder="Search by patient code, name or contact number..." value=""
                        class="h-11 w-full rounded-lg border border-slate-200 bg-slate-50 pl-10 pr-4 font-inter text-xs text-slate-700 outline-none transition placeholder:text-slate-400 focus:border-blue-500 focus:bg-white focus:ring-2 focus:ring-blue-50"
                    >


                </div>



                <!-- SEARCH BUTTON -->

                <button
                    type="submit"
                    class="rounded-lg bg-[#2563EB] px-5 font-inter text-[10px] font-bold text-white transition hover:bg-[#1D4ED8]"
                >

                    Search

                </button>
                <!-- CLEAR -->

                <button
                    id="clearButton"
                    type="button"
                    class="hidden items-center rounded-lg border border-slate-200 bg-white px-5 font-inter text-[10px] font-semibold text-slate-600 transition hover:bg-slate-50"
                >
                    Clear
                </button>




            </form>


        </div>



        <!-- RESULTS HEADER -->

        <div class="mb-4 flex items-center justify-between">

            <div>
                <p id="resultsText" class="font-inter text-[10px] text-slate-500">
                    All registered patients
                </p>
            </div>

            <!-- COUNT -->

            <div class="rounded-full bg-slate-100 px-3 py-1.5">


                <span id="patientCount" class="font-inter text-[9px] font-semibold text-slate-500">0 patients</span>


            </div>


        </div>



        <!-- TABLE CARD -->

        <div class="overflow-hidden rounded-xl border border-slate-200 bg-white">

            <div id="loadingState"
                 class="flex min-h-[350px] flex-col items-center justify-center px-6 text-center">
                <div class="mb-4 flex h-12 w-12 items-center justify-center rounded-xl bg-slate-100">
                    <svg class="h-5 w-5 animate-spin text-slate-400" fill="none" stroke="currentColor" stroke-width="1.6" viewBox="0 0 24 24">
                        <circle cx="12" cy="12" r="9" class="opacity-30" />
                        <path stroke-linecap="round" d="M21 12a9 9 0 01-9 9" />
                    </svg>
                </div>
                <h3 class="text-sm font-extrabold">Loading patients</h3>
                <p class="mt-1 font-inter text-[10px] text-slate-400">Please wait...</p>
            </div>

            <div id="tableContainer" class="hidden overflow-x-auto">
                <table class="w-full min-w-[900px]">
                    <thead class="border-b border-slate-100 bg-slate-50/70">
                        <tr>
                            <th class="px-5 py-3.5 text-left font-inter text-[9px] font-semibold uppercase tracking-wide text-slate-400">Patient</th>
                            <th class="px-5 py-3.5 text-left font-inter text-[9px] font-semibold uppercase tracking-wide text-slate-400">Patient Code</th>
                            <th class="px-5 py-3.5 text-left font-inter text-[9px] font-semibold uppercase tracking-wide text-slate-400">Contact</th>
                            <th class="px-5 py-3.5 text-left font-inter text-[9px] font-semibold uppercase tracking-wide text-slate-400">Email</th>
                            <th class="px-5 py-3.5 text-left font-inter text-[9px] font-semibold uppercase tracking-wide text-slate-400">Address</th>
                            <th class="px-5 py-3.5 text-right font-inter text-[9px] font-semibold uppercase tracking-wide text-slate-400">Actions</th>
                        </tr>
                    </thead>
                    <tbody id="patientTableBody" class="divide-y divide-slate-100"></tbody>
                </table>
            </div>

            <div id="emptyState"
                 class="hidden flex min-h-[350px] flex-col items-center justify-center px-6 text-center">
                <div class="mb-4 flex h-12 w-12 items-center justify-center rounded-xl bg-slate-100">
                    <svg class="h-5 w-5 text-slate-400" fill="none" stroke="currentColor" stroke-width="1.6" viewBox="0 0 24 24">
                        <circle cx="9" cy="7" r="4" />
                        <path stroke-linecap="round" d="M3 21a6 6 0 0112 0M16 11a4 4 0 014 4M16 18a5 5 0 015 3" />
                    </svg>
                </div>
                <h3 id="emptyTitle" class="text-sm font-extrabold">No patients yet</h3>
                <p id="emptyDescription" class="mt-1 max-w-[350px] font-inter text-[10px] leading-5 text-slate-400">
                    Start by registering a new patient.
                </p>
                <a id="emptyAction"
                   href="<%= contextPath %>/patients/add"
                   class="mt-4 rounded-lg bg-[#2563EB] px-4 py-2 font-inter text-[10px] font-bold text-white transition hover:bg-[#1D4ED8]">
                    + Add Patient
                </a>
            </div>

        </div>


        <!-- FOOTER -->

        <div class="mt-7 flex items-center justify-between px-1">


            <p class="font-inter text-[9px] text-slate-400">
                Sunrise Dental Clinic
            </p>


            <p class="font-inter text-[9px] text-slate-400">
                Patient Management
            </p>


        </div>


    </main>


</div>



<script>
    const contextPath = '<%= contextPath %>';

    const searchForm = document.getElementById('searchForm');
    const searchInput = document.getElementById('searchInput');
    const clearButton = document.getElementById('clearButton');

    const loadingState = document.getElementById('loadingState');
    const tableContainer = document.getElementById('tableContainer');
    const emptyState = document.getElementById('emptyState');
    const patientTableBody = document.getElementById('patientTableBody');

    const patientCount = document.getElementById('patientCount');
    const resultsText = document.getElementById('resultsText');

    const emptyTitle = document.getElementById('emptyTitle');
    const emptyDescription = document.getElementById('emptyDescription');
    const emptyAction = document.getElementById('emptyAction');

    const successMessage = document.getElementById('successMessage');
    const successText = document.getElementById('successText');
    const errorMessage = document.getElementById('errorMessage');
    const errorText = document.getElementById('errorText');

    function escapeHtml(value) {
        if (value === null || value === undefined) return '';
        return String(value)
            .replace(/&/g, '&amp;')
            .replace(/</g, '&lt;')
            .replace(/>/g, '&gt;')
            .replace(/"/g, '&quot;')
            .replace(/'/g, '&#039;');
    }

    function showSuccess(message) {
        errorMessage.classList.add('hidden');
        errorMessage.classList.remove('flex');
        successText.textContent = message;
        successMessage.classList.remove('hidden');
        successMessage.classList.add('flex');
    }

    function showError(message) {
        successMessage.classList.add('hidden');
        successMessage.classList.remove('flex');
        errorText.textContent = message;
        errorMessage.classList.remove('hidden');
        errorMessage.classList.add('flex');
    }

    function hideMessages() {
        successMessage.classList.add('hidden');
        successMessage.classList.remove('flex');
        errorMessage.classList.add('hidden');
        errorMessage.classList.remove('flex');
    }

    function setLoading(loading) {
        if (loading) {
            loadingState.classList.remove('hidden');
            tableContainer.classList.add('hidden');
            emptyState.classList.add('hidden');
        } else {
            loadingState.classList.add('hidden');
        }
    }

    function renderPatients(patients, keyword) {
        patientTableBody.innerHTML = '';

        const count = patients.length;
        patientCount.textContent =
            count + ' patient' + (count === 1 ? '' : 's');

        if (keyword) {
            resultsText.innerHTML =
                'Search results for <span class="font-semibold text-slate-700">&quot;'
                + escapeHtml(keyword)
                + '&quot;</span>';
            clearButton.classList.remove('hidden');
            clearButton.classList.add('flex');
        } else {
            resultsText.textContent = 'All registered patients';
            clearButton.classList.add('hidden');
            clearButton.classList.remove('flex');
        }

        if (count === 0) {
            tableContainer.classList.add('hidden');
            emptyState.classList.remove('hidden');

            if (keyword) {
                emptyTitle.textContent = 'No patients found';
                emptyDescription.innerHTML =
                    'No patients were found matching '
                    + '<span class="font-semibold text-slate-500">&quot;'
                    + escapeHtml(keyword)
                    + '&quot;</span>.';
                emptyAction.textContent = 'Clear search';
                emptyAction.href = '#';
            } else {
                emptyTitle.textContent = 'No patients yet';
                emptyDescription.textContent =
                    'Start by registering a new patient.';
                emptyAction.textContent = '+ Add Patient';
                emptyAction.href = contextPath + '/patients/add';
            }
            return;
        }

        emptyState.classList.add('hidden');
        tableContainer.classList.remove('hidden');

        patients.forEach(function(patient) {
            const name = patient.name || 'Patient';
            const firstLetter = name.trim()
                ? name.trim().charAt(0).toUpperCase()
                : 'P';

            const email = patient.email && patient.email.trim()
                ? patient.email
                : '-';

            const row = document.createElement('tr');
            row.className = 'transition hover:bg-slate-50/70';

            row.innerHTML =
                '<td class="px-5 py-4">'
                + '<div class="flex items-center gap-3">'
                + '<div class="flex h-9 w-9 shrink-0 items-center justify-center rounded-lg bg-blue-50 text-[11px] font-extrabold text-blue-600">'
                + escapeHtml(firstLetter)
                + '</div>'
                + '<div>'
                + '<p class="text-xs font-bold text-slate-700">'
                + escapeHtml(name)
                + '</p>'
                + '<p class="mt-0.5 font-inter text-[9px] text-slate-400">'
                + 'ID #' + escapeHtml(patient.patientId)
                + '</p>'
                + '</div>'
                + '</div>'
                + '</td>'

                + '<td class="px-5 py-4">'
                + '<span class="rounded-md bg-blue-50 px-2.5 py-1.5 font-inter text-[9px] font-semibold text-blue-600">'
                + escapeHtml(patient.patientCode || '-')
                + '</span>'
                + '</td>'

                + '<td class="px-5 py-4">'
                + '<p class="font-inter text-[10px] font-medium text-slate-600">'
                + escapeHtml(patient.contactNumber || '-')
                + '</p>'
                + '</td>'

                + '<td class="max-w-[180px] px-5 py-4">'
                + '<p class="truncate font-inter text-[10px] text-slate-600">'
                + escapeHtml(email)
                + '</p>'
                + '</td>'

                + '<td class="max-w-[220px] px-5 py-4">'
                + '<p class="truncate font-inter text-[10px] text-slate-500">'
                + escapeHtml(patient.address || '-')
                + '</p>'
                + '</td>'

                + '<td class="px-5 py-4">'
                + '<div class="flex items-center justify-end gap-2">'
                + '<a href="' + contextPath + '/patients/view?id='
                + encodeURIComponent(patient.patientId)
                + '" class="rounded-md border border-slate-200 bg-white px-3 py-1.5 font-inter text-[9px] font-semibold text-slate-600 transition hover:border-blue-200 hover:bg-blue-50 hover:text-blue-600">'
                + 'View'
                + '</a>'
                + '<a href="' + contextPath + '/patients/edit?id='
                + encodeURIComponent(patient.patientId)
                + '" class="rounded-md bg-slate-100 px-3 py-1.5 font-inter text-[9px] font-semibold text-slate-600 transition hover:bg-blue-50 hover:text-blue-600">'
                + 'Edit'
                + '</a>'
                + '</div>'
                + '</td>';

            patientTableBody.appendChild(row);
        });
    }

    async function loadPatients(keyword) {
        hideMessages();
        setLoading(true);

        try {
            let url = contextPath + '/api/patients';

            if (keyword && keyword.trim()) {
                url += '?keyword=' + encodeURIComponent(keyword.trim());
            }

            const response = await fetch(url, {
                method: 'GET',
                credentials: 'same-origin',
                headers: {
                    'Accept': 'application/json'
                }
            });

            const responseText = await response.text();
            let data;

            try {
                data = responseText ? JSON.parse(responseText) : null;
            } catch (jsonError) {
                throw new Error(
                    'Invalid response received from patient API.'
                );
            }

            if (!response.ok) {
                throw new Error(
                    data && data.message
                        ? data.message
                        : 'Unable to load patients.'
                );
            }

            if (!Array.isArray(data)) {
                throw new Error(
                    'Invalid patient data received from API.'
                );
            }

            renderPatients(
                data,
                keyword ? keyword.trim() : ''
            );

        } catch (error) {
            tableContainer.classList.add('hidden');
            emptyState.classList.add('hidden');
            patientCount.textContent = '0 patients';

            showError(
                error && error.message
                    ? error.message
                    : 'Could not load patients.'
            );
        } finally {
            setLoading(false);
        }
    }

    searchForm.addEventListener('submit', function(event) {
        event.preventDefault();
        loadPatients(searchInput.value.trim());
    });

    clearButton.addEventListener('click', function() {
        searchInput.value = '';
        loadPatients('');
    });

    emptyAction.addEventListener('click', function(event) {
        if (searchInput.value.trim()) {
            event.preventDefault();
            searchInput.value = '';
            loadPatients('');
        }
    });

    document.addEventListener('DOMContentLoaded', function() {
        const params = new URLSearchParams(window.location.search);
        const keyword = params.get('keyword') || '';
        const success = params.get('success');
        const updated = params.get('updated');

        searchInput.value = keyword;
        loadPatients(keyword);

        if (success === '1') {
            showSuccess('Patient registered successfully.');
        }

        if (updated === '1') {
            showSuccess('Patient updated successfully.');
        }
    });
</script>

</body>

</html>