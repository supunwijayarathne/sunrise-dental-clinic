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
        Login | Sunrise Dental Clinic
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


    <!-- =====================================================
         LEFT BRAND PANEL
    ====================================================== -->

    <div class="hidden w-[46%] bg-[#111827] lg:flex">


        <div class="flex w-full flex-col justify-between px-14 py-12">


            <!-- =================================================
                 BRAND
            ================================================== -->

            <div>

                <div class="flex items-center gap-3">


                    <!-- Sunrise Logo -->

                    <div
                        class="flex h-10 w-10 shrink-0 items-center justify-center rounded-xl"
                        style="background-color: rgba(255,255,255,0.10);"
                    >

                        <img
                            src="<%= request.getContextPath() %>/assets/images/sunrise-logo.png"
                            alt="Sunrise Dental Logo"
                            class="h-8 w-8 object-contain"
                        />

                    </div>


                    <!-- Brand Name -->

                    <div>

                        <h1
                            class="text-base font-extrabold tracking-[-0.3px] text-white"
                        >
                            Sunrise Dental
                        </h1>

                        <p
                            class="font-inter text-[9px] font-medium text-slate-500"
                        >
                            Clinic Management System
                        </p>

                    </div>


                </div>

            </div>



            <!-- =================================================
                 CENTER MESSAGE
            ================================================== -->

            <div class="max-w-[430px]">


                <h2
                    class="text-[32px] font-extrabold leading-tight tracking-[-1px] text-white"
                >

                    Everything your clinic needs,
                    <span class="text-blue-400">
                        in one place.
                    </span>

                </h2>


                <p
                    class="mt-4 max-w-[380px] font-inter text-[12px] leading-6 text-slate-400"
                >

                    Manage patients, appointments, treatments and billing
                    from a simple and organized clinic management system.

                </p>


            </div>



            <!-- =================================================
                 FOOTER
            ================================================== -->

            <div>

                <p
                    class="font-inter text-[9px] text-slate-600"
                >
                    Sunrise Dental Clinic
                </p>

            </div>


        </div>


    </div>



    <!-- =====================================================
         RIGHT LOGIN AREA
    ====================================================== -->

    <div
        class="flex flex-1 items-center justify-center px-6 py-10 sm:px-10"
    >


        <div class="w-full max-w-[400px]">


            <!-- =================================================
                 MOBILE BRAND
            ================================================== -->

            <div class="mb-10 lg:hidden">


                <div class="flex items-center gap-3">


                    <!-- Sunrise Logo -->

                    <div
                        class="flex h-10 w-10 shrink-0 items-center justify-center rounded-xl"
                        style="background-color: rgba(37,99,235,0.10);"
                    >

                        <img
                            src="<%= request.getContextPath() %>/assets/images/sunrise-logo.png"
                            alt="Sunrise Dental Logo"
                            class="h-8 w-8 object-contain"
                        />

                    </div>


                    <!-- Brand Name -->

                    <div>

                        <h1
                            class="text-base font-extrabold"
                        >
                            Sunrise Dental
                        </h1>

                        <p
                            class="font-inter text-[9px] text-slate-400"
                        >
                            Clinic Management System
                        </p>

                    </div>


                </div>


            </div>



            <!-- =================================================
                 LOGIN CARD
            ================================================== -->

            <div
                class="rounded-2xl border border-slate-200 bg-white p-7 shadow-[0_12px_40px_rgba(15,23,42,0.06)] sm:p-8"
            >


                <!-- =================================================
                     HEADER
                ================================================== -->

                <div class="mb-7">


                    <p
                        class="mb-2 font-inter text-[10px] font-semibold uppercase tracking-[0.12em] text-blue-600"
                    >
                        Staff Portal
                    </p>


                    <h2
                        class="text-[25px] font-extrabold tracking-[-0.7px]"
                    >
                        Welcome back
                    </h2>


                    <p
                        class="mt-1.5 font-inter text-[11px] leading-5 text-slate-500"
                    >
                        Sign in to access the clinic management system.
                    </p>


                </div>



                <!-- =================================================
                     API ERROR MESSAGE
                ================================================== -->

                <div
                    id="loginError"
                    class="mb-5 hidden items-start gap-3 rounded-lg border border-red-100 bg-red-50 px-3.5 py-3"
                >

                    <div
                        class="flex h-5 w-5 shrink-0 items-center justify-center rounded-full bg-red-100 font-inter text-[10px] font-bold text-red-600"
                    >
                        !
                    </div>


                    <p
                        id="loginErrorText"
                        class="font-inter text-[10px] font-medium leading-5 text-red-700"
                    >
                    </p>

                </div>



                <!-- =================================================
                     LOGIN FORM
                ================================================== -->

                <form
                    id="loginForm"
                    class="space-y-5"
                >


                    <!-- =================================================
                         USERNAME
                    ================================================== -->

                    <div>


                        <label
                            for="username"
                            class="mb-1.5 block font-inter text-[10px] font-semibold text-slate-700"
                        >
                            Username
                        </label>


                        <div class="relative">


                            <div
                                class="pointer-events-none absolute inset-y-0 left-3 flex items-center"
                            >

                                <svg
                                    class="h-4 w-4 text-slate-400"
                                    fill="none"
                                    stroke="currentColor"
                                    stroke-width="1.7"
                                    viewBox="0 0 24 24"
                                >

                                    <path
                                        stroke-linecap="round"
                                        stroke-linejoin="round"
                                        d="M20 21a8 8 0 00-16 0M12 13a4 4 0 100-8 4 4 0 000 8z"
                                    />

                                </svg>

                            </div>


                            <input
                                type="text"
                                id="username"
                                name="username"
                                autocomplete="username"
                                required
                                placeholder="Enter your username"
                                class="w-full rounded-lg border border-slate-200 bg-white py-3 pl-10 pr-3 font-inter text-[11px] outline-none transition placeholder:text-slate-400 focus:border-blue-500 focus:ring-4 focus:ring-blue-50"
                            >


                        </div>


                    </div>



                    <!-- =================================================
                         PASSWORD
                    ================================================== -->

                    <div>


                        <label
                            for="password"
                            class="mb-1.5 block font-inter text-[10px] font-semibold text-slate-700"
                        >
                            Password
                        </label>


                        <div class="relative">


                            <div
                                class="pointer-events-none absolute inset-y-0 left-3 flex items-center"
                            >

                                <svg
                                    class="h-4 w-4 text-slate-400"
                                    fill="none"
                                    stroke="currentColor"
                                    stroke-width="1.7"
                                    viewBox="0 0 24 24"
                                >

                                    <rect
                                        x="4"
                                        y="10"
                                        width="16"
                                        height="11"
                                        rx="2"
                                    />

                                    <path
                                        stroke-linecap="round"
                                        d="M8 10V7a4 4 0 018 0v3"
                                    />

                                </svg>

                            </div>


                            <input
                                type="password"
                                id="password"
                                name="password"
                                autocomplete="current-password"
                                required
                                placeholder="Enter your password"
                                class="w-full rounded-lg border border-slate-200 bg-white py-3 pl-10 pr-3 font-inter text-[11px] outline-none transition placeholder:text-slate-400 focus:border-blue-500 focus:ring-4 focus:ring-blue-50"
                            >


                        </div>


                    </div>



                    <!-- =================================================
                         LOGIN BUTTON
                    ================================================== -->

                    <button
                        type="submit"
                        id="loginButton"
                        class="flex w-full items-center justify-center gap-2 rounded-lg bg-[#2563EB] py-3 font-inter text-[11px] font-semibold text-white shadow-sm transition hover:bg-[#1D4ED8] focus:outline-none focus:ring-4 focus:ring-blue-100"
                    >

                        <span id="loginButtonText">
                            Sign In
                        </span>

                        <svg
                            id="loginButtonIcon"
                            class="h-3.5 w-3.5"
                            fill="none"
                            stroke="currentColor"
                            stroke-width="2"
                            viewBox="0 0 24 24"
                        >

                            <path
                                stroke-linecap="round"
                                stroke-linejoin="round"
                                d="M5 12h14M13 6l6 6-6 6"
                            />

                        </svg>

                    </button>


                </form>



                <!-- =================================================
                     SECURITY NOTE
                ================================================== -->

                <div class="mt-6 border-t border-slate-100 pt-5">


                    <div class="flex items-center justify-center gap-2">


                        <svg
                            class="h-3.5 w-3.5 text-slate-400"
                            fill="none"
                            stroke="currentColor"
                            stroke-width="1.6"
                            viewBox="0 0 24 24"
                        >

                            <rect
                                x="5"
                                y="10"
                                width="14"
                                height="11"
                                rx="2"
                            />

                            <path
                                stroke-linecap="round"
                                d="M8 10V7a4 4 0 018 0v3"
                            />

                        </svg>


                        <p
                            class="font-inter text-[9px] text-slate-400"
                        >
                            Authorized clinic staff only
                        </p>


                    </div>


                </div>


            </div>



            <!-- =================================================
                 COPYRIGHT
            ================================================== -->

            <p
                class="mt-5 text-center font-inter text-[9px] text-slate-400"
            >
                © Sunrise Dental Clinic
            </p>


        </div>


    </div>


