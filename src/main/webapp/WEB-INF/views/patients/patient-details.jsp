<%@ page language="java"
    contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<% String contextPath = request.getContextPath(); %>

<!DOCTYPE html>

<html lang="en">

<head>

    <meta charset="UTF-8">

    <meta name="viewport"
          content="width=device-width, initial-scale=1.0">

    <title>
        Patient Details | Sunrise Dental Clinic
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


        <div id="notFoundView" class="hidden">


            <!-- PATIENT NOT FOUND -->

            <div class="flex min-h-[70vh] items-center justify-center">


                <div class="w-full max-w-[500px] rounded-xl border border-slate-200 bg-white p-8 text-center">


                    <div class="mx-auto mb-5 flex h-12 w-12 items-center justify-center rounded-xl bg-red-50">


                        <svg
                            class="h-5 w-5 text-red-500"
                            fill="none"
                            stroke="currentColor"
                            stroke-width="1.8"
                            viewBox="0 0 24 24"
                        >

                            <circle
                                cx="12"
                                cy="12"
                                r="9"
                            />

                            <path
                                stroke-linecap="round"
                                d="M12 8v4M12 16h.01"
                            />

                        </svg>


                    </div>


                    <h1 class="text-lg font-extrabold">
                        Patient Not Found
                    </h1>


                    <p class="mt-2 font-inter text-[10px] leading-5 text-slate-400">
                        Patient information could not be found.
                    </p>


                    <a
                        href="<%= contextPath %>/patients"
                        class="mt-6 inline-flex rounded-lg border border-slate-200 bg-white px-5 py-2.5 font-inter text-[10px] font-semibold text-slate-600 transition hover:bg-slate-50"
                    >
                        ← Back to Patients
                    </a>


                </div>


            </div>


        </div>


        <div id="detailsView">


            <!-- PAGE HEADER -->

            <div class="mb-7 flex items-center justify-between">


                <div>


                    <p class="mb-1 font-inter text-[10px] font-semibold uppercase tracking-[0.12em] text-slate-400">
                        Patients
                    </p>


                    <h1 class="text-[25px] font-extrabold tracking-[-0.7px]">
                        Patient Details
                    </h1>


                    <p class="mt-1 font-inter text-xs text-slate-500">
                        View registered patient information.
                    </p>


                </div>



                <!-- PATIENT CODE -->

                <div class="rounded-lg border border-slate-200 bg-white px-4 py-2.5">


                    <p class="font-inter text-[8px] font-semibold uppercase tracking-[0.1em] text-slate-400">
                        Patient Code
                    </p>


                    <p class="mt-0.5 text-xs font-extrabold text-blue-600">

                        <span id="patientCode">-</span>

                    </p>


                </div>


            </div>



            <!-- PROFILE -->

            <div class="mx-auto max-w-[900px]">


                <div class="overflow-hidden rounded-xl border border-slate-200 bg-white">


                    <!-- PROFILE HEADER -->

                    <div class="flex items-center gap-5 border-b border-slate-100 px-7 py-6">


                        <!-- AVATAR -->

                        <div class="flex h-16 w-16 shrink-0 items-center justify-center rounded-2xl bg-blue-50 text-xl font-extrabold text-blue-600">


                            <span id="patientInitial">P</span>


                        </div>


                        <div class="flex-1">


                            <h2 class="text-lg font-extrabold tracking-[-0.4px]">

                                <span id="patientName">-</span>

                            </h2>


                            <p class="mt-1 font-inter text-[10px] text-slate-500">

                                Patient ID #<span id="patientId">-</span>

                            </p>


                        </div>


                        <!-- PATIENT CODE BADGE -->

                        <span class="rounded-full bg-blue-50 px-3 py-1.5 font-inter text-[9px] font-semibold text-blue-600">

                            <span id="patientCode">-</span>

                        </span>


                    </div>



                    <!-- DETAILS -->

                    


                </div>



                <!-- SUMMARY CARDS -->

                <div class="mt-5 grid grid-cols-3 gap-4">


                    <!-- CONTACT -->

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
                                    d="M22 16.92v3a2 2 0 01-2.18 2 19.79 19.79 0 01-8.63-3.07 19.5 19.5 0 01-6-6A19.79 19.79 0 012.12 4.18 2 2 0 014.11 2h3a2 2 0 012 1.72c.12.9.33 1.78.62 2.63a2 2 0 01-.45 2.11L8 9.73a16 16 0 006 6l1.27-1.27a2 2 0 012.11-.45c.85.29 1.73.5 2.63.62A2 2 0 0122 16.92z"
                                />

                            </svg>


                        </div>


                        <p class="font-inter text-[9px] text-slate-400">
                            Contact
                        </p>


                        <p class="mt-1 text-[11px] font-bold">

                            <span id="patientContact">-</span>

                        </p>


                    </div>



                    <!-- EMAIL -->

                    <div class="rounded-xl border border-slate-200 bg-white p-5">


                        <div class="mb-3 flex h-8 w-8 items-center justify-center rounded-lg bg-violet-50">


                            <svg
                                class="h-4 w-4 text-violet-600"
                                fill="none"
                                stroke="currentColor"
                                stroke-width="1.7"
                                viewBox="0 0 24 24"
                            >

                                <rect
                                    x="3"
                                    y="5"
                                    width="18"
                                    height="14"
                                    rx="2"
                                />

                                <path
                                    stroke-linecap="round"
                                    stroke-linejoin="round"
                                    d="m3 7 9 6 9-6"
                                />

                            </svg>


                        </div>


                        <p class="font-inter text-[9px] text-slate-400">
                            Email
                        </p>


                        <p class="mt-1 truncate text-[11px] font-bold">


                            <span id="patientEmailSummary">Not provided</span>


                        </p>


                    </div>



                    <!-- REGISTERED -->

                    <div class="rounded-xl border border-slate-200 bg-white p-5">


                        <div class="mb-3 flex h-8 w-8 items-center justify-center rounded-lg bg-emerald-50">


                            <svg
                                class="h-4 w-4 text-emerald-600"
                                fill="none"
                                stroke="currentColor"
                                stroke-width="1.7"
                                viewBox="0 0 24 24"
                            >

                                <rect
                                    x="3"
                                    y="4"
                                    width="18"
                                    height="18"
                                    rx="2"
                                />

                                <path
                                    stroke-linecap="round"
                                    d="M16 2v4M8 2v4M3 10h18"
                                />

                            </svg>


                        </div>


                        <p class="font-inter text-[9px] text-slate-400">
                            Registered
                        </p>


                        <p class="mt-1 text-[11px] font-bold">


                            <span id="patientCreatedSummary">N/A</span>


                        </p>


                    </div>


                </div>



                <!-- ACTIONS -->

                <div class="mt-6 flex items-center justify-between">


                    <a
                        href="<%= contextPath %>/patients"
                        class="flex items-center gap-2 rounded-lg border border-slate-200 bg-white px-4 py-2.5 font-inter text-[10px] font-semibold text-slate-600 transition hover:bg-slate-50"
                    >

                        ← Back to Patients

                    </a>


                    <a
                        id="editPatientLink" href="#"
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

                        Edit Patient

                    </a>


                </div>


            </div>



            <!-- FOOTER -->

            <div class="mt-8 flex items-center justify-between px-1">


                <p class="font-inter text-[9px] text-slate-400">
                    Sunrise Dental Clinic
                </p>


                <p class="font-inter text-[9px] text-slate-400">
                    Patient Management
                </p>


            </div>


        </div>


    </main>


