import '/features/account/_account.dart';

abstract class IAccountRepository {
  // Future<void> createAccount();
  List<AccountFieldsEntity> getAccountFields();
}