</div>



<!-- =========================================================
     REST API LOGIN
========================================================== -->

<script>

    const contextPath = "<%= request.getContextPath() %>";

    const loginForm =
        document.getElementById("loginForm");

    const loginError =
        document.getElementById("loginError");

    const loginErrorText =
        document.getElementById("loginErrorText");

    const loginButton =
        document.getElementById("loginButton");

    const loginButtonText =
        document.getElementById("loginButtonText");

    const loginButtonIcon =
        document.getElementById("loginButtonIcon");


    // =========================================================
    // SHOW ERROR
    // =========================================================

    function showLoginError(message) {

        loginErrorText.textContent =
            message;

        loginError.classList.remove("hidden");

        loginError.classList.add("flex");
    }


    // =========================================================
    // HIDE ERROR
    // =========================================================

    function hideLoginError() {

        loginError.classList.add("hidden");

        loginError.classList.remove("flex");

        loginErrorText.textContent = "";
    }


    // =========================================================
    // LOGIN
    // =========================================================

    loginForm.addEventListener(
        "submit",
        async function (event) {

            event.preventDefault();

            hideLoginError();


            const username =
                document.getElementById("username")
                    .value
                    .trim();

            const password =
                document.getElementById("password")
                    .value;


            // -----------------------------------------------------
            // Client-side validation
            // -----------------------------------------------------

            if (!username) {

                showLoginError(
                    "Please enter your username."
                );

                return;
            }


            if (!password) {

                showLoginError(
                    "Please enter your password."
                );

                return;
            }


            // -----------------------------------------------------
            // Disable button
            // -----------------------------------------------------

            loginButton.disabled = true;

            loginButton.classList.add(
                "opacity-70",
                "cursor-not-allowed"
            );

            loginButtonText.textContent =
                "Signing in...";

            loginButtonIcon.classList.add(
                "hidden"
            );


            try {

                // -------------------------------------------------
                // Send login request to REST API
                // -------------------------------------------------

                const response =
                    await fetch(
                        contextPath + "/api/auth/login",
                        {
                            method: "POST",

                            headers: {
                                "Content-Type":
                                    "application/x-www-form-urlencoded"
                            },

                            credentials: "same-origin",

                            body:
                                new URLSearchParams({
                                    username: username,
                                    password: password
                                })
                        }
                    );


                // -------------------------------------------------
                // Read API response
                // -------------------------------------------------

                let data = null;

                try {

                    data =
                        await response.json();

                } catch (jsonError) {

                    data = null;
                }


                // -------------------------------------------------
                // Login failed
                // -------------------------------------------------

                if (!response.ok) {

                    if (
                        data &&
                        data.message
                    ) {

                        showLoginError(
                            data.message
                        );

                    } else {

                        showLoginError(
                            "Invalid username or password."
                        );
                    }

                    return;
                }


                // -------------------------------------------------
                // Check successful response
                // -------------------------------------------------

                if (
                    !data ||
                    data.success !== true ||
                    !data.user
                ) {

                    showLoginError(
                        "Unable to sign in. Please try again."
                    );

                    return;
                }


                const user =
                    data.user;


                // -------------------------------------------------
                // First-login user
                // -------------------------------------------------

                if (
                    user.firstLogin === true
                ) {

                    window.location.href =
                        contextPath + "/help";

                    return;
                }


                // -------------------------------------------------
                // Get user role
                // -------------------------------------------------

                const role =
                    user.role
                        ? user.role
                            .trim()
                            .toUpperCase()
                        : "";


                // -------------------------------------------------
                // Admin dashboard
                // -------------------------------------------------

                if (role === "ADMIN") {

                    window.location.href =
                        contextPath + "/admin/dashboard";

                    return;
                }


                // -------------------------------------------------
                // Receptionist dashboard
                // -------------------------------------------------

                window.location.href =
                    contextPath + "/dashboard";


            } catch (error) {

                console.error(
                    "Login API error:",
                    error
                );

                showLoginError(
                    "Unable to connect to the server. Please try again."
                );

            } finally {

                // -------------------------------------------------
                // Re-enable button
                // -------------------------------------------------

                loginButton.disabled = false;

                loginButton.classList.remove(
                    "opacity-70",
                    "cursor-not-allowed"
                );

                loginButtonText.textContent =
                    "Sign In";

                loginButtonIcon.classList.remove(
                    "hidden"
                );
            }

        }
    );

</script>


</body>

</html>