<%@ page language="java"
    contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>

<%@ page import="java.util.List" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.ArrayList" %>

<%@ page import="com.sunrise.model.Dentist" %>
<%@ page import="com.sunrise.model.DentistSchedule" %>

<%
    Dentist dentist =
        (Dentist) request.getAttribute("dentist");

    List<DentistSchedule> schedules =
        (List<DentistSchedule>)
        request.getAttribute("schedules");

    String error =
        (String) request.getAttribute("error");

    String contextPath =
        request.getContextPath();


    String[] days = {
        "MONDAY",
        "TUESDAY",
        "WEDNESDAY",
        "THURSDAY",
        "FRIDAY",
        "SATURDAY",
        "SUNDAY"
    };


    /*
     * Group schedules by day.
     */
    Map<String, List<DentistSchedule>> daySchedules =
        new HashMap<>();


    for (String day : days) {

        daySchedules.put(
            day,
            new ArrayList<DentistSchedule>()
        );
    }


    if (schedules != null) {

        for (DentistSchedule schedule : schedules) {

            String day =
                schedule.getDayOfWeek();

            if (day != null) {

                day = day.toUpperCase();

                if (daySchedules.containsKey(day)) {

                    daySchedules
                        .get(day)
                        .add(schedule);
                }
            }
        }
    }
%>


<!DOCTYPE html>

<html lang="en">