</div>



<script>
(function () {
    "use strict";

    var contextPath = "<%= contextPath %>";
    var params = new URLSearchParams(window.location.search);
    var patientId = params.get("id") || params.get("patientId");

    var notFoundView = document.getElementById("notFoundView");
    var detailsView = document.getElementById("detailsView");
    var editPatientLink = document.getElementById("editPatientLink");

    function showNotFound() {
        if (detailsView) {
            detailsView.classList.add("hidden");
        }
        if (notFoundView) {
            notFoundView.classList.remove("hidden");
        }
    }

    function setText(id, value) {
        var elements = document.querySelectorAll('[id="' + id + '"]');
        var displayValue = value == null || String(value).trim() === ""
            ? "-"
            : String(value);

        for (var i = 0; i < elements.length; i++) {
            elements[i].textContent = displayValue;
        }
    }

    function loadPatient() {
        if (!patientId || !/^\d+$/.test(patientId)) {
            showNotFound();
            return;
        }

        fetch(contextPath + "/api/patients/" + encodeURIComponent(patientId), {
            method: "GET",
            credentials: "same-origin",
            headers: {
                "Accept": "application/json"
            }
        })
        .then(function (response) {
            if (!response.ok) {
                throw new Error("Patient not found");
            }
            return response.json();
        })
        .then(function (patient) {
            if (!patient || !patient.patientId) {
                throw new Error("Patient not found");
            }

            if (notFoundView) {
                notFoundView.classList.add("hidden");
            }
            if (detailsView) {
                detailsView.classList.remove("hidden");
            }

            var name = patient.name || "-";
            var email = patient.email && String(patient.email).trim()
                ? patient.email
                : "-";
            var registered = patient.createdAt || "-";

            if (registered !== "-" && String(registered).length >= 10) {
                registered = String(registered).substring(0, 10);
            }

            setText("patientCode", patient.patientCode);
            setText("patientInitial", name !== "-" ? name.substring(0, 1).toUpperCase() : "P");
            setText("patientName", name);
            setText("patientId", patient.patientId);
            setText("patientContact", patient.contactNumber);
            setText("patientEmail", email);
            setText("patientEmailSummary", email === "-" ? "Not provided" : email);
            setText("patientAddress", patient.address);
            setText("patientCreatedAt", patient.createdAt ? patient.createdAt : "-");
            setText("patientCreatedSummary", registered === "-" ? "N/A" : registered);

            if (editPatientLink) {
                editPatientLink.href =
                    contextPath + "/patients/edit?id=" +
                    encodeURIComponent(patient.patientId);
            }
        })
        .catch(function (error) {
            console.error("Could not load patient:", error);
            showNotFound();
        });
    }

    loadPatient();
})();
</script>

</body>

</html>