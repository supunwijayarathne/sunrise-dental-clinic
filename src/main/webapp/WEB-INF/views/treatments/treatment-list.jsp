<%@ page language="java"
    contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="java.util.List" %>
<%@ page import="com.sunrise.model.Treatment" %>

<%
    List<Treatment> treatments =
        (List<Treatment>) request.getAttribute("treatments");

    String keyword =
        (String) request.getAttribute("keyword");
%>

<!DOCTYPE html>

<html lang="en">

<head>

    <meta charset="UTF-8">

    <meta name="viewport"
          content="width=device-width, initial-scale=1.0">

    <title>
        Treatments | Sunrise Dental Clinic
    </title>


    <!-- Tailwind CSS -->

    <script src="https://cdn.tailwindcss.com"></script>


    <!-- Fonts -->

    <link rel="preconnect"
          href="https://fonts.googleapis.com">

    <link rel="preconnect"
          href="https://fonts.gstatic.com"
          crossorigin>

    <link
        href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&family=Manrope:wght@400;500;600;700;800&display=swap"
        rel="stylesheet"
    >


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
        <!-- HEADER -->
        <!-- ================================================= -->

        <div class="mb-7 flex items-end justify-between">


            <div>


                <!-- Breadcrumb -->

                <div class="mb-2 flex items-center gap-2 font-inter text-[9px] font-medium text-slate-400">

                    <span class="text-blue-600">
                        Management
                    </span>

                    <span>/</span>

                    <span class="text-slate-500">
                        Treatments
                    </span>

                </div>


                <h1 class="text-[25px] font-extrabold tracking-[-0.7px]">

                    Treatments

                </h1>


                <p class="mt-1 font-inter text-xs text-slate-500">

                    Manage dental treatments and treatment fees.

                </p>


            </div>


            <!-- Add Button -->

            <a
                href="<%= request.getContextPath() %>/treatments/add"
                class="inline-flex items-center gap-2 rounded-lg bg-[#2563EB] px-4 py-2.5 font-inter text-[10px] font-bold text-white shadow-sm transition hover:bg-[#1D4ED8]"
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
                        d="M12 5v14M5 12h14"
                    />

                </svg>


                Add Treatment


            </a>


        </div>



        <!-- ================================================= -->
        <!-- SUCCESS MESSAGES -->
        <!-- ================================================= -->

        <% if ("1".equals(request.getParameter("success"))) { %>


            <div class="mb-5 flex items-center gap-3 rounded-xl border border-emerald-100 bg-emerald-50 px-4 py-3">


                <div class="flex h-8 w-8 items-center justify-center rounded-lg bg-emerald-100">


                    <svg
                        class="h-4 w-4 text-emerald-600"
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


                </div>


                <div>


                    <p class="font-inter text-[10px] font-bold text-emerald-700">
                        Treatment added successfully.
                    </p>


                </div>


            </div>


        <% } %>



        <% if ("1".equals(request.getParameter("updated"))) { %>


            <div class="mb-5 flex items-center gap-3 rounded-xl border border-emerald-100 bg-emerald-50 px-4 py-3">


                <div class="flex h-8 w-8 items-center justify-center rounded-lg bg-emerald-100">


                    <svg
                        class="h-4 w-4 text-emerald-600"
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


                </div>


                <p class="font-inter text-[10px] font-bold text-emerald-700">
                    Treatment updated successfully.
                </p>


            </div>


        <% } %>



        <!-- ================================================= -->
        <!-- SEARCH + STATS -->
        <!-- ================================================= -->

        <div class="mb-5 grid grid-cols-[1fr_auto] gap-5">


            <!-- SEARCH -->

            <div class="rounded-xl border border-slate-200 bg-white p-4">


                <form
                    method="get"
                    action="<%= request.getContextPath() %>/treatments"
                    class="flex gap-2"
                >


                    <div class="relative flex-1">


                        <svg
                            class="absolute left-3 top-1/2 h-4 w-4 -translate-y-1/2 text-slate-400"
                            fill="none"
                            stroke="currentColor"
                            stroke-width="1.8"
                            viewBox="0 0 24 24"
                        >

                            <circle
                                cx="11"
                                cy="11"
                                r="7"
                            />

                            <path
                                stroke-linecap="round"
                                d="M20 20l-4-4"
                            />

                        </svg>


                        <input
                            type="text"
                            name="keyword"
                            placeholder="Search by treatment name or description..."
                            value="<%= keyword != null ? keyword : "" %>"
                            class="w-full rounded-lg border border-slate-200 bg-slate-50 py-2.5 pl-9 pr-3 font-inter text-[10px] text-slate-700 outline-none transition placeholder:text-slate-400 focus:border-blue-500 focus:bg-white focus:ring-2 focus:ring-blue-50"
                        >


                    </div>


                    <button
                        type="submit"
                        class="rounded-lg bg-[#172033] px-5 py-2.5 font-inter text-[10px] font-bold text-white transition hover:bg-[#0F172A]"
                    >

                        Search

                    </button>


                    <% if (keyword != null
                            && !keyword.trim().isEmpty()) { %>


                        <a
                            href="<%= request.getContextPath() %>/treatments"
                            class="rounded-lg border border-slate-200 bg-white px-4 py-2.5 font-inter text-[10px] font-semibold text-slate-500 transition hover:bg-slate-50"
                        >

                            Clear

                        </a>


                    <% } %>


                </form>


            </div>



            <!-- COUNT CARD -->

            <div class="flex min-w-[175px] items-center gap-3 rounded-xl border border-slate-200 bg-white px-5">


                <div class="flex h-9 w-9 items-center justify-center rounded-lg bg-blue-50">


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
                            d="M6 4h12v16H6z"
                        />

                        <path
                            stroke-linecap="round"
                            d="M9 8h6M9 12h6M9 16h4"
                        />

                    </svg>


                </div>


                <div>


                    <p class="font-inter text-[8px] font-semibold uppercase tracking-wide text-slate-400">
                        Total Treatments
                    </p>


                    <p class="mt-0.5 text-lg font-extrabold">

                        <%= treatments != null
                            ? treatments.size()
                            : 0 %>

                    </p>


                </div>


            </div>


        </div>



        <!-- ================================================= -->
        <!-- SEARCH RESULT -->
        <!-- ================================================= -->

        <% if (keyword != null
                && !keyword.trim().isEmpty()) { %>


            <div class="mb-5 font-inter text-[9px] text-slate-400">


                Search results for


                <span class="font-semibold text-slate-600">
                    "<%= keyword %>"
                </span>


                <span class="mx-1">
                    •
                </span>


                <%= treatments != null
                    ? treatments.size()
                    : 0 %>

                result(s)


            </div>


        <% } %>



        <!-- ================================================= -->
        <!-- TABLE CARD -->
        <!-- ================================================= -->

        <div class="overflow-hidden rounded-xl border border-slate-200 bg-white">


            <% if (treatments != null && !treatments.isEmpty()) { %>


                <div class="overflow-x-auto">


                    <table class="w-full border-collapse">


                        <!-- TABLE HEADER -->

                        <thead>


                            <tr class="border-b border-slate-100 bg-slate-50/70">


                                <th class="px-5 py-3.5 text-left font-inter text-[8px] font-bold uppercase tracking-[0.08em] text-slate-400">
                                    ID
                                </th>


                                <th class="px-5 py-3.5 text-left font-inter text-[8px] font-bold uppercase tracking-[0.08em] text-slate-400">
                                    Treatment
                                </th>


                                <th class="px-5 py-3.5 text-left font-inter text-[8px] font-bold uppercase tracking-[0.08em] text-slate-400">
                                    Description
                                </th>


                                <th class="px-5 py-3.5 text-left font-inter text-[8px] font-bold uppercase tracking-[0.08em] text-slate-400">
                                    Fee
                                </th>


                                <th class="px-5 py-3.5 text-left font-inter text-[8px] font-bold uppercase tracking-[0.08em] text-slate-400">
                                    Status
                                </th>


                                <th class="px-5 py-3.5 text-right font-inter text-[8px] font-bold uppercase tracking-[0.08em] text-slate-400">
                                    Actions
                                </th>


                            </tr>


                        </thead>



                        <!-- TABLE BODY -->

                        <tbody>


                        <% for (Treatment treatment : treatments) { %>


                            <tr class="border-b border-slate-100 last:border-0 transition hover:bg-slate-50/60">


                                <!-- ID -->

                                <td class="whitespace-nowrap px-5 py-4">


                                    <span class="font-inter text-[10px] font-semibold text-slate-400">

                                        #<%= treatment.getTreatmentId() %>

                                    </span>


                                </td>



                                <!-- NAME -->

                                <td class="px-5 py-4">


                                    <div class="flex items-center gap-3">


                                        <div class="flex h-9 w-9 shrink-0 items-center justify-center rounded-lg bg-blue-50">


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
                                                    d="M12 3c-3.5 0-6 2.7-6 6.2 0 2.3 1.2 4.1 2.8 5.4.7.6 1.2 1.4 1.2 2.4V19h4v-2c0-1 .5-1.8 1.2-2.4 1.6-1.3 2.8-3.1 2.8-5.4C18 5.7 15.5 3 12 3z"
                                                />

                                                <path
                                                    stroke-linecap="round"
                                                    d="M9 22h6"
                                                />

                                            </svg>


                                        </div>


                                        <div>


                                            <p class="font-inter text-[10px] font-bold text-slate-700">

                                                <%= treatment.getTreatmentName() %>

                                            </p>


                                            <p class="mt-0.5 font-inter text-[8px] text-slate-400">

                                                Dental Treatment

                                            </p>


                                        </div>


                                    </div>


                                </td>



                                <!-- DESCRIPTION -->

                                <td class="max-w-[330px] px-5 py-4">


                                    <p class="truncate font-inter text-[9px] leading-5 text-slate-500">

                                        <%= treatment.getDescription() %>

                                    </p>


                                </td>



                                <!-- FEE -->

                                <td class="whitespace-nowrap px-5 py-4">


                                    <p class="font-inter text-[10px] font-bold text-slate-700">

                                        LKR

                                        <%= String.format(
                                            "%.2f",
                                            treatment.getTreatmentFee()
                                        ) %>

                                    </p>


                                </td>



                                <!-- STATUS -->

                                <td class="px-5 py-4">


                                    <% if (treatment.isActive()) { %>


                                        <span class="inline-flex items-center gap-1.5 rounded-full bg-emerald-50 px-2.5 py-1 font-inter text-[8px] font-semibold text-emerald-600">


                                            <span class="h-1.5 w-1.5 rounded-full bg-emerald-500"></span>


                                            Active


                                        </span>


                                    <% } else { %>


                                        <span class="inline-flex items-center gap-1.5 rounded-full bg-slate-100 px-2.5 py-1 font-inter text-[8px] font-semibold text-slate-500">


                                            <span class="h-1.5 w-1.5 rounded-full bg-slate-400"></span>


                                            Inactive


                                        </span>


                                    <% } %>


                                </td>



                                <!-- ACTIONS -->

                                <td class="whitespace-nowrap px-5 py-4 text-right">


                                    <div class="flex justify-end gap-1.5">


                                        <a
                                            href="<%= request.getContextPath() %>/treatments/view?id=<%= treatment.getTreatmentId() %>"
                                            class="rounded-lg border border-slate-200 px-3 py-1.5 font-inter text-[8px] font-semibold text-slate-500 transition hover:border-blue-200 hover:bg-blue-50 hover:text-blue-600"
                                        >

                                            View

                                        </a>


                                        <a
                                            href="<%= request.getContextPath() %>/treatments/edit?id=<%= treatment.getTreatmentId() %>"
                                            class="rounded-lg border border-slate-200 px-3 py-1.5 font-inter text-[8px] font-semibold text-slate-500 transition hover:border-blue-200 hover:bg-blue-50 hover:text-blue-600"
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



                <!-- ================================================= -->
                <!-- EMPTY STATE -->
                <!-- ================================================= -->

                <div class="flex min-h-[350px] flex-col items-center justify-center px-6">


                    <div class="mb-4 flex h-14 w-14 items-center justify-center rounded-2xl bg-slate-50">


                        <svg
                            class="h-6 w-6 text-slate-300"
                            fill="none"
                            stroke="currentColor"
                            stroke-width="1.5"
                            viewBox="0 0 24 24"
                        >

                            <path
                                stroke-linecap="round"
                                stroke-linejoin="round"
                                d="M6 4h12v16H6z"
                            />

                            <path
                                stroke-linecap="round"
                                d="M9 8h6M9 12h6"
                            />

                        </svg>


                    </div>


                    <% if (keyword != null
                            && !keyword.trim().isEmpty()) { %>


                        <h3 class="text-sm font-extrabold">
                            No treatments found
                        </h3>


                        <p class="mt-1 max-w-sm text-center font-inter text-[9px] leading-5 text-slate-400">

                            No treatments matched
                            "<%= keyword %>".

                        </p>


                    <% } else { %>


                        <h3 class="text-sm font-extrabold">
                            No treatments yet
                        </h3>


                        <p class="mt-1 max-w-sm text-center font-inter text-[9px] leading-5 text-slate-400">

                            Start by adding your first dental treatment.

                        </p>


                        <a
                            href="<%= request.getContextPath() %>/treatments/add"
                            class="mt-4 rounded-lg bg-[#2563EB] px-4 py-2 font-inter text-[9px] font-bold text-white transition hover:bg-[#1D4ED8]"
                        >

                            + Add Treatment

                        </a>


                    <% } %>


                </div>


            <% } %>


        </div>



        <!-- ================================================= -->
        <!-- FOOTER -->
        <!-- ================================================= -->

        <div class="mt-6 flex items-center justify-between px-1">


            <p class="font-inter text-[8px] text-slate-400">
                Sunrise Dental Clinic
            </p>


            <a
                href="<%= request.getContextPath() %>/dashboard"
                class="font-inter text-[8px] font-semibold text-slate-400 transition hover:text-blue-600"
            >

                Back to Dashboard →

            </a>


        </div>


    </main>


</div>


</body>

</html>