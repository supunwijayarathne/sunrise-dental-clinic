<%@ page language="java"
    contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="UTF-8">

    <meta name="viewport"
          content="width=device-width, initial-scale=1.0">

    <title>Web Services | Sunrise Dental Clinic</title>


    <style>

        /* =====================================================
           RESET
        ===================================================== */

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }


        body {

            font-family:
                "Segoe UI",
                Arial,
                sans-serif;

            background: #f5f7fb;

            color: #172033;

            min-height: 100vh;

        }


        button,
        input {

            font-family: inherit;

        }


        /* =====================================================
           LAYOUT
        ===================================================== */

        .layout {

            display: flex;

            min-height: 100vh;

        }


        /* =====================================================
           SIDEBAR
        ===================================================== */

        .sidebar {

            width: 250px;

            background: #ffffff;

            border-right: 1px solid #e5e7eb;

            padding: 24px 16px;

            position: fixed;

            top: 0;
            bottom: 0;
            left: 0;

            overflow-y: auto;

        }


        .brand {

            display: flex;

            align-items: center;

            gap: 12px;

            padding: 4px 10px 28px;

        }


        .brand-logo {

            width: 42px;
            height: 42px;

            border-radius: 11px;

            background: #2563eb;

            color: #ffffff;

            display: flex;

            align-items: center;

            justify-content: center;

            font-weight: 800;

            font-size: 15px;

        }


        .brand-text h1 {

            font-size: 16px;

            font-weight: 750;

            color: #172033;

        }


        .brand-text p {

            margin-top: 3px;

            font-size: 11px;

            color: #98a2b3;

        }


        .nav-title {

            font-size: 10px;

            font-weight: 700;

            text-transform: uppercase;

            letter-spacing: 0.08em;

            color: #98a2b3;

            padding: 0 11px;

            margin-bottom: 8px;

        }


        .nav-item {

            width: 100%;

            border: none;

            background: transparent;

            color: #667085;

            display: flex;

            align-items: center;

            gap: 11px;

            padding: 11px 12px;

            margin-bottom: 3px;

            border-radius: 8px;

            cursor: pointer;

            text-align: left;

            font-size: 13px;

            transition: 0.2s;

        }


        .nav-item:hover {

            background: #f2f6ff;

            color: #2563eb;

        }


        .nav-item.active {

            background: #eff6ff;

            color: #2563eb;

            font-weight: 650;

        }


        .nav-icon {

            width: 28px;

            height: 28px;

            border-radius: 7px;

            background: #f5f7fa;

            display: flex;

            align-items: center;

            justify-content: center;

            font-size: 13px;

        }


        .nav-item.active .nav-icon {

            background: #dbeafe;

        }


        .sidebar-footer {

            position: absolute;

            bottom: 22px;

            left: 20px;

            right: 20px;

            padding-top: 15px;

            border-top: 1px solid #eef0f3;

        }


        .api-indicator {

            display: flex;

            align-items: center;

            gap: 8px;

            font-size: 11px;

            color: #667085;

        }


        .indicator-dot {

            width: 8px;

            height: 8px;

            border-radius: 50%;

            background: #9ca3af;

        }


        .indicator-dot.connected {

            background: #22c55e;

        }


        .indicator-dot.error {

            background: #ef4444;

        }


        /* =====================================================
           MAIN
        ===================================================== */

        .main {

            margin-left: 250px;

            width: calc(100% - 250px);

            min-height: 100vh;

        }


        /* =====================================================
           TOP BAR
        ===================================================== */

        .topbar {

            height: 70px;

            background: #ffffff;

            border-bottom: 1px solid #e5e7eb;

            display: flex;

            align-items: center;

            justify-content: space-between;

            padding: 0 32px;

        }


        .topbar-title {

            font-size: 14px;

            color: #667085;

        }


        .topbar-title strong {

            color: #172033;

        }


        .connection {

            display: flex;

            align-items: center;

            gap: 8px;

            font-size: 12px;

            color: #667085;

        }


        .connection-dot {

            width: 8px;

            height: 8px;

            border-radius: 50%;

            background: #9ca3af;

        }


        .connection-dot.online {

            background: #22c55e;

        }


        /* =====================================================
           CONTENT
        ===================================================== */

        .content {

            padding: 32px;

            max-width: 1500px;

            margin: auto;

        }


        .page-heading {

            margin-bottom: 26px;

        }


        .page-heading h2 {

            font-size: 25px;

            font-weight: 750;

            color: #172033;

        }


        .page-heading p {

            color: #667085;

            font-size: 13px;

            margin-top: 7px;

        }


        /* =====================================================
           STAT CARDS
        ===================================================== */

        .stats {

            display: grid;

            grid-template-columns:
                repeat(4, 1fr);

            gap: 15px;

            margin-bottom: 25px;

        }


        .stat-card {

            background: #ffffff;

            border: 1px solid #e6e9ee;

            border-radius: 11px;

            padding: 17px 18px;

        }


        .stat-label {

            font-size: 11px;

            color: #98a2b3;

            margin-bottom: 8px;

        }


        .stat-value {

            font-size: 23px;

            font-weight: 750;

            color: #172033;

        }


        .stat-sub {

            font-size: 11px;

            color: #98a2b3;

            margin-top: 4px;

        }


        /* =====================================================
           SERVICE CARDS
        ===================================================== */

        .section-title {

            font-size: 15px;

            font-weight: 700;

            margin-bottom: 13px;

        }


        .services {

            display: grid;

            grid-template-columns:
                repeat(4, 1fr);

            gap: 15px;

            margin-bottom: 25px;

        }


        .service-card {

            background: #ffffff;

            border: 1px solid #e6e9ee;

            border-radius: 11px;

            padding: 18px;

            transition: 0.2s;

        }


        .service-card:hover {

            border-color: #bfdbfe;

            transform: translateY(-1px);

        }


        .service-top {

            display: flex;

            justify-content: space-between;

            align-items: flex-start;

            margin-bottom: 13px;

        }


        .service-icon {

            width: 38px;

            height: 38px;

            border-radius: 9px;

            background: #eff6ff;

            color: #2563eb;

            display: flex;

            align-items: center;

            justify-content: center;

            font-weight: 750;

            font-size: 12px;

        }


        .service-number {

            font-size: 10px;

            color: #98a2b3;

        }


        .service-card h3 {

            font-size: 14px;

            margin-bottom: 5px;

        }


        .service-card p {

            color: #98a2b3;

            font-size: 11px;

            line-height: 1.5;

            min-height: 33px;

            margin-bottom: 13px;

        }


        .endpoint {

            background: #f8fafc;

            border: 1px solid #edf0f4;

            border-radius: 6px;

            padding: 7px 8px;

            font-family: Consolas, monospace;

            color: #667085;

            font-size: 10px;

            margin-bottom: 12px;

            overflow: hidden;

            white-space: nowrap;

            text-overflow: ellipsis;

        }


        .service-button {

            width: 100%;

            border: none;

            background: #2563eb;

            color: #ffffff;

            padding: 9px;

            border-radius: 7px;

            cursor: pointer;

            font-size: 11px;

            font-weight: 650;

        }


        .service-button:hover {

            background: #1d4ed8;

        }


        /* =====================================================
           SEARCH / FILTER
        ===================================================== */

        .tools {

            display: grid;

            grid-template-columns:
                1fr 1fr;

            gap: 15px;

            margin-bottom: 25px;

        }


        .tool-card {

            background: #ffffff;

            border: 1px solid #e6e9ee;

            border-radius: 11px;

            padding: 18px;

        }


        .tool-header {

            display: flex;

            justify-content: space-between;

            align-items: center;

            margin-bottom: 13px;

        }


        .tool-header h3 {

            font-size: 14px;

        }


        .tool-header span {

            font-size: 10px;

            color: #98a2b3;

        }


        .input-row {

            display: flex;

            gap: 8px;

        }


        .input {

            flex: 1;

            min-width: 0;

            height: 36px;

            border: 1px solid #d9dee7;

            border-radius: 7px;

            padding: 0 11px;

            outline: none;

            font-size: 12px;

            color: #172033;

        }


        .input:focus {

            border-color: #2563eb;

        }


        .small-button {

            border: none;

            background: #eff6ff;

            color: #2563eb;

            padding: 0 15px;

            border-radius: 7px;

            font-size: 11px;

            font-weight: 650;

            cursor: pointer;

        }


        .small-button:hover {

            background: #dbeafe;

        }


        /* =====================================================
           REPORT FILTER
        ===================================================== */

        .report-filter {

            background: #ffffff;

            border: 1px solid #e6e9ee;

            border-radius: 11px;

            padding: 18px;

            margin-bottom: 25px;

        }


        .report-row {

            display: flex;

            align-items: flex-end;

            gap: 10px;

            flex-wrap: wrap;

        }


        .date-field {

            display: flex;

            flex-direction: column;

            gap: 6px;

        }


        .date-field label {

            font-size: 10px;

            color: #667085;

            font-weight: 650;

        }


        .date-field input {

            height: 35px;

            border: 1px solid #d9dee7;

            border-radius: 7px;

            padding: 0 10px;

            font-size: 11px;

        }


        /* =====================================================
           RESULT
        ===================================================== */

        .result-card {

            background: #ffffff;

            border: 1px solid #e6e9ee;

            border-radius: 11px;

            overflow: hidden;

            margin-bottom: 22px;

        }


        .result-header {

            padding: 17px 20px;

            border-bottom: 1px solid #edf0f4;

            display: flex;

            justify-content: space-between;

            align-items: center;

        }


        .result-heading {

            display: flex;

            align-items: center;

            gap: 10px;

        }


        .result-heading h3 {

            font-size: 14px;

        }


        .result-url {

            font-family: Consolas, monospace;

            color: #98a2b3;

            font-size: 10px;

            margin-top: 4px;

        }


        .status-badge {

            padding: 5px 9px;

            border-radius: 20px;

            background: #f2f4f7;

            color: #667085;

            font-size: 10px;

            font-weight: 650;

        }


        .status-badge.success {

            background: #dcfce7;

            color: #15803d;

        }


        .status-badge.error {

            background: #fee2e2;

            color: #b91c1c;

        }


        /* =====================================================
           TABLE
        ===================================================== */

        .table-wrapper {

            width: 100%;

            overflow-x: auto;

        }


        table {

            width: 100%;

            border-collapse: collapse;

            min-width: 750px;

        }


        th {

            background: #f8fafc;

            color: #667085;

            font-size: 10px;

            text-align: left;

            padding: 12px 15px;

            border-bottom: 1px solid #e5e7eb;

            white-space: nowrap;

            font-weight: 700;

        }


        td {

            padding: 12px 15px;

            border-bottom: 1px solid #f1f3f6;

            font-size: 11px;

            color: #344054;

            white-space: nowrap;

        }


        tr:last-child td {

            border-bottom: none;

        }


        tr:hover td {

            background: #fafbfc;

        }


        .id-text {

            color: #2563eb;

            font-weight: 650;

        }


        .badge {

            display: inline-block;

            padding: 4px 8px;

            background: #eff6ff;

            color: #2563eb;

            border-radius: 20px;

            font-size: 9px;

            font-weight: 650;

        }


        .empty {

            padding: 55px 20px;

            text-align: center;

            color: #98a2b3;

            font-size: 12px;

        }


        .loading {

            padding: 55px 20px;

            text-align: center;

            color: #667085;

            font-size: 12px;

        }


        .error-box {

            margin: 18px;

            padding: 14px;

            border-radius: 8px;

            background: #fff5f5;

            border: 1px solid #fecaca;

            color: #b91c1c;

            font-size: 11px;

            line-height: 1.6;

        }


        /* =====================================================
           RAW JSON
        ===================================================== */

        .json-toggle {

            width: 100%;

            border: none;

            background: transparent;

            cursor: pointer;

            text-align: left;

        }


        .json-container {

            display: none;

        }


        .json-container.show {

            display: block;

        }


        pre {

            background: #111827;

            color: #d1d5db;

            padding: 20px;

            overflow-x: auto;

            max-height: 400px;

            font-family: Consolas, monospace;

            font-size: 10px;

            line-height: 1.6;

        }


        /* =====================================================
           FOOTER
        ===================================================== */

        .footer {

            text-align: center;

            color: #98a2b3;

            font-size: 10px;

            padding: 20px;

        }


        /* =====================================================
           RESPONSIVE
        ===================================================== */

        @media(max-width: 1100px) {

            .services {

                grid-template-columns:
                    repeat(2, 1fr);

            }

            .stats {

                grid-template-columns:
                    repeat(2, 1fr);

            }

        }


        @media(max-width: 800px) {

            .sidebar {

                width: 70px;

                padding: 20px 9px;

            }

            .brand-text,
            .nav-title,
            .nav-text,
            .sidebar-footer {

                display: none;

            }

            .brand {

                justify-content: center;

                padding-bottom: 25px;

            }

            .nav-item {

                justify-content: center;

                padding: 10px;

            }

            .main {

                margin-left: 70px;

                width: calc(100% - 70px);

            }

            .content {

                padding: 20px;

            }

            .tools {

                grid-template-columns: 1fr;

            }

        }


        @media(max-width: 550px) {

            .services,
            .stats {

                grid-template-columns: 1fr;

            }

            .topbar {

                padding: 0 18px;

            }

        }

    </style>

