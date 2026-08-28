<%@ page language="java"
    contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="com.sunrise.model.Patient" %>

<%
    Patient patient =
        (Patient) request.getAttribute("patient");

    String formMode =
        (String) request.getAttribute("formMode");

    boolean editMode =
        "edit".equals(formMode);

    String pageTitle =
        editMode
        ? "Edit Patient"
        : "Register New Patient";

    String buttonText =
        editMode
        ? "Update Patient"
        : "Register Patient";
%>

<!DOCTYPE html>

<html lang="en">

<head>

    <meta charset="UTF-8">

    <meta name="viewport"
          content="width=device-width, initial-scale=1.0">

    <title>
        <%= pageTitle %> | Sunrise Dental Clinic
    </title>


    <!-- Tailwind CSS -->

    <script src="https://cdn.tailwindcss.com"></script>


    <!-- Tailwind Configuration -->

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

        <div class="mb-7">


            <p class="mb-1 font-inter text-[10px] font-semibold uppercase tracking-[0.12em] text-slate-400">
                Patients
            </p>


            <h1 class="text-[25px] font-extrabold tracking-[-0.7px]">
                <%= pageTitle %>
            </h1>


            <p class="mt-1 font-inter text-xs text-slate-500">

                <% if (editMode) { %>

                    Update the patient's registered information.

                <% } else { %>

                    Enter the patient's information to register them.

                <% } %>

            </p>


        </div>



        <!-- ERROR -->

        <% if (request.getAttribute("error") != null) { %>


            <div class="mb-6 flex items-start gap-3 rounded-xl border border-red-100 bg-red-50 px-4 py-3">


                <div class="mt-0.5 flex h-7 w-7 shrink-0 items-center justify-center rounded-lg bg-red-100">


                    <svg
                        class="h-4 w-4 text-red-500"
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


                <div>

                    <p class="font-inter text-[10px] font-bold text-red-600">
                        Unable to save patient
                    </p>


                    <p class="mt-0.5 font-inter text-[10px] leading-5 text-red-500">

                        <%= request.getAttribute("error") %>

                    </p>

                </div>


            </div>


        <% } %>



        <!-- FORM CARD -->

        <div class="max-w-[900px] rounded-xl border border-slate-200 bg-white">


            <!-- CARD HEADER -->

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

                            <circle
                                cx="9"
                                cy="7"
                                r="4"
                            />

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


                        <p class="mt-0.5 font-inter text-[10px] text-slate-400">

                            <% if (editMode) { %>

                                Modify the patient's details below.

                            <% } else { %>

                                Add the patient's details below.

                            <% } %>

                        </p>


                    </div>


                </div>


            </div>



            <!-- FORM -->

            <form
                method="post"
                action="<%= request.getContextPath() %>/patients/<%= editMode ? "edit" : "add" %>"
                class="px-7 py-7"
            >


                <% if (editMode) { %>


                    <!-- PATIENT ID -->

                    <input
                        type="hidden"
                        name="patientId"
                        value="<%= patient.getPatientId() %>"
                    >


                    <!-- PATIENT CODE -->

                    <div class="mb-6">


                        <label class="mb-2 block font-inter text-[10px] font-semibold text-slate-600">
                            Patient Code
                        </label>


                        <div class="flex h-11 items-center rounded-lg border border-slate-200 bg-slate-50 px-3.5">


                            <span class="font-inter text-xs font-semibold text-slate-500">

                                <%= patient.getPatientCode() %>

                            </span>


                            <span class="ml-auto font-inter text-[9px] text-slate-400">
                                System generated
                            </span>


                        </div>


                    </div>


                <% } %>



                <!-- NAME + PHONE -->

                <div class="grid grid-cols-2 gap-5">


                    <!-- NAME -->

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
                            value="<%= patient != null && patient.getName() != null
                                ? patient.getName()
                                : "" %>"
                            required
                            class="h-11 w-full rounded-lg border border-slate-200 bg-white px-3.5 font-inter text-xs text-slate-700 outline-none transition placeholder:text-slate-300 focus:border-blue-500 focus:ring-2 focus:ring-blue-50"
                        >


                    </div>



                    <!-- PHONE -->

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
                            value="<%= patient != null && patient.getContactNumber() != null
                                ? patient.getContactNumber()
                                : "" %>"
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
                    ><%= patient != null && patient.getAddress() != null
                        ? patient.getAddress()
                        : "" %></textarea>


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
                        value="<%= patient != null && patient.getEmail() != null
                            ? patient.getEmail()
                            : "" %>"
                        class="h-11 w-full rounded-lg border border-slate-200 bg-white px-3.5 font-inter text-xs text-slate-700 outline-none transition placeholder:text-slate-300 focus:border-blue-500 focus:ring-2 focus:ring-blue-50"
                    >


                </div>



                <!-- FORM DIVIDER -->

                <div class="my-7 border-t border-slate-100"></div>



                <!-- REQUIRED INFO -->

                <div class="mb-6 rounded-lg bg-slate-50 px-4 py-3">


                    <div class="flex items-center gap-2">


                        <svg
                            class="h-3.5 w-3.5 text-slate-400"
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
                                d="M12 11v5M12 8h.01"
                            />

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


                    <% if (editMode) { %>


                        <a
                            href="<%= request.getContextPath() %>/patients/view?id=<%= patient.getPatientId() %>"
                            class="rounded-lg border border-slate-200 bg-white px-5 py-2.5 font-inter text-[10px] font-semibold text-slate-600 transition hover:bg-slate-50"
                        >

                            Cancel

                        </a>


                    <% } else { %>


                        <a
                            href="<%= request.getContextPath() %>/patients"
                            class="rounded-lg border border-slate-200 bg-white px-5 py-2.5 font-inter text-[10px] font-semibold text-slate-600 transition hover:bg-slate-50"
                        >

                            Cancel

                        </a>


                    <% } %>



                    <button
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


                        <%= buttonText %>


                    </button>


                </div>


            </form>


        </div>



        <!-- FOOTER -->

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


</body>

</html>