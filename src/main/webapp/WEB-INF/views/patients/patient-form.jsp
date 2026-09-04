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

    <title id="pageTitle">
        Patient | Sunrise Dental Clinic
    </title>

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

    <link rel="preconnect" href="https://fonts.googleapis.com">

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

    <jsp:include page="../common/sidebar.jsp" />

    <main class="ml-[250px] min-h-screen flex-1 px-8 py-7">

        <div class="mb-7">

            <p class="mb-1 font-inter text-[10px] font-semibold uppercase tracking-[0.12em] text-slate-400">
                Patients
            </p>

            <h1 id="pageHeading" class="text-[25px] font-extrabold tracking-[-0.7px]">
                Register New Patient
            </h1>

            <p id="pageDescription" class="mt-1 font-inter text-xs text-slate-500">
                Enter the patient's information to register them.
            </p>

        </div>

        <!-- REST API ERROR -->

        <div id="errorMessage"
             class="mb-6 hidden flex items-start gap-3 rounded-xl border border-red-100 bg-red-50 px-4 py-3">

            <div class="mt-0.5 flex h-7 w-7 shrink-0 items-center justify-center rounded-lg bg-red-100">

                <svg
                    class="h-4 w-4 text-red-500"
                    fill="none"
                    stroke="currentColor"
                    stroke-width="1.8"
                    viewBox="0 0 24 24"
                >
                    <circle cx="12" cy="12" r="9" />
                    <path stroke-linecap="round" d="M12 8v4M12 16h.01" />
                </svg>

            </div>

            <div>

                <p class="font-inter text-[10px] font-bold text-red-600">
                    Unable to save patient
                </p>

                <p id="errorText"
                   class="mt-0.5 font-inter text-[10px] leading-5 text-red-500">
                </p>

            </div>

        </div>

        <!-- REST API SUCCESS -->

        <div id="successMessage"
             class="mb-6 hidden flex items-start gap-3 rounded-xl border border-green-100 bg-green-50 px-4 py-3">

            <div class="mt-0.5 flex h-7 w-7 shrink-0 items-center justify-center rounded-lg bg-green-100">

                <svg
                    class="h-4 w-4 text-green-600"
                    fill="none"
                    stroke="currentColor"
                    stroke-width="1.8"
                    viewBox="0 0 24 24"
                >
                    <circle cx="12" cy="12" r="9" />
                    <path stroke-linecap="round" d="M8 12l3 3 5-6" />
                </svg>

            </div>

            <div>

                <p class="font-inter text-[10px] font-bold text-green-700">
                    Patient saved successfully
                </p>

                <p id="successText"
                   class="mt-0.5 font-inter text-[10px] leading-5 text-green-600">
                </p>

            </div>

        </div>

        <div class="max-w-[900px] rounded-xl border border-slate-200 bg-white">

            <div class="border-b border-slate-100 px-7 py-6">

                <div class="flex items-center gap-4">

                    <div class="flex h-11 w-11 items-center justify-center rounded-xl bg-blue-50">

                        <svg
                            class="h-5 w-5 text-blue-600"
                            fill="none"
                            stroke="currentColor"
                            stroke-width="1.7"
                            viewBox="0 0 24 24"
                        >
                            <path
                                stroke-linecap="round"
                                stroke-linejoin="round"
                                d="M15 19a6 6 0 00-12 0"
                            />
                            <circle cx="9" cy="7" r="4" />
                            <path
                                stroke-linecap="round"
                                stroke-linejoin="round"
                                d="M19 8v6M16 11h6"
                            />
                        </svg>

                    </div>

                    <div>

                        <h2 class="text-sm font-extrabold">
                            Patient Information
                        </h2>

                        <p id="cardDescription"
                           class="mt-0.5 font-inter text-[10px] text-slate-400">
                            Add the patient's details below.
                        </p>

                    </div>

                </div>

            </div>

            <form
                id="patientForm"
                class="px-7 py-7"
            >

                <!-- PATIENT ID -->

                <input
                    type="hidden"
                    id="patientId"
                    name="patientId"
                >

                <!-- PATIENT CODE -->

                <div id="patientCodeContainer" class="mb-6 hidden">

                    <label class="mb-2 block font-inter text-[10px] font-semibold text-slate-600">
                        Patient Code
                    </label>

                    <div class="flex h-11 items-center rounded-lg border border-slate-200 bg-slate-50 px-3.5">

                        <span id="patientCode"
                              class="font-inter text-xs font-semibold text-slate-500">
                        </span>

                        <span class="ml-auto font-inter text-[9px] text-slate-400">
                            System generated
                        </span>

                    </div>

                </div>

                <!-- NAME + PHONE -->

                <div class="grid grid-cols-2 gap-5">

                    <div class="mb-5">

                        <label
                            for="name"
                            class="mb-2 block font-inter text-[10px] font-semibold text-slate-600"
                        >
                            Patient Name
                            <span class="text-red-500">*</span>
                        </label>

                        <input
                            type="text"
                            id="name"
                            name="name"
                            maxlength="100"
                            placeholder="Enter patient name"
                            required
                            class="h-11 w-full rounded-lg border border-slate-200 bg-white px-3.5 font-inter text-xs text-slate-700 outline-none transition placeholder:text-slate-300 focus:border-blue-500 focus:ring-2 focus:ring-blue-50"
                        >

                    </div>

                    <div class="mb-5">

                        <label
                            for="contactNumber"
                            class="mb-2 block font-inter text-[10px] font-semibold text-slate-600"
                        >
                            Contact Number
                            <span class="text-red-500">*</span>
                        </label>

                        <input
                            type="text"
                            id="contactNumber"
                            name="contactNumber"
                            maxlength="15"
                            pattern="[0-9+ ]{9,15}"
                            title="Enter a valid contact number"
                            placeholder="0712345678"
                            required
                            class="h-11 w-full rounded-lg border border-slate-200 bg-white px-3.5 font-inter text-xs text-slate-700 outline-none transition placeholder:text-slate-300 focus:border-blue-500 focus:ring-2 focus:ring-blue-50"
                        >

                    </div>

                </div>

                <!-- ADDRESS -->

                <div class="mb-5">

                    <label
                        for="address"
                        class="mb-2 block font-inter text-[10px] font-semibold text-slate-600"
                    >
                        Address
                        <span class="text-red-500">*</span>
                    </label>

                    <textarea
                        id="address"
                        name="address"
                        rows="3"
                        maxlength="255"
                        placeholder="Enter patient's address"
                        required
                        class="w-full resize-none rounded-lg border border-slate-200 bg-white px-3.5 py-3 font-inter text-xs leading-5 text-slate-700 outline-none transition placeholder:text-slate-300 focus:border-blue-500 focus:ring-2 focus:ring-blue-50"
                    ></textarea>

                    <p class="mt-1.5 font-inter text-[9px] text-slate-400">
                        Maximum 255 characters.
                    </p>

                </div>

                <!-- EMAIL -->

                <div class="mb-5">

                    <label
                        for="email"
                        class="mb-2 block font-inter text-[10px] font-semibold text-slate-600"
                    >
                        Email Address
                        <span class="ml-1 font-normal text-slate-400">
                            Optional
                        </span>
                    </label>

                    <input
                        type="email"
                        id="email"
                        name="email"
                        maxlength="100"
                        placeholder="example@gmail.com"
                        class="h-11 w-full rounded-lg border border-slate-200 bg-white px-3.5 font-inter text-xs text-slate-700 outline-none transition placeholder:text-slate-300 focus:border-blue-500 focus:ring-2 focus:ring-blue-50"
                    >

                </div>

                <div class="my-7 border-t border-slate-100"></div>

                <div class="mb-6 rounded-lg bg-slate-50 px-4 py-3">

                    <div class="flex items-center gap-2">

                        <svg
                            class="h-3.5 w-3.5 text-slate-400"
                            fill="none"
                            stroke="currentColor"
                            stroke-width="1.7"
                            viewBox="0 0 24 24"
                        >
                            <circle cx="12" cy="12" r="9" />
                            <path stroke-linecap="round" d="M12 11v5M12 8h.01" />
                        </svg>

                        <p class="font-inter text-[9px] text-slate-500">
                            Fields marked with
                            <span class="font-bold text-red-500">*</span>
                            are required.
                        </p>

                    </div>

                </div>

                <!-- ACTIONS -->

                <div class="flex items-center justify-between">

                    <a
                        id="cancelButton"
                        href="<%= contextPath %>/patients"
                        class="rounded-lg border border-slate-200 bg-white px-5 py-2.5 font-inter text-[10px] font-semibold text-slate-600 transition hover:bg-slate-50"
                    >
                        Cancel
                    </a>

                    <button
                        id="submitButton"
                        type="submit"
                        class="inline-flex items-center gap-2 rounded-lg bg-[#2563EB] px-5 py-2.5 font-inter text-[10px] font-bold text-white shadow-sm transition hover:bg-[#1D4ED8] focus:outline-none focus:ring-2 focus:ring-blue-200"
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
                                d="M5 12l4 4L19 6"
                            />
                        </svg>

                        <span id="submitText">Register Patient</span>

                    </button>

                </div>

            </form>

        </div>

        <div class="mt-8 flex max-w-[900px] items-center justify-between px-1">

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
(function () {

    const contextPath = '<%= contextPath %>';

    const form = document.getElementById('patientForm');
    const patientIdInput = document.getElementById('patientId');

    const nameInput = document.getElementById('name');
    const contactInput = document.getElementById('contactNumber');
    const addressInput = document.getElementById('address');
    const emailInput = document.getElementById('email');

    const pageTitle = document.getElementById('pageTitle');
    const pageHeading = document.getElementById('pageHeading');
    const pageDescription = document.getElementById('pageDescription');
    const cardDescription = document.getElementById('cardDescription');

    const patientCodeContainer =
        document.getElementById('patientCodeContainer');

    const patientCode =
        document.getElementById('patientCode');

    const submitButton =
        document.getElementById('submitButton');

    const submitText =
        document.getElementById('submitText');

    const cancelButton =
        document.getElementById('cancelButton');

    const errorMessage =
        document.getElementById('errorMessage');

    const errorText =
        document.getElementById('errorText');

    const successMessage =
        document.getElementById('successMessage');

    const successText =
        document.getElementById('successText');

    const params =
        new URLSearchParams(window.location.search);

    const requestedId =
        params.get('id') || params.get('patientId');

    const editMode =
        requestedId !== null &&
        requestedId.trim() !== '' &&
        Number(requestedId) > 0;


    function showError(message) {

        errorText.textContent =
            message || 'An unexpected error occurred.';

        errorMessage.classList.remove('hidden');

        successMessage.classList.add('hidden');
    }


    function showSuccess(message) {

        successText.textContent =
            message || 'Patient saved successfully.';

        successMessage.classList.remove('hidden');

        errorMessage.classList.add('hidden');
    }


    function hideMessages() {

        errorMessage.classList.add('hidden');
        successMessage.classList.add('hidden');
    }


    function escapePatientCode(value) {

        return value || '';
    }


    function generatePatientCode() {

        const now = new Date();

        const year =
            now.getFullYear();

        const month =
            String(now.getMonth() + 1).padStart(2, '0');

        const day =
            String(now.getDate()).padStart(2, '0');

        const time =
            String(now.getHours()).padStart(2, '0')
            + String(now.getMinutes()).padStart(2, '0')
            + String(now.getSeconds()).padStart(2, '0');

        return 'P' + year + month + day + time;
    }


    function setEditMode() {

        pageTitle.textContent =
            'Edit Patient | Sunrise Dental Clinic';

        pageHeading.textContent =
            'Edit Patient';

        pageDescription.textContent =
            "Update the patient's registered information.";

        cardDescription.textContent =
            "Modify the patient's details below.";

        submitText.textContent =
            'Update Patient';

        patientCodeContainer.classList.remove('hidden');

        cancelButton.href =
            contextPath + '/patients/view?id=' + encodeURIComponent(requestedId);
    }


    function setCreateMode() {

        pageTitle.textContent =
            'Register New Patient | Sunrise Dental Clinic';

        pageHeading.textContent =
            'Register New Patient';

        pageDescription.textContent =
            "Enter the patient's information to register them.";

        cardDescription.textContent =
            "Add the patient's details below.";

        submitText.textContent =
            'Register Patient';

        patientCodeContainer.classList.add('hidden');

        cancelButton.href =
            contextPath + '/patients';
    }


    async function readResponse(response) {

        const text =
            await response.text();

        let data = null;

        if (text) {

            try {
                data = JSON.parse(text);
            } catch (e) {
                data = null;
            }
        }

        if (!response.ok) {

            if (data && data.message) {
                throw new Error(data.message);
            }

            if (text) {
                throw new Error(text);
            }

            throw new Error(
                'Request failed with status ' + response.status
            );
        }

        return data;
    }


    async function loadPatient() {

        hideMessages();

        try {

            const response =
                await fetch(
                    contextPath
                    + '/api/patients/'
                    + encodeURIComponent(requestedId),
                    {
                        method: 'GET',
                        credentials: 'same-origin',
                        headers: {
                            'Accept': 'application/json'
                        }
                    }
                );

            const patient =
                await readResponse(response);

            if (!patient) {
                throw new Error('Patient data was not returned.');
            }

            patientIdInput.value =
                patient.patientId || '';

            patientCode.textContent =
                escapePatientCode(patient.patientCode);

            nameInput.value =
                patient.name || '';

            contactInput.value =
                patient.contactNumber || '';

            addressInput.value =
                patient.address || '';

            emailInput.value =
                patient.email || '';

        } catch (error) {

            showError(
                error.message ||
                'Could not load patient information.'
            );

            submitButton.disabled = true;
            submitButton.classList.add('opacity-50', 'cursor-not-allowed');
        }
    }


    async function createPatient() {

        const patientCodeValue =
            generatePatientCode();

        const formData =
            new URLSearchParams();

        formData.append(
            'patientCode',
            patientCodeValue
        );

        formData.append(
            'name',
            nameInput.value.trim()
        );

        formData.append(
            'address',
            addressInput.value.trim()
        );

        formData.append(
            'contactNumber',
            contactInput.value.trim()
        );

        formData.append(
            'email',
            emailInput.value.trim()
        );

        const response =
            await fetch(
                contextPath + '/api/patients',
                {
                    method: 'POST',
                    credentials: 'same-origin',
                    headers: {
                        'Content-Type':
                            'application/x-www-form-urlencoded; charset=UTF-8',
                        'Accept': 'application/json'
                    },
                    body: formData.toString()
                }
            );

        return await readResponse(response);
    }


    async function updatePatient() {

        const formData =
            new URLSearchParams();

        formData.append(
            'name',
            nameInput.value.trim()
        );

        formData.append(
            'address',
            addressInput.value.trim()
        );

        formData.append(
            'contactNumber',
            contactInput.value.trim()
        );

        formData.append(
            'email',
            emailInput.value.trim()
        );

        const response =
            await fetch(
                contextPath
                + '/api/patients/'
                + encodeURIComponent(requestedId),
                {
                    method: 'PUT',
                    credentials: 'same-origin',
                    headers: {
                        'Content-Type':
                            'application/x-www-form-urlencoded; charset=UTF-8',
                        'Accept': 'application/json'
                    },
                    body: formData.toString()
                }
            );

        return await readResponse(response);
    }


    form.addEventListener('submit', async function (event) {

        event.preventDefault();

        hideMessages();

        if (!form.checkValidity()) {

            form.reportValidity();

            return;
        }

        submitButton.disabled = true;

        submitButton.classList.add(
            'opacity-50',
            'cursor-not-allowed'
        );

        const originalText =
            submitText.textContent;

        submitText.textContent =
            editMode
            ? 'Updating...'
            : 'Registering...';

        try {

            const patient =
                editMode
                ? await updatePatient()
                : await createPatient();

            showSuccess(
                editMode
                ? 'Patient information updated successfully.'
                : 'Patient registered successfully.'
            );

            if (patient && patient.patientId) {

                patientIdInput.value =
                    patient.patientId;

                if (patient.patientCode) {
                    patientCode.textContent =
                        patient.patientCode;
                }
            }

            setTimeout(function () {

                if (editMode) {

                    window.location.href =
                        contextPath
                        + '/patients/view?id='
                        + encodeURIComponent(requestedId);

                } else {

                    window.location.href =
                        contextPath + '/patients';

                }

            }, 700);

        } catch (error) {

            showError(
                error.message ||
                'Patient could not be saved.'
            );

            submitButton.disabled = false;

            submitButton.classList.remove(
                'opacity-50',
                'cursor-not-allowed'
            );

            submitText.textContent =
                originalText;
        }

    });


    if (editMode) {

        setEditMode();

        loadPatient();

    } else {

        setCreateMode();

    }

})();
</script>

</body>

</html>
