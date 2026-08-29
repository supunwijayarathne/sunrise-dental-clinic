<%@ page contentType="text/html;charset=UTF-8" %>

<%@ page import="com.sunrise.model.Bill" %>
<%@ page import="com.sunrise.model.Patient" %>
<%@ page import="com.sunrise.model.Treatment" %>
<%@ page import="com.sunrise.model.Appointment" %>
<%@ page import="com.sunrise.model.Dentist" %>

<%
    Bill bill =
        (Bill) request.getAttribute("bill");

    Patient patient =
        (Patient) request.getAttribute("patient");

    Treatment treatment =
        (Treatment) request.getAttribute("treatment");

    Appointment appointment =
        (Appointment) request.getAttribute("appointment");

    Dentist dentist =
        (Dentist) request.getAttribute("dentist");
%>

<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="UTF-8">

    <meta
        name="viewport"
        content="width=device-width, initial-scale=1.0">

    <title>
        <%= bill.getBillNumber() %> | Sunrise Dental
    </title>


    <!-- =====================================================
         FONTS
    ====================================================== -->

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

        * {
            box-sizing: border-box;
        }


        body {
            margin: 0;
            padding: 40px 20px;
            background: #F5F7FB;
            color: #172033;
            font-family: 'Inter', sans-serif;
        }


        .font-manrope {
            font-family: 'Manrope', sans-serif;
        }


        .font-inter {
            font-family: 'Inter', sans-serif;
        }


        /* =====================================================
           PRINT BUTTON
        ====================================================== */

        .print-button {
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 8px;

            margin: 0 auto 20px;

            padding: 11px 18px;

            background: #2563EB;
            color: #FFFFFF;

            border: none;
            border-radius: 8px;

            font-family: 'Inter', sans-serif;
            font-size: 12px;
            font-weight: 700;

            cursor: pointer;

            transition:
                background 0.2s ease,
                transform 0.2s ease;
        }


        .print-button:hover {
            background: #1D4ED8;
        }


        /* =====================================================
           RECEIPT
        ====================================================== */

        .receipt {
            width: 100%;
            max-width: 760px;

            margin: 0 auto;

            background: #FFFFFF;

            border: 1px solid #E2E8F0;
            border-radius: 12px;

            padding: 42px;

            box-shadow:
                0 4px 20px rgba(15, 23, 42, 0.06);
        }


        /* =====================================================
           HEADER
        ====================================================== */

        .header {
            display: flex;
            align-items: flex-start;
            justify-content: space-between;

            padding-bottom: 24px;

            border-bottom: 1px solid #E5E7EB;
        }


        .brand {
            font-family: 'Manrope', sans-serif;
            font-size: 23px;
            font-weight: 800;
            letter-spacing: -0.02em;

            color: #172033;
        }


        .subtitle {
            margin-top: 5px;

            font-family: 'Inter', sans-serif;
            font-size: 11px;
            font-weight: 500;

            color: #64748B;
        }


        .bill-number {
            text-align: right;
        }


        .label {
            font-family: 'Inter', sans-serif;
            font-size: 10px;
            font-weight: 600;

            color: #94A3B8;

            text-transform: uppercase;
            letter-spacing: 0.07em;
        }


        .value {
            margin-top: 5px;

            font-family: 'Manrope', sans-serif;
            font-size: 14px;
            font-weight: 800;

            color: #172033;
        }


        /* =====================================================
           SECTIONS
        ====================================================== */

        .section {
            margin-top: 28px;
        }


        .section-title {
            margin-bottom: 12px;

            font-family: 'Manrope', sans-serif;
            font-size: 13px;
            font-weight: 800;

            color: #172033;
        }


        /* =====================================================
           INFO GRID
        ====================================================== */

        .info-grid {
            display: grid;

            grid-template-columns: repeat(2, minmax(0, 1fr));

            gap: 12px;
        }


        .info {
            padding: 14px;

            background: #F8FAFC;

            border: 1px solid #F1F5F9;
            border-radius: 8px;
        }


        .info .value {
            margin-top: 5px;

            font-family: 'Manrope', sans-serif;
            font-size: 13px;
            font-weight: 700;

            color: #334155;
        }


        /* =====================================================
           BILL SUMMARY TABLE
        ====================================================== */

        .table {
            width: 100%;

            margin-top: 18px;

            border-collapse: collapse;
        }


        .table th {
            padding: 12px;

            background: #F8FAFC;

            border-bottom: 1px solid #E5E7EB;

            font-family: 'Inter', sans-serif;
            font-size: 10px;
            font-weight: 700;

            color: #64748B;

            text-transform: uppercase;
            letter-spacing: 0.06em;

            text-align: left;
        }


        .table td {
            padding: 14px 12px;

            border-bottom: 1px solid #E5E7EB;

            font-family: 'Inter', sans-serif;
            font-size: 12px;
            font-weight: 500;

            color: #475569;
        }


        .table td.amount {
            font-family: 'Manrope', sans-serif;
            font-weight: 700;

            color: #334155;
        }


        .amount {
            text-align: right;
        }


        /* =====================================================
           TOTAL
        ====================================================== */

        .total {
            display: flex;
            align-items: center;
            justify-content: flex-end;

            gap: 55px;

            margin-top: 20px;
            padding-top: 16px;

            border-top: 1px solid #E5E7EB;
        }


        .total-label {
            font-family: 'Manrope', sans-serif;
            font-size: 16px;
            font-weight: 800;

            color: #172033;
        }


        .total-value {
            font-family: 'Manrope', sans-serif;
            font-size: 19px;
            font-weight: 800;

            color: #2563EB;
        }


        /* =====================================================
           FOOTER
        ====================================================== */

        .footer {
            margin-top: 38px;
            padding-top: 20px;

            border-top: 1px solid #E5E7EB;

            text-align: center;

            font-family: 'Inter', sans-serif;
            font-size: 10px;
            font-weight: 500;

            line-height: 1.7;

            color: #94A3B8;
        }


        /* =====================================================
           RESPONSIVE
        ====================================================== */

        @media (max-width: 640px) {

            body {
                padding: 20px 10px;
            }


            .receipt {
                padding: 25px 20px;
                border-radius: 10px;
            }


            .header {
                flex-direction: column;
                gap: 18px;
            }


            .bill-number {
                text-align: left;
            }


            .info-grid {
                grid-template-columns: 1fr;
            }


            .total {
                gap: 25px;
            }

        }


        /* =====================================================
           PRINT
        ====================================================== */

        @media print {

            body {
                padding: 0;
                background: #FFFFFF;
            }


            .receipt {
                max-width: none;

                margin: 0;

                padding: 30px;

                border: none;
                border-radius: 0;

                box-shadow: none;
            }


            .print-button {
                display: none;
            }

        }

    </style>