</head>


<body>


<div class="layout">


    <!-- =====================================================
         SIDEBAR
    ====================================================== -->

    <aside class="sidebar">


        <div class="brand">

            <div class="brand-logo">
                SD
            </div>

            <div class="brand-text">

                <h1>Sunrise Dental</h1>

                <p>Clinic Management System</p>

            </div>

        </div>


        <div class="nav-title">
            Web Services
        </div>


        <button class="nav-item active"
                onclick="loadAppointments()">

            <span class="nav-icon">A</span>

            <span class="nav-text">
                Appointments
            </span>

        </button>


        <button class="nav-item"
                onclick="loadPatients()">

            <span class="nav-icon">P</span>

            <span class="nav-text">
                Patients
            </span>

        </button>


        <button class="nav-item"
                onclick="loadDentists()">

            <span class="nav-icon">D</span>

            <span class="nav-text">
                Dentists
            </span>

        </button>


        <button class="nav-item"
                onclick="loadTreatments()">

            <span class="nav-icon">T</span>

            <span class="nav-text">
                Treatments
            </span>

        </button>


        <button class="nav-item"
                onclick="loadBills()">

            <span class="nav-icon">B</span>

            <span class="nav-text">
                Billing
            </span>

        </button>


        <button class="nav-item"
                onclick="loadSchedules()">

            <span class="nav-icon">S</span>

            <span class="nav-text">
                Schedules
            </span>

        </button>


        <button class="nav-item"
                onclick="loadReport()">

            <span class="nav-icon">R</span>

            <span class="nav-text">
                Reports
            </span>

        </button>


        <div class="sidebar-footer">

            <div class="api-indicator">

                <span id="sidebarDot"
                      class="indicator-dot">
                </span>

                <span id="sidebarStatus">
                    API not tested
                </span>

            </div>

        </div>


    </aside>



    <!-- =====================================================
         MAIN
    ====================================================== -->

    <main class="main">


        <!-- TOP BAR -->

        <header class="topbar">

            <div class="topbar-title">

                Sunrise Dental Clinic
                <span> / </span>

                <strong>
                    Web Services
                </strong>

            </div>


            <div class="connection">

                <span id="connectionDot"
                      class="connection-dot">
                </span>

                <span id="connectionText">
                    Not connected
                </span>

            </div>

        </header>



        <!-- =================================================
             CONTENT
        ================================================== -->

        <section class="content">


            <div class="page-heading">

                <h2>
                    Web Services Dashboard
                </h2>

                <p>
                    Test and consume the RESTful services
                    provided by the Sunrise Dental Clinic system.
                </p>

            </div>



            <!-- =================================================
                 STATS
            ================================================== -->

            <div class="stats">


                <div class="stat-card">

                    <div class="stat-label">
                        AVAILABLE SERVICES
                    </div>

                    <div class="stat-value">
                        7
                    </div>

                    <div class="stat-sub">
                        REST API endpoints
                    </div>

                </div>


                <div class="stat-card">

                    <div class="stat-label">
                        RESPONSE FORMAT
                    </div>

                    <div class="stat-value">
                        JSON
                    </div>

                    <div class="stat-sub">
                        HTTP API response
                    </div>

                </div>


                <div class="stat-card">

                    <div class="stat-label">
                        SERVER
                    </div>

                    <div class="stat-value">
                        Tomcat
                    </div>

                    <div class="stat-sub">
                        Java Servlet web services
                    </div>

                </div>


                <div class="stat-card">

                    <div class="stat-label">
                        DATABASE
                    </div>

                    <div class="stat-value">
                        MySQL
                    </div>

                    <div class="stat-sub">
                        DAO-backed data
                    </div>

                </div>


            </div>



            <!-- =================================================
                 SERVICES
            ================================================== -->

            <div class="section-title">
                Available Services
            </div>


            <div class="services">


                <!-- APPOINTMENTS -->

                <div class="service-card">

                    <div class="service-top">

                        <div class="service-icon">
                            AP
                        </div>

                        <div class="service-number">
                            API 01
                        </div>

                    </div>


                    <h3>
                        Appointments
                    </h3>

                    <p>
                        Retrieve appointment records
                        from the clinic database.
                    </p>


                    <div class="endpoint">
                        GET /api/appointments
                    </div>


                    <button class="service-button"
                            onclick="loadAppointments()">

                        Test Service

                    </button>

                </div>



                <!-- PATIENTS -->

                <div class="service-card">

                    <div class="service-top">

                        <div class="service-icon">
                            PT
                        </div>

                        <div class="service-number">
                            API 02
                        </div>

                    </div>


                    <h3>
                        Patients
                    </h3>

                    <p>
                        Retrieve patient records
                        and perform patient searches.
                    </p>


                    <div class="endpoint">
                        GET /api/patients
                    </div>


                    <button class="service-button"
                            onclick="loadPatients()">

                        Test Service

                    </button>

                </div>



                <!-- DENTISTS -->

                <div class="service-card">

                    <div class="service-top">

                        <div class="service-icon">
                            DR
                        </div>

                        <div class="service-number">
                            API 03
                        </div>

                    </div>


                    <h3>
                        Dentists
                    </h3>

                    <p>
                        Retrieve dentist information
                        and search dentist records.
                    </p>


                    <div class="endpoint">
                        GET /api/dentists
                    </div>


                    <button class="service-button"
                            onclick="loadDentists()">

                        Test Service

                    </button>

                </div>



                <!-- TREATMENTS -->

                <div class="service-card">

                    <div class="service-top">

                        <div class="service-icon">
                            TR
                        </div>

                        <div class="service-number">
                            API 04
                        </div>

                    </div>


                    <h3>
                        Treatments
                    </h3>

                    <p>
                        Retrieve available treatment
                        records and charges.
                    </p>


                    <div class="endpoint">
                        GET /api/treatments
                    </div>


                    <button class="service-button"
                            onclick="loadTreatments()">

                        Test Service

                    </button>

                </div>



                <!-- BILLING -->

                <div class="service-card">

                    <div class="service-top">

                        <div class="service-icon">
                            BL
                        </div>

                        <div class="service-number">
                            API 05
                        </div>

                    </div>


                    <h3>
                        Billing
                    </h3>

                    <p>
                        Retrieve generated billing
                        records and amounts.
                    </p>


                    <div class="endpoint">
                        GET /api/billing
                    </div>


                    <button class="service-button"
                            onclick="loadBills()">

                        Test Service

                    </button>

                </div>



                <!-- SCHEDULE -->

                <div class="service-card">

                    <div class="service-top">

                        <div class="service-icon">
                            SC
                        </div>

                        <div class="service-number">
                            API 06
                        </div>

                    </div>


                    <h3>
                        Dentist Schedules
                    </h3>

                    <p>
                        Retrieve weekly dentist
                        availability schedules.
                    </p>


                    <div class="endpoint">
                        GET /api/schedules
                    </div>


                    <button class="service-button"
                            onclick="loadSchedules()">

                        Test Service

                    </button>

                </div>



                <!-- REPORT -->

                <div class="service-card">

                    <div class="service-top">

                        <div class="service-icon">
                            RP
                        </div>

                        <div class="service-number">
                            API 07
                        </div>

                    </div>


                    <h3>
                        Reports
                    </h3>

                    <p>
                        Retrieve appointment, revenue
                        and treatment statistics.
                    </p>


                    <div class="endpoint">
                        GET /api/reports
                    </div>


                    <button class="service-button"
                            onclick="loadReport()">

                        Test Service

                    </button>

                </div>


            </div>



            <!-- =================================================
                 SEARCH TOOLS
            ================================================== -->

            <div class="section-title">
                API Search
            </div>


            <div class="tools">


                <!-- PATIENT SEARCH -->

                <div class="tool-card">

                    <div class="tool-header">

                        <h3>
                            Patient Search
                        </h3>

                        <span>
                            GET /api/patients
                        </span>

                    </div>


                    <div class="input-row">

                        <input
                            id="patientSearch"
                            class="input"
                            type="text"
                            placeholder="Patient name or code">


                        <button
                            class="small-button"
                            onclick="searchPatients()">

                            Search

                        </button>

                    </div>

                </div>



                <!-- DENTIST SEARCH -->

                <div class="tool-card">

                    <div class="tool-header">

                        <h3>
                            Dentist Search
                        </h3>

                        <span>
                            GET /api/dentists
                        </span>

                    </div>


                    <div class="input-row">

                        <input
                            id="dentistSearch"
                            class="input"
                            type="text"
                            placeholder="Dentist name or specialization">


                        <button
                            class="small-button"
                            onclick="searchDentists()">

                            Search

                        </button>

                    </div>

                </div>


            </div>



            <!-- =================================================
                 REPORT FILTER
            ================================================== -->

            <div class="report-filter">

                <div class="tool-header">

                    <h3>
                        Report Parameters
                    </h3>

                    <span>
                        Optional date range
                    </span>

                </div>


                <div class="report-row">


                    <div class="date-field">

                        <label>
                            START DATE
                        </label>

                        <input
                            type="date"
                            id="startDate">

                    </div>


                    <div class="date-field">

                        <label>
                            END DATE
                        </label>

                        <input
                            type="date"
                            id="endDate">

                    </div>


                    <button
                        class="small-button"
                        style="height:35px;"
                        onclick="loadReport()">

                        Generate Report

                    </button>


                </div>

            </div>



            <!-- =================================================
                 RESULT
            ================================================== -->

            <div class="result-card">


                <div class="result-header">


                    <div class="result-heading">

                        <div>

                            <h3 id="resultTitle">
                                API Response
                            </h3>

                            <div
                                id="resultUrl"
                                class="result-url">

                                Select a service to begin

                            </div>

                        </div>

                    </div>


                    <span
                        id="httpStatus"
                        class="status-badge">

                        Waiting

                    </span>


                </div>


                <div id="resultContainer">

                    <div class="empty">

                        Select one of the web services
                        above to retrieve data.

                    </div>

                </div>


            </div>



            <!-- =================================================
                 RAW JSON
            ================================================== -->

            <div class="result-card">


                <button
                    class="json-toggle"
                    onclick="toggleJson()">


                    <div class="result-header">

                        <div>

                            <h3>
                                Raw JSON Response
                            </h3>

                            <div class="result-url">
                                Actual response returned by the API
                            </div>

                        </div>


                        <span class="status-badge">
                            JSON
                        </span>

                    </div>


                </button>


                <div
                    id="jsonContainer"
                    class="json-container">

                    <pre id="rawJson">
