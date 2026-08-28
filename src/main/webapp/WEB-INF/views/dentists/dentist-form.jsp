<%@ page language="java"
    contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="com.sunrise.model.Dentist" %>

<%
    Dentist dentist =
        (Dentist) request.getAttribute("dentist");

    String formMode =
        (String) request.getAttribute("formMode");

    boolean editMode =
        "edit".equals(formMode);

    String title =
        editMode ? "Edit Dentist" : "Add Dentist";

    String buttonText =
        editMode ? "Update Dentist" : "Add Dentist";
%>

<!DOCTYPE html>

<html lang="en">

<head>

    <meta charset="UTF-8">

    <meta name="viewport"
          content="width=device-width, initial-scale=1.0">

    <title>
        <%= title %> | Sunrise Dental Clinic
    </title>


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


    <!-- MAIN -->

    <main class="ml-[250px] min-h-screen flex-1 px-8 py-7">


        <!-- HEADER -->

        <div class="mb-7 flex items-center justify-between">


            <div>


                <p class="mb-1 font-inter text-[10px] font-semibold uppercase tracking-[0.12em] text-slate-400">
                    Dentists
                </p>


                <h1 class="text-[25px] font-extrabold tracking-[-0.7px]">
                    <%= title %>
                </h1>


                <p class="mt-1 font-inter text-xs text-slate-500">

                    <%= editMode
                        ? "Update dentist information."
                        : "Register a new dentist in the clinic system." %>

                </p>


            </div>


            <% if (editMode) { %>


                <div class="rounded-lg border border-slate-200 bg-white px-4 py-2.5">


                    <p class="font-inter text-[8px] font-semibold uppercase tracking-[0.1em] text-slate-400">
                        Dentist ID
                    </p>


                    <p class="mt-0.5 text-xs font-extrabold text-blue-600">

                        #<%= dentist.getDentistId() %>

                    </p>


                </div>


            <% } %>


        </div>



        <!-- ERROR -->

        <% if (request.getAttribute("error") != null) { %>


            <div class="mx-auto mb-5 flex max-w-[850px] items-start gap-3 rounded-lg border border-red-100 bg-red-50 px-4 py-3">


                <div class="flex h-5 w-5 shrink-0 items-center justify-center rounded-full bg-red-100 font-inter text-[10px] font-bold text-red-600">
                    !
                </div>


                <p class="font-inter text-[10px] font-medium leading-5 text-red-700">

                    <%= request.getAttribute("error") %>

                </p>


            </div>


        <% } %>



        <!-- FORM -->

        <div class="mx-auto max-w-[850px]">


            <form
                id="dentistForm"
                method="post"
                action="<%= request.getContextPath() %>/dentists/<%= editMode ? "edit" : "add" %>"
            >


                <% if (editMode) { %>


                    <input
                        type="hidden"
                        name="dentistId"
                        value="<%= dentist.getDentistId() %>"
                    >


                <% } %>



                <!-- BASIC INFORMATION -->

                <div class="mb-5 rounded-xl border border-slate-200 bg-white p-6">


                    <div class="mb-6 flex items-center gap-3">


                        <div class="flex h-9 w-9 items-center justify-center rounded-lg bg-blue-50 text-xs font-extrabold text-blue-600">
                            D
                        </div>


                        <div>


                            <h2 class="text-sm font-extrabold">
                                Dentist Information
                            </h2>


                            <p class="mt-0.5 font-inter text-[9px] text-slate-400">
                                Basic information about the dentist.
                            </p>


                        </div>


                    </div>



                    <!-- NAME -->

                    <div class="mb-5">


                        <label
                            for="dentistName"
                            class="mb-1.5 block font-inter text-[10px] font-semibold text-slate-700"
                        >

                            Dentist Name

                            <span class="text-red-500">
                                *
                            </span>

                        </label>


                        <input
                            type="text"
                            id="dentistName"
                            name="dentistName"
                            maxlength="100"
                            placeholder="Enter dentist name"
                            value="<%= dentist != null
                                && dentist.getDentistName() != null
                                ? dentist.getDentistName()
                                : "" %>"
                            required
                            class="w-full rounded-lg border border-slate-200 bg-white px-3 py-3 font-inter text-[11px] outline-none transition placeholder:text-slate-400 focus:border-blue-500 focus:ring-4 focus:ring-blue-50"
                        >


                    </div>



                    <!-- SPECIALIZATION -->

                    <div>


                        <label
                            for="specialization"
                            class="mb-1.5 block font-inter text-[10px] font-semibold text-slate-700"
                        >

                            Specialization

                            <span class="text-red-500">
                                *
                            </span>

                        </label>


                        <input
                            type="text"
                            id="specialization"
                            name="specialization"
                            maxlength="100"
                            placeholder="e.g. General Dentistry"
                            value="<%= dentist != null
                                && dentist.getSpecialization() != null
                                ? dentist.getSpecialization()
                                : "" %>"
                            required
                            class="w-full rounded-lg border border-slate-200 bg-white px-3 py-3 font-inter text-[11px] outline-none transition placeholder:text-slate-400 focus:border-blue-500 focus:ring-4 focus:ring-blue-50"
                        >


                    </div>


                </div>



                <!-- CONTACT & FEE -->

                <div class="mb-5 rounded-xl border border-slate-200 bg-white p-6">


                    <div class="mb-6 flex items-center gap-3">


                        <div class="flex h-9 w-9 items-center justify-center rounded-lg bg-emerald-50 text-xs font-extrabold text-emerald-600">
                            $
                        </div>


                        <div>


                            <h2 class="text-sm font-extrabold">
                                Contact &amp; Consultation
                            </h2>


                            <p class="mt-0.5 font-inter text-[9px] text-slate-400">
                                Contact details and consultation fee.
                            </p>


                        </div>


                    </div>



                    <div class="grid grid-cols-2 gap-5">


                        <!-- CONSULTATION FEE -->

                        <div>


                            <label
                                for="consultationFee"
                                class="mb-1.5 block font-inter text-[10px] font-semibold text-slate-700"
                            >

                                Consultation Fee

                                <span class="text-red-500">
                                    *
                                </span>

                            </label>


                            <div class="relative">


                                <span class="pointer-events-none absolute inset-y-0 left-3 flex items-center font-inter text-[10px] font-semibold text-slate-400">
                                    LKR
                                </span>


                                <input
                                    type="number"
                                    id="consultationFee"
                                    name="consultationFee"
                                    min="0"
                                    step="0.01"
                                    placeholder="0.00"
                                    value="<%= dentist != null
                                        ? dentist.getConsultationFee()
                                        : "" %>"
                                    required
                                    class="w-full rounded-lg border border-slate-200 bg-white py-3 pl-12 pr-3 font-inter text-[11px] outline-none transition placeholder:text-slate-400 focus:border-blue-500 focus:ring-4 focus:ring-blue-50"
                                >


                            </div>


                        </div>



                        <!-- PHONE -->

                        <div>


                            <label
                                for="phoneNumber"
                                class="mb-1.5 block font-inter text-[10px] font-semibold text-slate-700"
                            >

                                Phone Number

                                <span class="text-red-500">
                                    *
                                </span>

                            </label>


                            <input
                                type="text"
                                id="phoneNumber"
                                name="phoneNumber"
                                maxlength="15"
                                placeholder="0712345678"
                                value="<%= dentist != null
                                    && dentist.getPhoneNumber() != null
                                    ? dentist.getPhoneNumber()
                                    : "" %>"
                                required
                                class="w-full rounded-lg border border-slate-200 bg-white px-3 py-3 font-inter text-[11px] outline-none transition placeholder:text-slate-400 focus:border-blue-500 focus:ring-4 focus:ring-blue-50"
                            >


                        </div>



                        <!-- EMAIL -->

                        <div class="col-span-2">


                            <label
                                for="email"
                                class="mb-1.5 block font-inter text-[10px] font-semibold text-slate-700"
                            >

                                Email

                                <span class="ml-1 font-normal text-slate-400">
                                    (Optional)
                                </span>

                            </label>


                            <input
                                type="email"
                                id="email"
                                name="email"
                                maxlength="100"
                                placeholder="example@gmail.com"
                                value="<%= dentist != null
                                    && dentist.getEmail() != null
                                    ? dentist.getEmail()
                                    : "" %>"
                                class="w-full rounded-lg border border-slate-200 bg-white px-3 py-3 font-inter text-[11px] outline-none transition placeholder:text-slate-400 focus:border-blue-500 focus:ring-4 focus:ring-blue-50"
                            >


                        </div>


                    </div>


                </div>



                <!-- STATUS -->

                <div class="mb-5 rounded-xl border border-slate-200 bg-white p-6">


                    <div class="mb-6 flex items-center gap-3">


                        <div class="flex h-9 w-9 items-center justify-center rounded-lg bg-slate-100 text-xs font-extrabold text-slate-600">
                            ✓
                        </div>


                        <div>


                            <h2 class="text-sm font-extrabold">
                                Account Status
                            </h2>


                            <p class="mt-0.5 font-inter text-[9px] text-slate-400">
                                Control whether this dentist is active.
                            </p>


                        </div>


                    </div>



                    <label
                        for="active"
                        class="mb-1.5 block font-inter text-[10px] font-semibold text-slate-700"
                    >
                        Status
                    </label>


                    <select
                        id="active"
                        name="active"
                        class="w-full rounded-lg border border-slate-200 bg-white px-3 py-3 font-inter text-[11px] outline-none transition focus:border-blue-500 focus:ring-4 focus:ring-blue-50"
                    >


                        <option
                            value="true"
                            <%= dentist == null || dentist.isActive()
                                ? "selected"
                                : "" %>
                        >
                            Active
                        </option>


                        <option
                            value="false"
                            <%= dentist != null && !dentist.isActive()
                                ? "selected"
                                : "" %>
                        >
                            Inactive
                        </option>


                    </select>


                    <p class="mt-2 font-inter text-[9px] text-slate-400">

                        Inactive dentists will remain in the system but can be
                        excluded from active clinic operations.

                    </p>


                </div>



                <!-- ACTIONS -->

                <div class="flex items-center justify-between">


                    <p class="font-inter text-[9px] text-slate-400">


                        <span class="text-red-500">
                            *
                        </span>

                        Required fields


                    </p>


                    <div class="flex gap-2">


                        <a
                            href="<%= request.getContextPath() %>/dentists"
                            class="rounded-lg border border-slate-200 bg-white px-5 py-2.5 font-inter text-[10px] font-semibold text-slate-600 transition hover:bg-slate-50"
                        >
                            Cancel
                        </a>


                        <button
                            type="submit"
                            class="flex items-center gap-2 rounded-lg bg-[#2563EB] px-5 py-2.5 font-inter text-[10px] font-bold text-white shadow-sm transition hover:bg-[#1D4ED8] focus:outline-none focus:ring-4 focus:ring-blue-100"
                        >


                            <% if (editMode) { %>


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


                            <% } else { %>


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
                                        d="M12 5v14M5 12h14"
                                    />

                                </svg>


                            <% } %>


                            <%= buttonText %>


                        </button>


                    </div>


                </div>


            </form>


        </div>



        <!-- FOOTER -->

        <div class="mx-auto mt-8 flex max-w-[850px] items-center justify-between px-1">


            <p class="font-inter text-[9px] text-slate-400">
                Sunrise Dental Clinic
            </p>


            <p class="font-inter text-[9px] text-slate-400">
                Dentist Management
            </p>


        </div>


    </main>


</div>


</body>

</html>