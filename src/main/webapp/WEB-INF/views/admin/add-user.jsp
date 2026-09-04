<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
    String contextPath = request.getContextPath();
%>

<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="UTF-8">

    <meta name="viewport"
          content="width=device-width, initial-scale=1.0">

    <title>Add User - Sunrise Dental Clinic</title>

    <script src="https://cdn.tailwindcss.com"></script>

    <link rel="preconnect"
          href="https://fonts.googleapis.com">

    <link rel="preconnect"
          href="https://fonts.gstatic.com"
          crossorigin>

    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&family=Manrope:wght@400;500;600;700;800&display=swap"
          rel="stylesheet">

    <style>

        body {
            font-family: 'Manrope', sans-serif;
        }

        .font-inter {
            font-family: 'Inter', sans-serif;
        }

        .font-manrope {
            font-family: 'Manrope', sans-serif;
        }

        input:focus,
        textarea:focus,
        select:focus {
            outline: none;
        }

    </style>

</head>


<body class="min-h-screen bg-[#F5F7FB] font-manrope text-[#172033]">


<div class="flex min-h-screen">


    <!-- =====================================================
         COMMON SIDEBAR
         ===================================================== -->

    <jsp:include page="../common/sidebar.jsp" />


    <!-- =====================================================
         MAIN CONTENT
         ===================================================== -->

    <main class="ml-[250px] min-h-screen flex-1 px-8 py-7">


        <!-- =================================================
             PAGE HEADER
             ================================================= -->

        <div class="mb-7">


            <!-- Breadcrumb -->

            <div class="mb-4 flex items-center gap-2 font-inter text-[11px] font-medium text-slate-400">

                <a
                    href="<%= contextPath %>/admin/users"
                    class="transition hover:text-blue-600">

                    Users

                </a>

                <span>/</span>

                <span class="text-slate-500">
                    Add User
                </span>

            </div>


            <!-- Title -->

            <div class="flex items-end justify-between">

                <div>

                    <h1 class="font-manrope text-2xl font-extrabold tracking-tight text-[#172033]">

                        Add User

                    </h1>

                    <p class="mt-1.5 font-inter text-xs text-slate-500">

                        Create a new user account for the clinic.

                    </p>

                </div>


                <!-- Back button -->

                <a
                    href="<%= contextPath %>/admin/users"

                    class="inline-flex items-center gap-2 rounded-lg border border-slate-200 bg-white px-4 py-2.5 font-inter text-[11px] font-semibold text-slate-600 shadow-sm transition hover:bg-slate-50">

                    <svg
                        class="h-4 w-4"
                        fill="none"
                        stroke="currentColor"
                        stroke-width="1.8"
                        viewBox="0 0 24 24">

                        <path
                            stroke-linecap="round"
                            stroke-linejoin="round"
                            d="M19 12H5"/>

                        <path
                            stroke-linecap="round"
                            stroke-linejoin="round"
                            d="M12 19l-7-7 7-7"/>

                    </svg>

                    Back to Users

                </a>

            </div>

        </div>



        <!-- =================================================
             ERROR MESSAGE
             ================================================= -->

        <div
            id="errorMessage"
            class="mb-6 hidden flex items-start gap-3 rounded-xl border border-red-100 bg-red-50 px-4 py-3.5">

            <div class="mt-0.5 shrink-0 text-red-500">

                <svg
                    class="h-4 w-4"
                    fill="none"
                    stroke="currentColor"
                    stroke-width="1.8"
                    viewBox="0 0 24 24">

                    <circle
                        cx="12"
                        cy="12"
                        r="9"/>

                    <path
                        stroke-linecap="round"
                        d="M12 8v4"/>

                    <path
                        stroke-linecap="round"
                        d="M12 16h.01"/>

                </svg>

            </div>

            <div>

                <p class="font-inter text-xs font-semibold text-red-700">

                    Unable to create user

                </p>

                <p
                    id="errorText"
                    class="mt-0.5 font-inter text-[11px] text-red-600">

                </p>

            </div>

        </div>


        <!-- =================================================
             FORM
             ================================================= -->

        <form
            id="addUserForm">


            <div class="grid grid-cols-1 gap-5 xl:grid-cols-3">


                <!-- =================================================
                     PERSONAL INFORMATION
                     ================================================= -->

                <div class="xl:col-span-2 rounded-xl border border-slate-200 bg-white">


                    <!-- Card Header -->

                    <div class="flex items-center gap-3 border-b border-slate-100 px-6 py-5">


                        <div class="flex h-9 w-9 items-center justify-center rounded-lg bg-blue-50 text-blue-600">

                            <svg
                                class="h-4 w-4"
                                fill="none"
                                stroke="currentColor"
                                stroke-width="1.8"
                                viewBox="0 0 24 24">

                                <path
                                    stroke-linecap="round"
                                    stroke-linejoin="round"
                                    d="M16 21v-2a4 4 0 00-4-4H6a4 4 0 00-4 4v2"/>

                                <circle
                                    cx="9"
                                    cy="7"
                                    r="4"/>

                                <path
                                    stroke-linecap="round"
                                    stroke-linejoin="round"
                                    d="M19 8v6M22 11h-6"/>

                            </svg>

                        </div>


                        <div>

                            <h2 class="font-manrope text-sm font-bold text-[#172033]">

                                Personal Information

                            </h2>

                            <p class="mt-0.5 font-inter text-[10px] text-slate-400">

                                Basic information about the user.

                            </p>

                        </div>

                    </div>



                    <!-- Form Fields -->

                    <div class="p-6">


                        <div class="grid grid-cols-1 gap-5 md:grid-cols-2">


                            <!-- Full Name -->

                            <div>

                                <label
                                    for="fullName"
                                    class="mb-2 block font-inter text-[10px] font-semibold uppercase tracking-wide text-slate-500">

                                    Full Name

                                    <span class="text-red-500">*</span>

                                </label>

                                <input
                                    type="text"
                                    id="fullName"
                                    name="fullName"
                                    placeholder="Enter full name"
                                    value=""
                                    required

                                    class="w-full rounded-lg border border-slate-200 bg-white px-3.5 py-2.5 font-inter text-xs text-[#172033] transition placeholder:text-slate-400 focus:border-blue-500 focus:ring-2 focus:ring-blue-100">

                            </div>



                            <!-- Position -->

                            <div>

                                <label
                                    for="position"
                                    class="mb-2 block font-inter text-[10px] font-semibold uppercase tracking-wide text-slate-500">

                                    Position

                                </label>

                                <input
                                    type="text"
                                    id="position"
                                    name="position"
                                    value="Staff"

                                    class="w-full cursor-not-allowed rounded-lg border border-slate-200 bg-slate-50 px-3.5 py-2.5 font-inter text-xs font-medium text-slate-500">

                            </div>



                            <!-- System Role -->

                            <div>

                                <label
                                    for="role"
                                    class="mb-2 block font-inter text-[10px] font-semibold uppercase tracking-wide text-slate-500">

                                    System Role

                                    <span class="text-red-500">*</span>

                                </label>

                                <select
                                    id="role"
                                    name="role"
                                    required

                                    class="w-full rounded-lg border border-slate-200 bg-white px-3.5 py-2.5 font-inter text-xs text-[#172033] transition focus:border-blue-500 focus:ring-2 focus:ring-blue-100">


                                    <option
                                        value="RECEPTIONIST"
                                        selected>

                                        Receptionist

                                    </option>


                                    <option
                                        value="ADMIN"
                                        >

                                        Administrator

                                    </option>


                                </select>

                                <p class="mt-1.5 font-inter text-[10px] text-slate-400">

                                    Controls the user's system permissions.

                                </p>

                            </div>



                            <!-- Email -->

                            <div>

                                <label
                                    for="email"
                                    class="mb-2 block font-inter text-[10px] font-semibold uppercase tracking-wide text-slate-500">

                                    Email Address

                                </label>

                                <input
                                    type="email"
                                    id="email"
                                    name="email"
                                    placeholder="example@email.com"
                                    value=""

                                    class="w-full rounded-lg border border-slate-200 bg-white px-3.5 py-2.5 font-inter text-xs text-[#172033] transition placeholder:text-slate-400 focus:border-blue-500 focus:ring-2 focus:ring-blue-100">

                            </div>



                            <!-- Phone -->

                            <div>

                                <label
                                    for="phone"
                                    class="mb-2 block font-inter text-[10px] font-semibold uppercase tracking-wide text-slate-500">

                                    Contact Number

                                </label>

                                <input
                                    type="tel"
                                    id="phone"
                                    name="phone"
                                    placeholder="0771234567"
                                    value=""

                                    class="w-full rounded-lg border border-slate-200 bg-white px-3.5 py-2.5 font-inter text-xs text-[#172033] transition placeholder:text-slate-400 focus:border-blue-500 focus:ring-2 focus:ring-blue-100">

                            </div>



                            <!-- Address -->

                            <div class="md:col-span-2">

                                <label
                                    for="address"
                                    class="mb-2 block font-inter text-[10px] font-semibold uppercase tracking-wide text-slate-500">

                                    Address

                                </label>

                                <textarea
                                    id="address"
                                    name="address"
                                    rows="3"
                                    placeholder="Enter user address"

                                    class="w-full resize-none rounded-lg border border-slate-200 bg-white px-3.5 py-2.5 font-inter text-xs text-[#172033] transition placeholder:text-slate-400 focus:border-blue-500 focus:ring-2 focus:ring-blue-100"></textarea>

                            </div>


                        </div>

                    </div>

                </div>



                <!-- =================================================
                     LOGIN ACCOUNT
                     ================================================= -->

                <div class="rounded-xl border border-slate-200 bg-white">


                    <!-- Card Header -->

                    <div class="flex items-center gap-3 border-b border-slate-100 px-6 py-5">


                        <div class="flex h-9 w-9 items-center justify-center rounded-lg bg-blue-50 text-blue-600">

                            <svg
                                class="h-4 w-4"
                                fill="none"
                                stroke="currentColor"
                                stroke-width="1.8"
                                viewBox="0 0 24 24">

                                <rect
                                    x="3"
                                    y="11"
                                    width="18"
                                    height="10"
                                    rx="2"/>

                                <path
                                    stroke-linecap="round"
                                    stroke-linejoin="round"
                                    d="M7 11V7a5 5 0 0110 0v4"/>

                            </svg>

                        </div>


                        <div>

                            <h2 class="font-manrope text-sm font-bold text-[#172033]">

                                Login Account

                            </h2>

                            <p class="mt-0.5 font-inter text-[10px] text-slate-400">

                                System access credentials.

                            </p>

                        </div>

                    </div>



                    <!-- Account Fields -->

                    <div class="p-6">


                        <!-- Username -->

                        <div class="mb-5">

                            <label
                                for="username"
                                class="mb-2 block font-inter text-[10px] font-semibold uppercase tracking-wide text-slate-500">

                                Username

                                <span class="text-red-500">*</span>

                            </label>

                            <input
                                type="text"
                                id="username"
                                name="username"
                                placeholder="Enter username"
                                value=""
                                required

                                class="w-full rounded-lg border border-slate-200 bg-white px-3.5 py-2.5 font-inter text-xs text-[#172033] transition placeholder:text-slate-400 focus:border-blue-500 focus:ring-2 focus:ring-blue-100">

                            <p class="mt-1.5 font-inter text-[10px] text-slate-400">

                                Username must be unique.

                            </p>

                        </div>



                        <!-- Password -->

                        <div>

                            <label
                                for="password"
                                class="mb-2 block font-inter text-[10px] font-semibold uppercase tracking-wide text-slate-500">

                                Password

                                <span class="text-red-500">*</span>

                            </label>

                            <input
                                type="password"
                                id="password"
                                name="password"
                                placeholder="Enter password"
                                minlength="4"
                                required

                                class="w-full rounded-lg border border-slate-200 bg-white px-3.5 py-2.5 font-inter text-xs text-[#172033] transition placeholder:text-slate-400 focus:border-blue-500 focus:ring-2 focus:ring-blue-100">

                            <p class="mt-1.5 font-inter text-[10px] text-slate-400">

                                Minimum 4 characters.

                            </p>

                        </div>



                        <!-- =================================================
                             ROLE SUMMARY
                             ================================================= -->

                        <div class="mt-6 border-t border-slate-100 pt-5">

                            <div class="flex items-center justify-between gap-3">

                                <div>

                                    <p class="font-inter text-[10px] font-semibold uppercase tracking-wide text-slate-500">

                                        Selected Role

                                    </p>

                                    <p
                                        id="roleDescription"
                                        class="mt-1 font-inter text-[10px] text-slate-400">

                                        Receptionist access

                                    </p>

                                </div>


                                <span
                                    id="roleBadge"
                                    class="shrink-0 rounded-full bg-blue-50 px-2.5 py-1 font-inter text-[10px] font-semibold text-blue-600">

                                    Receptionist

                                </span>

                            </div>

                        </div>


                    </div>

                </div>


            </div>



            <!-- =================================================
                 FORM ACTIONS
                 ================================================= -->

            <div class="mt-5 flex items-center justify-end gap-3 rounded-xl border border-slate-200 bg-white px-6 py-4">


                <a
                    href="<%= contextPath %>/admin/users"

                    class="rounded-lg border border-slate-200 bg-white px-5 py-2.5 font-inter text-[11px] font-semibold text-slate-600 transition hover:bg-slate-50">

                    Cancel

                </a>


                <button
                    type="submit"

                    class="inline-flex items-center gap-2 rounded-lg bg-[#2563EB] px-5 py-2.5 font-inter text-[11px] font-bold text-white shadow-sm transition hover:bg-[#1D4ED8]">


                    <svg
                        class="h-4 w-4"
                        fill="none"
                        stroke="currentColor"
                        stroke-width="2"
                        viewBox="0 0 24 24">

                        <path
                            stroke-linecap="round"
                            stroke-linejoin="round"
                            d="M12 5v14M5 12h14"/>

                    </svg>

                    Create User

                </button>

            </div>


        </form>


    </main>