No API request has been made yet.
                    </pre>

                </div>


            </div>



            <div class="footer">

                Sunrise Dental Clinic
                &nbsp; • &nbsp;
                RESTful Web Services
                &nbsp; • &nbsp;
                Java / JSP / Servlet / MySQL

            </div>


        </section>

    </main>

</div>



<script>


/* =========================================================
   BASE URL

   IMPORTANT:
   request.getContextPath() automatically uses your current
   port (8081) and application context.

   Example:
   http://localhost:8081/SunriseDentalClinic
========================================================= */

const BASE_URL =
    "<%= request.getContextPath() %>";



/* =========================================================
   ELEMENTS
========================================================= */

const resultContainer =
    document.getElementById(
        "resultContainer"
    );

const resultTitle =
    document.getElementById(
        "resultTitle"
    );

const resultUrl =
    document.getElementById(
        "resultUrl"
    );

const httpStatus =
    document.getElementById(
        "httpStatus"
    );

const rawJson =
    document.getElementById(
        "rawJson"
    );



/* =========================================================
   GENERIC API REQUEST
========================================================= */

async function callAPI(
    endpoint,
    title,
    renderer
) {


    const url =
        BASE_URL + endpoint;


    resultTitle.innerText =
        title;


    resultUrl.innerText =
        "GET " + url;


    httpStatus.innerText =
        "Loading";


    httpStatus.className =
        "status-badge";


    resultContainer.innerHTML =
        '<div class="loading">' +
        'Calling web service...' +
        '</div>';


    console.log(
        "Calling API:",
        url
    );


    try {


        const response =
            await fetch(
                url,
                {
                    method: "GET",

                    headers: {
                        "Accept":
                            "application/json"
                    }
                }
            );


        console.log(
            "HTTP status:",
            response.status
        );


        const text =
            await response.text();


        console.log(
            "API response:",
            text
        );


        let data;


        try {

            data =
                JSON.parse(text);

        } catch (e) {

            data =
                text;

        }


        httpStatus.innerText =
            "HTTP " +
            response.status;


        if (response.ok) {

            httpStatus.className =
                "status-badge success";


            setConnected();

        } else {

            httpStatus.className =
                "status-badge error";

        }


        rawJson.innerText =
            typeof data === "string"
                ? data
                : JSON.stringify(
                    data,
                    null,
                    4
                );


        if (!response.ok) {


            resultContainer.innerHTML =

                '<div class="error-box">' +

                '<strong>API request failed.</strong>' +

                '<br><br>' +

                escapeHtml(
                    typeof data === "string"
                        ? data
                        : JSON.stringify(data)
                ) +

                '</div>';


            return;

        }


        renderer(data);


    } catch (error) {


        console.error(
            "API ERROR:",
            error
        );


        httpStatus.innerText =
            "Connection Error";


        httpStatus.className =
            "status-badge error";


        resultContainer.innerHTML =

            '<div class="error-box">' +

            '<strong>Unable to connect to the web service.</strong>' +

            '<br><br>' +

            escapeHtml(
                error.message
            ) +

            '<br><br>' +

            '<strong>Requested URL:</strong><br>' +

            escapeHtml(url) +

            '</div>';


        rawJson.innerText =
            error.toString();


        setDisconnected();

    }

}



