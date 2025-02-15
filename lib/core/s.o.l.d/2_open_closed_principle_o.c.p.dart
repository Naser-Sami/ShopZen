// •	Advanced Example:
// Suppose you are building a payment processing system
// that initially only supports PayPal
// but later needs to support other payment gateways like Stripe or Square.

// Bad example: Adding new payment methods requires modifying the existing class.
import 'dart:developer';

class PaymentProcessorBad {
  void processPayment(String method) {
    if (method == 'paypal') {
      log('Processing PayPal payment');
    } else if (method == 'stripe') {
      log('Processing Stripe payment');
    } else if (method == 'square') {
      log('Processing Square payment');
    }
  }
}

// Good example: PaymentProcessor is open for extension but closed for modification.
abstract class PaymentMethod {
  void process(double amount);
  bool validatePayment();
  String getPaymentDetails();
}

class PayPal implements PaymentMethod {
  @override
  void process(double amount) {
    log('Processing PayPal payment of \$$amount');
  }

  @override
  bool validatePayment() {
    // PayPal-specific validation logic
    log('Validating PayPal payment');
    return true; // Example validation result
  }

  @override
  String getPaymentDetails() {
    return 'PayPal payment details';
  }
}

class Stripe implements PaymentMethod {
  @override
  void process(double amount) {
    log('Processing Stripe payment of \$$amount');
  }

  @override
  bool validatePayment() {
    // Stripe-specific validation logic
    log('Validating Stripe payment');
    return true; // Example validation result
  }

  @override
  String getPaymentDetails() {
    return 'Stripe payment details';
  }
}

class Square implements PaymentMethod {
  @override
  void process(double amount) {
    log('Processing Square payment of \$$amount');
  }

  @override
  String getPaymentDetails() {
    throw UnimplementedError();
  }

  @override
  bool validatePayment() {
    throw UnimplementedError();
  }
}

class PaymentProcessors {
  final double amount;
  PaymentProcessors(this.amount);

  void processPayment(PaymentMethod paymentMethod) {
    paymentMethod.process(amount);
    paymentMethod.validatePayment();
    paymentMethod.getPaymentDetails();
  }
}


	// • Why is this better?: 
  // If you need to add a new payment method,
  // you simply create a new class that implements PaymentMethod 
  // without modifying the PaymentProcessor.
  //
  // This makes the code more modular and reduces the risk of introducing bugs.