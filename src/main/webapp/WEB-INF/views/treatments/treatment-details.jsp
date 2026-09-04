<%@ page language="java"
    contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>

<html lang="en">

<head>

    <meta charset="UTF-8">

    <meta name="viewport"
          content="width=device-width, initial-scale=1.0">

    <title>
        Treatment Details | Sunrise Dental Clinic
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


        <div id="notFound" class="hidden">


            <!-- NOT FOUND -->

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
                        Treatment Not Found
                    </h1>


                    <p class="mt-2 font-inter text-[10px] leading-5 text-slate-400">
                        Treatment information could not be found.
                    </p>


                    <a
                        href="<%= request.getContextPath() %>/treatments"
                        class="mt-6 inline-flex rounded-lg border border-slate-200 bg-white px-5 py-2.5 font-inter text-[10px] font-semibold text-slate-600 transition hover:bg-slate-50"
                    >

                        ← Back to Treatments

                    </a>


                </div>


            </div>


        </div>


        <div id="detailsContent">


            <!-- PAGE HEADER -->

            <div class="mb-7 flex items-center justify-between">


                <div>


                    <p class="mb-1 font-inter text-[10px] font-semibold uppercase tracking-[0.12em] text-slate-400">
                        Treatments
                    </p>


                    <h1 class="text-[25px] font-extrabold tracking-[-0.7px]">
                        Treatment Details
                    </h1>


                    <p class="mt-1 font-inter text-xs text-slate-500">
                        Complete information about this dental treatment.
                    </p>


                </div>



                <!-- TREATMENT ID -->

                <div class="rounded-lg border border-slate-200 bg-white px-4 py-2.5">


                    <p class="font-inter text-[8px] font-semibold uppercase tracking-[0.1em] text-slate-400">
                        Treatment ID
                    </p>


                    <p class="mt-0.5 text-xs font-extrabold text-blue-600">

                        #<span data-treatment-id></span>

                    </p>


                </div>


            </div>



            <!-- SUCCESS -->

            <% if ("1".equals(request.getParameter("updated"))) { %>


                <div class="mb-6 flex items-center gap-3 rounded-xl border border-emerald-100 bg-emerald-50 px-4 py-3">


                    <div class="flex h-7 w-7 items-center justify-center rounded-lg bg-emerald-100">


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


                    <p class="font-inter text-[10px] font-semibold text-emerald-700">
                        Treatment updated successfully.
                    </p>


                </div>


            <% } %>



            <!-- CONTENT -->

            <div class="mx-auto max-w-[900px]">


                <!-- MAIN CARD -->

                <div class="overflow-hidden rounded-xl border border-slate-200 bg-white">


                    <!-- CARD HEADER -->

                    <div class="flex items-center gap-5 border-b border-slate-100 px-7 py-6">


                        <!-- ICON -->

                        <div class="flex h-14 w-14 shrink-0 items-center justify-center rounded-2xl bg-blue-50">


                            <svg
                                class="h-6 w-6 text-blue-600"
                                fill="none"
                                stroke="currentColor"
                                stroke-width="1.6"
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


                        <div class="flex-1">


                            <h2 class="text-lg font-extrabold tracking-[-0.4px]">

                                <span data-treatment-name></span>

                            </h2>


                            <p class="mt-1 font-inter text-[10px] text-slate-400">

                                Treatment #<span data-treatment-id></span>

                            </p>


                        </div>



                        <!-- STATUS -->

                        <span id="headerActive" class="hidden rounded-full bg-emerald-50 px-3 py-1.5 font-inter text-[9px] font-semibold text-emerald-600">

                            Active

                        </span>

                        <span id="headerInactive" class="hidden rounded-full bg-slate-100 px-3 py-1.5 font-inter text-[9px] font-semibold text-slate-500">

                            Inactive

                        </span>


                    </div>



                    <!-- DETAILS -->

                    <div class="grid grid-cols-2">


                        <!-- TREATMENT NAME -->

                        <div class="border-b border-r border-slate-100 px-7 py-5">


                            <p class="font-inter text-[9px] font-semibold uppercase tracking-wide text-slate-400">
                                Treatment Name
                            </p>


                            <p class="mt-2 text-sm font-bold">

                                <span data-treatment-name></span>

                            </p>


                        </div>



                        <!-- FEE -->

                        <div class="border-b border-slate-100 px-7 py-5">


                            <p class="font-inter text-[9px] font-semibold uppercase tracking-wide text-slate-400">
                                Treatment Fee
                            </p>


                            <p class="mt-2 text-sm font-extrabold text-blue-600">

                                LKR

                                <span data-treatment-fee></span>

                            </p>


                        </div>



                        <!-- DESCRIPTION -->

                        <div class="col-span-2 border-b border-slate-100 px-7 py-6">


                            <p class="font-inter text-[9px] font-semibold uppercase tracking-wide text-slate-400">
                                Description
                            </p>


                            <p class="mt-2 max-w-[750px] text-sm leading-7 text-slate-600">


                                <span data-treatment-description></span>


                            </p>


                        </div>



                        <!-- STATUS -->

                        <div class="border-r border-slate-100 px-7 py-5">


                            <p class="font-inter text-[9px] font-semibold uppercase tracking-wide text-slate-400">
                                Status
                            </p>


                            <div class="mt-2">


                                <span id="statusActive" class="hidden inline-flex items-center gap-2 rounded-full bg-emerald-50 px-3 py-1.5 font-inter text-[9px] font-semibold text-emerald-600">

                                    <span class="h-1.5 w-1.5 rounded-full bg-emerald-500"></span>

                                    Active

                                </span>

                                <span id="statusInactive" class="hidden inline-flex items-center gap-2 rounded-full bg-slate-100 px-3 py-1.5 font-inter text-[9px] font-semibold text-slate-500">

                                    <span class="h-1.5 w-1.5 rounded-full bg-slate-400"></span>

                                    Inactive

                                </span>


                            </div>


                        </div>



                        <!-- ID -->

                        <div class="px-7 py-5">


                            <p class="font-inter text-[9px] font-semibold uppercase tracking-wide text-slate-400">
                                Treatment ID
                            </p>


                            <p class="mt-2 text-sm font-bold">

                                #<span data-treatment-id></span>

                            </p>


                        </div>


                    </div>


                </div>



                <!-- SUMMARY -->

                <div class="mt-5 grid grid-cols-2 gap-4">


                    <!-- FEE CARD -->

                    <div class="rounded-xl border border-slate-200 bg-white p-5">


                        <div class="mb-3 flex h-9 w-9 items-center justify-center rounded-lg bg-blue-50">


                            <svg
                                class="h-4 w-4 text-blue-600"
                                fill="none"
                                stroke="currentColor"
                                stroke-width="1.7"
                                viewBox="0 0 24 24"
                            >

                                <path
                                    stroke-linecap="round"
                                    d="M12 1v22M17 5H9.5a3.5 3.5 0 000 7h5a3.5 3.5 0 010 7H7"
                                />

                            </svg>


                        </div>


                        <p class="font-inter text-[9px] text-slate-400">
                            Treatment Fee
                        </p>


                        <p class="mt-1 text-base font-extrabold">

                            LKR

                            <span data-treatment-fee></span>

                        </p>


                    </div>



                    <!-- STATUS CARD -->

                    <div class="rounded-xl border border-slate-200 bg-white p-5">


                        <div class="mb-3 flex h-9 w-9 items-center justify-center rounded-lg bg-emerald-50">


                            <svg
                                class="h-4 w-4 text-emerald-600"
                                fill="none"
                                stroke="currentColor"
                                stroke-width="1.7"
                                viewBox="0 0 24 24"
                            >

                                <path
                                    stroke-linecap="round"
                                    stroke-linejoin="round"
                                    d="M5 12l4 4L19 6"
                                />

                            </svg>


                        </div>


                        <p class="font-inter text-[9px] text-slate-400">
                            Current Status
                        </p>


                        <p class="mt-1 text-sm font-extrabold">


                            <span data-current-status></span>


                        </p>


                    </div>


                </div>



                <!-- ACTIONS -->

                <div class="mt-6 flex items-center justify-between">


                    <a
                        href="<%= request.getContextPath() %>/treatments"
                        class="flex items-center gap-2 rounded-lg border border-slate-200 bg-white px-4 py-2.5 font-inter text-[10px] font-semibold text-slate-600 transition hover:bg-slate-50"
                    >

                        ← Back to Treatments

                    </a>



                    <a
                        id="editTreatmentLink" href="#"
                        class="inline-flex items-center gap-2 rounded-lg bg-[#2563EB] px-5 py-2.5 font-inter text-[10px] font-bold text-white shadow-sm transition hover:bg-[#1D4ED8]"
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

                        Edit Treatment

                    </a>


                </div>


            </div>



            <!-- FOOTER -->

            <div class="mt-8 flex items-center justify-between px-1">


                <p class="font-inter text-[9px] text-slate-400">
                    Sunrise Dental Clinic
                </p>


                <p class="font-inter text-[9px] text-slate-400">
                    Treatment Management
                </p>


            </div>


        </div>


    </main>