/* =========================================================
   APPOINTMENTS
========================================================= */

function loadAppointments() {


    activateNav(0);


    callAPI(
        "/api/appointments",
        "Appointments",
        renderGenericTable
    );

}



/* =========================================================
   PATIENTS
========================================================= */

function loadPatients() {


    activateNav(1);


    callAPI(
        "/api/patients",
        "Patients",
        renderGenericTable
    );

}


function searchPatients() {


    const keyword =
        document
            .getElementById(
                "patientSearch"
            )
            .value
            .trim();


    if (!keyword) {

        loadPatients();

        return;

    }


    activateNav(1);


    callAPI(

        "/api/patients?keyword=" +
        encodeURIComponent(keyword),

        "Patient Search",

        renderGenericTable

    );

}



/* =========================================================
   DENTISTS
========================================================= */

function loadDentists() {


    activateNav(2);


    callAPI(
        "/api/dentists",
        "Dentists",
        renderGenericTable
    );

}


function searchDentists() {


    const keyword =
        document
            .getElementById(
                "dentistSearch"
            )
            .value
            .trim();


    if (!keyword) {

        loadDentists();

        return;

    }


    activateNav(2);


    callAPI(

        "/api/dentists?keyword=" +
        encodeURIComponent(keyword),

        "Dentist Search",

        renderGenericTable

    );

}