<head>

    <meta charset="UTF-8">

    <meta
        name="viewport"
        content="width=device-width, initial-scale=1.0">

    <title>
        Schedule | <%= dentist.getDentistName() %>
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

                        <%= dentist.getDentistName() %>

                    </h1>


                    <p
                        class="mt-1 font-inter text-xs text-slate-500">

                        <%= dentist.getSpecialization() != null
                            ? dentist.getSpecialization()
                            : "Dentist" %>

                    </p>

                </div>


                <a
                    href="<%= contextPath %>/dentists/view?id=<%= dentist.getDentistId() %>"
                    class="rounded-md border border-slate-200 bg-white px-4 py-2 font-inter text-[10px] font-semibold text-slate-600 transition hover:border-blue-200 hover:bg-blue-50 hover:text-blue-600">

                    Back

                </a>

            </div>


            <!-- ================================================= -->
            <!-- ERROR -->
            <!-- ================================================= -->

            <% if (error != null && !error.trim().isEmpty()) { %>

                <div
                    class="mb-5 rounded-lg border border-red-100 bg-red-50 px-4 py-3">

                    <p
                        class="font-inter text-[11px] font-medium text-red-600">

                        <%= error %>

                    </p>

                </div>

            <% } %>


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

            <form
                method="post"
                action="<%= contextPath %>/dentists/schedule/save"
                id="scheduleForm">


                <input
                    type="hidden"
                    name="dentistId"
                    value="<%= dentist.getDentistId() %>">


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

                        <%
                            for (String day : days) {

                                List<DentistSchedule> dayList =
                                    daySchedules.get(day);

                                boolean hasSchedule =
                                    dayList != null
                                    && !dayList.isEmpty();
                        %>


                        <!-- ================================================= -->
                        <!-- DAY ROW -->
                        <!-- ================================================= -->

                        <div
                            class="border-b border-slate-100 px-6 py-5"
                            data-day="<%= day %>">


                            <!-- DAY HEADER -->

                            <div
                                class="mb-3 flex items-center justify-between">


                                <div
                                    class="flex items-center gap-3">


                                    <div
                                        class="flex h-8 w-8 items-center justify-center rounded-lg bg-slate-50">

                                        <span
                                            class="font-inter text-[10px] font-bold text-slate-500">

                                            <%= day.substring(0, 1) %>

                                        </span>

                                    </div>


                                    <div>

                                        <p
                                            class="font-manrope text-[12px] font-bold text-[#172033]">

                                            <%= day.substring(0, 1)
                                                + day.substring(1).toLowerCase() %>

                                        </p>


                                        <p
                                            class="day-status font-inter text-[9px] text-slate-400">

                                            <%= hasSchedule
                                                ? dayList.size()
                                                + " working period"
                                                + (dayList.size() > 1
                                                    ? "s"
                                                    : "")
                                                : "Day off" %>

                                        </p>

                                    </div>

                                </div>


                                <!-- ADD PERIOD -->

                                <button
                                    type="button"
                                    onclick="addPeriod('<%= day %>')"
                                    class="rounded-md border border-slate-200 bg-white px-3 py-1.5 font-inter text-[9px] font-semibold text-slate-600 transition hover:border-blue-200 hover:bg-blue-50 hover:text-blue-600">

                                    + Add period

                                </button>

                            </div>


                            <!-- ================================================= -->
                            <!-- PERIODS -->
                            <!-- ================================================= -->

                            <div
                                id="periods-<%= day %>"
                                class="space-y-2.5">


                                <% if (hasSchedule) { %>


                                    <%
                                        for (
                                            DentistSchedule schedule
                                            : dayList
                                        ) {
                                    %>


                                    <!-- PERIOD -->

                                    <div
                                        class="period-row flex flex-wrap items-end gap-3 rounded-lg border border-slate-200 bg-slate-50 p-3"
                                        data-day="<%= day %>">


                                        <!-- VERY IMPORTANT:
                                             DAY VALUE IS INSIDE EVERY ROW -->

                                        <input
                                            type="hidden"
                                            name="dayOfWeek"
                                            value="<%= day %>">


                                        <!-- START TIME -->

                                        <div
                                            class="min-w-[180px] flex-1">

                                            <label
                                                class="mb-1.5 block font-inter text-[9px] font-semibold uppercase tracking-wide text-slate-400">

                                                Start time

                                            </label>


                                            <input
                                                type="time"
                                                name="startTime"
                                                value="<%= schedule.getStartTime() %>"
                                                required
                                                class="h-[38px] w-full rounded-md border border-slate-200 bg-white px-3 font-inter text-[11px] text-slate-700 outline-none transition focus:border-blue-500 focus:ring-2 focus:ring-blue-100">

                                        </div>


                                        <!-- TO -->

                                        <div
                                            class="pb-2 font-inter text-[10px] text-slate-400">

                                            to

                                        </div>


                                        <!-- END TIME -->

                                        <div
                                            class="min-w-[180px] flex-1">

                                            <label
                                                class="mb-1.5 block font-inter text-[9px] font-semibold uppercase tracking-wide text-slate-400">

                                                End time

                                            </label>


                                            <input
                                                type="time"
                                                name="endTime"
                                                value="<%= schedule.getEndTime() %>"
                                                required
                                                class="h-[38px] w-full rounded-md border border-slate-200 bg-white px-3 font-inter text-[11px] text-slate-700 outline-none transition focus:border-blue-500 focus:ring-2 focus:ring-blue-100">

                                        </div>


                                        <!-- SLOT DURATION -->

                                        <div
                                            class="w-[145px]">

                                            <label
                                                class="mb-1.5 block font-inter text-[9px] font-semibold uppercase tracking-wide text-slate-400">

                                                Slot duration

                                            </label>


                                            <select
                                                name="slotDuration"
                                                class="h-[38px] w-full rounded-md border border-slate-200 bg-white px-3 font-inter text-[11px] text-slate-700 outline-none transition focus:border-blue-500 focus:ring-2 focus:ring-blue-100">


                                                <option
                                                    value="15"
                                                    <%= schedule.getSlotDuration() == 15
                                                        ? "selected"
                                                        : "" %>>

                                                    15 minutes

                                                </option>


                                                <option
                                                    value="30"
                                                    <%= schedule.getSlotDuration() == 30
                                                        ? "selected"
                                                        : "" %>>

                                                    30 minutes

                                                </option>


                                                <option
                                                    value="45"
                                                    <%= schedule.getSlotDuration() == 45
                                                        ? "selected"
                                                        : "" %>>

                                                    45 minutes

                                                </option>


                                                <option
                                                    value="60"
                                                    <%= schedule.getSlotDuration() == 60
                                                        ? "selected"
                                                        : "" %>>

                                                    60 minutes

                                                </option>

                                            </select>

                                        </div>


                                        <!-- REMOVE -->

                                        <button
                                            type="button"
                                            onclick="removePeriod(this)"
                                            class="h-[38px] rounded-md border border-red-100 bg-white px-3 font-inter text-[9px] font-semibold text-red-500 transition hover:bg-red-50">

                                            Remove

                                        </button>


                                    </div>


                                    <%
                                        }
                                    %>


                                <% } else { %>


                                    <!-- EMPTY DAY -->

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


                                <% } %>


                            </div>


                        </div>


                        <%
                            }
                        %>

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
                                href="<%= contextPath %>/dentists/view?id=<%= dentist.getDentistId() %>"
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


/*
 * ============================================================
 * ADD NEW PERIOD
 * ============================================================
 */

