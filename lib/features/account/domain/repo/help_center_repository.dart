import '/features/account/_account.dart';

abstract class IHelpCenterRepository {
  List<HelpCenterFieldsEntity> getHelpCenterFields();
}