/* =========================================================
   TREATMENTS
========================================================= */

function loadTreatments() {


    activateNav(3);


    callAPI(
        "/api/treatments",
        "Treatments",
        renderGenericTable
    );

}



/* =========================================================
   BILLING
========================================================= */

function loadBills() {


    activateNav(4);


    callAPI(
        "/api/billing",
        "Billing Records",
        renderGenericTable
    );

}



/* =========================================================
   SCHEDULES
========================================================= */

function loadSchedules() {


    activateNav(5);


    const dentistId =
        prompt(
            "Enter Dentist ID",
            "1"
        );


    if (
        dentistId === null ||
        dentistId.trim() === ""
    ) {

        return;

    }


    callAPI(

        "/api/schedules?dentistId=" +
        encodeURIComponent(
            dentistId
        ),

        "Dentist Schedule",

        renderGenericTable

    );

}



/* =========================================================
   REPORT
========================================================= */

function loadReport() {


    activateNav(6);


    const startDate =
        document
            .getElementById(
                "startDate"
            )
            .value;


    const endDate =
        document
            .getElementById(
                "endDate"
            )
            .value;


    let endpoint =
        "/api/reports";


    if (
        startDate &&
        endDate
    ) {

        endpoint +=

            "?startDate=" +
            encodeURIComponent(
                startDate
            ) +

            "&endDate=" +
            encodeURIComponent(
                endDate
            );

    }


    callAPI(

        endpoint,

        "Management Report",

        renderReport

    );

}



