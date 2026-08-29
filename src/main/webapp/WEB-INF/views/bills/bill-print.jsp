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
<html>

<head>

    <meta charset="UTF-8">

    <title><%= bill.getBillNumber() %></title>

    <style>

        * {
            box-sizing: border-box;
        }

        body {

            margin: 0;

            padding: 40px;

            font-family: Arial, sans-serif;

            background: #f5f7fb;

            color: #172033;
        }

        .receipt {

            max-width: 760px;

            margin: auto;

            background: white;

            padding: 45px;

            border-radius: 12px;

            box-shadow:
                0 4px 20px rgba(0,0,0,0.06);
        }

        .header {

            display: flex;

            justify-content: space-between;

            border-bottom: 1px solid #e5e7eb;

            padding-bottom: 25px;
        }

        .brand {

            font-size: 24px;

            font-weight: bold;
        }

        .subtitle {

            margin-top: 5px;

            color: #64748b;

            font-size: 12px;
        }

        .bill-number {

            text-align: right;
        }

        .label {

            font-size: 11px;

            color: #94a3b8;

            text-transform: uppercase;
        }

        .value {

            margin-top: 5px;

            font-size: 14px;

            font-weight: bold;
        }

        .section {

            margin-top: 30px;
        }

        .section-title {

            margin-bottom: 12px;

            font-size: 13px;

            font-weight: bold;
        }

        .info-grid {

            display: grid;

            grid-template-columns: 1fr 1fr;

            gap: 12px;
        }

        .info {

            background: #f8fafc;

            padding: 14px;

            border-radius: 8px;
        }

        .table {

            width: 100%;

            margin-top: 20px;

            border-collapse: collapse;
        }

        .table th {

            text-align: left;

            background: #f8fafc;

            padding: 12px;

            font-size: 12px;

            color: #64748b;
        }

        .table td {

            padding: 14px 12px;

            border-bottom: 1px solid #e5e7eb;

            font-size: 13px;
        }

        .amount {

            text-align: right;
        }

        .total {

            margin-top: 20px;

            display: flex;

            justify-content: flex-end;

            gap: 50px;

            font-size: 18px;

            font-weight: bold;
        }

        .footer {

            margin-top: 40px;

            padding-top: 20px;

            border-top: 1px solid #e5e7eb;

            text-align: center;

            color: #94a3b8;

            font-size: 11px;
        }

        .print-button {

            display: block;

            margin: 20px auto;

            padding: 12px 20px;

            background: #2563eb;

            color: white;

            border: none;

            border-radius: 8px;

            cursor: pointer;
        }

        @media print {

            body {

                padding: 0;

                background: white;
            }

            .receipt {

                box-shadow: none;

                max-width: none;

                border-radius: 0;
            }

            .print-button {

                display: none;
            }
        }

    </style>

</head>

<body>

    <button class="print-button"
            onclick="window.print()">

        Print Bill

    </button>


    <div class="receipt">


        <!-- HEADER -->

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


        <!-- PATIENT -->

        <div class="section">

            <div class="section-title">
                Patient Information
            </div>


            <div class="info-grid">

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


        <!-- APPOINTMENT -->

        <% if (appointment != null) { %>

        <div class="section">

            <div class="section-title">
                Appointment Information
            </div>


            <div class="info-grid">

                <div class="info">

                    <div class="label">
                        Appointment
                    </div>

                    <div class="value">
                        <%= appointment.getAppointmentNumber() %>
                    </div>

                </div>


                <div class="info">

<div class="info">

    <p class="text-xs text-slate-400">
        Dentist
    </p>

    <p class="mt-1 text-sm font-semibold text-slate-800">

        <%= dentist != null
            ? dentist.getDentistName()
            : "Not available" %>

    </p>

</div>

            </div>

        </div>

        <% } %>


        <!-- BILL ITEMS -->

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


            <div class="total">

                <span>
                    Total
                </span>

                <span>

                    LKR
                    <%= String.format(
                        "%.2f",
                        bill.getTotalAmount()
                    ) %>

                </span>

            </div>

        </div>


        <!-- FOOTER -->

        <div class="footer">

            Thank you for choosing Sunrise Dental.

            <br>

            This is a computer-generated bill.

        </div>


    </div>

</body>

</html>