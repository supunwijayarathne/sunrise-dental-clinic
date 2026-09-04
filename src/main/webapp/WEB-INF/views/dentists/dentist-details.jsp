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
        Dentist Details | Sunrise Dental Clinic
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


    <!-- Google Fonts -->

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


        <!-- PAGE HEADER -->

        <div class="mb-7 flex items-center justify-between">


            <div>


                <p class="mb-1 font-inter text-[10px] font-semibold uppercase tracking-[0.12em] text-slate-400">
                    Dentists
                </p>


                <h1 class="text-[25px] font-extrabold tracking-[-0.7px]">
                    Dentist Details
                </h1>


                <p class="mt-1 font-inter text-xs text-slate-500">
                    Complete information about this dentist.
                </p>


            </div>


            <!-- ID -->

            <div class="rounded-lg border border-slate-200 bg-white px-4 py-2.5">


                <p class="font-inter text-[8px] font-semibold uppercase tracking-[0.1em] text-slate-400">
                    Dentist ID
                </p>


                <p
                    id="topDentistId"
                    class="mt-0.5 text-xs font-extrabold text-blue-600"
                >
                    -
                </p>


            </div>


        </div>



        <!-- SUCCESS -->

        <div
            id="successMessage"
            class="mb-5 hidden flex items-center gap-3 rounded-lg border border-emerald-100 bg-emerald-50 px-4 py-3 text-xs font-semibold text-emerald-700"
        >


            <span class="flex h-5 w-5 items-center justify-center rounded-full bg-emerald-100">
                ✓
            </span>


            Dentist updated successfully.


        </div>



        <!-- LOADING -->

        <div
            id="loadingState"
            class="mx-auto max-w-[900px] rounded-xl border border-slate-200 bg-white px-7 py-10 text-center"
        >

            <p class="font-inter text-[10px] text-slate-400">
                Loading dentist details...
            </p>

        </div>



        <!-- ERROR -->

        <div
            id="errorState"
            class="mx-auto hidden max-w-[900px] rounded-xl border border-red-100 bg-red-50 px-7 py-8 text-center"
        >

            <p class="font-inter text-[10px] font-semibold text-red-600">
                Unable to load dentist details.
            </p>


            <p
                id="errorText"
                class="mt-1 font-inter text-[9px] text-red-500"
            ></p>


            <a
                href="<%= contextPath %>/dentists"
                class="mt-4 inline-block rounded-lg bg-[#2563EB] px-4 py-2 font-inter text-[10px] font-semibold text-white"
            >
                Back to Dentists
            </a>

        </div>



        <!-- CONTENT -->

        <div
            id="dentistContent"
            class="mx-auto hidden max-w-[900px]"
        >


            <!-- PROFILE CARD -->

            <div class="overflow-hidden rounded-xl border border-slate-200 bg-white">


                <!-- PROFILE HEADER -->

                <div class="flex items-center gap-5 border-b border-slate-100 px-7 py-6">


                    <!-- AVATAR -->

                    <div
                        id="dentistAvatar"
                        class="flex h-16 w-16 items-center justify-center rounded-2xl bg-blue-50 text-xl font-extrabold text-blue-600"
                    >

                        D

                    </div>


                    <!-- NAME + SPECIALIZATION -->

                    <div class="flex-1">


                        <h2
                            id="dentistName"
                            class="text-lg font-extrabold tracking-[-0.4px]"
                        >

                            -

                        </h2>


                        <p
                            id="dentistSpecialization"
                            class="mt-1 font-inter text-[10px] text-slate-500"
                        >

                            -

                        </p>


                    </div>



                    <!-- STATUS -->

                    <span
                        id="profileStatus"
                        class="rounded-full px-3 py-1.5 font-inter text-[9px] font-semibold"
                    >

                        -

                    </span>


                </div>



                <!-- DETAILS -->

                <div class="grid grid-cols-2">


                    <!-- DENTIST ID -->

                    <div class="border-b border-r border-slate-100 px-7 py-5">


                        <p class="font-inter text-[9px] font-semibold uppercase tracking-wide text-slate-400">
                            Dentist ID
                        </p>


                        <p
                            id="detailDentistId"
                            class="mt-2 text-sm font-bold"
                        >

                            -

                        </p>


                    </div>



                    <!-- SPECIALIZATION -->

                    <div class="border-b border-slate-100 px-7 py-5">


                        <p class="font-inter text-[9px] font-semibold uppercase tracking-wide text-slate-400">
                            Specialization
                        </p>


                        <p
                            id="detailSpecialization"
                            class="mt-2 text-sm font-bold"
                        >

                            -

                        </p>


                    </div>



                    <!-- CONSULTATION FEE -->

                    <div class="border-b border-r border-slate-100 px-7 py-5">


                        <p class="font-inter text-[9px] font-semibold uppercase tracking-wide text-slate-400">
                            Consultation Fee
                        </p>


                        <p
                            id="detailFee"
                            class="mt-2 text-sm font-extrabold text-[#2563EB]"
                        >

                            -

                        </p>


                    </div>



                    <!-- PHONE -->

                    <div class="border-b border-slate-100 px-7 py-5">


                        <p class="font-inter text-[9px] font-semibold uppercase tracking-wide text-slate-400">
                            Phone Number
                        </p>


                        <p
                            id="detailPhone"
                            class="mt-2 text-sm font-bold"
                        >

                            -

                        </p>


                    </div>



                    <!-- EMAIL -->

                    <div class="border-r border-slate-100 px-7 py-5">


                        <p class="font-inter text-[9px] font-semibold uppercase tracking-wide text-slate-400">
                            Email
                        </p>


                        <p
                            id="detailEmail"
                            class="mt-2 break-all text-sm font-bold"
                        >

                            -

                        </p>


                    </div>



                    <!-- STATUS -->

                    <div class="px-7 py-5">


                        <p class="font-inter text-[9px] font-semibold uppercase tracking-wide text-slate-400">
                            Account Status
                        </p>


                        <div class="mt-2">


                            <span
                                id="detailStatus"
                                class="inline-flex items-center gap-1.5 rounded-full px-2.5 py-1 font-inter text-[9px] font-semibold"
                            >


                                <span
                                    id="statusDot"
                                    class="h-1.5 w-1.5 rounded-full"
                                ></span>


                                <span id="statusText">
                                    -
                                </span>


                            </span>


                        </div>


                    </div>


                </div>


            </div>



            <!-- QUICK SUMMARY -->

            <div class="mt-5 grid grid-cols-3 gap-4">


                <!-- SPECIALIZATION -->

                <div class="rounded-xl border border-slate-200 bg-white p-5">


                    <div class="mb-3 flex h-8 w-8 items-center justify-center rounded-lg bg-blue-50">


                        <svg
                            class="h-4 w-4 text-blue-600"
                            fill="none"
                            stroke="currentColor"
                            stroke-width="1.7"
                            viewBox="0 0 24 24"
                        >

                            <path
                                stroke-linecap="round"
                                stroke-linejoin="round"
                                d="M12 3v18M3 12h18"
                            />

                        </svg>


                    </div>


                    <p class="font-inter text-[9px] text-slate-400">
                        Specialty
                    </p>


                    <p
                        id="summarySpecialization"
                        class="mt-1 text-[11px] font-bold"
                    >

                        -

                    </p>


                </div>



                <!-- FEE -->

                <div class="rounded-xl border border-slate-200 bg-white p-5">


                    <div class="mb-3 flex h-8 w-8 items-center justify-center rounded-lg bg-emerald-50">


                        <svg
                            class="h-4 w-4 text-emerald-600"
                            fill="none"
                            stroke="currentColor"
                            stroke-width="1.7"
                            viewBox="0 0 24 24"
                        >

                            <path
                                stroke-linecap="round"
                                stroke-linejoin="round"
                                d="M12 2v20M17 5H9.5a3.5 3.5 0 000 7H14a3.5 3.5 0 010 7H6"
                            />

                        </svg>


                    </div>


                    <p class="font-inter text-[9px] text-slate-400">
                        Consultation Fee
                    </p>


                    <p
                        id="summaryFee"
                        class="mt-1 text-[11px] font-extrabold"
                    >

                        -

                    </p>


                </div>



                <!-- STATUS -->

                <div class="rounded-xl border border-slate-200 bg-white p-5">


                    <div class="mb-3 flex h-8 w-8 items-center justify-center rounded-lg bg-slate-100">


                        <svg
                            class="h-4 w-4 text-slate-600"
                            fill="none"
                            stroke="currentColor"
                            stroke-width="1.7"
                            viewBox="0 0 24 24"
                        >

                            <circle
                                cx="12"
                                cy="12"
                                r="9"
                            />


                            <path
                                stroke-linecap="round"
                                d="M8 12l2.5 2.5L16 9"
                            />

                        </svg>


                    </div>


                    <p class="font-inter text-[9px] text-slate-400">
                        Current Status
                    </p>


                    <p
                        id="summaryStatus"
                        class="mt-1 text-[11px] font-bold"
                    >

                        -

                    </p>


                </div>


            </div>



            <!-- ACTIONS -->

            <div class="mt-6 flex items-center justify-between">


                <a
                    href="<%= contextPath %>/dentists"
                    class="flex items-center gap-2 rounded-lg border border-slate-200 bg-white px-4 py-2.5 font-inter text-[10px] font-semibold text-slate-600 transition hover:bg-slate-50"
                >

                    ← Back to Dentists

                </a>


                <a
                    id="editButton"
                    href="#"
                    class="flex items-center gap-2 rounded-lg bg-[#2563EB] px-5 py-2.5 font-inter text-[10px] font-bold text-white shadow-sm transition hover:bg-[#1D4ED8]"
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
                            stroke-linejoin="round"
                            d="M12 20h9"
                        />


                        <path
                            stroke-linecap="round"
                            stroke-linejoin="round"
                            d="M16.5 3.5a2.1 2.1 0 013 3L8 18l-4 1 1-4z"
                        />

                    </svg>


                    Edit Dentist

                </a>


            </div>


        </div>



        <!-- FOOTER -->

        <div class="mt-8 flex items-center justify-between px-1">


            <p class="font-inter text-[9px] text-slate-400">
                Sunrise Dental Clinic
            </p>


            <p class="font-inter text-[9px] text-slate-400">
                Dentist Management
            </p>


        </div>


    </main>