</head>


<body>


    <!-- =====================================================
         PRINT BUTTON
    ====================================================== -->

    <button
        type="button"
        class="print-button"
        onclick="window.print()">


        <svg
            width="15"
            height="15"
            viewBox="0 0 24 24"
            fill="none"
            stroke="currentColor"
            stroke-width="1.8"
            stroke-linecap="round"
            stroke-linejoin="round">

            <path d="M6 9V2h12v7"/>

            <path
                d="M6 18H4a2 2 0 0 1-2-2v-5a2 2 0 0 1 2-2h16a2 2 0 0 1 2 2v5a2 2 0 0 1-2 2h-2"/>

            <path d="M6 14h12v8H6z"/>

        </svg>


        Print Bill

    </button>



    <!-- =====================================================
         RECEIPT
    ====================================================== -->

    <div class="receipt">


        <!-- =================================================
             HEADER
        ================================================== -->

        <div class="header">


            <div>

                <div class="brand">
                    Sunrise Dental
                </div>


                <div class="subtitle">
                    Clinic Management System
                </div>

            </div>



            <div class="bill-number">

                <div class="label">
                    Bill Number
                </div>


                <div class="value">
                    <%= bill.getBillNumber() %>
                </div>

            </div>


        </div>



        <!-- =================================================
             PATIENT INFORMATION
        ================================================== -->

        <div class="section">


            <div class="section-title">
                Patient Information
            </div>


            <div class="info-grid">


                <!-- PATIENT -->

                <div class="info">

                    <div class="label">
                        Patient
                    </div>


                    <div class="value">

                        <%= patient != null
                            ? patient.getName()
                            : "Patient #" + bill.getPatientId() %>

                    </div>

                </div>



                <!-- BILL TYPE -->

                <div class="info">

                    <div class="label">
                        Bill Type
                    </div>


                    <div class="value">

                        <%= "WALK_IN".equals(
                                bill.getBillType())
                            ? "Walk-in / Custom"
                            : "Appointment" %>

                    </div>

                </div>


            </div>

        </div>



        <!-- =================================================
             APPOINTMENT INFORMATION
        ================================================== -->

        <% if (appointment != null) { %>


        <div class="section">


            <div class="section-title">
                Appointment Information
            </div>


            <div class="info-grid">


                <!-- APPOINTMENT -->

                <div class="info">

                    <div class="label">
                        Appointment
                    </div>


                    <div class="value">
                        <%= appointment.getAppointmentNumber() %>
                    </div>

                </div>



                <!-- DENTIST -->

                <div class="info">

                    <div class="label">
                        Dentist
                    </div>


                    <div class="value">

                        <%= dentist != null
                            ? dentist.getDentistName()
                            : "Not available" %>

                    </div>

                </div>


            </div>

        </div>


        <% } %>



        <!-- =================================================
             BILL SUMMARY
        ================================================== -->

        <div class="section">


            <div class="section-title">
                Bill Summary
            </div>


            <table class="table">


                <thead>

                    <tr>

                        <th>
                            Description
                        </th>

                        <th class="amount">
                            Amount
                        </th>

                    </tr>

                </thead>


                <tbody>


                    <!-- CONSULTATION -->

                    <tr>

                        <td>
                            Consultation Fee
                        </td>


                        <td class="amount">

                            LKR
                            <%= String.format(
                                "%.2f",
                                bill.getConsultationFee()
                            ) %>

                        </td>

                    </tr>



                    <!-- TREATMENT -->

                    <tr>

                        <td>

                            <%= treatment != null
                                ? treatment.getTreatmentName()
                                : "Treatment" %>

                        </td>


                        <td class="amount">

                            LKR
                            <%= String.format(
                                "%.2f",
                                bill.getTreatmentFee()
                            ) %>

                        </td>

                    </tr>


                </tbody>

            </table>



            <!-- =================================================
                 TOTAL
            ================================================== -->

            <div class="total">


                <span class="total-label">
                    Total
                </span>


                <span class="total-value">

                    LKR
                    <%= String.format(
                        "%.2f",
                        bill.getTotalAmount()
                    ) %>

                </span>


            </div>


        </div>



        <!-- =================================================
             FOOTER
        ================================================== -->

        <div class="footer">

            Thank you for choosing Sunrise Dental.

            <br>

            This is a computer-generated bill.

        </div>


    </div>


</body>

</html>