<%@ page language="java"
    contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="java.util.List" %>
<%@ page import="com.sunrise.model.Appointment" %>
<%@ page import="com.sunrise.model.Patient" %>
<%@ page import="com.sunrise.model.Dentist" %>
<%@ page import="com.sunrise.model.Treatment" %>
<%@ page import="com.sunrise.dao.PatientDAO" %>
<%@ page import="com.sunrise.dao.DentistDAO" %>
<%@ page import="com.sunrise.dao.TreatmentDAO" %>

<%
    List<Appointment> appointments =
        (List<Appointment>) request.getAttribute("appointments");

    String keyword =
        (String) request.getAttribute("keyword");

    PatientDAO patientDAO = new PatientDAO();
    DentistDAO dentistDAO = new DentistDAO();
    TreatmentDAO treatmentDAO = new TreatmentDAO();
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


        <!-- SUCCESS -->

        <% if ("1".equals(request.getParameter("success"))) { %>

            <div class="mb-5 flex items-center gap-3 rounded-lg border border-emerald-100 bg-emerald-50 px-4 py-3 text-xs font-semibold text-emerald-700">

                <span class="flex h-5 w-5 items-center justify-center rounded-full bg-emerald-100">
                    ✓
                </span>

                Appointment created successfully.

            </div>

        <% } %>


        <% if ("1".equals(request.getParameter("updated"))) { %>

            <div class="mb-5 flex items-center gap-3 rounded-lg border border-emerald-100 bg-emerald-50 px-4 py-3 text-xs font-semibold text-emerald-700">

                <span class="flex h-5 w-5 items-center justify-center rounded-full bg-emerald-100">
                    ✓
                </span>

                Appointment updated successfully.

            </div>

        <% } %>


        <!-- SEARCH -->

        <div class="mb-5 rounded-xl border border-slate-200 bg-white p-4">

            <form
                method="get"
                action="<%= request.getContextPath() %>/appointments"
                class="flex gap-2"
            >

                <div class="relative flex-1">

                    <input
                        type="text"
                        name="keyword"
                        value="<%= keyword != null ? keyword : "" %>"
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


                <% if (keyword != null && !keyword.trim().isEmpty()) { %>

                    <a
                        href="<%= request.getContextPath() %>/appointments"
                        class="rounded-lg border border-slate-200 bg-white px-4 py-2.5 text-xs font-semibold text-slate-600 hover:bg-slate-50"
                    >
                        Clear
                    </a>

                <% } %>

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
                    <strong class="text-slate-700">
                        <%= appointments != null ? appointments.size() : 0 %>
                    </strong>

                </span>

            </div>


            <% if (appointments != null && !appointments.isEmpty()) { %>


                <div class="overflow-x-auto">

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


                        <tbody>


                        <% for (Appointment appointment : appointments) {

                            Patient patient =
                                patientDAO.getPatientById(
                                    appointment.getPatientId()
                                );

                            Dentist dentist =
                                dentistDAO.getDentistById(
                                    appointment.getDentistId()
                                );

                            Treatment treatment =
                                treatmentDAO.getTreatmentById(
                                    appointment.getTreatmentId()
                                );

                            String status =
                                appointment.getStatus();

                            String statusClass =
                                status.toLowerCase()
                                      .replace("_", "-");

                            String statusBg = "bg-blue-50 text-blue-700";

                            if ("COMPLETED".equals(status)) {
                                statusBg = "bg-emerald-50 text-emerald-700";
                            } else if ("CANCELLED".equals(status)) {
                                statusBg = "bg-red-50 text-red-700";
                            } else if ("NO_SHOW".equals(status)) {
                                statusBg = "bg-amber-50 text-amber-700";
                            } else if ("BILLED".equals(status)) {
                                statusBg = "bg-violet-50 text-violet-700";
                            }
                        %>


                            <tr class="border-t border-slate-100 transition hover:bg-slate-50/70">


                                <td class="px-4 py-3">

                                    <a
                                        href="<%= request.getContextPath() %>/appointments/view?id=<%= appointment.getAppointmentId() %>"
                                        class="text-[10px] font-extrabold text-blue-600 hover:underline"
                                    >
                                        <%= appointment.getAppointmentNumber() %>
                                    </a>

                                </td>


                                <td class="px-4 py-3 text-[10px] font-medium">

                                    <%= patient != null
                                        ? patient.getName()
                                        : "Unknown Patient" %>

                                </td>


                                <td class="px-4 py-3 text-[10px] font-medium">

                                    <%= dentist != null
                                        ? dentist.getDentistName()
                                        : "Unknown Dentist" %>

                                </td>


                                <td class="px-4 py-3 text-[10px] font-medium">

                                    <%= treatment != null
                                        ? treatment.getTreatmentName()
                                        : "Unknown Treatment" %>

                                </td>


                                <td class="px-4 py-3 font-inter text-[10px] text-slate-500">

                                    <%= appointment.getAppointmentDate() %>

                                </td>


                                <td class="px-4 py-3 font-inter text-[10px] text-slate-500">

                                    <%= appointment.getAppointmentTime() %>

                                </td>


                                <td class="px-4 py-3">

                                    <span class="inline-flex rounded-full px-2.5 py-1 font-inter text-[9px] font-semibold <%= statusBg %>">

                                        <%= status.replace("_", " ") %>

                                    </span>

                                </td>


                                <td class="px-4 py-3">

                                    <div class="flex gap-1">

                                        <a
                                            href="<%= request.getContextPath() %>/appointments/view?id=<%= appointment.getAppointmentId() %>"
                                            class="rounded-md px-2 py-1 text-[9px] font-semibold text-slate-500 hover:bg-blue-50 hover:text-blue-600"
                                        >
                                            View
                                        </a>

                                        <a
                                            href="<%= request.getContextPath() %>/appointments/edit?id=<%= appointment.getAppointmentId() %>"
                                            class="rounded-md px-2 py-1 text-[9px] font-semibold text-slate-500 hover:bg-blue-50 hover:text-blue-600"
                                        >
                                            Edit
                                        </a>

                                    </div>

                                </td>


                            </tr>


                        <% } %>


                        </tbody>

                    </table>

                </div>


            <% } else { %>


                <div class="px-5 py-16 text-center">

                    <div class="mx-auto mb-3 flex h-11 w-11 items-center justify-center rounded-xl bg-slate-100 text-slate-400">
                        &#9638;
                    </div>

                    <h3 class="text-sm font-extrabold">
                        No appointments found
                    </h3>

                    <p class="mt-1 font-inter text-[10px] text-slate-500">

                        <% if (keyword != null && !keyword.trim().isEmpty()) { %>

                            No appointments found for
                            "<strong><%= keyword %></strong>".

                        <% } else { %>

                            No appointments have been booked yet.

                        <% } %>

                    </p>

                </div>


            <% } %>


        </div>


    </main>

</div>

</body>
</html>