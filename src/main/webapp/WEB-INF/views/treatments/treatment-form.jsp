<%@ page language="java"
    contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="com.sunrise.model.Treatment" %>

<%
    Treatment treatment =
        (Treatment) request.getAttribute("treatment");

    String formMode =
        (String) request.getAttribute("formMode");

    boolean editMode =
        "edit".equals(formMode);

    String title =
        editMode ? "Edit Treatment" : "Add Treatment";

    String buttonText =
        editMode ? "Update Treatment" : "Add Treatment";
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
        href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&family=Manrope:wght@400;500;600;700;800&display=swap"
        rel="stylesheet"
    >

</head>


<body class="min-h-screen bg-[#F5F7FB] font-manrope text-[#172033]">


<div class="flex min-h-screen">


    <!-- ================================================= -->
    <!-- SIDEBAR -->
    <!-- ================================================= -->

    <jsp:include page="../common/sidebar.jsp" />


    <!-- ================================================= -->
    <!-- MAIN CONTENT -->
    <!-- ================================================= -->

    <main class="ml-[250px] min-h-screen flex-1 px-8 py-7">


        <!-- ================================================= -->
        <!-- PAGE HEADER -->
        <!-- ================================================= -->

        <div class="mb-7">


            <!-- Breadcrumb -->

            <div class="mb-2 flex items-center gap-2 font-inter text-[9px] font-medium text-slate-400">

                <a
                    href="<%= request.getContextPath() %>/treatments"
                    class="transition hover:text-blue-600"
                >
                    Treatments
                </a>

                <span>/</span>

                <span class="text-slate-500">
                    <%= title %>
                </span>

            </div>


            <h1 class="text-[25px] font-extrabold tracking-[-0.7px]">

                <%= title %>

            </h1>


            <p class="mt-1 font-inter text-xs text-slate-500">

                <%= editMode
                    ? "Update the treatment information and pricing."
                    : "Register a new dental treatment in the clinic system." %>

            </p>


        </div>



        <!-- ================================================= -->
        <!-- ERROR MESSAGE -->
        <!-- ================================================= -->

        <% if (request.getAttribute("error") != null) { %>


            <div class="mb-6 flex items-start gap-3 rounded-xl border border-red-100 bg-red-50 px-4 py-3">


                <div class="flex h-8 w-8 shrink-0 items-center justify-center rounded-lg bg-red-100">


                    <svg
                        class="h-4 w-4 text-red-600"
                        fill="none"
                        stroke="currentColor"
                        stroke-width="1.8"
                        viewBox="0 0 24 24"
                    >

                        <path
                            stroke-linecap="round"
                            stroke-linejoin="round"
                            d="M12 9v4"
                        />

                        <path
                            stroke-linecap="round"
                            stroke-linejoin="round"
                            d="M12 17h.01"
                        />

                        <circle
                            cx="12"
                            cy="12"
                            r="9"
                        />

                    </svg>


                </div>


                <div>


                    <p class="font-inter text-[10px] font-bold text-red-700">
                        Unable to save treatment
                    </p>


                    <p class="mt-1 font-inter text-[10px] leading-5 text-red-600">

                        <%= request.getAttribute("error") %>

                    </p>


                </div>


            </div>


        <% } %>



        <!-- ================================================= -->
        <!-- FORM LAYOUT -->
        <!-- ================================================= -->

        <div class="grid max-w-[1050px] grid-cols-[1fr_280px] gap-6">


            <!-- ================================================= -->
            <!-- FORM CARD -->
            <!-- ================================================= -->

            <div class="rounded-xl border border-slate-200 bg-white">


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
                                    d="M12 3c-3.5 0-6 2.7-6 6.2 0 2.3 1.2 4.1 2.8 5.4.7.6 1.2 1.4 1.2 2.4V19h4v-2c0-1 .5-1.8 1.2-2.4 1.6-1.3 2.8-3.1 2.8-5.4C18 5.7 15.5 3 12 3z"
                                />

                                <path
                                    stroke-linecap="round"
                                    d="M9 22h6"
                                />

                            </svg>


                        </div>


                        <div>


                            <h2 class="text-base font-extrabold">

                                Treatment Information

                            </h2>


                            <p class="mt-1 font-inter text-[9px] text-slate-400">

                                Enter the details for this treatment.

                            </p>


                        </div>


                    </div>


                </div>



                <!-- ================================================= -->
                <!-- FORM -->
                <!-- ================================================= -->

                <form
                    id="treatmentForm"
                    method="post"
                    action="<%= request.getContextPath() %>/treatments/<%= editMode ? "edit" : "add" %>"
                    class="px-7 py-7"
                >


                    <!-- ============================================= -->
                    <!-- HIDDEN ID -->
                    <!-- ============================================= -->

                    <% if (editMode) { %>

                        <input
                            type="hidden"
                            name="treatmentId"
                            value="<%= treatment.getTreatmentId() %>"
                        >

                    <% } %>



                    <!-- ============================================= -->
                    <!-- TREATMENT ID -->
                    <!-- ============================================= -->

                    <% if (editMode) { %>


                        <div class="mb-6 rounded-lg border border-slate-200 bg-slate-50 px-4 py-3">


                            <div class="flex items-center justify-between">


                                <div>


                                    <p class="font-inter text-[8px] font-semibold uppercase tracking-[0.1em] text-slate-400">
                                        Treatment ID
                                    </p>


                                    <p class="mt-1 text-xs font-extrabold">
                                        #<%= treatment.getTreatmentId() %>
                                    </p>


                                </div>


                                <span class="rounded-full bg-blue-50 px-3 py-1.5 font-inter text-[8px] font-semibold text-blue-600">
                                    Existing Treatment
                                </span>


                            </div>


                        </div>


                    <% } %>



                    <!-- ============================================= -->
                    <!-- TREATMENT NAME -->
                    <!-- ============================================= -->

                    <div class="mb-5">


                        <label
                            for="treatmentName"
                            class="mb-2 block font-inter text-[10px] font-semibold text-slate-700"
                        >

                            Treatment Name

                            <span class="text-red-500">*</span>

                        </label>


                        <input
                            type="text"
                            id="treatmentName"
                            name="treatmentName"
                            maxlength="100"
                            placeholder="e.g. Dental Cleaning"
                            value="<%= treatment != null
                                && treatment.getTreatmentName() != null
                                ? treatment.getTreatmentName()
                                : "" %>"
                            required
                            class="w-full rounded-lg border border-slate-200 bg-white px-3.5 py-3 font-inter text-[11px] text-slate-700 outline-none transition placeholder:text-slate-300 focus:border-blue-500 focus:ring-2 focus:ring-blue-50"
                        >


                        <p class="mt-1.5 font-inter text-[8px] text-slate-400">
                            Enter a clear and recognizable treatment name.
                        </p>


                    </div>



                    <!-- ============================================= -->
                    <!-- DESCRIPTION -->
                    <!-- ============================================= -->

                    <div class="mb-5">


                        <label
                            for="description"
                            class="mb-2 block font-inter text-[10px] font-semibold text-slate-700"
                        >

                            Description

                            <span class="text-red-500">*</span>

                        </label>


                        <textarea
                            id="description"
                            name="description"
                            maxlength="500"
                            placeholder="Enter treatment description"
                            required
                            class="min-h-[130px] w-full resize-y rounded-lg border border-slate-200 bg-white px-3.5 py-3 font-inter text-[11px] leading-5 text-slate-700 outline-none transition placeholder:text-slate-300 focus:border-blue-500 focus:ring-2 focus:ring-blue-50"
                        ><%= treatment != null
                            && treatment.getDescription() != null
                            ? treatment.getDescription()
                            : "" %></textarea>


                        <p class="mt-1.5 font-inter text-[8px] text-slate-400">
                            Provide a short explanation of what the treatment includes.
                        </p>


                    </div>



                    <!-- ============================================= -->
                    <!-- FEE -->
                    <!-- ============================================= -->

                    <div class="mb-5">


                        <label
                            for="treatmentFee"
                            class="mb-2 block font-inter text-[10px] font-semibold text-slate-700"
                        >

                            Treatment Fee

                            <span class="text-red-500">*</span>

                        </label>


                        <div class="relative">


                            <span class="absolute left-3.5 top-1/2 -translate-y-1/2 font-inter text-[10px] font-semibold text-slate-400">
                                LKR
                            </span>


                            <input
                                type="number"
                                id="treatmentFee"
                                name="treatmentFee"
                                min="0"
                                step="0.01"
                                placeholder="0.00"
                                value="<%= treatment != null
                                    ? treatment.getTreatmentFee()
                                    : "" %>"
                                required
                                class="w-full rounded-lg border border-slate-200 bg-white py-3 pl-12 pr-3.5 font-inter text-[11px] text-slate-700 outline-none transition placeholder:text-slate-300 focus:border-blue-500 focus:ring-2 focus:ring-blue-50"
                            >


                        </div>


                        <p class="mt-1.5 font-inter text-[8px] text-slate-400">
                            Set the standard fee charged for this treatment.
                        </p>


                    </div>



                    <!-- ============================================= -->
                    <!-- STATUS -->
                    <!-- ============================================= -->

                    <div class="mb-7">


                        <label
                            for="active"
                            class="mb-2 block font-inter text-[10px] font-semibold text-slate-700"
                        >

                            Status

                        </label>


                        <select
                            id="active"
                            name="active"
                            class="w-full appearance-none rounded-lg border border-slate-200 bg-white px-3.5 py-3 font-inter text-[11px] text-slate-700 outline-none transition focus:border-blue-500 focus:ring-2 focus:ring-blue-50"
                        >


                            <option
                                value="true"
                                <%= treatment == null || treatment.isActive()
                                    ? "selected"
                                    : "" %>
                            >
                                Active
                            </option>


                            <option
                                value="false"
                                <%= treatment != null && !treatment.isActive()
                                    ? "selected"
                                    : "" %>
                            >
                                Inactive
                            </option>


                        </select>


                        <p class="mt-1.5 font-inter text-[8px] text-slate-400">
                            Inactive treatments will not normally be available for new appointments.
                        </p>


                    </div>



                    <!-- ============================================= -->
                    <!-- ACTIONS -->
                    <!-- ============================================= -->

                    <div class="flex items-center justify-between border-t border-slate-100 pt-6">


                        <a
                            href="<%= request.getContextPath() %>/treatments"
                            class="rounded-lg border border-slate-200 bg-white px-4 py-2.5 font-inter text-[10px] font-semibold text-slate-600 transition hover:bg-slate-50"
                        >

                            Cancel

                        </a>


                        <button
                            type="submit"
                            class="inline-flex items-center gap-2 rounded-lg bg-[#2563EB] px-5 py-2.5 font-inter text-[10px] font-bold text-white shadow-sm transition hover:bg-[#1D4ED8]"
                        >


                            <svg
                                class="h-3.5 w-3.5"
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


                            <%= buttonText %>


                        </button>


                    </div>


                </form>


            </div>



            <!-- ================================================= -->
            <!-- SIDE INFORMATION -->
            <!-- ================================================= -->

            <div class="space-y-4">


                <!-- INFO CARD -->

                <div class="rounded-xl border border-slate-200 bg-white p-5">


                    <div class="mb-4 flex h-9 w-9 items-center justify-center rounded-lg bg-blue-50">


                        <svg
                            class="h-4 w-4 text-blue-600"
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
                                d="M12 11v5"
                            />

                            <path
                                stroke-linecap="round"
                                d="M12 8h.01"
                            />

                        </svg>


                    </div>


                    <h3 class="text-sm font-extrabold">
                        Treatment Setup
                    </h3>


                    <p class="mt-2 font-inter text-[9px] leading-5 text-slate-400">
                        Keep treatment information accurate because these details can be used when creating appointments and patient bills.
                    </p>


                </div>



                <!-- FEE INFO -->

                <div class="rounded-xl border border-slate-200 bg-white p-5">


                    <div class="flex items-start gap-3">


                        <div class="flex h-8 w-8 shrink-0 items-center justify-center rounded-lg bg-emerald-50">


                            <svg
                                class="h-4 w-4 text-emerald-600"
                                fill="none"
                                stroke="currentColor"
                                stroke-width="1.7"
                                viewBox="0 0 24 24"
                            >

                                <path
                                    stroke-linecap="round"
                                    d="M12 1v22"
                                />

                                <path
                                    stroke-linecap="round"
                                    stroke-linejoin="round"
                                    d="M17 5H9.5a3.5 3.5 0 000 7h5a3.5 3.5 0 010 7H7"
                                />

                            </svg>


                        </div>


                        <div>


                            <p class="font-inter text-[9px] font-semibold text-slate-500">
                                Treatment Fee
                            </p>


                            <p class="mt-1 font-inter text-[8px] leading-4 text-slate-400">
                                This amount is used as the standard treatment charge when the treatment is selected.
                            </p>


                        </div>


                    </div>


                </div>



                <!-- STATUS INFO -->

                <div class="rounded-xl border border-slate-200 bg-white p-5">


                    <p class="mb-3 font-inter text-[9px] font-semibold uppercase tracking-wide text-slate-400">
                        Status Guide
                    </p>


                    <div class="space-y-3">


                        <div class="flex items-center gap-2.5">


                            <span class="h-2 w-2 rounded-full bg-emerald-500"></span>


                            <div>


                                <p class="font-inter text-[9px] font-semibold text-slate-600">
                                    Active
                                </p>


                                <p class="font-inter text-[8px] text-slate-400">
                                    Available for use
                                </p>


                            </div>


                        </div>



                        <div class="flex items-center gap-2.5">


                            <span class="h-2 w-2 rounded-full bg-slate-400"></span>


                            <div>


                                <p class="font-inter text-[9px] font-semibold text-slate-600">
                                    Inactive
                                </p>


                                <p class="font-inter text-[8px] text-slate-400">
                                    Temporarily unavailable
                                </p>


                            </div>


                        </div>


                    </div>


                </div>


            </div>


        </div>



        <!-- ================================================= -->
        <!-- FOOTER -->
        <!-- ================================================= -->

        <div class="mt-8 flex max-w-[1050px] items-center justify-between px-1">


            <p class="font-inter text-[9px] text-slate-400">
                Sunrise Dental Clinic
            </p>


            <p class="font-inter text-[9px] text-slate-400">
                Treatment Management
            </p>


        </div>


    </main>


</div>


</body>

</html>