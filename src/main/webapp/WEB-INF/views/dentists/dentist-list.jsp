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

    <title>
        Dentists | Sunrise Dental Clinic
    </title>


    <!-- Tailwind CSS -->

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
                    Clinic Management
                </p>


                <h1 class="text-[25px] font-extrabold tracking-[-0.7px]">
                    Dentists
                </h1>


                <p class="mt-1 font-inter text-xs text-slate-500">
                    Manage dentists and their clinic information.
                </p>

            </div>


            <!-- ADD BUTTON -->

            <a
                href="<%= contextPath %>/dentists/add"
                class="flex items-center gap-2 rounded-lg bg-[#2563EB] px-4 py-2.5 font-inter text-[10px] font-bold text-white shadow-sm transition hover:bg-[#1D4ED8]"
            >

                <svg
                    class="h-3.5 w-3.5"
                    fill="none"
                    stroke="currentColor"
                    stroke-width="2"
                    viewBox="0 0 24 24"
                >

                    <path
                        stroke-linecap="round"
                        stroke-linejoin="round"
                        d="M12 5v14M5 12h14"
                    />

                </svg>

                Add Dentist

            </a>

        </div>



        <!-- SUCCESS MESSAGE -->

        <div
            id="successMessage"
            class="mb-5 hidden items-center gap-3 rounded-lg border border-emerald-100 bg-emerald-50 px-4 py-3"
        >

            <div class="flex h-5 w-5 items-center justify-center rounded-full bg-emerald-100 font-inter text-[10px] font-bold text-emerald-600">
                ✓
            </div>

            <p
                id="successText"
                class="font-inter text-[10px] font-semibold text-emerald-700"
            >
                Dentist added successfully.
            </p>

        </div>



        <!-- SEARCH CARD -->

        <div class="mb-5 rounded-xl border border-slate-200 bg-white p-4">


            <form
                id="dentistSearchForm"
                class="flex items-center gap-3"
            >


                <!-- SEARCH INPUT -->

                <div class="relative flex-1">

                    <svg
                        class="pointer-events-none absolute left-3 top-1/2 h-4 w-4 -translate-y-1/2 text-slate-400"
                        fill="none"
                        stroke="currentColor"
                        stroke-width="1.8"
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
                        id="keyword"
                        type="text"
                        name="keyword"
                        placeholder="Search by name, specialization, phone or email..."
                        class="w-full rounded-lg border border-slate-200 bg-slate-50 py-2.5 pl-10 pr-3 font-inter text-[10px] outline-none transition placeholder:text-slate-400 focus:border-blue-500 focus:bg-white focus:ring-4 focus:ring-blue-50"
                    >

                </div>


                <!-- SEARCH -->

                <button
                    type="submit"
                    class="rounded-lg bg-[#172033] px-5 py-2.5 font-inter text-[10px] font-semibold text-white transition hover:bg-[#263248]"
                >
                    Search
                </button>


                <!-- CLEAR -->

                <button
                    type="button"
                    id="clearSearch"
                    class="hidden rounded-lg border border-slate-200 bg-white px-4 py-2.5 font-inter text-[10px] font-semibold text-slate-600 transition hover:bg-slate-50"
                >
                    Clear
                </button>


            </form>

        </div>



        <!-- STATS -->

        <div class="mb-4 flex items-center justify-between">


            <div>

                <p class="font-inter text-[10px] text-slate-400">
                    Total Dentists
                </p>

                <p class="mt-0.5 text-lg font-extrabold">
                    <span id="dentistCount">0</span>
                </p>

            </div>


            <p
                id="searchResultText"
                class="hidden font-inter text-[10px] text-slate-400"
            >

                Search results for

                <span
                    id="searchKeywordText"
                    class="font-semibold text-slate-600"
                ></span>

            </p>


        </div>



        <!-- TABLE CARD -->

        <div class="overflow-hidden rounded-xl border border-slate-200 bg-white">


            <div class="overflow-x-auto">

                <table class="w-full min-w-[950px]">


                    <!-- TABLE HEADER -->

                    <thead>

                        <tr class="border-b border-slate-100 bg-slate-50/70">


                            <th
                                class="px-5 py-3 text-left font-inter text-[9px] font-semibold uppercase tracking-wide text-slate-400"
                            >
                                Dentist
                            </th>


                            <th
                                class="px-5 py-3 text-left font-inter text-[9px] font-semibold uppercase tracking-wide text-slate-400"
                            >
                                Specialization
                            </th>


                            <th
                                class="px-5 py-3 text-left font-inter text-[9px] font-semibold uppercase tracking-wide text-slate-400"
                            >
                                Consultation
                            </th>


                            <th
                                class="px-5 py-3 text-left font-inter text-[9px] font-semibold uppercase tracking-wide text-slate-400"
                            >
                                Contact
                            </th>


                            <th
                                class="px-5 py-3 text-left font-inter text-[9px] font-semibold uppercase tracking-wide text-slate-400"
                            >
                                Status
                            </th>


                            <th
                                class="px-5 py-3 text-right font-inter text-[9px] font-semibold uppercase tracking-wide text-slate-400"
                            >
                                Actions
                            </th>


                        </tr>

                    </thead>



                    <!-- TABLE BODY -->

                    <tbody
                        id="dentistTableBody"
                        class="divide-y divide-slate-100"
                    >

                        <tr>

                            <td
                                colspan="6"
                                class="px-6 py-12 text-center"
                            >

                                <span class="font-inter text-xs text-slate-400">
                                    Loading dentists...
                                </span>

                            </td>

                        </tr>

                    </tbody>


                </table>

            </div>


        </div>



        <!-- EMPTY STATE -->

        <div
            id="emptyState"
            class="mt-5 hidden flex min-h-[300px] flex-col items-center justify-center rounded-xl border border-slate-200 bg-white px-6 text-center"
        >


            <div class="mb-4 flex h-12 w-12 items-center justify-center rounded-xl bg-slate-100">

                <svg
                    class="h-5 w-5 text-slate-400"
                    fill="none"
                    stroke="currentColor"
                    stroke-width="1.7"
                    viewBox="0 0 24 24"
                >

                    <path
                        stroke-linecap="round"
                        stroke-linejoin="round"
                        d="M16 21v-2a4 4 0 00-4-4H6a4 4 0 00-4 4v2"
                    />

                    <circle
                        cx="9"
                        cy="7"
                        r="4"
                    />

                    <path
                        stroke-linecap="round"
                        d="M19 8v6M22 11h-6"
                    />

                </svg>

            </div>


            <h3
                id="emptyTitle"
                class="text-sm font-extrabold"
            >
                No dentists yet
            </h3>


            <p
                id="emptyText"
                class="mt-1 max-w-[350px] font-inter text-[10px] leading-5 text-slate-400"
            >
                No dentists have been registered in the clinic system yet.
            </p>


            <a
                id="emptyButton"
                href="<%= contextPath %>/dentists/add"
                class="mt-4 rounded-lg bg-[#2563EB] px-4 py-2 font-inter text-[10px] font-semibold text-white hover:bg-[#1D4ED8]"
            >
                Add First Dentist
            </a>


        </div>



        <!-- ERROR STATE -->

        <div
            id="errorMessage"
            class="mt-5 hidden rounded-xl border border-red-100 bg-red-50 px-5 py-4"
        >

            <p class="font-inter text-[10px] font-semibold text-red-600">
                Unable to load dentists.
            </p>

            <p
                id="errorDetails"
                class="mt-1 font-inter text-[9px] text-red-500"
            ></p>

        </div>



        <!-- FOOTER -->

        <div class="mt-7 flex items-center justify-between px-1">

            <p class="font-inter text-[9px] text-slate-400">
                Sunrise Dental Clinic
            </p>


            <a
                href="<%= contextPath %>/dashboard"
                class="font-inter text-[9px] font-medium text-slate-400 transition hover:text-blue-600"
            >
                ← Dashboard
            </a>

        </div>


    </main>


