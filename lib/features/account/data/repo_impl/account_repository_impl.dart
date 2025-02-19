import '/features/account/_account.dart';

class AccountRepositoryImpl implements IAccountRepository {
  @override
  List<AccountFieldsEntity> getAccountFields() {
    return [
      const AccountFieldsEntity(
        icon: 'person',
        name: 'Your Profile',
      ),
      const AccountFieldsEntity(
        icon: 'orders',
        name: 'My Orders',
      ),
      const AccountFieldsEntity(
        icon: 'credit-card',
        name: 'Payments Methods',
      ),
      const AccountFieldsEntity(
        icon: 'notification',
        name: 'Notifications',
      ),
      const AccountFieldsEntity(
        icon: 'circle-lock',
        name: 'Privacy Policy',
      ),
      const AccountFieldsEntity(
        icon: 'help-circle',
        name: 'Help Center',
      ),
      const AccountFieldsEntity(
        icon: 'user-add',
        name: 'Invite Friends',
      ),
    ];
  }
}