/* =========================================================
   GENERIC TABLE RENDERER

   This is intentionally dynamic.

   Therefore if your API JSON has slightly different field
   names, the dashboard will still display the response.
========================================================= */

function renderGenericTable(data) {


    if (
        data === null ||
        data === undefined
    ) {

        showEmpty(
            "No data returned."
        );

        return;

    }


    /* Object containing an array */

    if (
        !Array.isArray(data) &&
        typeof data === "object"
    ) {


        const possibleArray =
            findArray(data);


        if (possibleArray) {

            renderGenericTable(
                possibleArray
            );

            return;

        }


        renderObjectTable(data);

        return;

    }


    if (
        !Array.isArray(data) ||
        data.length === 0
    ) {

        showEmpty(
            "No records found."
        );

        return;

    }


    const rows =
        data;


    const keys =
        getAllKeys(rows);


    let html =

        '<div class="table-wrapper">' +

        '<table>' +

        '<thead>' +

        '<tr>';


    keys.forEach(
        function(key) {

            html +=
                '<th>' +
                escapeHtml(
                    formatKey(key)
                ) +
                '</th>';

        }
    );


    html +=

        '</tr>' +

        '</thead>' +

        '<tbody>';


    rows.forEach(
        function(row) {

            html += '<tr>';


            keys.forEach(
                function(key) {

                    let value =
                        row[key];


                    if (
                        value === null ||
                        value === undefined
                    ) {

                        value = "-";

                    }


                    if (
                        typeof value ===
                        "object"
                    ) {

                        value =
                            JSON.stringify(
                                value
                            );

                    }


                    html +=

                        '<td>' +

                        escapeHtml(
                            String(value)
                        ) +

                        '</td>';

                }
            );


            html += '</tr>';

        }
    );


    html +=

        '</tbody>' +

        '</table>' +

        '</div>';


    resultContainer.innerHTML =
        html;

}