</div>



<!-- =========================================================
     ROLE DISPLAY + REST API SUBMISSION
========================================================== -->

<script>

(function () {

    const contextPath = "<%= contextPath %>";

    const form =
        document.getElementById("addUserForm");

    const roleSelect =
        document.getElementById("role");

    const roleBadge =
        document.getElementById("roleBadge");

    const roleDescription =
        document.getElementById("roleDescription");

    const errorMessage =
        document.getElementById("errorMessage");

    const errorText =
        document.getElementById("errorText");

    const submitButton =
        form.querySelector('button[type="submit"]');


    /*
     * ========================================================
     * ROLE DISPLAY
     * ========================================================
     */

    function updateRoleDisplay() {

        const role =
            roleSelect.value;

        if (role === "ADMIN") {

            roleBadge.textContent =
                "Administrator";

            roleDescription.textContent =
                "Administrator access to system management and reports.";

        } else {

            roleBadge.textContent =
                "Receptionist";

            roleDescription.textContent =
                "Receptionist access for clinic operational tasks.";

        }

    }


    /*
     * ========================================================
     * SHOW API ERROR
     * ========================================================
     */

    function showError(message) {

        errorText.textContent =
            message || "User could not be created.";

        errorMessage.classList.remove(
            "hidden"
        );

        errorMessage.scrollIntoView({
            behavior: "smooth",
            block: "start"
        });

    }


    /*
     * ========================================================
     * HIDE ERROR
     * ========================================================
     */

    function hideError() {

        errorMessage.classList.add(
            "hidden"
        );

        errorText.textContent =
            "";

    }


    /*
     * ========================================================
     * CREATE USER
     *
     * POST /api/users
     *
     * UserApi expects:
     * fullName
     * email
     * phone
     * address
     * position
     * username
     * password
     * role
     * ========================================================
     */

    form.addEventListener(
        "submit",
        async function (event) {

            event.preventDefault();

            hideError();


            /*
             * ------------------------------------------------
             * GET FORM VALUES
             * ------------------------------------------------
             */

            const fullName =
                document
                    .getElementById("fullName")
                    .value
                    .trim();

            const position =
                document
                    .getElementById("position")
                    .value
                    .trim();

            const role =
                roleSelect
                    .value
                    .trim();

            const email =
                document
                    .getElementById("email")
                    .value
                    .trim();

            const phone =
                document
                    .getElementById("phone")
                    .value
                    .trim();

            const address =
                document
                    .getElementById("address")
                    .value
                    .trim();

            const username =
                document
                    .getElementById("username")
                    .value
                    .trim();

            const password =
                document
                    .getElementById("password")
                    .value;


            /*
             * ------------------------------------------------
             * CLIENT-SIDE VALIDATION
             * ------------------------------------------------
             */

            if (!fullName) {

                showError(
                    "Full name is required."
                );

                return;

            }


            if (!username) {

                showError(
                    "Username is required."
                );

                return;

            }


            if (!password) {

                showError(
                    "Password is required."
                );

                return;

            }


            if (password.length < 4) {

                showError(
                    "Password must contain at least 4 characters."
                );

                return;

            }


            /*
             * ------------------------------------------------
             * PREVENT DOUBLE SUBMISSION
             * ------------------------------------------------
             */

            submitButton.disabled =
                true;

            submitButton.classList.add(
                "opacity-70",
                "cursor-not-allowed"
            );


            /*
             * ------------------------------------------------
             * BUILD FORM DATA
             *
             * UserApi currently reads
             * application/x-www-form-urlencoded
             * request bodies.
             * ------------------------------------------------
             */

            const formData =
                new URLSearchParams();


            formData.append(
                "fullName",
                fullName
            );

            formData.append(
                "position",
                position
            );

            formData.append(
                "role",
                role
            );

            formData.append(
                "email",
                email
            );

            formData.append(
                "phone",
                phone
            );

            formData.append(
                "address",
                address
            );

            formData.append(
                "username",
                username
            );

            formData.append(
                "password",
                password
            );


            /*
             * ------------------------------------------------
             * REST API REQUEST
             *
             * POST /api/users
             * ------------------------------------------------
             */

            try {

                const response =
                    await fetch(
                        contextPath +
                        "/api/users",
                        {
                            method: "POST",

                            credentials:
                                "same-origin",

                            headers: {
                                "Content-Type":
                                    "application/x-www-form-urlencoded; charset=UTF-8",

                                "Accept":
                                    "application/json"
                            },

                            body:
                                formData.toString()
                        }
                    );


                /*
                 * ------------------------------------------------
                 * READ RESPONSE
                 * ------------------------------------------------
                 */

                let data = null;

                try {

                    data =
                        await response.json();

                }
                catch (jsonError) {

                    data = null;

                }


                /*
                 * ------------------------------------------------
                 * API SUCCESS
                 *
                 * UserApi returns 201 when
                 * the user is successfully created.
                 * ------------------------------------------------
                 */

                if (
                    response.ok &&
                    response.status >= 200 &&
                    response.status < 300
                ) {

                    window.location.href =
                        contextPath +
                        "/admin/users";

                    return;

                }


                /*
                 * ------------------------------------------------
                 * API ERROR
                 * ------------------------------------------------
                 */

                let message =
                    "User could not be created.";


                if (data) {

                    if (data.message) {

                        message =
                            data.message;

                    }
                    else if (data.error) {

                        if (
                            typeof data.error ===
                            "string"
                        ) {

                            message =
                                data.error;

                        }
                        else if (
                            data.error.message
                        ) {

                            message =
                                data.error.message;

                        }

                    }

                }


                if (response.status === 401) {

                    window.location.href =
                        contextPath +
                        "/login";

                    return;

                }


                if (response.status === 403) {

                    message =
                        "You do not have permission to create users.";

                }


                if (response.status === 409) {

                    message =
                        data && data.message
                            ? data.message
                            : "Username already exists.";

                }


                showError(
                    message
                );


            }
            catch (error) {

                console.error(
                    "Create user API error:",
                    error
                );


                showError(
                    "Unable to connect to the server. Please try again."
                );

            }
            finally {

                submitButton.disabled =
                    false;

                submitButton.classList.remove(
                    "opacity-70",
                    "cursor-not-allowed"
                );

            }

        }
    );


    /*
     * ========================================================
     * ROLE CHANGE
     * ========================================================
     */

    roleSelect.addEventListener(
        "change",
        updateRoleDisplay
    );


    /*
     * ========================================================
     * INITIAL ROLE DISPLAY
     * ========================================================
     */

    updateRoleDisplay();

})();

</script>


</body>

</html>
