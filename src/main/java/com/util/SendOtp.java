package com.util;

import java.net.HttpURLConnection;
import java.net.URI;
import java.net.URL;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;

public class SendOtp {

    // Retrieve API key from environment variable, falling back to default value
    private static final String API_KEY = System.getenv("FAST2SMS_API_KEY") != null ?
            System.getenv("FAST2SMS_API_KEY") : "6grpJhOtTW4jKARZkNixm5cdVq1HBMGowvQ0SDl8EIf93seuFnjcYfC0q6X5LZhFoBUMsIakKmA1uw9p";

    /**
     * Dispatches an OTP message via Fast2SMS HTTP API.
     *
     * @param mobile Recipient 10-digit mobile number
     * @param otp    Generated OTP code
     * @return true if HTTP response code is 200 OK
     */
    public static boolean send(String mobile, int otp) {
        try {
            String message = "Your OTP for registration is " + otp;

            String urlStr = "https://www.fast2sms.com/dev/bulkV2?" +
                    "authorization=" + API_KEY +
                    "&sender_id=FSTSMS" +
                    "&message=" + URLEncoder.encode(message, StandardCharsets.UTF_8.name()) +
                    "&language=english" +
                    "&route=q" +
                    "&numbers=" + mobile;

            // Safe URI-to-URL conversion (Java 20+)
            URL url = new URI(urlStr).toURL();

            HttpURLConnection conn = (HttpURLConnection) url.openConnection();
            conn.setRequestMethod("GET");
            conn.setConnectTimeout(5000); // 5 seconds timeout
            conn.setReadTimeout(5000);

            int responseCode = conn.getResponseCode();
            if (responseCode == HttpURLConnection.HTTP_OK) {
                System.out.println("OTP successfully sent to " + mobile);
                return true;
            } else {
                System.err.println("Fast2SMS API returned error status code: " + responseCode);
            }

        } catch (Exception e) {
            System.err.println("Failed to send OTP to " + mobile + ": " + e.getMessage());
            e.printStackTrace();
        }
        return false;
    }
}