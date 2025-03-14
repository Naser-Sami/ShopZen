import 'dart:developer';

import '/core/_core.dart';

class EmailService {
  static Future<void> sendEmail(String name, String email, String message) async {
    const String emailJsUrl = 'https://api.emailjs.com/api/v1.0/email/send';
    const String serviceId = 'service_sowfi1j';
    const String templateId = 'template_vwq65z8';
    const String userId = 'nmrVSY1og9QZvwbll';

    final response = await sl<DioService>().post(
      path: emailJsUrl,
      headers: {
        'Content-Type': 'application/json',
      },
      data: {
        'service_id': serviceId,
        'template_id': templateId,
        'user_id': userId,
        'template_params': {
          'name': name,
          'email': email,
          'message': message,
        },
      },
    );

    if (response.statusCode == 200) {
      log('Email sent successfully');
    } else {
      log('Failed to send email: ${response.body}');
    }
  }
}
