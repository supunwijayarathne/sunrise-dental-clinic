<%@ page contentType="text/html;charset=UTF-8" %>



<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="UTF-8">

    <meta
        name="viewport"
        content="width=device-width, initial-scale=1.0">

    <title>Bill | Sunrise Dental</title>


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

<button type="button" class="print-button" onclick="window.print()">
    <svg width="15" height="15" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8" stroke-linecap="round" stroke-linejoin="round">
        <path d="M6 9V2h12v7"/>
        <path d="M6 18H4a2 2 0 0 1-2-2v-5a2 2 0 0 1 2-2h16a2 2 0 0 1 2 2v5a2 2 0 0 1-2 2h-2"/>
        <path d="M6 14h12v8H6z"/>
    </svg>
    Print Bill
</button>

<div class="receipt">

    <div class="header">
        <div>
            <div class="brand">Sunrise Dental</div>
            <div class="subtitle">Clinic Management System</div>
        </div>

        <div class="bill-number">
            <div class="label">Bill Number</div>
            <div id="billNumber" class="value">Loading...</div>
        </div>
    </div>

    <div class="section">
        <div class="section-title">Patient Information</div>

        <div class="info-grid">
            <div class="info">
                <div class="label">Patient</div>
                <div id="patientName" class="value">Loading...</div>
            </div>

            <div class="info">
                <div class="label">Bill Type</div>
                <div id="billType" class="value">-</div>
            </div>
        </div>
    </div>

    <div id="appointmentSection" class="section hidden-print-section" style="display:none;">
        <div class="section-title">Appointment Information</div>

        <div class="info-grid">
            <div class="info">
                <div class="label">Appointment</div>
                <div id="appointmentNumber" class="value">-</div>
            </div>

            <div class="info">
                <div class="label">Dentist</div>
                <div id="dentistName" class="value">-</div>
            </div>
        </div>
    </div>

    <div class="section">
        <div class="section-title">Bill Summary</div>

        <table class="table">
            <thead>
                <tr>
                    <th>Description</th>
                    <th class="amount">Amount</th>
                </tr>
            </thead>

            <tbody>
                <tr>
                    <td>Consultation Fee</td>
                    <td id="consultationFee" class="amount">LKR 0.00</td>
                </tr>

                <tr>
                    <td id="treatmentName">Treatment</td>
                    <td id="treatmentFee" class="amount">LKR 0.00</td>
                </tr>
            </tbody>
        </table>

        <div class="total">
            <span class="total-label">Total</span>
            <span id="totalAmount" class="total-value">LKR 0.00</span>
        </div>
    </div>

    <div class="footer">
        Thank you for choosing Sunrise Dental.
        <br>
        This is a computer-generated bill.
    </div>

</div>

<script>
(function () {
    "use strict";

    var contextPath = "<%= request.getContextPath() %>";
    var params = new URLSearchParams(window.location.search);
    var billId = params.get("id") || params.get("billId") || "";

    function setText(id, value) {
        var el = document.getElementById(id);
        if (el) {
            el.textContent = value == null || value === "" ? "N/A" : String(value);
        }
    }

    function money(value) {
        var n = Number(value);
        return isNaN(n) ? "LKR 0.00" : "LKR " + n.toFixed(2);
    }

    function getJson(url) {
        return fetch(contextPath + url, {
            credentials: "same-origin",
            headers: { "Accept": "application/json" }
        }).then(function (response) {
            if (!response.ok) {
                throw new Error("Unable to load billing information.");
            }
            return response.json();
        });
    }

    if (!billId) {
        setText("billNumber", "Bill not found");
        return;
    }

    getJson("/api/billing/" + encodeURIComponent(billId))
        .then(function (bill) {
            setText("billNumber", bill.billNumber);
            setText("consultationFee", money(bill.consultationFee));
            setText("treatmentFee", money(bill.treatmentFee));
            setText("totalAmount", money(bill.totalAmount));

            var type = String(bill.billType || "").toUpperCase();

            if (type === "WALK_IN") {
                setText("billType", "Walk-in / Custom");
            } else {
                setText("billType", "Appointment");
                document.getElementById("appointmentSection").style.display = "block";
            }

            return Promise.all([
                getJson("/api/patients/" + encodeURIComponent(bill.patientId)),
                bill.treatmentId
                    ? getJson("/api/treatments/" + encodeURIComponent(bill.treatmentId))
                    : Promise.resolve(null),
                bill.appointmentId
                    ? getJson("/api/appointments/" + encodeURIComponent(bill.appointmentId))
                    : Promise.resolve(null)
            ]);
        })
        .then(function (data) {
            var patient = data[0];
            var treatment = data[1];
            var appointment = data[2];

            setText("patientName", patient && (patient.name || patient.fullName || patient.patientName));

            if (treatment) {
                setText("treatmentName", treatment.treatmentName || treatment.name);
            }

            if (appointment) {
                setText("appointmentNumber", appointment.appointmentNumber);

                if (appointment.dentistId) {
                    return getJson("/api/dentists/" + encodeURIComponent(appointment.dentistId))
                        .then(function (dentist) {
                            setText("dentistName", dentist && (dentist.dentistName || dentist.name));
                        });
                }
            }
        })
        .catch(function (error) {
            console.error("Could not load printable bill:", error);
            setText("billNumber", "Unable to load bill");
        });
})();
</script>

</body>
</html>