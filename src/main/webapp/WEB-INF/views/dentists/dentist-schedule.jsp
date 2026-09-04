<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
String contextPath = request.getContextPath();
%>

<!DOCTYPE html>

<html lang="en">

<head>

    <meta charset="UTF-8">

    <meta
        name="viewport"
        content="width=device-width, initial-scale=1.0">

    <title>
        Schedule | <span id="dentistName">Loading...</span>
    </title>


    <!-- ===================================================== -->
    <!-- TAILWIND -->
    <!-- ===================================================== -->

    <script src="https://cdn.tailwindcss.com"></script>


    <!-- ===================================================== -->
    <!-- FONTS -->
    <!-- ===================================================== -->

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

        body {
            font-family: 'Manrope', sans-serif;
        }

        .font-manrope {
            font-family: 'Manrope', sans-serif;
        }

        .font-inter {
            font-family: 'Inter', sans-serif;
        }

        input[type="time"]::-webkit-calendar-picker-indicator {
            opacity: 0.45;
            cursor: pointer;
        }

    </style>

</head>


<body
    class="min-h-screen bg-[#F5F7FB] text-[#172033]">


<div class="flex min-h-screen">


    <!-- ===================================================== -->
    <!-- SIDEBAR -->
    <!-- ===================================================== -->

    <jsp:include
        page="../common/sidebar.jsp" />


    <!-- ===================================================== -->
    <!-- MAIN CONTENT -->
    <!-- ===================================================== -->

    <main
        class="ml-[250px] min-h-screen flex-1 px-8 py-7">


        <div
            class="mx-auto max-w-[1050px]">


            <!-- ================================================= -->
            <!-- PAGE HEADER -->
            <!-- ================================================= -->

            <div
                class="mb-7 flex items-end justify-between">


                <div>

                    <p
                        class="mb-1 font-inter text-[10px] font-semibold uppercase tracking-[0.12em] text-blue-600">

                        Dentist Schedule

                    </p>


                    <h1
                        class="font-manrope text-[24px] font-extrabold tracking-tight text-[#172033]">

                        <span id="dentistName">Loading...</span>

                    </h1>


                    <p
                        class="mt-1 font-inter text-xs text-slate-500">

                        <span id="dentistSpecialization">Dentist</span>

                    </p>

                </div>


                <a
                    id="backButton" href="<%= contextPath %>/dentists"
                    class="rounded-md border border-slate-200 bg-white px-4 py-2 font-inter text-[10px] font-semibold text-slate-600 transition hover:border-blue-200 hover:bg-blue-50 hover:text-blue-600">

                    Back

                </a>

            </div>


            <!-- ================================================= -->
            <!-- ERROR -->
            <!-- ================================================= -->

            <div
    id="errorMessage"
    class="mb-5 hidden rounded-lg border border-red-100 bg-red-50 px-4 py-3">

    <p
        id="errorText"
        class="font-inter text-[11px] font-medium text-red-600">

    </p>