</div>



<script>
(function () {
    var params = new URLSearchParams(window.location.search);
    var id = params.get("id") || params.get("treatmentId");
    var apiBase = "<%= request.getContextPath() %>/api/treatments";

    var notFound = document.getElementById("notFound");
    var detailsContent = document.getElementById("detailsContent");

    function setText(selector, value) {
        var elements = document.querySelectorAll(selector);
        elements.forEach(function (element) {
            element.textContent = value == null ? "" : value;
        });
    }

    function showStatus(active) {
        var headerActive = document.getElementById("headerActive");
        var headerInactive = document.getElementById("headerInactive");
        var statusActive = document.getElementById("statusActive");
        var statusInactive = document.getElementById("statusInactive");
        var currentStatus = document.querySelector("[data-current-status]");

        if (active === true) {
            headerActive.classList.remove("hidden");
            headerInactive.classList.add("hidden");
            statusActive.classList.remove("hidden");
            statusInactive.classList.add("hidden");
            currentStatus.textContent = "Active";
        } else {
            headerActive.classList.add("hidden");
            headerInactive.classList.remove("hidden");
            statusActive.classList.add("hidden");
            statusInactive.classList.remove("hidden");
            currentStatus.textContent = "Inactive";
        }
    }

    function showNotFound() {
        detailsContent.classList.add("hidden");
        notFound.classList.remove("hidden");
    }

    if (!id) {
        showNotFound();
        return;
    }

    fetch(apiBase + "/" + encodeURIComponent(id), {
        method: "GET",
        headers: { "Accept": "application/json" }
    })
    .then(function (response) {
        if (!response.ok) {
            throw new Error("Treatment not found");
        }
        return response.json();
    })
    .then(function (item) {
        setText("[data-treatment-id]", item.treatmentId);
        setText("[data-treatment-name]", item.treatmentName);
        setText("[data-treatment-fee]", Number(item.treatmentFee || 0).toFixed(2));
        setText("[data-treatment-description]", item.description && item.description.trim() ? item.description : "No description provided.");
        showStatus(item.active === true);

        var editLink = document.getElementById("editTreatmentLink");
        if (editLink) {
            editLink.href = "<%= request.getContextPath() %>/treatments/edit?id=" + encodeURIComponent(item.treatmentId);
        }
    })
    .catch(function () {
        showNotFound();
    });
})();
</script>

</body>

</html>