/* =========================================================
   OBJECT TABLE
========================================================= */

function renderObjectTable(data) {


    const keys =
        Object.keys(data);


    if (keys.length === 0) {

        showEmpty(
            "No data returned."
        );

        return;

    }


    let html =

        '<div class="table-wrapper">' +

        '<table>' +

        '<thead>' +

        '<tr>' +

        '<th>Property</th>' +

        '<th>Value</th>' +

        '</tr>' +

        '</thead>' +

        '<tbody>';


    keys.forEach(
        function(key) {


            let value =
                data[key];


            if (
                value === null ||
                value === undefined
            ) {

                value = "-";

            }


            if (
                typeof value ===
                "object"
            ) {

                value =
                    JSON.stringify(
                        value
                    );

            }


            html +=

                '<tr>' +

                '<td>' +

                '<strong>' +

                escapeHtml(
                    formatKey(key)
                ) +

                '</strong>' +

                '</td>' +

                '<td>' +

                escapeHtml(
                    String(value)
                ) +

                '</td>' +

                '</tr>';

        }
    );


    html +=

        '</tbody>' +

        '</table>' +

        '</div>';


    resultContainer.innerHTML =
        html;

}



/* =========================================================
   REPORT RENDERER

   ReportStats contains:
   - totalBills
   - appointmentBills
   - walkInBills
   - totalAppointments
   - scheduledAppointments
   - completedAppointments
   - cancelledAppointments
   - noShowAppointments
   - billedAppointments
   - totalRevenue
   - appointmentRevenue
   - walkInRevenue
   - bills
   - appointments
   - treatments

   The method below handles both a direct ReportStats object
   and JSON containing nested report arrays.
========================================================= */

function renderReport(data) {


    if (
        !data ||
        typeof data !== "object"
    ) {

        showEmpty(
            "No report data available."
        );

        return;

    }


    let html = '';


    /* Summary metrics */

    const metrics = [

        ["Total Bills", data.totalBills],

        [
            "Appointment Bills",
            data.appointmentBills
        ],

        [
            "Walk-in Bills",
            data.walkInBills
        ],

        [
            "Total Appointments",
            data.totalAppointments
        ],

        [
            "Scheduled Appointments",
            data.scheduledAppointments
        ],

        [
            "Completed Appointments",
            data.completedAppointments
        ],

        [
            "Cancelled Appointments",
            data.cancelledAppointments
        ],

        [
            "No-show Appointments",
            data.noShowAppointments
        ],

        [
            "Billed Appointments",
            data.billedAppointments
        ],

        [
            "Total Revenue",
            data.totalRevenue
        ],

        [
            "Appointment Revenue",
            data.appointmentRevenue
        ],

        [
            "Walk-in Revenue",
            data.walkInRevenue
        ]

    ];


    const availableMetrics =
        metrics.filter(
            function(item) {

                return (
                    item[1] !==
                    undefined
                );

            }
        );


    if (
        availableMetrics.length > 0
    ) {


        html +=

            '<div style="' +
            'padding:20px;' +
            'display:grid;' +
            'grid-template-columns:' +
            'repeat(auto-fit,minmax(160px,1fr));' +
            'gap:12px;">';


        availableMetrics.forEach(
            function(item) {

                html +=

                    '<div style="' +
                    'background:#f8fafc;' +
                    'border:1px solid #edf0f4;' +
                    'border-radius:9px;' +
                    'padding:14px;">' +

                    '<div style="' +
                    'font-size:10px;' +
                    'color:#98a2b3;' +
                    'margin-bottom:7px;">' +

                    escapeHtml(
                        item[0]
                    ) +

                    '</div>' +

                    '<div style="' +
                    'font-size:18px;' +
                    'font-weight:750;' +
                    'color:#172033;">' +

                    escapeHtml(
                        String(item[1])
                    ) +

                    '</div>' +

                    '</div>';

            }
        );


        html += '</div>';

    }


    resultContainer.innerHTML =
        html;


    /* Nested report tables */

    if (
        Array.isArray(
            data.appointments
        )
    ) {

        appendReportTable(
            "Appointment Report",
            data.appointments
        );

    }


    if (
        Array.isArray(
            data.bills
        )
    ) {

        appendReportTable(
            "Billing Report",
            data.bills
        );

    }


    if (
        Array.isArray(
            data.treatments
        )
    ) {

        appendReportTable(
            "Treatment Report",
            data.treatments
        );

    }


    if (
        html === "" &&
        !data.appointments &&
        !data.bills &&
        !data.treatments
    ) {

        renderObjectTable(data);

    }

}



