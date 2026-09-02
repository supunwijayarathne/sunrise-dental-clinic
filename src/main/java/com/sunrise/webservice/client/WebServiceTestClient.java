package com.sunrise.webservice.client;

import java.io.IOException;
import java.net.URI;
import java.net.http.HttpClient;
import java.net.http.HttpRequest;
import java.net.http.HttpResponse;

public class WebServiceTestClient {

    // =========================================================
    // BASE URL
    // =========================================================

    private static final String BASE_URL =
            "http://localhost:8080/SunriseDentalClinic";

    private static final HttpClient CLIENT =
            HttpClient.newHttpClient();


    // =========================================================
    // MAIN
    // =========================================================

    public static void main(String[] args) {

        System.out.println("==============================================");
        System.out.println(" SUNRISE DENTAL CLINIC - WEB SERVICE CLIENT");
        System.out.println("==============================================");

        try {

            // -------------------------------------------------
            // 1. APPOINTMENTS
            // -------------------------------------------------

            System.out.println("\n--- APPOINTMENT WEB SERVICE ---");

            sendGet(
                    BASE_URL + "/api/appointments"
            );


            // -------------------------------------------------
            // 2. PATIENTS
            // -------------------------------------------------

            System.out.println("\n--- PATIENT WEB SERVICE ---");

            sendGet(
                    BASE_URL + "/api/patients"
            );


            // -------------------------------------------------
            // Patient Search
            // -------------------------------------------------

            System.out.println("\n--- PATIENT SEARCH ---");

            sendGet(
                    BASE_URL + "/api/patients?keyword=John"
            );


            // -------------------------------------------------
            // 3. DENTISTS
            // -------------------------------------------------

            System.out.println("\n--- DENTIST WEB SERVICE ---");

            sendGet(
                    BASE_URL + "/api/dentists"
            );


            // -------------------------------------------------
            // Dentist Search
            // -------------------------------------------------

            System.out.println("\n--- DENTIST SEARCH ---");

            sendGet(
                    BASE_URL + "/api/dentists?keyword=Test"
            );


            // -------------------------------------------------
            // 4. TREATMENTS
            // -------------------------------------------------

            System.out.println("\n--- TREATMENT WEB SERVICE ---");

            sendGet(
                    BASE_URL + "/api/treatments"
            );


            // -------------------------------------------------
            // 5. BILLING
            // -------------------------------------------------

            System.out.println("\n--- BILLING WEB SERVICE ---");

            sendGet(
                    BASE_URL + "/api/billing"
            );


            // -------------------------------------------------
            // 6. DENTIST SCHEDULE
            // -------------------------------------------------

            System.out.println("\n--- DENTIST SCHEDULE WEB SERVICE ---");

            // Change 1 to an existing dentist ID in your database.
            sendGet(
                    BASE_URL + "/api/schedules?dentistId=1"
            );


            // -------------------------------------------------
            // 7. REPORTS
            // -------------------------------------------------

            System.out.println("\n--- REPORT WEB SERVICE ---");

            sendGet(
                    BASE_URL + "/api/reports?startDate=2026-01-01&endDate=2026-12-31"
            );


            System.out.println("\n==============================================");
            System.out.println(" WEB SERVICE CLIENT TEST COMPLETED");
            System.out.println("==============================================");

        } catch (Exception e) {

            System.out.println("\nERROR:");
            e.printStackTrace();
        }
    }


    // =========================================================
    // SEND GET REQUEST
    // =========================================================

    private static void sendGet(String url)
            throws IOException, InterruptedException {

        System.out.println("\nRequest:");
        System.out.println("GET " + url);


        HttpRequest request =
                HttpRequest.newBuilder()
                        .uri(URI.create(url))
                        .header(
                                "Accept",
                                "application/json"
                        )
                        .GET()
                        .build();


        HttpResponse<String> response =
                CLIENT.send(
                        request,
                        HttpResponse.BodyHandlers.ofString()
                );


        System.out.println("HTTP Status: "
                + response.statusCode());


        System.out.println("Response:");

        System.out.println(
                formatJson(response.body())
        );
    }


    // =========================================================
    // SIMPLE JSON FORMATTING
    // =========================================================

    private static String formatJson(String json) {

        if (json == null || json.isBlank()) {
            return "(empty response)";
        }

        StringBuilder result =
                new StringBuilder();

        int indent = 0;

        boolean insideString = false;

        boolean escaped = false;


        for (int i = 0; i < json.length(); i++) {

            char c = json.charAt(i);


            if (c == '"' && !escaped) {
                insideString = !insideString;
            }


            if (!insideString) {

                if (c == '{' || c == '[') {

                    result.append(c);
                    result.append('\n');

                    indent++;

                    appendIndent(
                            result,
                            indent
                    );

                    escaped = false;

                    continue;
                }


                if (c == '}' || c == ']') {

                    result.append('\n');

                    indent--;

                    appendIndent(
                            result,
                            indent
                    );

                    result.append(c);

                    escaped = false;

                    continue;
                }


                if (c == ',') {

                    result.append(c);
                    result.append('\n');

                    appendIndent(
                            result,
                            indent
                    );

                    escaped = false;

                    continue;
                }


                if (c == ':') {

                    result.append(c);
                    result.append(' ');

                    escaped = false;

                    continue;
                }
            }


            result.append(c);


            if (c == '\\' && !escaped) {
                escaped = true;
            } else {
                escaped = false;
            }
        }


        return result.toString();
    }


    // =========================================================
    // INDENT
    // =========================================================

    private static void appendIndent(
            StringBuilder builder,
            int indent) {

        for (int i = 0; i < indent; i++) {
            builder.append("    ");
        }
    }
}