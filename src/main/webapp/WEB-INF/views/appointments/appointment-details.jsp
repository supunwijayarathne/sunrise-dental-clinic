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
        Appointment Details | Sunrise Dental Clinic
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

        <div class="mb-7">

            <h1 class="text-[24px] font-extrabold tracking-[-0.6px]">
                Appointment Details
            </h1>

            <p class="mt-1 font-inter text-xs text-slate-500">
                Complete information about this appointment
            </p>

        </div>


        <!-- APPOINTMENT HEADER -->

        <div class="mb-5 flex items-center justify-between rounded-xl border border-slate-200 bg-white px-6 py-5">


            <div class="flex items-center gap-4">


                <div class="flex h-11 w-11 items-center justify-center rounded-xl bg-blue-50 text-sm font-extrabold text-blue-600">
                    A
                </div>


                <div>

                    <p class="font-inter text-[9px] font-semibold uppercase tracking-wide text-slate-400">
                        Appointment Number
                    </p>

                    <h2 class="mt-1 text-base font-extrabold">
                        <span id="appointmentNumber">—</span>
                    </h2>

                </div>


            </div>


            <span id="headerStatus" class="rounded-full px-3 py-1.5 font-inter text-[9px] font-semibold bg-blue-50 text-blue-700">

                <span id="statusText">—</span>

            </span>


        </div>


        <!-- SUCCESS -->
        <div id="updateSuccessMessage" class="hidden mb-5 flex items-center gap-3 rounded-lg border border-emerald-100 bg-emerald-50 px-4 py-3 text-xs font-semibold text-emerald-700">
            <span class="flex h-5 w-5 items-center justify-center rounded-full bg-emerald-100">✓</span>
            Appointment updated successfully.
        </div>


        <!-- GRID -->

        <div class="grid grid-cols-2 gap-5">


            <!-- APPOINTMENT -->

            <div class="rounded-xl border border-slate-200 bg-white p-6">


                <div class="mb-5 flex items-center gap-3">

                    <div class="flex h-9 w-9 items-center justify-center rounded-lg bg-blue-50 text-xs font-extrabold text-blue-600">
                        A
                    </div>

                    <h2 class="text-sm font-extrabold">
                        Appointment Information
                    </h2>

                </div>


                <div class="grid grid-cols-2">


                    <div class="border-b border-slate-100 py-3">

                        <p class="font-inter text-[9px] font-semibold uppercase tracking-wide text-slate-400">
                            Appointment ID
                        </p>

                        <p class="mt-1 text-xs font-semibold">
                            <span id="appointmentId">—</span>
                        </p>

                    </div>


                    <div class="border-b border-slate-100 py-3">

                        <p class="font-inter text-[9px] font-semibold uppercase tracking-wide text-slate-400">
                            Appointment Number
                        </p>

                        <p class="mt-1 text-xs font-semibold">
                            <span id="appointmentNumberInfo">—</span>
                        </p>

                    </div>


                    <div class="border-b border-slate-100 py-3">

                        <p class="font-inter text-[9px] font-semibold uppercase tracking-wide text-slate-400">
                            Date
                        </p>

                        <p class="mt-1 text-xs font-semibold">
                            <span id="appointmentDate">—</span>
                        </p>

                    </div>


                    <div class="border-b border-slate-100 py-3">

                        <p class="font-inter text-[9px] font-semibold uppercase tracking-wide text-slate-400">
                            Time
                        </p>

                        <p class="mt-1 text-xs font-semibold">
                            <span id="appointmentTime">—</span>
                        </p>

                    </div>


                    <div class="py-3">

                        <p class="font-inter text-[9px] font-semibold uppercase tracking-wide text-slate-400">
                            Status
                        </p>

                        <p class="mt-2">

                            <span id="detailStatus" class="rounded-full px-2.5 py-1 font-inter text-[9px] font-semibold bg-blue-50 text-blue-700">
                                <span id="statusTextInfo">—</span>
                            </span>

                        </p>

                    </div>


                </div>


            </div>


            <!-- PATIENT -->

            <div class="rounded-xl border border-slate-200 bg-white p-6">


                <div class="mb-5 flex items-center gap-3">

                    <div class="flex h-9 w-9 items-center justify-center rounded-lg bg-blue-50 text-xs font-extrabold text-blue-600">
                        P
                    </div>

                    <h2 class="text-sm font-extrabold">
                        Patient
                    </h2>

                </div>


                <div class="space-y-4">


                    <div>

                        <p class="font-inter text-[9px] font-semibold uppercase tracking-wide text-slate-400">
                            Patient Code
                        </p>

                        <p class="mt-1 text-xs font-semibold">
                            <span id="patientCode">—</span>
                        </p>

                    </div>


                    <div>

                        <p class="font-inter text-[9px] font-semibold uppercase tracking-wide text-slate-400">
                            Patient Name
                        </p>

                        <p class="mt-1 text-xs font-semibold">
                            <span id="patientName">—</span>
                        </p>

                    </div>


                    <div>

                        <p class="font-inter text-[9px] font-semibold uppercase tracking-wide text-slate-400">
                            Contact Number
                        </p>

                        <p class="mt-1 text-xs font-semibold">
                            <span id="patientContact">—</span>
                        </p>

                    </div>


                </div>


            </div>


            <!-- DENTIST -->

            <div class="rounded-xl border border-slate-200 bg-white p-6">


                <div class="mb-5 flex items-center gap-3">

                    <div class="flex h-9 w-9 items-center justify-center rounded-lg bg-blue-50 text-xs font-extrabold text-blue-600">
                        D
                    </div>

                    <h2 class="text-sm font-extrabold">
                        Dentist
                    </h2>

                </div>


                <div class="space-y-4">


                    <div>

                        <p class="font-inter text-[9px] font-semibold uppercase tracking-wide text-slate-400">
                            Dentist Name
                        </p>

                        <p class="mt-1 text-xs font-semibold">
                            <span id="dentistName">—</span>
                        </p>

                    </div>


                    <div>

                        <p class="font-inter text-[9px] font-semibold uppercase tracking-wide text-slate-400">
                            Specialization
                        </p>

                        <p class="mt-1 text-xs font-semibold">
                            <span id="dentistSpecialization">—</span>
                        </p>

                    </div>


                </div>


            </div>


            <!-- TREATMENT -->

            <div class="rounded-xl border border-slate-200 bg-white p-6">


                <div class="mb-5 flex items-center gap-3">

                    <div class="flex h-9 w-9 items-center justify-center rounded-lg bg-blue-50 text-xs font-extrabold text-blue-600">
                        T
                    </div>

                    <h2 class="text-sm font-extrabold">
                        Treatment
                    </h2>

                </div>


                <div class="space-y-4">


                    <div>

                        <p class="font-inter text-[9px] font-semibold uppercase tracking-wide text-slate-400">
                            Treatment Name
                        </p>

                        <p class="mt-1 text-xs font-semibold">
                            <span id="treatmentName">—</span>
                        </p>

                    </div>


                    <div>

                        <p class="font-inter text-[9px] font-semibold uppercase tracking-wide text-slate-400">
                            Treatment Fee
                        </p>

                        <p class="mt-1 text-xs font-semibold">

                            <span id="treatmentFee">—</span>

                        </p>

                    </div>


                </div>


            </div>


            <!-- NOTES -->

            <div class="col-span-2 rounded-xl border border-slate-200 bg-white p-6">


                <div class="mb-5 flex items-center gap-3">

                    <div class="flex h-9 w-9 items-center justify-center rounded-lg bg-blue-50 text-xs font-extrabold text-blue-600">
                        N
                    </div>

                    <h2 class="text-sm font-extrabold">
                        Notes
                    </h2>

                </div>


                <div class="rounded-lg border border-slate-100 bg-slate-50 px-4 py-3 font-inter text-[11px] leading-7 text-slate-600">

                    <span id="appointmentNotes">No additional notes.</span>

                </div>


            </div>


            <!-- SYSTEM -->

            <div class="col-span-2 rounded-xl border border-slate-200 bg-white p-6">


                <div class="mb-5 flex items-center gap-3">

                    <div class="flex h-9 w-9 items-center justify-center rounded-lg bg-blue-50 text-xs font-extrabold text-blue-600">
                        S
                    </div>

                    <h2 class="text-sm font-extrabold">
                        System Information
                    </h2>

                </div>


                <div class="grid grid-cols-3 gap-5">


                    <div>

                        <p class="font-inter text-[9px] font-semibold uppercase tracking-wide text-slate-400">
                            Created By
                        </p>

                        <p class="mt-1 text-xs font-semibold">
                            User ID: <span id="createdBy">—</span>
                        </p>

                    </div>


                    <div>

                        <p class="font-inter text-[9px] font-semibold uppercase tracking-wide text-slate-400">
                            Created At
                        </p>

                        <p class="mt-1 text-xs font-semibold">
                            <span id="createdAt">—</span>
                        </p>

                    </div>


                    <div>

                        <p class="font-inter text-[9px] font-semibold uppercase tracking-wide text-slate-400">
                            Last Updated
                        </p>

                        <p class="mt-1 text-xs font-semibold">
                            <span id="updatedAt">—</span>
                        </p>

                    </div>


                </div>


            </div>


        </div>


        <!-- ACTIONS -->

        <div class="mt-5 flex gap-2">


            <a
                href="#" id="editAppointmentLink"
                class="rounded-lg bg-[#2563EB] px-5 py-2.5 text-xs font-bold text-white hover:bg-[#1D4ED8]"
            >
                Edit Appointment
            </a>


            <a
                href="<%= contextPath %>/appointments"
                class="rounded-lg border border-slate-200 bg-white px-5 py-2.5 text-xs font-semibold text-slate-600 hover:bg-slate-50"
            >
                ← Back to Appointments
            </a>


        </div>


    </main>

