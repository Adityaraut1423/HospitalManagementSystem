package com.util;

import java.util.Properties;

import jakarta.mail.Authenticator;
import jakarta.mail.Message;
import jakarta.mail.PasswordAuthentication;
import jakarta.mail.Session;
import jakarta.mail.Transport;
import jakarta.mail.internet.InternetAddress;
import jakarta.mail.internet.MimeMessage;

public class EmailUtil {

    // Retrieve credentials from environment variables, falling back to default values
    private static final String FROM_EMAIL = System.getenv("SMTP_EMAIL") != null ?
            System.getenv("SMTP_EMAIL") : "emailforproject659@gmail.com";

    private static final String APP_PASSWORD = System.getenv("SMTP_PASSWORD") != null ?
            System.getenv("SMTP_PASSWORD") : "hswy zvxq fmpb chvk";

    /**
     * Sends a plain text email.
     */
    public static boolean sendMail(String to, String subject, String body) {
        return sendMail(to, subject, body, false);
    }

    /**
     * Sends an email with support for HTML content.
     *
     * @param to        Recipient address
     * @param subject   Email subject
     * @param content   Email body text or HTML markup
     * @param isHtml    Set to true to render body as HTML
     */
    public static boolean sendMail(String to, String subject, String content, boolean isHtml) {

        try {
            // SMTP Properties setup
            Properties props = new Properties();
            props.put("mail.smtp.host", "smtp.gmail.com");
            props.put("mail.smtp.port", "587");
            props.put("mail.smtp.auth", "true");
            props.put("mail.smtp.starttls.enable", "true");
            props.put("mail.smtp.ssl.protocols", "TLSv1.2");
            props.put("mail.smtp.ssl.trust", "smtp.gmail.com");

            // Create Session with Authenticator
            Session session = Session.getInstance(props, new Authenticator() {
                @Override
                protected PasswordAuthentication getPasswordAuthentication() {
                    return new PasswordAuthentication(FROM_EMAIL, APP_PASSWORD);
                }
            });

            // Create MimeMessage
            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress(FROM_EMAIL, "Hospital System"));
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(to));
            message.setSubject(subject);

            // Set content based on format
            if (isHtml) {
                message.setContent(content, "text/html; charset=utf-8");
            } else {
                message.setText(content);
            }

            // Send Message
            Transport.send(message);

            System.out.println("Email sent successfully to: " + to);
            return true;

        } catch (Exception e) {
            System.err.println("Failed to send email to " + to + ": " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }
}