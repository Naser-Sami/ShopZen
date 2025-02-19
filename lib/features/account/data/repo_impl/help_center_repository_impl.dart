import '/features/account/_account.dart';

class HelpCenterRepositoryImpl implements IHelpCenterRepository {
  @override
  List<HelpCenterFieldsEntity> getHelpCenterFields() {
    return [
      HelpCenterFieldsEntity(
        icon: 'support',
        name: 'Customer Service',
      ),
      HelpCenterFieldsEntity(
        icon: 'whatsapp',
        name: 'WhatsApp',
      ),
      HelpCenterFieldsEntity(
        icon: 'website',
        name: 'Website',
      ),
      HelpCenterFieldsEntity(
        icon: 'facebook-logo',
        name: 'Facebook',
      ),
      HelpCenterFieldsEntity(
        icon: 'Twitter',
        name: 'Twitter',
      ),
      HelpCenterFieldsEntity(
        icon: 'Instagram',
        name: 'Instagram',
      ),
    ];
  }
}