function addPeriod(day) {

    const container =
        document.getElementById(
            "periods-" + day
        );


    /*
     * Remove "No working hours configured"
     */

    const empty =
        container.querySelector(
            ".empty-day"
        );


    if (empty) {
        empty.remove();
    }


    /*
     * Create new row
     */

    const row =
        document.createElement("div");


    row.className =
        "period-row flex flex-wrap items-end gap-3 rounded-lg border border-slate-200 bg-slate-50 p-3";


    /*
     * IMPORTANT:
     *
     * dayOfWeek is created inside the row.
     */

    row.setAttribute(
        "data-day",
        day
    );


    row.innerHTML = `

        <input
            type="hidden"
            name="dayOfWeek"
            value="${day}">


        <!-- START -->

        <div class="min-w-[180px] flex-1">

            <label
                class="mb-1.5 block font-inter text-[9px] font-semibold uppercase tracking-wide text-slate-400">

                Start time

            </label>

            <input
                type="time"
                name="startTime"
                value="09:00"
                required
                class="h-[38px] w-full rounded-md border border-slate-200 bg-white px-3 font-inter text-[11px] text-slate-700 outline-none transition focus:border-blue-500 focus:ring-2 focus:ring-blue-100">

        </div>


        <!-- TO -->

        <div class="pb-2 font-inter text-[10px] text-slate-400">

            to

        </div>


        <!-- END -->

        <div class="min-w-[180px] flex-1">

            <label
                class="mb-1.5 block font-inter text-[9px] font-semibold uppercase tracking-wide text-slate-400">

                End time

            </label>

            <input
                type="time"
                name="endTime"
                value="17:00"
                required
                class="h-[38px] w-full rounded-md border border-slate-200 bg-white px-3 font-inter text-[11px] text-slate-700 outline-none transition focus:border-blue-500 focus:ring-2 focus:ring-blue-100">

        </div>


        <!-- DURATION -->

        <div class="w-[145px]">

            <label
                class="mb-1.5 block font-inter text-[9px] font-semibold uppercase tracking-wide text-slate-400">

                Slot duration

            </label>

            <select
                name="slotDuration"
                class="h-[38px] w-full rounded-md border border-slate-200 bg-white px-3 font-inter text-[11px] text-slate-700 outline-none transition focus:border-blue-500 focus:ring-2 focus:ring-blue-100">

                <option value="15">
                    15 minutes
                </option>

                <option value="30" selected>
                    30 minutes
                </option>

                <option value="45">
                    45 minutes
                </option>

                <option value="60">
                    60 minutes
                </option>

            </select>

        </div>


        <!-- REMOVE -->

        <button
            type="button"
            onclick="removePeriod(this)"
            class="h-[38px] rounded-md border border-red-100 bg-white px-3 font-inter text-[9px] font-semibold text-red-500 transition hover:bg-red-50">

            Remove

        </button>

    `;


    container.appendChild(row);


    updateDayStatus(day);
}


/*
 * ============================================================
 * REMOVE PERIOD
 * ============================================================
 */

function removePeriod(button) {

    const row =
        button.closest(".period-row");


    if (!row) {
        return;
    }


    const day =
        row.getAttribute("data-day");


    const container =
        row.parentElement;


    row.remove();


    /*
     * If there are no periods left,
     * show Day Off message.
     */

    const remaining =
        container.querySelectorAll(
            ".period-row"
        );


    if (remaining.length === 0) {

        container.innerHTML = `

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

        `;
    }


    updateDayStatus(day);
}


/*
 * ============================================================
 * UPDATE DAY STATUS
 * ============================================================
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
            + (rows.length > 1
                ? "s"
                : "");
    }
}


/*
 * ============================================================
 * FORM VALIDATION
 * ============================================================
 *
 * Make absolutely sure every period has a day.
 */

document
    .getElementById("scheduleForm")
    .addEventListener(
        "submit",
        function(event) {

            const rows =
                document.querySelectorAll(
                    ".period-row"
                );


            /*
             * No schedule is also allowed.
             *
             * This means the dentist can have
             * a completely empty weekly schedule.
             */


            rows.forEach(function(row) {

                const day =
                    row.getAttribute(
                        "data-day"
                    );


                let dayInput =
                    row.querySelector(
                        'input[name="dayOfWeek"]'
                    );


                /*
                 * Create it if somehow missing.
                 */

                if (!dayInput) {

                    dayInput =
                        document.createElement(
                            "input"
                        );

                    dayInput.type =
                        "hidden";

                    dayInput.name =
                        "dayOfWeek";

                    row.prepend(
                        dayInput
                    );
                }


                dayInput.value =
                    day.toUpperCase();
            });


            /*
             * Debug output.
             *
             * You can remove this later.
             */

            console.log(
                "===== SCHEDULE FORM SUBMIT ====="
            );


            console.log(
                "Days:",
                Array.from(
                    document.querySelectorAll(
                        'input[name="dayOfWeek"]'
                    )
                ).map(
                    input => input.value
                )
            );


            console.log(
                "Starts:",
                Array.from(
                    document.querySelectorAll(
                        'input[name="startTime"]'
                    )
                ).map(
                    input => input.value
                )
            );


            console.log(
                "Ends:",
                Array.from(
                    document.querySelectorAll(
                        'input[name="endTime"]'
                    )
                ).map(
                    input => input.value
                )
            );


            console.log(
                "Durations:",
                Array.from(
                    document.querySelectorAll(
                        '[name="slotDuration"]'
                    )
                ).map(
                    input => input.value
                )
            );


            console.log(
                "================================"
            );
        }
    );

</script>


</body>

</html>