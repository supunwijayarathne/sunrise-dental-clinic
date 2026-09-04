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
        Dentist | Sunrise Dental Clinic
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

    <link
        rel="preconnect"
        href="https://fonts.googleapis.com"
    >

    <link
        rel="preconnect"
        href="https://fonts.gstatic.com"
        crossorigin
    >

    <link
        href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600&family=Manrope:wght@400;500;600;700;800&display=swap"
        rel="stylesheet"
    >


    <style>

        body {
            font-family: 'Manrope', sans-serif;
        }

        .font-inter {
            font-family: 'Inter', sans-serif;
        }

        .font-manrope {
            font-family: 'Manrope', sans-serif;
        }

        input:focus,
        textarea:focus,
        select:focus {
            outline: none;
        }

    </style>

</head>


<body
    class="min-h-screen bg-[#F5F7FB] font-manrope text-[#172033]"
>


<div class="flex min-h-screen">


    <!-- =====================================================
         SIDEBAR
         ===================================================== -->

    <jsp:include page="../common/sidebar.jsp" />


    <!-- =====================================================
         MAIN CONTENT
         ===================================================== -->

    <main
        class="ml-[250px] min-h-screen flex-1 px-8 py-7"
    >


        <!-- =================================================
             PAGE HEADER
             ================================================= -->

        <div class="mb-7">


            <!-- Breadcrumb -->

            <div
                class="mb-4 flex items-center gap-2 font-inter text-[11px] font-medium text-slate-400"
            >

                <a
                    href="<%= contextPath %>/dentists"
                    class="transition hover:text-blue-600"
                >

                    Dentists

                </a>

                <span>/</span>

                <span
                    id="breadcrumbTitle"
                    class="text-slate-500"
                >

                    Add Dentist

                </span>

            </div>


            <!-- Header -->

            <div
                class="flex items-end justify-between"
            >

                <div>

                    <h1
                        id="pageTitle"
                        class="font-manrope text-2xl font-extrabold tracking-tight text-[#172033]"
                    >

                        Add Dentist

                    </h1>

                    <p
                        id="pageDescription"
                        class="mt-1.5 font-inter text-xs text-slate-500"
                    >

                        Add a new dentist to the clinic.

                    </p>

                </div>


                <!-- Back -->

                <a
                    href="<%= contextPath %>/dentists"
                    class="inline-flex items-center gap-2 rounded-lg border border-slate-200 bg-white px-4 py-2.5 font-inter text-[11px] font-semibold text-slate-600 shadow-sm transition hover:bg-slate-50"
                >

                    <svg
                        class="h-4 w-4"
                        fill="none"
                        stroke="currentColor"
                        stroke-width="1.8"
                        viewBox="0 0 24 24"
                    >

                        <path
                            stroke-linecap="round"
                            stroke-linejoin="round"
                            d="M19 12H5"
                        />

                        <path
                            stroke-linecap="round"
                            stroke-linejoin="round"
                            d="M12 19l-7-7 7-7"
                        />

                    </svg>

                    Back to Dentists

                </a>

            </div>

        </div>



        <!-- =================================================
             FORM
             ================================================= -->

        <form
            id="dentistForm"
            class="mx-auto max-w-[850px]"
        >


            <!-- Hidden Dentist ID -->

            <input
                type="hidden"
                id="dentistId"
                name="dentistId"
                value=""
            >


            <!-- =================================================
                 DENTIST INFORMATION
                 ================================================= -->

            <div
                class="overflow-hidden rounded-xl border border-slate-200 bg-white"
            >


                <!-- Card Header -->

                <div
                    class="border-b border-slate-100 px-6 py-4"
                >

                    <div class="flex items-center gap-3">

                        <div
                            class="flex h-9 w-9 items-center justify-center rounded-lg bg-blue-50 text-blue-600"
                        >

                            <svg
                                class="h-4 w-4"
                                fill="none"
                                stroke="currentColor"
                                stroke-width="1.8"
                                viewBox="0 0 24 24"
                            >

                                <path
                                    stroke-linecap="round"
                                    stroke-linejoin="round"
                                    d="M15 21v-2a4 4 0 00-4-4H7a4 4 0 00-4 4v2"
                                />

                                <circle
                                    cx="9"
                                    cy="7"
                                    r="4"
                                />

                                <path
                                    stroke-linecap="round"
                                    stroke-linejoin="round"
                                    d="M19 8v6"
                                />

                                <path
                                    stroke-linecap="round"
                                    stroke-linejoin="round"
                                    d="M22 11h-6"
                                />

                            </svg>

                        </div>


                        <div>

                            <h2
                                class="font-manrope text-sm font-bold text-[#172033]"
                            >

                                Dentist Information

                            </h2>

                            <p
                                class="mt-0.5 font-inter text-[10px] text-slate-400"
                            >

                                Basic information about the dentist.

                            </p>

                        </div>

                    </div>

                </div>



                <!-- Card Body -->

                <div class="p-6">


                    <div
                        class="grid grid-cols-1 gap-5 md:grid-cols-2"
                    >


                        <!-- Dentist Name -->

                        <div>

                            <label
                                for="dentistName"
                                class="mb-2 block font-inter text-[10px] font-semibold uppercase tracking-wide text-slate-500"
                            >

                                Dentist Name

                            </label>

                            <input
                                type="text"
                                id="dentistName"
                                name="dentistName"
                                required
                                placeholder="Enter dentist name"
                                class="w-full rounded-lg border border-slate-200 bg-white px-3.5 py-2.5 font-inter text-xs text-slate-700 placeholder:text-slate-300 focus:border-blue-500 focus:ring-1 focus:ring-blue-500"
                            >

                        </div>



                        <!-- Specialization -->

                        <div>

                            <label
                                for="specialization"
                                class="mb-2 block font-inter text-[10px] font-semibold uppercase tracking-wide text-slate-500"
                            >

                                Specialization

                            </label>

                            <input
                                type="text"
                                id="specialization"
                                name="specialization"
                                required
                                placeholder="e.g. General Dentistry"
                                class="w-full rounded-lg border border-slate-200 bg-white px-3.5 py-2.5 font-inter text-xs text-slate-700 placeholder:text-slate-300 focus:border-blue-500 focus:ring-1 focus:ring-blue-500"
                            >

                        </div>


                    </div>

                </div>

            </div>



            <!-- =================================================
                 CONTACT & CONSULTATION
                 ================================================= -->

            <div
                class="mt-5 overflow-hidden rounded-xl border border-slate-200 bg-white"
            >


                <!-- Header -->

                <div
                    class="border-b border-slate-100 px-6 py-4"
                >

                    <div class="flex items-center gap-3">

                        <div
                            class="flex h-9 w-9 items-center justify-center rounded-lg bg-blue-50 text-blue-600"
                        >

                            <svg
                                class="h-4 w-4"
                                fill="none"
                                stroke="currentColor"
                                stroke-width="1.8"
                                viewBox="0 0 24 24"
                            >

                                <path
                                    stroke-linecap="round"
                                    stroke-linejoin="round"
                                    d="M22 16.92v3a2 2 0 01-2.18 2 19.79 19.79 0 01-8.63-3.07 19.5 19.5 0 01-6-6A19.79 19.79 0 012.12 4.18 2 2 0 014.11 2h3a2 2 0 012 1.72 12.84 12.84 0 00.7 2.81 2 2 0 01-.45 2.11L8.09 9.91a16 16 0 006 6l1.27-1.27a2 2 0 012.11-.45 12.84 12.84 0 002.81.7A2 2 0 0122 16.92z"
                                />

                            </svg>

                        </div>


                        <div>

                            <h2
                                class="font-manrope text-sm font-bold text-[#172033]"
                            >

                                Contact & Consultation

                            </h2>

                            <p
                                class="mt-0.5 font-inter text-[10px] text-slate-400"
                            >

                                Contact details and consultation fee.

                            </p>

                        </div>

                    </div>

                </div>



                <!-- Body -->

                <div class="p-6">


                    <div
                        class="grid grid-cols-1 gap-5 md:grid-cols-2"
                    >


                        <!-- Consultation Fee -->

                        <div>

                            <label
                                for="consultationFee"
                                class="mb-2 block font-inter text-[10px] font-semibold uppercase tracking-wide text-slate-500"
                            >

                                Consultation Fee

                            </label>

                            <div class="relative">

                                <span
                                    class="absolute left-3.5 top-1/2 -translate-y-1/2 font-inter text-xs font-medium text-slate-400"
                                >

                                    LKR

                                </span>

                                <input
                                    type="number"
                                    id="consultationFee"
                                    name="consultationFee"
                                    required
                                    min="0"
                                    step="0.01"
                                    placeholder="0.00"
                                    class="w-full rounded-lg border border-slate-200 bg-white py-2.5 pl-12 pr-3.5 font-inter text-xs text-slate-700 placeholder:text-slate-300 focus:border-blue-500 focus:ring-1 focus:ring-blue-500"
                                >

                            </div>

                        </div>



                        <!-- Phone -->

                        <div>

                            <label
                                for="phoneNumber"
                                class="mb-2 block font-inter text-[10px] font-semibold uppercase tracking-wide text-slate-500"
                            >

                                Phone Number

                            </label>

                            <input
                                type="text"
                                id="phoneNumber"
                                name="phoneNumber"
                                placeholder="Enter phone number"
                                class="w-full rounded-lg border border-slate-200 bg-white px-3.5 py-2.5 font-inter text-xs text-slate-700 placeholder:text-slate-300 focus:border-blue-500 focus:ring-1 focus:ring-blue-500"
                            >

                        </div>



                        <!-- Email -->

                        <div class="md:col-span-2">

                            <label
                                for="email"
                                class="mb-2 block font-inter text-[10px] font-semibold uppercase tracking-wide text-slate-500"
                            >

                                Email Address

                            </label>

                            <input
                                type="email"
                                id="email"
                                name="email"
                                placeholder="Enter email address"
                                class="w-full rounded-lg border border-slate-200 bg-white px-3.5 py-2.5 font-inter text-xs text-slate-700 placeholder:text-slate-300 focus:border-blue-500 focus:ring-1 focus:ring-blue-500"
                            >

                        </div>


                    </div>

                </div>

            </div>



            <!-- =================================================
                 ACCOUNT STATUS
                 ================================================= -->

            <div
                class="mt-5 overflow-hidden rounded-xl border border-slate-200 bg-white"
            >


                <!-- Header -->

                <div
                    class="border-b border-slate-100 px-6 py-4"
                >

                    <div class="flex items-center gap-3">

                        <div
                            class="flex h-9 w-9 items-center justify-center rounded-lg bg-blue-50 text-blue-600"
                        >

                            <svg
                                class="h-4 w-4"
                                fill="none"
                                stroke="currentColor"
                                stroke-width="1.8"
                                viewBox="0 0 24 24"
                            >

                                <path
                                    stroke-linecap="round"
                                    stroke-linejoin="round"
                                    d="M12 3l7 4v5c0 4.5-3 7.5-7 9-4-1.5-7-4.5-7-9V7l7-4z"
                                />

                                <path
                                    stroke-linecap="round"
                                    stroke-linejoin="round"
                                    d="M9 12l2 2 4-4"
                                />

                            </svg>

                        </div>


                        <div>

                            <h2
                                class="font-manrope text-sm font-bold text-[#172033]"
                            >

                                Account Status

                            </h2>

                            <p
                                class="mt-0.5 font-inter text-[10px] text-slate-400"
                            >

                                Control whether the dentist is active.

                            </p>

                        </div>

                    </div>

                </div>



                <!-- Body -->

                <div class="p-6">


                    <label
                        for="active"
                        class="mb-2 block font-inter text-[10px] font-semibold uppercase tracking-wide text-slate-500"
                    >

                        Status

                    </label>


                    <select
                        id="active"
                        name="active"
                        class="w-full rounded-lg border border-slate-200 bg-white px-3.5 py-2.5 font-inter text-xs text-slate-700 focus:border-blue-500 focus:ring-1 focus:ring-blue-500"
                    >

                        <option value="true">
                            Active
                        </option>

                        <option value="false">
                            Inactive
                        </option>

                    </select>


                </div>

            </div>



            <!-- =================================================
                 API MESSAGE
                 ================================================= -->

            <div
                id="apiMessage"
                class="mt-5 hidden rounded-lg border px-4 py-3 font-inter text-xs"
            >
            </div>



            <!-- =================================================
                 ACTIONS
                 ================================================= -->

            <div
                class="mt-5 flex items-center justify-end gap-3 rounded-xl border border-slate-200 bg-white px-6 py-4"
            >


                <!-- Cancel -->

                <a
                    href="<%= contextPath %>/dentists"
                    class="rounded-lg border border-slate-200 bg-white px-5 py-2.5 font-inter text-[11px] font-semibold text-slate-600 transition hover:bg-slate-50"
                >

                    Cancel

                </a>


                <!-- Submit -->

                <button
                    id="submitButton"
                    type="submit"
                    class="inline-flex items-center gap-2 rounded-lg bg-[#2563EB] px-5 py-2.5 font-inter text-[11px] font-bold text-white shadow-sm transition hover:bg-[#1D4ED8]"
                >

                    <svg
                        class="h-4 w-4"
                        fill="none"
                        stroke="currentColor"
                        stroke-width="2"
                        viewBox="0 0 24 24"
                    >

                        <path
                            stroke-linecap="round"
                            stroke-linejoin="round"
                            d="M5 12l4 4L19 6"
                        />

                    </svg>

                    <span id="submitButtonText">
                        Add Dentist
                    </span>

                </button>


            </div>


        </form>



        <!-- =================================================
             FOOTER
             ================================================= -->

        <div
            class="mx-auto mt-8 flex max-w-[850px] items-center justify-between px-1"
        >

            <p
                class="font-inter text-[9px] text-slate-400"
            >

                Sunrise Dental Clinic

            </p>

            <p
                class="font-inter text-[9px] text-slate-400"
            >

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


    /*
     * =========================================================
     * BASIC VARIABLES
     * =========================================================
     */

    const contextPath =
        "<%= contextPath %>";


    const params =
        new URLSearchParams(
            window.location.search
        );


    const requestedDentistId =
        params.get("id") ||
        params.get("dentistId") ||
        "";


    const editMode =
        requestedDentistId !== "";


    const form =
        document.getElementById(
            "dentistForm"
        );


    const submitButton =
        document.getElementById(
            "submitButton"
        );


    const submitButtonText =
        document.getElementById(
            "submitButtonText"
        );


    const pageTitle =
        document.getElementById(
            "pageTitle"
        );


    const pageDescription =
        document.getElementById(
            "pageDescription"
        );


    const breadcrumbTitle =
        document.getElementById(
            "breadcrumbTitle"
        );


    const apiMessage =
        document.getElementById(
            "apiMessage"
        );


    const dentistIdField =
        document.getElementById(
            "dentistId"
        );


    /*
     * =========================================================
     * PAGE MODE
     * =========================================================
     */

    if (editMode) {

        document.title =
            "Edit Dentist - Sunrise Dental Clinic";


        pageTitle.textContent =
            "Edit Dentist";


        pageDescription.textContent =
            "Update the dentist's clinic information.";


        breadcrumbTitle.textContent =
            "Edit Dentist";


        submitButtonText.textContent =
            "Update Dentist";


        dentistIdField.value =
            requestedDentistId;

    }



    /*
     * =========================================================
     * MESSAGE
     * =========================================================
     */

    function showMessage(
        message,
        success
    ) {

        if (!apiMessage) {
            return;
        }


        apiMessage.classList.remove(
            "hidden",
            "border-emerald-100",
            "bg-emerald-50",
            "text-emerald-700",
            "border-red-100",
            "bg-red-50",
            "text-red-700"
        );


        if (success) {

            apiMessage.classList.add(
                "border-emerald-100",
                "bg-emerald-50",
                "text-emerald-700"
            );

        }
        else {

            apiMessage.classList.add(
                "border-red-100",
                "bg-red-50",
                "text-red-700"
            );

        }


        apiMessage.textContent =
            message;

    }



    /*
     * =========================================================
     * GET FIELD
     * =========================================================
     */

    function field(
        name
    ) {

        return form.querySelector(
            '[name="' + name + '"]'
        );

    }



    /*
     * =========================================================
     * SET FIELD
     * =========================================================
     */

    function setField(
        name,
        value
    ) {

        const element =
            field(name);


        if (!element) {
            return;
        }


        element.value =
            value === null ||
            value === undefined
                ? ""
                : value;

    }



    /*
     * =========================================================
     * GET JSON
     * =========================================================
     */

    async function getJson(
        url
    ) {

        const response =
            await fetch(
                contextPath + url,
                {
                    method: "GET",

                    credentials:
                        "same-origin",

                    headers: {
                        "Accept":
                            "application/json"
                    }
                }
            );


        if (response.status === 401) {

            window.location.href =
                contextPath + "/login";

            return null;

        }


        if (response.status === 403) {

            throw new Error(
                "You do not have permission to access this dentist."
            );

        }


        const text =
            await response.text();


        let data = null;


        if (text) {

            try {

                data =
                    JSON.parse(text);

            }
            catch (error) {

                data = null;

            }

        }


        if (!response.ok) {

            throw new Error(
                getApiMessage(
                    data,
                    "Unable to load dentist."
                )
            );

        }


        return data;

    }



    /*
     * =========================================================
     * API ERROR MESSAGE
     * =========================================================
     */

    function getApiMessage(
        data,
        fallback
    ) {

        if (!data) {
            return fallback;
        }


        if (
            typeof data.message ===
            "string"
        ) {

            return data.message;

        }


        if (
            typeof data.error ===
            "string"
        ) {

            return data.error;

        }


        if (
            data.error &&
            typeof data.error.message ===
            "string"
        ) {

            return data.error.message;

        }


        return fallback;

    }



    /*
     * =========================================================
     * LOAD DENTIST FOR EDIT
     *
     * GET /api/dentists/{id}
     * =========================================================
     */

    async function loadDentist() {

        if (!editMode) {
            return;
        }


        try {

            showMessage(
                "Loading dentist information...",
                true
            );


            const dentist =
                await getJson(
                    "/api/dentists/" +
                    encodeURIComponent(
                        requestedDentistId
                    )
                );


            if (!dentist) {
                return;
            }


            /*
             * Dentist ID
             */

            setField(
                "dentistId",
                dentist.dentistId
            );


            /*
             * Dentist Name
             */

            setField(
                "dentistName",
                dentist.dentistName ||
                dentist.name ||
                dentist.fullName ||
                ""
            );


            /*
             * Specialization
             */

            setField(
                "specialization",
                dentist.specialization ||
                dentist.speciality ||
                dentist.specialty ||
                ""
            );


            /*
             * Consultation Fee
             */

            setField(
                "consultationFee",
                dentist.consultationFee == null
                    ? ""
                    : dentist.consultationFee
            );


            /*
             * Phone
             */

            setField(
                "phoneNumber",
                dentist.phoneNumber ||
                dentist.phone ||
                ""
            );


            /*
             * Email
             */

            setField(
                "email",
                dentist.email ||
                ""
            );


            /*
             * Active status
             */

            setField(
                "active",
                dentist.active === false
                    ? "false"
                    : "true"
            );


            if (apiMessage) {

                apiMessage.classList.add(
                    "hidden"
                );

            }

        }
        catch (error) {

            console.error(
                "Load dentist error:",
                error
            );


            showMessage(
                error.message ||
                "Unable to load dentist information.",
                false
            );

        }

    }



    /*
     * =========================================================
     * FORM SUBMIT
     * =========================================================
     */

    form.addEventListener(
        "submit",
        async function (event) {

            event.preventDefault();


            /*
             * Clear old message
             */

            if (apiMessage) {

                apiMessage.classList.add(
                    "hidden"
                );

            }


            /*
             * Read values
             */

            const dentistName =
                field("dentistName")
                    .value
                    .trim();


            const specialization =
                field("specialization")
                    .value
                    .trim();


            const consultationFee =
                field("consultationFee")
                    .value
                    .trim();


            const phoneNumber =
                field("phoneNumber")
                    .value
                    .trim();


            const email =
                field("email")
                    .value
                    .trim();


            const active =
                field("active")
                    .value;


            /*
             * =================================================
             * VALIDATION
             * =================================================
             */

            if (!dentistName) {

                showMessage(
                    "Dentist name is required.",
                    false
                );

                field("dentistName").focus();

                return;

            }


            if (!specialization) {

                showMessage(
                    "Specialization is required.",
                    false
                );

                field("specialization").focus();

                return;

            }


            if (
                consultationFee === "" ||
                isNaN(
                    Number(
                        consultationFee
                    )
                )
            ) {

                showMessage(
                    "Please enter a valid consultation fee.",
                    false
                );

                field("consultationFee").focus();

                return;

            }


            if (
                Number(
                    consultationFee
                ) < 0
            ) {

                showMessage(
                    "Consultation fee cannot be negative.",
                    false
                );

                field("consultationFee").focus();

                return;

            }



            /*
             * =================================================
             * PREVENT DOUBLE CLICK
             * =================================================
             */

            submitButton.disabled =
                true;


            submitButton.classList.add(
                "opacity-70",
                "cursor-not-allowed"
            );


            submitButtonText.textContent =
                editMode
                    ? "Updating..."
                    : "Saving...";



            /*
             * =================================================
             * BUILD FORM DATA
             * =================================================
             */

            const formData =
                new URLSearchParams();


            formData.append(
                "dentistName",
                dentistName
            );


            formData.append(
                "specialization",
                specialization
            );


            formData.append(
                "consultationFee",
                consultationFee
            );


            formData.append(
                "phoneNumber",
                phoneNumber
            );


            formData.append(
                "email",
                email
            );


            formData.append(
                "active",
                active
            );



            /*
             * =================================================
             * API URL
             * =================================================
             */

            let apiUrl =
                contextPath +
                "/api/dentists";


            if (editMode) {

                apiUrl +=
                    "/" +
                    encodeURIComponent(
                        requestedDentistId
                    );

            }



            /*
             * =================================================
             * API METHOD
             *
             * ADD:
             * POST /api/dentists
             *
             * UPDATE:
             * PUT /api/dentists/{id}
             * =================================================
             */

            const method =
                editMode
                    ? "PUT"
                    : "POST";



            try {

                const response =
                    await fetch(
                        apiUrl,
                        {
                            method:
                                method,

                            credentials:
                                "same-origin",

                            headers: {

                                "Content-Type":
                                    "application/x-www-form-urlencoded; charset=UTF-8",

                                "Accept":
                                    "application/json"

                            },

                            body:
                                formData.toString()

                        }
                    );


                /*
                 * =================================================
                 * READ RESPONSE
                 * =================================================
                 */

                const responseText =
                    await response.text();


                let responseData =
                    null;


                if (responseText) {

                    try {

                        responseData =
                            JSON.parse(
                                responseText
                            );

                    }
                    catch (jsonError) {

                        responseData =
                            null;

                    }

                }



                /*
                 * =================================================
                 * AUTHENTICATION
                 * =================================================
                 */

                if (
                    response.status ===
                    401
                ) {

                    window.location.href =
                        contextPath +
                        "/login";

                    return;

                }



                /*
                 * =================================================
                 * AUTHORIZATION
                 * =================================================
                 */

                if (
                    response.status ===
                    403
                ) {

                    throw new Error(
                        editMode
                            ? "You do not have permission to update dentists."
                            : "You do not have permission to add dentists."
                    );

                }



                /*
                 * =================================================
                 * SUCCESS
                 *
                 * 200 = UPDATE
                 * 201 = CREATE
                 * =================================================
                 */

                if (
                    response.ok &&
                    response.status >= 200 &&
                    response.status < 300
                ) {


                    showMessage(
                        editMode
                            ? "Dentist updated successfully."
                            : "Dentist added successfully.",
                        true
                    );


                    /*
                     * Small delay so user can see
                     * success message.
                     */

                    setTimeout(
                        function () {

                            if (editMode) {

                                window.location.href =
                                    contextPath +
                                    "/dentists?updated=1";

                            }
                            else {

                                window.location.href =
                                    contextPath +
                                    "/dentists?success=1";

                            }

                        },
                        500
                    );


                    return;

                }



                /*
                 * =================================================
                 * API ERROR
                 * =================================================
                 */

                throw new Error(
                    getApiMessage(
                        responseData,
                        editMode
                            ? "Dentist could not be updated."
                            : "Dentist could not be added."
                    )
                );

            }
            catch (error) {

                console.error(
                    "Dentist save error:",
                    error
                );


                showMessage(
                    error.message ||
                    (
                        editMode
                            ? "Unable to update dentist."
                            : "Unable to add dentist."
                    ),
                    false
                );


                submitButton.disabled =
                    false;


                submitButton.classList.remove(
                    "opacity-70",
                    "cursor-not-allowed"
                );


                submitButtonText.textContent =
                    editMode
                        ? "Update Dentist"
                        : "Add Dentist";

            }

        }
    );



    /*
     * =========================================================
     * INITIAL LOAD
     * =========================================================
     */

    loadDentist();


})();

</script>


</body>

</html>