</div>


            <!-- ================================================= -->
            <!-- SUCCESS -->
            <!-- ================================================= -->

            <% if ("1".equals(
                    request.getParameter("saved"))) { %>

                <div
                    class="mb-5 rounded-lg border border-blue-100 bg-blue-50 px-4 py-3">

                    <p
                        class="font-inter text-[11px] font-medium text-blue-600">

                        Schedule updated successfully.

                    </p>

                </div>

            <% } %>


            <!-- ================================================= -->
            <!-- SCHEDULE FORM -->
            <!-- ================================================= -->

            <div
                id="errorMessage"
                class="mb-5 hidden rounded-lg border border-red-100 bg-red-50 px-4 py-3">
                <p id="errorText"
                    class="font-inter text-[11px] font-medium text-red-600"></p>
            </div>

            <div
                id="successMessage"
                class="mb-5 hidden rounded-lg border border-blue-100 bg-blue-50 px-4 py-3">
                <p class="font-inter text-[11px] font-medium text-blue-600">
                    Schedule updated successfully.
                </p>
            </div>

            <form
                id="scheduleForm">


                <input
                    type="hidden"
                    name="dentistId"
                    id="dentistId"
                    value="">


                <!-- ================================================= -->
                <!-- MAIN CARD -->
                <!-- ================================================= -->

                <div
                    class="overflow-hidden rounded-xl border border-slate-200 bg-white">


                    <!-- ================================================= -->
                    <!-- CARD HEADER -->
                    <!-- ================================================= -->

                    <div
                        class="flex items-center justify-between border-b border-slate-100 px-6 py-5">


                        <div>

                            <h2
                                class="font-manrope text-[14px] font-extrabold text-[#172033]">

                                Working Hours

                            </h2>


                            <p
                                class="mt-1 font-inter text-[10px] text-slate-400">

                                Set the working periods used to generate appointment slots.

                            </p>

                        </div>


                        <div
                            class="rounded-md bg-blue-50 px-3 py-1.5">

                            <span
                                class="font-inter text-[9px] font-semibold text-blue-600">

                                Appointment availability

                            </span>

                        </div>

                    </div>


                    <!-- ================================================= -->
                    <!-- DAYS -->
                    <!-- ================================================= -->

                    <div>

                        <div
                            class="border-b border-slate-100 px-6 py-5"
                            data-day="MONDAY">

                            <div
                                class="mb-3 flex items-center justify-between">

                                <div class="flex items-center gap-3">

                                    <div
                                        class="flex h-8 w-8 items-center justify-center rounded-lg bg-slate-50">

                                        <span
                                            class="font-inter text-[10px] font-bold text-slate-500">

                                            M

                                        </span>

                                    </div>

                                    <div>

                                        <p
                                            class="font-manrope text-[12px] font-bold text-[#172033]">

                                            Monday

                                        </p>

                                        <p
                                            class="day-status font-inter text-[9px] text-slate-400">

                                            Day off

                                        </p>

                                    </div>

                                </div>

                                <button
                                    type="button"
                                    onclick="addPeriod('MONDAY')"
                                    class="rounded-md border border-slate-200 bg-white px-3 py-1.5 font-inter text-[9px] font-semibold text-slate-600 transition hover:border-blue-200 hover:bg-blue-50 hover:text-blue-600">

                                    + Add period

                                </button>

                            </div>

                            <div
                                id="periods-MONDAY"
                                class="space-y-2.5">

                                <div
                                    class="empty-day flex items-center justify-between rounded-lg border border-dashed border-slate-200 bg-slate-50 px-4 py-3">

                                    <p
                                        class="font-inter text-[10px] text-slate-400">

                                        No working hours configured.

                                    </p>

                                    <span
                                        class="font-inter text-[9px] font-medium text-slate-300">

                                        Day off

                                    </span>

                                </div>

                            </div>

                        </div>


                        <div
                            class="border-b border-slate-100 px-6 py-5"
                            data-day="TUESDAY">

                            <div
                                class="mb-3 flex items-center justify-between">

                                <div class="flex items-center gap-3">

                                    <div
                                        class="flex h-8 w-8 items-center justify-center rounded-lg bg-slate-50">

                                        <span
                                            class="font-inter text-[10px] font-bold text-slate-500">

                                            T

                                        </span>

                                    </div>

                                    <div>

                                        <p
                                            class="font-manrope text-[12px] font-bold text-[#172033]">

                                            Tuesday

                                        </p>

                                        <p
                                            class="day-status font-inter text-[9px] text-slate-400">

                                            Day off

                                        </p>

                                    </div>

                                </div>

                                <button
                                    type="button"
                                    onclick="addPeriod('TUESDAY')"
                                    class="rounded-md border border-slate-200 bg-white px-3 py-1.5 font-inter text-[9px] font-semibold text-slate-600 transition hover:border-blue-200 hover:bg-blue-50 hover:text-blue-600">

                                    + Add period

                                </button>

                            </div>

                            <div
                                id="periods-TUESDAY"
                                class="space-y-2.5">

                                <div
                                    class="empty-day flex items-center justify-between rounded-lg border border-dashed border-slate-200 bg-slate-50 px-4 py-3">

                                    <p
                                        class="font-inter text-[10px] text-slate-400">

                                        No working hours configured.

                                    </p>

                                    <span
                                        class="font-inter text-[9px] font-medium text-slate-300">

                                        Day off

                                    </span>

                                </div>

                            </div>

                        </div>


                        <div
                            class="border-b border-slate-100 px-6 py-5"
                            data-day="WEDNESDAY">

                            <div
                                class="mb-3 flex items-center justify-between">

                                <div class="flex items-center gap-3">

                                    <div
                                        class="flex h-8 w-8 items-center justify-center rounded-lg bg-slate-50">

                                        <span
                                            class="font-inter text-[10px] font-bold text-slate-500">

                                            W

                                        </span>

                                    </div>

                                    <div>

                                        <p
                                            class="font-manrope text-[12px] font-bold text-[#172033]">

                                            Wednesday

                                        </p>

                                        <p
                                            class="day-status font-inter text-[9px] text-slate-400">

                                            Day off

                                        </p>

                                    </div>

                                </div>

                                <button
                                    type="button"
                                    onclick="addPeriod('WEDNESDAY')"
                                    class="rounded-md border border-slate-200 bg-white px-3 py-1.5 font-inter text-[9px] font-semibold text-slate-600 transition hover:border-blue-200 hover:bg-blue-50 hover:text-blue-600">

                                    + Add period

                                </button>

                            </div>

                            <div
                                id="periods-WEDNESDAY"
                                class="space-y-2.5">

                                <div
                                    class="empty-day flex items-center justify-between rounded-lg border border-dashed border-slate-200 bg-slate-50 px-4 py-3">

                                    <p
                                        class="font-inter text-[10px] text-slate-400">

                                        No working hours configured.

                                    </p>

                                    <span
                                        class="font-inter text-[9px] font-medium text-slate-300">

                                        Day off

                                    </span>

                                </div>

                            </div>

                        </div>


                        <div
                            class="border-b border-slate-100 px-6 py-5"
                            data-day="THURSDAY">

                            <div
                                class="mb-3 flex items-center justify-between">

                                <div class="flex items-center gap-3">

                                    <div
                                        class="flex h-8 w-8 items-center justify-center rounded-lg bg-slate-50">

                                        <span
                                            class="font-inter text-[10px] font-bold text-slate-500">

                                            T

                                        </span>

                                    </div>

                                    <div>

                                        <p
                                            class="font-manrope text-[12px] font-bold text-[#172033]">

                                            Thursday

                                        </p>

                                        <p
                                            class="day-status font-inter text-[9px] text-slate-400">

                                            Day off

                                        </p>

                                    </div>

                                </div>

                                <button
                                    type="button"
                                    onclick="addPeriod('THURSDAY')"
                                    class="rounded-md border border-slate-200 bg-white px-3 py-1.5 font-inter text-[9px] font-semibold text-slate-600 transition hover:border-blue-200 hover:bg-blue-50 hover:text-blue-600">

                                    + Add period

                                </button>

                            </div>

                            <div
                                id="periods-THURSDAY"
                                class="space-y-2.5">

                                <div
                                    class="empty-day flex items-center justify-between rounded-lg border border-dashed border-slate-200 bg-slate-50 px-4 py-3">

                                    <p
                                        class="font-inter text-[10px] text-slate-400">

                                        No working hours configured.

                                    </p>

                                    <span
                                        class="font-inter text-[9px] font-medium text-slate-300">

                                        Day off

                                    </span>

                                </div>

                            </div>

                        </div>


                        <div
                            class="border-b border-slate-100 px-6 py-5"
                            data-day="FRIDAY">

                            <div
                                class="mb-3 flex items-center justify-between">

                                <div class="flex items-center gap-3">

                                    <div
                                        class="flex h-8 w-8 items-center justify-center rounded-lg bg-slate-50">

                                        <span
                                            class="font-inter text-[10px] font-bold text-slate-500">

                                            F

                                        </span>

                                    </div>

                                    <div>

                                        <p
                                            class="font-manrope text-[12px] font-bold text-[#172033]">

                                            Friday

                                        </p>

                                        <p
                                            class="day-status font-inter text-[9px] text-slate-400">

                                            Day off

                                        </p>

                                    </div>

                                </div>

                                <button
                                    type="button"
                                    onclick="addPeriod('FRIDAY')"
                                    class="rounded-md border border-slate-200 bg-white px-3 py-1.5 font-inter text-[9px] font-semibold text-slate-600 transition hover:border-blue-200 hover:bg-blue-50 hover:text-blue-600">

                                    + Add period

                                </button>

                            </div>

                            <div
                                id="periods-FRIDAY"
                                class="space-y-2.5">

                                <div
                                    class="empty-day flex items-center justify-between rounded-lg border border-dashed border-slate-200 bg-slate-50 px-4 py-3">

                                    <p
                                        class="font-inter text-[10px] text-slate-400">

                                        No working hours configured.

                                    </p>

                                    <span
                                        class="font-inter text-[9px] font-medium text-slate-300">

                                        Day off

                                    </span>

                                </div>

                            </div>

                        </div>


                        <div
                            class="border-b border-slate-100 px-6 py-5"
                            data-day="SATURDAY">

                            <div
                                class="mb-3 flex items-center justify-between">

                                <div class="flex items-center gap-3">

                                    <div
                                        class="flex h-8 w-8 items-center justify-center rounded-lg bg-slate-50">

                                        <span
                                            class="font-inter text-[10px] font-bold text-slate-500">

                                            S

                                        </span>

                                    </div>

                                    <div>

                                        <p
                                            class="font-manrope text-[12px] font-bold text-[#172033]">

                                            Saturday

                                        </p>

                                        <p
                                            class="day-status font-inter text-[9px] text-slate-400">

                                            Day off

                                        </p>

                                    </div>

                                </div>

                                <button
                                    type="button"
                                    onclick="addPeriod('SATURDAY')"
                                    class="rounded-md border border-slate-200 bg-white px-3 py-1.5 font-inter text-[9px] font-semibold text-slate-600 transition hover:border-blue-200 hover:bg-blue-50 hover:text-blue-600">

                                    + Add period

                                </button>

                            </div>

                            <div
                                id="periods-SATURDAY"
                                class="space-y-2.5">

                                <div
                                    class="empty-day flex items-center justify-between rounded-lg border border-dashed border-slate-200 bg-slate-50 px-4 py-3">

                                    <p
                                        class="font-inter text-[10px] text-slate-400">

                                        No working hours configured.

                                    </p>

                                    <span
                                        class="font-inter text-[9px] font-medium text-slate-300">

                                        Day off

                                    </span>

                                </div>

                            </div>

                        </div>


                        <div
                            class="border-b border-slate-100 px-6 py-5"
                            data-day="SUNDAY">

                            <div
                                class="mb-3 flex items-center justify-between">

                                <div class="flex items-center gap-3">

                                    <div
                                        class="flex h-8 w-8 items-center justify-center rounded-lg bg-slate-50">

                                        <span
                                            class="font-inter text-[10px] font-bold text-slate-500">

                                            S

                                        </span>

                                    </div>

                                    <div>

                                        <p
                                            class="font-manrope text-[12px] font-bold text-[#172033]">

                                            Sunday

                                        </p>

                                        <p
                                            class="day-status font-inter text-[9px] text-slate-400">

                                            Day off

                                        </p>

                                    </div>

                                </div>

                                <button
                                    type="button"
                                    onclick="addPeriod('SUNDAY')"
                                    class="rounded-md border border-slate-200 bg-white px-3 py-1.5 font-inter text-[9px] font-semibold text-slate-600 transition hover:border-blue-200 hover:bg-blue-50 hover:text-blue-600">

                                    + Add period

                                </button>

                            </div>

                            <div
                                id="periods-SUNDAY"
                                class="space-y-2.5">

                                <div
                                    class="empty-day flex items-center justify-between rounded-lg border border-dashed border-slate-200 bg-slate-50 px-4 py-3">

                                    <p
                                        class="font-inter text-[10px] text-slate-400">

                                        No working hours configured.

                                    </p>

                                    <span
                                        class="font-inter text-[9px] font-medium text-slate-300">

                                        Day off

                                    </span>

                                </div>

                            </div>

                        </div>

                    </div>

                    <!-- ================================================= -->
                    <!-- FOOTER -->
                    <!-- ================================================= -->

                    <div
                        class="flex items-center justify-between bg-slate-50/50 px-6 py-5">


                        <div>

                            <p
                                class="font-inter text-[10px] font-medium text-slate-500">

                                Changes affect future appointment availability.

                            </p>


                            <p
                                class="mt-1 font-inter text-[9px] text-slate-400">

                                Add multiple periods when the dentist has breaks.

                            </p>

                        </div>


                        <div
                            class="flex items-center gap-2">


                            <a
                                id="backButton" href="<%= contextPath %>/dentists"
                                class="rounded-md border border-slate-200 bg-white px-4 py-2 font-inter text-[10px] font-semibold text-slate-600 transition hover:bg-slate-100">

                                Cancel

                            </a>


                            <button
                                type="submit"
                                class="rounded-md bg-blue-600 px-5 py-2 font-inter text-[10px] font-bold text-white transition hover:bg-blue-700">

                                Save Schedule

                            </button>

                        </div>

                    </div>


                </div>


            </form>

        </div>

    </main>

