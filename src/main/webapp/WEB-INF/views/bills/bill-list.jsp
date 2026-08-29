<%@ page contentType="text/html;charset=UTF-8" %>

<%@ page import="java.util.List" %>
<%@ page import="com.sunrise.model.Bill" %>

<%
    String contextPath = request.getContextPath();

    List<Bill> bills =
        (List<Bill>) request.getAttribute("bills");

    String keyword =
        (String) request.getAttribute("keyword");

    String billType =
        (String) request.getAttribute("billType");

    if (keyword == null) keyword = "";

    if (billType == null || billType.isEmpty()) {
        billType = "ALL";
    }
%>

<!DOCTYPE html>
<html>

<head>

    <meta charset="UTF-8">

    <title>Billing | Sunrise Dental</title>

    <script src="https://cdn.tailwindcss.com"></script>

</head>

<body class="bg-[#f5f7fb]">

    <%
        String currentPage =
            request.getRequestURI()
                .substring(contextPath.length());

        boolean billsActive =
            currentPage.startsWith("/bills");
    %>


    <!-- SIDEBAR -->

    <aside class="fixed left-0 top-0 z-50 flex h-screen w-[250px] flex-col bg-[#111827] px-4 py-6">

        <div class="mb-8 px-3">

            <h1 class="font-manrope text-lg font-extrabold tracking-tight text-white">
                Sunrise Dental
            </h1>

            <p class="mt-1 font-inter text-[10px] font-medium text-slate-500">
                Clinic Management System
            </p>

        </div>


        <div class="mb-6">

            <p class="mb-2 px-3 font-inter text-[10px] font-semibold uppercase tracking-[0.12em] text-slate-500">
                Main Menu
            </p>

            <nav class="space-y-1">

                <a href="<%= contextPath %>/dashboard"
                   class="flex items-center gap-3 rounded-lg px-3 py-2.5 text-[13px] font-semibold text-slate-400 hover:bg-[#1f2937] hover:text-white">

                    Dashboard

                </a>

                <a href="<%= contextPath %>/patients"
                   class="flex items-center gap-3 rounded-lg px-3 py-2.5 text-[13px] font-semibold text-slate-400 hover:bg-[#1f2937] hover:text-white">

                    Patients

                </a>

                <a href="<%= contextPath %>/dentists"
                   class="flex items-center gap-3 rounded-lg px-3 py-2.5 text-[13px] font-semibold text-slate-400 hover:bg-[#1f2937] hover:text-white">

                    Dentists

                </a>

                <a href="<%= contextPath %>/treatments"
                   class="flex items-center gap-3 rounded-lg px-3 py-2.5 text-[13px] font-semibold text-slate-400 hover:bg-[#1f2937] hover:text-white">

                    Treatments

                </a>

                <a href="<%= contextPath %>/appointments"
                   class="flex items-center gap-3 rounded-lg px-3 py-2.5 text-[13px] font-semibold text-slate-400 hover:bg-[#1f2937] hover:text-white">

                    Appointments

                </a>

                <a href="<%= contextPath %>/bills"
                   class="flex items-center gap-3 rounded-lg bg-[#1d4ed8] px-3 py-2.5 text-[13px] font-semibold text-white">

                    Billing

                </a>

            </nav>

        </div>


        <div>

            <p class="mb-2 px-3 font-inter text-[10px] font-semibold uppercase tracking-[0.12em] text-slate-500">
                Management
            </p>

            <nav class="space-y-1">

                <a href="<%= contextPath %>/reports"
                   class="flex items-center gap-3 rounded-lg px-3 py-2.5 text-[13px] font-semibold text-slate-400 hover:bg-[#1f2937] hover:text-white">

                    Reports

                </a>

            </nav>

        </div>


        <div class="mt-auto border-t border-white/[0.06] pt-4">

            <a href="<%= contextPath %>/logout"
               class="flex items-center gap-3 rounded-lg px-3 py-2.5 text-[13px] font-semibold text-slate-400 hover:bg-[#1f2937] hover:text-white">

                Logout

            </a>

        </div>

    </aside>


    <!-- MAIN -->

    <main class="ml-[250px] min-h-screen px-8 py-8">

        <div class="mx-auto max-w-[1200px]">

            <div class="mb-7 flex items-center justify-between">

                <div>

                    <h1 class="text-2xl font-bold text-[#172033]">
                        Billing
                    </h1>

                    <p class="mt-1 text-sm text-slate-500">
                        Manage patient bills and payments
                    </p>

                </div>


                <a href="<%= contextPath %>/bills/add"
                   class="rounded-lg bg-[#2563eb] px-5 py-3 text-sm font-semibold text-white hover:bg-[#1d4ed8]">

                    + Create Bill

                </a>

            </div>


            <!-- SEARCH -->

            <div class="mb-6 rounded-xl bg-white p-5 shadow-sm">

                <form method="get"
                      action="<%= contextPath %>/bills"
                      class="flex flex-col gap-3 md:flex-row">

                    <input type="text"
                           name="keyword"
                           value="<%= keyword %>"
                           placeholder="Search bill number, patient, appointment..."
                           class="flex-1 rounded-lg border border-slate-200 px-4 py-3 text-sm outline-none focus:border-[#2563eb]">


                    <select name="billType"
                            class="rounded-lg border border-slate-200 px-4 py-3 text-sm outline-none focus:border-[#2563eb]">

                        <option value="ALL"
                            <%= "ALL".equalsIgnoreCase(billType) ? "selected" : "" %>>
                            All Bills
                        </option>

                        <option value="APPOINTMENT"
                            <%= "APPOINTMENT".equalsIgnoreCase(billType) ? "selected" : "" %>>
                            Appointment Bills
                        </option>

                        <option value="WALK_IN"
                            <%= "WALK_IN".equalsIgnoreCase(billType) ? "selected" : "" %>>
                            Walk-in Bills
                        </option>

                    </select>


                    <button type="submit"
                            class="rounded-lg bg-[#2563eb] px-6 py-3 text-sm font-semibold text-white hover:bg-[#1d4ed8]">

                        Search

                    </button>


                    <a href="<%= contextPath %>/bills"
                       class="rounded-lg bg-slate-200 px-5 py-3 text-center text-sm font-semibold text-slate-700 hover:bg-slate-300">

                        Clear

                    </a>

                </form>

            </div>


            <!-- TABLE -->

            <div class="overflow-hidden rounded-xl bg-white shadow-sm">

                <div class="border-b border-slate-100 px-6 py-5">

                    <h2 class="text-base font-bold text-[#172033]">
                        Bills
                    </h2>

                    <p class="mt-1 text-xs text-slate-500">
                        <%= bills != null ? bills.size() : 0 %> bill(s) found
                    </p>

                </div>


                <div class="overflow-x-auto">

                    <table class="w-full text-left">

                        <thead class="bg-slate-50">

                            <tr>

                                <th class="px-6 py-4 text-xs font-semibold uppercase tracking-wide text-slate-500">
                                    Bill
                                </th>

                                <th class="px-6 py-4 text-xs font-semibold uppercase tracking-wide text-slate-500">
                                    Patient
                                </th>

                                <th class="px-6 py-4 text-xs font-semibold uppercase tracking-wide text-slate-500">
                                    Type
                                </th>

                                <th class="px-6 py-4 text-xs font-semibold uppercase tracking-wide text-slate-500">
                                    Total
                                </th>

                                <th class="px-6 py-4 text-xs font-semibold uppercase tracking-wide text-slate-500">
                                    Action
                                </th>

                            </tr>

                        </thead>


                        <tbody class="divide-y divide-slate-100">

                            <%
                                if (bills != null && !bills.isEmpty()) {

                                    for (Bill bill : bills) {
                            %>

                            <tr class="hover:bg-slate-50">

                                <td class="px-6 py-4">

                                    <div class="text-sm font-semibold text-slate-800">
                                        <%= bill.getBillNumber() %>
                                    </div>

                                    <div class="mt-1 text-xs text-slate-400">
                                        ID #<%= bill.getBillId() %>
                                    </div>

                                </td>


                                <td class="px-6 py-4">

                                    <div class="text-sm text-slate-700">
                                        Patient #<%= bill.getPatientId() %>
                                    </div>

                                </td>


                                <td class="px-6 py-4">

                                    <% if ("WALK_IN".equals(bill.getBillType())) { %>

                                        <span class="rounded-full bg-amber-50 px-3 py-1 text-xs font-semibold text-amber-700">
                                            Walk-in
                                        </span>

                                    <% } else { %>

                                        <span class="rounded-full bg-blue-50 px-3 py-1 text-xs font-semibold text-blue-700">
                                            Appointment
                                        </span>

                                    <% } %>

                                </td>


                                <td class="px-6 py-4">

                                    <span class="text-sm font-bold text-slate-800">
                                        LKR <%= String.format("%.2f", bill.getTotalAmount()) %>
                                    </span>

                                </td>


                                <td class="px-6 py-4">

                                    <a href="<%= contextPath %>/bills/view?id=<%= bill.getBillId() %>"
                                       class="rounded-lg bg-slate-100 px-4 py-2 text-xs font-semibold text-slate-700 hover:bg-slate-200">

                                        View

                                    </a>

                                </td>

                            </tr>

                            <%
                                    }

                                } else {
                            %>

                            <tr>

                                <td colspan="5"
                                    class="px-6 py-14 text-center">

                                    <div class="text-sm font-semibold text-slate-700">
                                        No bills found
                                    </div>

                                    <div class="mt-1 text-xs text-slate-400">
                                        Try changing your search or create a new bill.
                                    </div>

                                </td>

                            </tr>

                            <%
                                }
                            %>

                        </tbody>

                    </table>

                </div>

            </div>

        </div>

    </main>

</body>

</html>