</div>



<!-- =========================================================
     REST API
     ========================================================= -->

<script>

(function () {

    "use strict";


    /* =====================================================
       CONTEXT PATH
       ===================================================== */

    var contextPath =
        "<%= contextPath %>";


    /* =====================================================
       GET DENTIST ID FROM URL
       ===================================================== */

    var urlParams =
        new URLSearchParams(
            window.location.search
        );


    var dentistId =
        urlParams.get("id") ||
        urlParams.get("dentistId");


    /* =====================================================
       ELEMENTS
       ===================================================== */

    var loadingState =
        document.getElementById(
            "loadingState"
        );


    var errorState =
        document.getElementById(
            "errorState"
        );


    var errorText =
        document.getElementById(
            "errorText"
        );


    var dentistContent =
        document.getElementById(
            "dentistContent"
        );


    var topDentistId =
        document.getElementById(
            "topDentistId"
        );


    var dentistAvatar =
        document.getElementById(
            "dentistAvatar"
        );


    var dentistName =
        document.getElementById(
            "dentistName"
        );


    var dentistSpecialization =
        document.getElementById(
            "dentistSpecialization"
        );


    var profileStatus =
        document.getElementById(
            "profileStatus"
        );


    var detailDentistId =
        document.getElementById(
            "detailDentistId"
        );


    var detailSpecialization =
        document.getElementById(
            "detailSpecialization"
        );


    var detailFee =
        document.getElementById(
            "detailFee"
        );


    var detailPhone =
        document.getElementById(
            "detailPhone"
        );


    var detailEmail =
        document.getElementById(
            "detailEmail"
        );


    var detailStatus =
        document.getElementById(
            "detailStatus"
        );


    var statusDot =
        document.getElementById(
            "statusDot"
        );


    var statusText =
        document.getElementById(
            "statusText"
        );


    var summarySpecialization =
        document.getElementById(
            "summarySpecialization"
        );


    var summaryFee =
        document.getElementById(
            "summaryFee"
        );


    var summaryStatus =
        document.getElementById(
            "summaryStatus"
        );


    var editButton =
        document.getElementById(
            "editButton"
        );


    var successMessage =
        document.getElementById(
            "successMessage"
        );



    /* =====================================================
       CHECK ID
       ===================================================== */

    if (!dentistId) {

        loadingState.classList.add(
            "hidden"
        );


        errorState.classList.remove(
            "hidden"
        );


        errorText.textContent =
            "No dentist ID was provided.";

        return;

    }



    /* =====================================================
       SUCCESS MESSAGE
       ===================================================== */

    if (
        urlParams.get("updated") === "1"
    ) {

        successMessage.classList.remove(
            "hidden"
        );

    }



    /* =====================================================
       LOAD DENTIST
       ===================================================== */

    function loadDentist() {


        /*
         * REST API:
         *
         * GET /api/dentists/{id}
         */

        var apiUrl =
            contextPath +
            "/api/dentists/" +
            encodeURIComponent(
                dentistId
            );


        console.log(
            "GET:",
            apiUrl
        );


        fetch(
            apiUrl,
            {
                method: "GET",

                credentials:
                    "same-origin",

                headers: {

                    "Accept":
                        "application/json"

                }

            }
        )

        .then(function (response) {


            /* LOGIN REQUIRED */

            if (
                response.status ===
                401
            ) {

                window.location.href =
                    contextPath +
                    "/login";

                return null;

            }


            /* NOT FOUND */

            if (
                response.status ===
                404
            ) {

                throw new Error(
                    "Dentist not found."
                );

            }


            /* OTHER ERROR */

            if (!response.ok) {

                throw new Error(
                    "Unable to load dentist. HTTP " +
                    response.status
                );

            }


            return response.json();

        })

        .then(function (dentist) {


            if (!dentist) {

                return;

            }


            console.log(
                "Dentist:",
                dentist
            );


            renderDentist(
                dentist
            );

        })

        .catch(function (error) {

            console.error(
                "Dentist API error:",
                error
            );


            loadingState.classList.add(
                "hidden"
            );


            dentistContent.classList.add(
                "hidden"
            );


            errorState.classList.remove(
                "hidden"
            );


            errorText.textContent =
                error.message ||
                "Unable to load dentist details.";

        });

    }



    /* =====================================================
       RENDER DENTIST
       ===================================================== */

    function renderDentist(
        dentist
    ) {


        /*
         * Fields returned by DentistApi:
         *
         * dentistId
         * dentistName
         * specialization
         * consultationFee
         * phoneNumber
         * email
         * active
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
            "-";


        var active =
            dentist.active === true;



        /* =================================================
           TOP ID
           ================================================= */

        topDentistId.textContent =
            "#" + id;



        /* =================================================
           MAIN AVATAR
           ================================================= */

        var firstLetter =
            name
                .trim()
                .substring(0, 1)
                .toUpperCase();


        dentistAvatar.textContent =
            firstLetter ||
            "D";



        /* =================================================
           MAIN NAME
           ================================================= */

        dentistName.textContent =
            name;


        dentistSpecialization.textContent =
            specialization;



        /* =================================================
           PROFILE STATUS
           ================================================= */

        if (active) {

            profileStatus.textContent =
                "Active";


            profileStatus.className =
                "rounded-full bg-emerald-50 px-3 py-1.5 font-inter text-[9px] font-semibold text-emerald-600";

        }

        else {

            profileStatus.textContent =
                "Inactive";


            profileStatus.className =
                "rounded-full bg-slate-100 px-3 py-1.5 font-inter text-[9px] font-semibold text-slate-500";

        }



        /* =================================================
           DETAILS
           ================================================= */

        /*
         * Changed:
         *
         * Dentist Name
         *      ↓
         * Dentist ID
         */

        detailDentistId.textContent =
            "#" + id;


        detailSpecialization.textContent =
            specialization;


        detailFee.textContent =
            "LKR " +
            fee.toFixed(2);


        detailPhone.textContent =
            phone;


        detailEmail.textContent =
            email;



        /* =================================================
           ACCOUNT STATUS
           ================================================= */

        if (active) {


            detailStatus.className =
                "inline-flex items-center gap-1.5 rounded-full bg-emerald-50 px-2.5 py-1 font-inter text-[9px] font-semibold text-emerald-600";


            statusDot.className =
                "h-1.5 w-1.5 rounded-full bg-emerald-400";


            statusText.textContent =
                "Active";


        }

        else {


            detailStatus.className =
                "inline-flex items-center gap-1.5 rounded-full bg-slate-100 px-2.5 py-1 font-inter text-[9px] font-semibold text-slate-500";


            statusDot.className =
                "h-1.5 w-1.5 rounded-full bg-slate-400";


            statusText.textContent =
                "Inactive";


        }



        /* =================================================
           QUICK SUMMARY
           ================================================= */

        summarySpecialization.textContent =
            specialization;


        summaryFee.textContent =
            "LKR " +
            fee.toFixed(2);


        summaryStatus.textContent =
            active
                ? "Available"
                : "Inactive";



        /* =================================================
           EDIT BUTTON
           ================================================= */

        editButton.href =
            contextPath +
            "/dentists/edit?id=" +
            encodeURIComponent(
                id
            );



        /* =================================================
           SHOW CONTENT
           ================================================= */

        loadingState.classList.add(
            "hidden"
        );


        errorState.classList.add(
            "hidden"
        );


        dentistContent.classList.remove(
            "hidden"
        );

    }



    /* =====================================================
       START
       ===================================================== */

    loadDentist();


})();

</script>


</body>

</html>