</div>


<!-- ========================================================= -->
<!-- JAVASCRIPT -->
<!-- ========================================================= -->

<script>

(function () {

    "use strict";

    const contextPath = "<%= contextPath %>";

    const params = new URLSearchParams(
        window.location.search
    );

    const dentistId =
        params.get("id")
        || params.get("dentistId")
        || "";

    const days = [
        "MONDAY",
        "TUESDAY",
        "WEDNESDAY",
        "THURSDAY",
        "FRIDAY",
        "SATURDAY",
        "SUNDAY"
    ];

    const dentistIdElement =
        document.getElementById("dentistId");

    if (dentistIdElement) {
        dentistIdElement.value = dentistId;
    }


    function showError(message) {

        const box =
            document.getElementById("errorMessage");

        const text =
            document.getElementById("errorText");

        if (text) {
            text.textContent = message;
        }

        if (box) {
            box.classList.remove("hidden");
        }
    }


    function hideError() {

        const box =
            document.getElementById("errorMessage");

        if (box) {
            box.classList.add("hidden");
        }
    }


    function showSuccess() {

        const box =
            document.getElementById("successMessage");

        if (box) {
            box.classList.remove("hidden");
        }
    }


    async function apiError(response) {

        let body = "";

        try {
            body = await response.text();
        } catch (e) {}

        if (!body) {
            return "Request failed. HTTP " + response.status;
        }

        try {

            const json = JSON.parse(body);

            if (json.message) {
                return json.message;
            }

            if (json.error) {
                return json.error;
            }

        } catch (e) {}

        return body;
    }


    function formatTime(value) {

        if (!value) {
            return "";
        }

        return String(value).substring(0, 5);
    }


    function escapeHtml(value) {

        return String(value)
            .replace(/&/g, "&amp;")
            .replace(/</g, "&lt;")
            .replace(/>/g, "&gt;")
            .replace(/"/g, "&quot;")
            .replace(/'/g, "&#039;");
    }


    /*
     * ========================================================
     * GET DENTIST
     * ========================================================
     */

    async function loadDentist() {

        if (!dentistId) {

            showError(
                "Dentist ID is missing from the URL."
            );

            return;
        }

        try {

            const response = await fetch(
                contextPath
                + "/api/dentists/"
                + encodeURIComponent(dentistId),
                {
                    method: "GET",
                    credentials: "same-origin",
                    headers: {
                        "Accept": "application/json"
                    }
                }
            );


            if (response.status === 401) {

                window.location.href =
                    contextPath + "/login";

                return;
            }


            if (!response.ok) {

                throw new Error(
                    await apiError(response)
                );
            }


            const dentist =
                await response.json();


            const name =
                document.getElementById(
                    "dentistName"
                );

            if (name) {
                name.textContent =
                    dentist.dentistName || "Dentist";
            }


            const specialization =
                document.getElementById(
                    "dentistSpecialization"
                );

            if (specialization) {
                specialization.textContent =
                    dentist.specialization || "Dentist";
            }


            const back =
                document.getElementById(
                    "backButton"
                );

            if (back) {
                back.href =
                    contextPath + "/dentists";
            }


            const cancel =
                document.getElementById(
                    "cancelButton"
                );

            if (cancel) {
                cancel.href =
                    contextPath
                    + "/dentists/view?id="
                    + encodeURIComponent(dentistId);
            }


            document.title =
                "Schedule | "
                + (dentist.dentistName || "Dentist");


        } catch (error) {

            console.error(
                "Dentist REST API error:",
                error
            );

            showError(
                "Could not load dentist information. "
                + error.message
            );
        }
    }


    /*
     * ========================================================
     * GET SCHEDULE
     * ========================================================
     */

    async function loadSchedule() {

        if (!dentistId) {
            return;
        }

        try {

            const response = await fetch(
                contextPath
                + "/api/schedules?dentistId="
                + encodeURIComponent(dentistId),
                {
                    method: "GET",
                    credentials: "same-origin",
                    headers: {
                        "Accept": "application/json"
                    }
                }
            );


            if (response.status === 401) {

                window.location.href =
                    contextPath + "/login";

                return;
            }


            if (!response.ok) {

                throw new Error(
                    await apiError(response)
                );
            }


            const schedules =
                await response.json();


            if (!Array.isArray(schedules)) {

                throw new Error(
                    "Invalid schedule response."
                );
            }


            schedules.forEach(
                function (schedule) {

                    const day =
                        String(
                            schedule.dayOfWeek || ""
                        ).toUpperCase();


                    if (
                        days.indexOf(day) === -1
                    ) {
                        return;
                    }


                    addPeriod(
                        day,
                        formatTime(schedule.startTime),
                        formatTime(schedule.endTime),
                        schedule.slotDuration
                    );
                }
            );


            days.forEach(
                function (day) {
                    updateDayStatus(day);
                }
            );


        } catch (error) {

            console.error(
                "Schedule REST API error:",
                error
            );

            showError(
                "Could not load dentist schedule. "
                + error.message
            );
        }
    }


    /*
     * ========================================================
     * ADD PERIOD
     * ========================================================
     */

    function addPeriod(
        day,
        startTime,
        endTime,
        slotDuration
    ) {

        const container =
            document.getElementById(
                "periods-" + day
            );


        if (!container) {
            return;
        }


        const empty =
            container.querySelector(
                ".empty-day"
            );


        if (empty) {
            empty.remove();
        }


        const start =
            startTime || "09:00";

        const end =
            endTime || "17:00";

        const duration =
            slotDuration
            ? String(slotDuration)
            : "30";


        const row =
            document.createElement("div");


        row.className =
            "period-row flex flex-wrap items-end gap-3 rounded-lg border border-slate-200 bg-slate-50 p-3";


        row.setAttribute(
            "data-day",
            day
        );


        row.innerHTML =
            '<input type="hidden" name="dayOfWeek" value="'
            + escapeHtml(day)
            + '">'

            + '<div class="min-w-[180px] flex-1">'

            + '<label class="mb-1.5 block font-inter text-[9px] font-semibold uppercase tracking-wide text-slate-400">'
            + 'Start time'
            + '</label>'

            + '<input type="time" name="startTime" value="'
            + escapeHtml(start)
            + '" required class="h-[38px] w-full rounded-md border border-slate-200 bg-white px-3 font-inter text-[11px] text-slate-700 outline-none transition focus:border-blue-500 focus:ring-2 focus:ring-blue-100">'

            + '</div>'

            + '<div class="pb-2 font-inter text-[10px] text-slate-400">'
            + 'to'
            + '</div>'

            + '<div class="min-w-[180px] flex-1">'

            + '<label class="mb-1.5 block font-inter text-[9px] font-semibold uppercase tracking-wide text-slate-400">'
            + 'End time'
            + '</label>'

            + '<input type="time" name="endTime" value="'
            + escapeHtml(end)
            + '" required class="h-[38px] w-full rounded-md border border-slate-200 bg-white px-3 font-inter text-[11px] text-slate-700 outline-none transition focus:border-blue-500 focus:ring-2 focus:ring-blue-100">'

            + '</div>'

            + '<div class="w-[145px]">'

            + '<label class="mb-1.5 block font-inter text-[9px] font-semibold uppercase tracking-wide text-slate-400">'
            + 'Slot duration'
            + '</label>'

            + '<select name="slotDuration" class="h-[38px] w-full rounded-md border border-slate-200 bg-white px-3 font-inter text-[11px] text-slate-700 outline-none transition focus:border-blue-500 focus:ring-2 focus:ring-blue-100">'

            + '<option value="15">15 minutes</option>'
            + '<option value="30">30 minutes</option>'
            + '<option value="45">45 minutes</option>'
            + '<option value="60">60 minutes</option>'

            + '</select>'

            + '</div>'

            + '<button type="button" class="remove-period h-[38px] rounded-md border border-red-100 bg-white px-3 font-inter text-[9px] font-semibold text-red-500 transition hover:bg-red-50">'

            + 'Remove'

            + '</button>';


        container.appendChild(row);


        const select =
            row.querySelector(
                '[name="slotDuration"]'
            );


        if (select) {
            select.value = duration;
        }


        const remove =
            row.querySelector(
                ".remove-period"
            );


        if (remove) {

            remove.addEventListener(
                "click",
                function () {
                    removePeriod(row);
                }
            );
        }


        updateDayStatus(day);
    }


    window.addPeriod = addPeriod;


    /*
     * ========================================================
     * REMOVE PERIOD
     * ========================================================
     */

    function removePeriod(row) {

        if (!row) {
            return;
        }


        const day =
            row.getAttribute("data-day");


        const container =
            row.parentElement;


        row.remove();


        if (
            container
            && container.querySelectorAll(
                ".period-row"
            ).length === 0
        ) {

            container.innerHTML =
                '<div class="empty-day flex items-center justify-between rounded-lg border border-dashed border-slate-200 bg-slate-50 px-4 py-3">'

                + '<p class="font-inter text-[10px] text-slate-400">'
                + 'No working hours configured.'
                + '</p>'

                + '<span class="font-inter text-[9px] font-medium text-slate-300">'
                + 'Day off'
                + '</span>'

                + '</div>';
        }


        updateDayStatus(day);
    }


    /*
     * ========================================================
     * DAY STATUS
     * ========================================================
     */

    function updateDayStatus(day) {

        const dayContainer =
            document.querySelector(
                '[data-day="' + day + '"]'
            );


        if (!dayContainer) {
            return;
        }


        const rows =
            dayContainer.querySelectorAll(
                ".period-row"
            );


        const status =
            dayContainer.querySelector(
                ".day-status"
            );


        if (!status) {
            return;
        }


        if (rows.length === 0) {

            status.textContent =
                "Day off";

        } else {

            status.textContent =
                rows.length
                + " working period"
                + (
                    rows.length > 1
                    ? "s"
                    : ""
                );
        }
    }


    /*
     * ========================================================
     * PUT SCHEDULE
     * ========================================================
     */

    const form =
        document.getElementById(
            "scheduleForm"
        );


    if (form) {

        form.addEventListener(
            "submit",
            async function (event) {

                event.preventDefault();

                hideError();


                if (!dentistId) {

                    showError(
                        "Dentist ID is missing."
                    );

                    return;
                }


                const rows =
                    document.querySelectorAll(
                        ".period-row"
                    );


                const formData =
                    new URLSearchParams();


                for (
                    let i = 0;
                    i < rows.length;
                    i++
                ) {

                    const row =
                        rows[i];


                    const day =
                        row.getAttribute(
                            "data-day"
                        );


                    const start =
                        row.querySelector(
                            '[name="startTime"]'
                        );


                    const end =
                        row.querySelector(
                            '[name="endTime"]'
                        );


                    const duration =
                        row.querySelector(
                            '[name="slotDuration"]'
                        );


                    if (
                        !day
                        || !start
                        || !end
                        || !duration
                    ) {
                        continue;
                    }


                    if (
                        !start.value
                        || !end.value
                    ) {

                        showError(
                            "Please enter both start and end times."
                        );

                        return;
                    }


                    if (
                        end.value <= start.value
                    ) {

                        showError(
                            day
                            + ": End time must be after start time."
                        );

                        return;
                    }


                    formData.append(
                        "dayOfWeek",
                        day.toUpperCase()
                    );


                    formData.append(
                        "startTime",
                        start.value
                    );


                    formData.append(
                        "endTime",
                        end.value
                    );


                    formData.append(
                        "slotDuration",
                        duration.value
                    );
                }


                const saveButton =
                    form.querySelector(
                        'button[type="submit"]'
                    );


                if (saveButton) {

                    saveButton.disabled = true;

                    saveButton.textContent =
                        "Saving...";

                    saveButton.classList.add(
                        "opacity-70",
                        "cursor-not-allowed"
                    );
                }


                try {

                    const response =
                        await fetch(
                            contextPath
                            + "/api/schedules/"
                            + encodeURIComponent(
                                dentistId
                            ),
                            {
                                method: "PUT",

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


                    if (response.status === 401) {

                        window.location.href =
                            contextPath + "/login";

                        return;
                    }


                    if (!response.ok) {

                        throw new Error(
                            await apiError(response)
                        );
                    }


                    await response.json();


                    showSuccess();


                    window.scrollTo({
                        top: 0,
                        behavior: "smooth"
                    });


                } catch (error) {

                    console.error(
                        "Schedule save REST API error:",
                        error
                    );


                    showError(
                        "Could not save schedule. "
                        + error.message
                    );


                } finally {

                    if (saveButton) {

                        saveButton.disabled = false;

                        saveButton.textContent =
                            "Save Schedule";

                        saveButton.classList.remove(
                            "opacity-70",
                            "cursor-not-allowed"
                        );
                    }
                }

            }
        );
    }


    /*
     * ========================================================
     * LOAD
     * ========================================================
     */

    loadDentist();

    loadSchedule();

})();

</script>


</body>

</html>