// • Advanced Example:
// Consider an e-commerce system where an order service depends
// on a payment service,
// but you want to be able to change the payment method easily.

// Bad example: High-level OrderService depends directly on a low-level CreditCardPayment class.
import 'dart:developer';

class CreditCardPaymentBad {
  void processPayment(double amount) {
    log('Processing credit card payment of \$$amount');
  }
}

class OrderServiceBad {
  CreditCardPayment paymentProcessor = CreditCardPayment();

  void checkout(double amount) {
    paymentProcessor.processPayment(amount);
  }
}

// Good example: High-level OrderService depends on an abstraction, making it more flexible.
abstract class PaymentProcessor {
  void processPayment(double amount);
}

class CreditCardPayment implements PaymentProcessor {
  @override
  void processPayment(double amount) {
    log('Processing credit card payment of \$$amount');
  }
}

class PayPalPayment implements PaymentProcessor {
  @override
  void processPayment(double amount) {
    log('Processing PayPal payment of \$$amount');
  }
}

class OrderService {
  final PaymentProcessor paymentProcessor;

  OrderService(this.paymentProcessor);

  void checkout(double amount) {
    paymentProcessor.processPayment(amount);
  }
}

// Usage
// void main() {
//   PaymentProcessor creditCard = CreditCardPayment();
//   OrderService orderService = OrderService(creditCard);
//   orderService.checkout(100.0);

//   PaymentProcessor paypal = PayPalPayment();
//   orderService = OrderService(paypal);
//   orderService.checkout(200.0);
// }

	// • Why is this better?:
  // OrderService can work with any payment method that implements PaymentProcessor,
  // allowing you to swap out payment methods without changing the OrderService code.