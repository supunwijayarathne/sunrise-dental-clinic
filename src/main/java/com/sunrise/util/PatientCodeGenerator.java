package com.sunrise.util;

import java.util.UUID;

public class PatientCodeGenerator {

    public static String generate() {

        String randomCode = UUID.randomUUID()
                .toString()
                .substring(0, 8)
                .toUpperCase();

        return "PAT-" + randomCode;
    }
}