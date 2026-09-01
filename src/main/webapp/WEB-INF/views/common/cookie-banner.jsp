<%@ page language="java"
    contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
    String cookieConsent = null;

    Cookie[] cookies = request.getCookies();

    if (cookies != null) {

        for (Cookie cookie : cookies) {

            if ("cookieConsent".equals(cookie.getName())) {

                cookieConsent = cookie.getValue();
                break;
            }
        }
    }
%>

<style>

#cookieBanner {
    position: fixed;
    left: 24px;
    right: 24px;
    bottom: 24px;

    max-width: 900px;
    margin: 0 auto;

    background: #ffffff;

    border: 1px solid #e5e7eb;

    border-radius: 14px;

    padding: 18px 20px;

    display: flex;
    align-items: center;
    justify-content: space-between;
    gap: 20px;

    box-shadow: 0 10px 35px rgba(0, 0, 0, 0.12);

    z-index: 9999;

    font-family: Arial, sans-serif;
}

.cookie-content {
    display: flex;
    align-items: flex-start;
    gap: 13px;
}

.cookie-icon {
    width: 38px;
    height: 38px;

    display: flex;
    align-items: center;
    justify-content: center;

    background: #eff6ff;

    border-radius: 10px;

    flex-shrink: 0;
}

.cookie-icon svg {
    width: 21px;
    height: 21px;
}

.cookie-text h3 {
    margin: 0 0 5px 0;

    font-size: 15px;

    color: #111827;
}

.cookie-text p {
    margin: 0;

    font-size: 13px;

    line-height: 1.5;

    color: #6b7280;
}

.cookie-actions {
    flex-shrink: 0;
}

.cookie-accept {
    border: none;

    background: #2563eb;

    color: white;

    padding: 10px 18px;

    border-radius: 8px;

    font-size: 13px;

    font-weight: 600;

    cursor: pointer;

    transition: 0.2s;
}

.cookie-accept:hover {
    opacity: 0.9;
}

@media (max-width: 650px) {

    #cookieBanner {

        left: 12px;
        right: 12px;
        bottom: 12px;

        flex-direction: column;

        align-items: stretch;

    }

    .cookie-actions {
        width: 100%;
    }

    .cookie-accept {
        width: 100%;
    }
}

</style>


<%
    if (!"accepted".equals(cookieConsent)) {
%>

<div id="cookieBanner">

    <div class="cookie-content">

        <div class="cookie-icon">

            <svg
                fill="none"
                stroke="currentColor"
                stroke-width="1.8"
                viewBox="0 0 24 24">

                <path
                    stroke-linecap="round"
                    stroke-linejoin="round"
                    d="M20.5 13.5A8.5 8.5 0 1110.5 3.5
                       c.3 1.8 1.8 3 3.6 3
                       1.1 0 2-.9 2-2
                       0-.5-.2-1-.5-1.4
                       A8.5 8.5 0 0120.5 13.5z">
                </path>

                <circle
                    cx="8"
                    cy="12"
                    r="1">
                </circle>

                <circle
                    cx="12"
                    cy="16"
                    r="1">
                </circle>

                <circle
                    cx="15"
                    cy="11"
                    r="1">
                </circle>

            </svg>

        </div>


        <div class="cookie-text">

            <h3>
                Cookie Preferences
            </h3>

            <p>
                This system uses cookies to remember your
                preferences and improve your experience.
            </p>

        </div>

    </div>


    <div class="cookie-actions">

        <button
            type="button"
            class="cookie-accept"
            onclick="acceptCookies()">

            Accept Cookies

        </button>

    </div>

</div>

<%
    }
%>


<script>

function acceptCookies() {

    // Cookie valid for 30 days
    const maxAge = 60 * 60 * 24 * 30;

    document.cookie =
        "cookieConsent=accepted;" +
        "max-age=" + maxAge + ";" +
        "path=/;" +
        "SameSite=Lax";

    // Hide banner
    const banner =
        document.getElementById("cookieBanner");

    if (banner) {

        banner.style.display = "none";
    }
}

</script>