</div>

</body>

</html>
<script>
(function () {

    const contextPath = "<%= contextPath %>";

    const params = new URLSearchParams(window.location.search);

    const appointmentId =
        params.get("id") ||
        params.get("appointmentId") ||
        "";


    function setText(id, val, fallback) {

        const element =
            document.getElementById(id);

        if (!element) {
            return;
        }

        if (
            val === null ||
            val === undefined ||
            String(val).trim() === ""
        ) {
            element.textContent =
                fallback || "N/A";
        } else {
            element.textContent =
                String(val);
        }
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


    function getPatientName(patient) {

        if (!patient) {
            return "N/A";
        }

        return patient.name ||
               patient.fullName ||
               "N/A";
    }


    function getDentistName(dentist) {

        if (!dentist) {
            return "N/A";
        }

        return dentist.dentistName ||
               dentist.name ||
               dentist.fullName ||
               "N/A";
    }


    function getTreatmentName(treatment) {

        if (!treatment) {
            return "N/A";
        }

        return treatment.treatmentName ||
               treatment.name ||
               "N/A";
    }


    function setStatus(status) {

        const display =
            String(status || "BOOKED")
                .replace(/_/g, " ");

        let classes =
            "bg-blue-50 text-blue-700";

        const s =
            String(status || "")
                .toUpperCase();

        if (s === "COMPLETED") {
            classes =
                "bg-emerald-50 text-emerald-700";
        } else if (s === "CANCELLED") {
            classes =
                "bg-red-50 text-red-700";
        } else if (s === "NO_SHOW") {
            classes =
                "bg-amber-50 text-amber-700";
        } else if (s === "BILLED") {
            classes =
                "bg-violet-50 text-violet-700";
        }

        const headerStatus =
            document.getElementById("headerStatus");

        if (headerStatus) {
            headerStatus.className =
                "rounded-full px-3 py-1.5 font-inter " +
                "text-[9px] font-semibold " +
                classes;

            headerStatus.textContent =
                display;
        }

        const detailStatus =
            document.getElementById("detailStatus");

        if (detailStatus) {
            detailStatus.className =
                "rounded-full px-2.5 py-1 font-inter " +
                "text-[9px] font-semibold " +
                classes;

            detailStatus.textContent =
                display;
        }

        setText(
            "statusText",
            display
        );

        setText(
            "statusTextInfo",
            display
        );
    }


    function showError(message) {

        let element =
            document.getElementById(
                "apiErrorMessage"
            );

        if (!element) {

            element =
                document.createElement("div");

            element.id =
                "apiErrorMessage";

            element.className =
                "mb-5 rounded-lg border border-red-100 " +
                "bg-red-50 px-4 py-3 text-xs font-semibold " +
                "text-red-700";

            const main =
                document.querySelector("main");

            if (main) {
                main.prepend(element);
            }
        }

        element.textContent =
            message;
    }


    async function loadAppointment() {

        if (!appointmentId) {
            showError(
                "No appointment ID was provided."
            );
            return;
        }


        try {

            const appointment =
                await getJson(
                    "/api/appointments/" +
                    encodeURIComponent(
                        appointmentId
                    )
                );


            if (!appointment) {
                return;
            }


            const related =
                await Promise.all([

                    appointment.patientId
                        ? getJson(
                            "/api/patients/" +
                            encodeURIComponent(
                                appointment.patientId
                            )
                          )
                        : Promise.resolve(null),

                    appointment.dentistId
                        ? getJson(
                            "/api/dentists/" +
                            encodeURIComponent(
                                appointment.dentistId
                            )
                          )
                        : Promise.resolve(null),

                    appointment.treatmentId
                        ? getJson(
                            "/api/treatments/" +
                            encodeURIComponent(
                                appointment.treatmentId
                            )
                          )
                        : Promise.resolve(null)

                ]);


            const patient =
                related[0];

            const dentist =
                related[1];

            const treatment =
                related[2];


            // Appointment Information
            setText(
                "appointmentId",
                appointment.appointmentId
            );

            const appointmentNumber =
                appointment.appointmentNumber ||
                appointment.appointmentNo ||
                appointment.number;

            setText(
                "appointmentNumber",
                appointmentNumber
            );

            setText(
                "appointmentNumberInfo",
                appointmentNumber
            );

            setText(
                "appointmentDate",
                appointment.appointmentDate ||
                appointment.date
            );

            setText(
                "appointmentTime",
                appointment.appointmentTime
                    ? String(
                        appointment.appointmentTime
                      ).substring(0, 5)
                    : appointment.time
            );


            // Patient
            setText(
                "patientCode",
                patient
                    ? patient.patientCode
                    : null
            );

            setText(
                "patientName",
                getPatientName(patient)
            );

            setText(
                "patientContact",
                patient
                    ? patient.contactNumber
                    : null
            );


            // Dentist
            setText(
                "dentistName",
                getDentistName(dentist)
            );

            setText(
                "dentistSpecialization",
                dentist
                    ? dentist.specialization
                    : null
            );


            // Treatment
            setText(
                "treatmentName",
                getTreatmentName(treatment)
            );

            const fee =
                treatment &&
                treatment.treatmentFee !== null &&
                treatment.treatmentFee !== undefined
                    ? "LKR " +
                      Number(
                          treatment.treatmentFee
                      ).toFixed(2)
                    : null;

            setText(
                "treatmentFee",
                fee
            );


            // Other information
            setText(
                "appointmentNotes",
                appointment.notes &&
                String(appointment.notes).trim()
                    ? appointment.notes
                    : "No additional notes."
            );

            setText(
                "createdBy",
                appointment.createdBy
            );

            setText(
                "createdAt",
                appointment.createdAt
            );

            setText(
                "updatedAt",
                appointment.updatedAt
            );


            setStatus(
                appointment.status
            );


            // Build the Edit button only after the real
            // appointment ID has been received.
            const editLink =
                document.getElementById(
                    "editAppointmentLink"
                );

            if (editLink) {

                editLink.href =
                    contextPath +
                    "/appointments/edit?id=" +
                    encodeURIComponent(
                        appointment.appointmentId
                    );

                editLink.style.display =
                    "inline-flex";
            }

        } catch (error) {

            console.error(
                "Could not load appointment:",
                error
            );

            showError(
                "Could not load appointment details. " +
                "Please check the appointment ID and REST API."
            );
        }
    }


    // Show the original success message when the edit
    // operation redirects back with ?updated=1.
    if (params.get("updated") === "1") {

        const message =
            document.getElementById(
                "updateSuccessMessage"
            );

        if (message) {
            message.classList.remove("hidden");
        }
    }


    loadAppointment();

})();
</script>
