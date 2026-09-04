package com.sunrise.api;

import java.io.IOException;
import java.time.LocalDate;
import java.time.LocalTime;
import java.util.List;
import jakarta.servlet.http.HttpServletResponse;

public final class ApiUtil {
    private ApiUtil() {}

    public static void json(HttpServletResponse r) {
        r.setContentType("application/json");
        r.setCharacterEncoding("UTF-8");
    }

    public static String q(String s) {
        if (s == null) return "";
        return s.replace("\\", "\\\\").replace("\"", "\\\"")
                .replace("\r", "\\r").replace("\n", "\\n");
    }

    public static String str(String s) { return "\"" + q(s) + "\""; }
    public static String nullable(String s) { return s == null ? "null" : str(s); }
    public static String date(LocalDate d) { return d == null ? "null" : str(d.toString()); }
    public static String time(LocalTime t) { return t == null ? "null" : str(t.toString()); }

    public static boolean blank(String s) { return s == null || s.trim().isEmpty(); }

    public static void error(HttpServletResponse r, int status, String message) throws IOException {
        r.setStatus(status);
        json(r);
        r.getWriter().write("{\"success\":false,\"message\":" + str(message) + "}");
    }

    public static void ok(HttpServletResponse r, String message) throws IOException {
        json(r);
        r.getWriter().write("{\"success\":true,\"message\":" + str(message) + "}");
    }

    public static void noContent(HttpServletResponse r) { r.setStatus(HttpServletResponse.SC_NO_CONTENT); }

    public static void cors(HttpServletResponse r) {
        // Keep this permissive while the API is being developed.
        // If the final frontend is hosted on another origin and uses sessions,
        // replace * with that exact origin and enable credentials there.
        r.setHeader("Access-Control-Allow-Origin", "*");
        r.setHeader("Access-Control-Allow-Methods", "GET, POST, PUT, PATCH, OPTIONS");
        r.setHeader("Access-Control-Allow-Headers", "Content-Type");
    }

    public static String intList(List<Integer> values) {
        StringBuilder b = new StringBuilder("[");
        for (int i=0;i<values.size();i++) { if(i>0)b.append(','); b.append(values.get(i)); }
        return b.append(']').toString();
    }
}
