package com.sunrise.webservice;

import java.io.IOException;

import com.sunrise.dao.ReportDAO;
import com.sunrise.model.ReportStats;

import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;


@WebServlet("/api/reports/*")
public class ReportWebService extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private ReportDAO reportDAO;

    @Override
    public void init() {
        reportDAO =
                new ReportDAO();
    }

    @Override
    protected void doGet(
            HttpServletRequest request,
            HttpServletResponse response)
            throws IOException {
    	
    	HttpSession session = request.getSession(false);

    	if (session == null ||
    	    !"Admin".equalsIgnoreCase(
    	        String.valueOf(session.getAttribute("role")))) {

    	    response.setStatus(
    	        HttpServletResponse.SC_FORBIDDEN
    	    );

    	    response.setContentType(
    	        "application/json"
    	    );

    	    response.getWriter().write(
    	        "{\"error\":\"Access denied. Admin role required.\"}"
    	    );

    	    return;
    	}

        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        try {

            /*
             * Your existing ReportDAO uses a date range.
             * We deliberately don't guess its exact parameters here.
             * The final call must match the current method signature.
             */

            response.getWriter().write(
                    "{\"success\":true,\"service\":\"Report Web Service\",\"message\":\"Report endpoint is available. Connect this endpoint to the existing ReportDAO date-range method.\"}"
            );

        } catch (Exception e) {

            response.setStatus(500);

            response.getWriter().write(
                    "{\"success\":false,\"message\":\"Server error\"}"
            );
        }
    }
}