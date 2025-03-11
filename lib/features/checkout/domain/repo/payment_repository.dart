abstract class IPaymentRepository {
  Future<void> savePayment(String payment);
  Future<void> initPaymentSheet();
}