/* =========================================================
   APPEND REPORT TABLE
========================================================= */

function appendReportTable(
    title,
    data
) {


    if (
        !Array.isArray(data) ||
        data.length === 0
    ) {

        return;

    }


    const keys =
        getAllKeys(data);


    let html =

        '<div style="' +
        'border-top:1px solid #edf0f4;' +
        'padding-top:0;">' +

        '<div style="' +
        'padding:17px 20px;' +
        'font-size:13px;' +
        'font-weight:700;">' +

        escapeHtml(title) +

        '</div>' +

        '<div class="table-wrapper">' +

        '<table>' +

        '<thead><tr>';


    keys.forEach(
        function(key) {

            html +=

                '<th>' +

                escapeHtml(
                    formatKey(key)
                ) +

                '</th>';

        }
    );


    html +=
        '</tr></thead><tbody>';


    data.forEach(
        function(row) {

            html += '<tr>';


            keys.forEach(
                function(key) {

                    let value =
                        row[key];


                    if (
                        value === null ||
                        value === undefined
                    ) {

                        value = "-";

                    }


                    if (
                        typeof value ===
                        "object"
                    ) {

                        value =
                            JSON.stringify(
                                value
                            );

                    }


                    html +=

                        '<td>' +

                        escapeHtml(
                            String(value)
                        ) +

                        '</td>';

                }
            );


            html += '</tr>';

        }
    );


    html +=

        '</tbody>' +

        '</table>' +

        '</div>' +

        '</div>';


    resultContainer.insertAdjacentHTML(
        "beforeend",
        html
    );

}



/* =========================================================
   FIND ARRAY INSIDE OBJECT
========================================================= */

function findArray(object) {


    const keys =
        Object.keys(object);


    for (
        let i = 0;
        i < keys.length;
        i++
    ) {


        if (
            Array.isArray(
                object[keys[i]]
            )
        ) {

            return object[keys[i]];

        }

    }


    return null;

}



/* =========================================================
   GET ALL TABLE KEYS
========================================================= */

function getAllKeys(rows) {


    const keySet =
        new Set();


    rows.forEach(
        function(row) {

            if (
                row &&
                typeof row === "object"
            ) {

                Object.keys(row)
                    .forEach(
                        function(key) {

                            keySet.add(
                                key
                            );

                        }
                    );

            }

        }
    );


    return Array.from(
        keySet
    );

}



/* =========================================================
   FORMAT PROPERTY NAME
========================================================= */

function formatKey(key) {


    return key

        .replace(
            /([A-Z])/g,
            " $1"
        )

        .replace(
            /^./,
            function(str) {

                return str.toUpperCase();

            }
        );

}



/* =========================================================
   EMPTY
========================================================= */

function showEmpty(message) {


    resultContainer.innerHTML =

        '<div class="empty">' +

        escapeHtml(message) +

        '</div>';

}



/* =========================================================
   CONNECTION STATUS
========================================================= */

function setConnected() {


    document.getElementById(
        "connectionDot"
    ).className =
        "connection-dot online";


    document.getElementById(
        "connectionText"
    ).innerText =
        "API Connected";


    document.getElementById(
        "sidebarDot"
    ).className =
        "indicator-dot connected";


    document.getElementById(
        "sidebarStatus"
    ).innerText =
        "API connected";

}



function setDisconnected() {


    document.getElementById(
        "connectionDot"
    ).className =
        "connection-dot error";


    document.getElementById(
        "connectionText"
    ).innerText =
        "API Error";


    document.getElementById(
        "sidebarDot"
    ).className =
        "indicator-dot error";


    document.getElementById(
        "sidebarStatus"
    ).innerText =
        "API error";

}



/* =========================================================
   NAVIGATION ACTIVE STATE
========================================================= */

function activateNav(index) {


    const items =
        document.querySelectorAll(
            ".nav-item"
        );


    items.forEach(
        function(item, i) {

            item.classList.toggle(
                "active",
                i === index
            );

        }
    );

}



/* =========================================================
   TOGGLE RAW JSON
========================================================= */

function toggleJson() {


    const container =
        document.getElementById(
            "jsonContainer"
        );


    container.classList.toggle(
        "show"
    );

}



/* =========================================================
   HTML ESCAPE
========================================================= */

function escapeHtml(value) {


    return String(value)

        .replace(
            /&/g,
            "&amp;"
        )

        .replace(
            /</g,
            "&lt;"
        )

        .replace(
            />/g,
            "&gt;"
        )

        .replace(
            /"/g,
            "&quot;"
        )

        .replace(
            /'/g,
            "&#039;"
        );

}



/* =========================================================
   INITIAL TEST
========================================================= */

/*
 * Don't automatically call all seven APIs when the page opens.
 * The user can select the service they want to demonstrate.
 */


</script>


</body>

</html>