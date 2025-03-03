import 'dart:developer';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import '/core/_core.dart';

createPaymentIntent(String amount, String currency) async {
  final DioHelper dioHelper = DioHelper();
  try {
    //Request body
    Map<String, dynamic> body = {
      'amount': calculateAmount(amount),
      'currency': currency,
    };

    final response = await dioHelper.post<Map<String, dynamic>>(
      path: "https://api.stripe.com/v1/payment_intents",
      headers: {
        'Authorization': 'Bearer ${dotenv.env['STRIPE_SECRET']}',
        'Content-Type': 'application/x-www-form-urlencoded'
      },
      data: body,
    );

    log('response-> $response');

    return response;
  } catch (err) {
    throw Exception(err.toString());
  }
}

calculateAmount(String amount) {
  final calculatedAmount = (int.parse(amount)) * 100;
  return calculatedAmount.toString();
}