</div>



<script>

(function () {

    "use strict";


    /* =====================================================
       APPLICATION CONTEXT
       ===================================================== */

    var contextPath = "<%= contextPath %>";

    var apiUrl = contextPath + "/api/dentists";


    /* =====================================================
       ELEMENTS
       ===================================================== */

    var tableBody =
        document.getElementById("dentistTableBody");

    var dentistCount =
        document.getElementById("dentistCount");

    var searchForm =
        document.getElementById("dentistSearchForm");

    var keywordInput =
        document.getElementById("keyword");

    var clearSearch =
        document.getElementById("clearSearch");

    var searchResultText =
        document.getElementById("searchResultText");

    var searchKeywordText =
        document.getElementById("searchKeywordText");

    var emptyState =
        document.getElementById("emptyState");

    var emptyTitle =
        document.getElementById("emptyTitle");

    var emptyText =
        document.getElementById("emptyText");

    var emptyButton =
        document.getElementById("emptyButton");

    var errorMessage =
        document.getElementById("errorMessage");

    var errorDetails =
        document.getElementById("errorDetails");


    /* =====================================================
       ESCAPE HTML
       ===================================================== */

    function escapeHtml(value) {

        return String(
            value === null || value === undefined
                ? ""
                : value
        )
        .replace(/&/g, "&amp;")
        .replace(/</g, "&lt;")
        .replace(/>/g, "&gt;")
        .replace(/"/g, "&quot;")
        .replace(/'/g, "&#039;");

    }


    /* =====================================================
       LOAD DENTISTS
       ===================================================== */

    function loadDentists() {

        var keyword =
            keywordInput.value.trim();


        var url =
            apiUrl;


        /*
         * IMPORTANT:
         *
         * The DentistApi supports:
         *
         * GET /api/dentists
         *
         * and:
         *
         * GET /api/dentists?keyword=...
         *
         */

        if (keyword !== "") {

            url +=
                "?keyword=" +
                encodeURIComponent(keyword);

        }


        /* Loading */

        emptyState.classList.add("hidden");

        errorMessage.classList.add("hidden");

        tableBody.innerHTML =
            '<tr>' +
                '<td colspan="6" class="px-6 py-12 text-center">' +
                    '<span class="font-inter text-xs text-slate-400">' +
                        'Loading dentists...' +
                    '</span>' +
                '</td>' +
            '</tr>';


        fetch(
            url,
            {
                method: "GET",

                credentials: "same-origin",

                headers: {
                    "Accept": "application/json"
                }
            }
        )

        .then(function (response) {


            /*
             * Login/session protection
             */

            if (response.status === 401) {

                window.location.href =
                    contextPath + "/login";

                throw new Error(
                    "Authentication required."
                );

            }


            if (!response.ok) {

                throw new Error(
                    "API returned HTTP " +
                    response.status
                );

            }


            return response.json();

        })

        .then(function (dentists) {

            console.log(
                "Dentist API response:",
                dentists
            );


            if (!Array.isArray(dentists)) {

                throw new Error(
                    "API response is not a JSON array."
                );

            }


            renderDentists(dentists);

        })

        .catch(function (error) {

            console.error(
                "Dentist API error:",
                error
            );


            tableBody.innerHTML = "";

            dentistCount.textContent = "0";


            emptyState.classList.add("hidden");

            errorMessage.classList.remove("hidden");


            errorDetails.textContent =
                error.message ||
                "Please try again.";

        });

    }


    /* =====================================================
       RENDER DENTISTS
       ===================================================== */

    function renderDentists(dentists) {


        dentistCount.textContent =
            dentists.length;


        var keyword =
            keywordInput.value.trim();


        /* Search information */

        if (keyword !== "") {

            searchResultText.classList.remove("hidden");

            searchKeywordText.textContent =
                '"' + keyword + '"';

            clearSearch.classList.remove("hidden");

        } else {

            searchResultText.classList.add("hidden");

            clearSearch.classList.add("hidden");

        }


        /* No dentists */

        if (dentists.length === 0) {

            tableBody.innerHTML = "";

            emptyState.classList.remove("hidden");


            if (keyword !== "") {

                emptyTitle.textContent =
                    "No dentists found";

                emptyText.textContent =
                    'No dentists matched "' +
                    keyword +
                    '". Try a different search term.';

                emptyButton.textContent =
                    "Clear Search";

                emptyButton.href =
                    "#";

                emptyButton.onclick =
                    function (event) {

                        event.preventDefault();

                        keywordInput.value = "";

                        loadDentists();

                    };

            } else {

                emptyTitle.textContent =
                    "No dentists yet";

                emptyText.textContent =
                    "No dentists have been registered in the clinic system yet.";

                emptyButton.textContent =
                    "Add First Dentist";

                emptyButton.href =
                    contextPath + "/dentists/add";

                emptyButton.onclick = null;

            }

            return;

        }


        emptyState.classList.add("hidden");


        /* =================================================
           BUILD TABLE
           ================================================= */

        var html = "";


        dentists.forEach(function (dentist) {


            /*
             * These names exactly match DentistApi.java
             */

            var id =
                dentist.dentistId;


            var name =
                dentist.dentistName ||
                "-";


            var specialization =
                dentist.specialization ||
                "-";


            var fee =
                Number(
                    dentist.consultationFee || 0
                );


            var phone =
                dentist.phoneNumber ||
                "-";


            var email =
                dentist.email ||
                "No email";


            var active =
                dentist.active === true;


            var firstLetter =
                name
                    .trim()
                    .charAt(0)
                    .toUpperCase();


            if (firstLetter === "") {
                firstLetter = "?";
            }


            /* =================================================
               TABLE ROW
               ================================================= */

            html +=
                '<tr class="transition hover:bg-slate-50/70">';


            /* DENTIST */

            html +=
                '<td class="px-5 py-4">' +

                    '<div class="flex items-center gap-3">' +

                        '<div class="flex h-9 w-9 shrink-0 items-center justify-center rounded-lg bg-blue-50 font-manrope text-xs font-extrabold text-blue-600">' +

                            escapeHtml(firstLetter) +

                        '</div>' +

                        '<div>' +

                            '<p class="font-manrope text-xs font-bold text-slate-800">' +

                                escapeHtml(name) +

                            '</p>' +

                            '<p class="mt-0.5 font-inter text-[9px] text-slate-400">' +

                                'ID: ' +
                                escapeHtml(id) +

                            '</p>' +

                        '</div>' +

                    '</div>' +

                '</td>';


            /* SPECIALIZATION */

            html +=
                '<td class="px-5 py-4">' +

                    '<span class="font-inter text-[10px] font-medium text-slate-600">' +

                        escapeHtml(
                            specialization
                        ) +

                    '</span>' +

                '</td>';


            /* CONSULTATION */

            html +=
                '<td class="px-5 py-4">' +

                    '<span class="font-inter text-[10px] font-semibold text-slate-700">' +

                        'LKR ' +

                        escapeHtml(
                            fee.toFixed(2)
                        ) +

                    '</span>' +

                '</td>';


            /* CONTACT */

            html +=
                '<td class="px-5 py-4">' +

                    '<div>' +

                        '<p class="font-inter text-[10px] font-medium text-slate-700">' +

                            escapeHtml(phone) +

                        '</p>' +

                        '<p class="mt-0.5 font-inter text-[9px] text-slate-400">' +

                            escapeHtml(email) +

                        '</p>' +

                    '</div>' +

                '</td>';


            /* STATUS */

            html +=
                '<td class="px-5 py-4">' +

                    '<span class="inline-flex rounded-full px-3 py-1.5 font-inter text-[10px] font-bold ' +

                    (
                        active
                            ? 'bg-emerald-50 text-emerald-700'
                            : 'bg-slate-100 text-slate-500'
                    ) +

                    '">' +

                    (
                        active
                            ? 'Active'
                            : 'Inactive'
                    ) +

                    '</span>' +

                '</td>';


            /* ACTIONS */

            html +=
                '<td class="px-5 py-4 text-right">' +

                    '<div class="flex items-center justify-end gap-3">' +


                        '<a ' +

                            'href="' +

                            contextPath +

                            '/dentists/view?id=' +

                            encodeURIComponent(id) +

                            '" ' +

                            'class="font-inter text-[10px] font-bold text-blue-600 transition hover:text-blue-800">' +

                            'View' +

                        '</a>' +


                        '<a ' +

                            'href="' +

                            contextPath +

                            '/dentists/edit?id=' +

                            encodeURIComponent(id) +

                            '" ' +

                            'class="font-inter text-[10px] font-bold text-slate-600 transition hover:text-blue-700">' +

                            'Edit' +

                        '</a>' +


                        '<a ' +

                            'href="' +

                            contextPath +

                            '/dentists/schedule?id=' +

                            encodeURIComponent(id) +

                            '" ' +

                            'class="font-inter text-[10px] font-bold text-slate-500 transition hover:text-blue-700">' +

                            'Schedule' +

                        '</a>' +


                    '</div>' +

                '</td>';


            html +=
                '</tr>';

        });


        tableBody.innerHTML =
            html;

    }


    /* =====================================================
       SEARCH FORM
       ===================================================== */

    searchForm.addEventListener(
        "submit",
        function (event) {

            event.preventDefault();

            loadDentists();

        }
    );


    /* =====================================================
       ENTER KEY
       ===================================================== */

    keywordInput.addEventListener(
        "keydown",
        function (event) {

            if (event.key === "Enter") {

                event.preventDefault();

                loadDentists();

            }

        }
    );


    /* =====================================================
       CLEAR SEARCH
       ===================================================== */

    clearSearch.addEventListener(
        "click",
        function () {

            keywordInput.value = "";

            loadDentists();

        }
    );


    /* =====================================================
       INITIAL LOAD
       ===================================================== */

    loadDentists();


})();

</script>


</body>

</html>