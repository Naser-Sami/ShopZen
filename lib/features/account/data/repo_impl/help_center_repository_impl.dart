import '/features/account/_account.dart';

class HelpCenterRepositoryImpl implements IHelpCenterRepository {
  @override
  List<HelpCenterFieldsEntity> getHelpCenterFields() {
    return [
      const HelpCenterFieldsEntity(
        icon: 'support',
        name: 'Customer Service',
      ),
      const HelpCenterFieldsEntity(
        icon: 'whatsapp',
        name: 'WhatsApp',
      ),
      const HelpCenterFieldsEntity(
        icon: 'website',
        name: 'Website',
      ),
      const HelpCenterFieldsEntity(
        icon: 'facebook-logo',
        name: 'Facebook',
      ),
      const HelpCenterFieldsEntity(
        icon: 'Twitter',
        name: 'Twitter',
      ),
      const HelpCenterFieldsEntity(
        icon: 'Instagram',
        name: 'Instagram',
      ),
    ];
  }
}
