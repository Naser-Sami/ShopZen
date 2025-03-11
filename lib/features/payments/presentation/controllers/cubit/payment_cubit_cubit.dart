import 'package:flutter_bloc/flutter_bloc.dart';

import '/core/utils/helpers/_helpers.dart' show PaymentCard;

class PaymentCubitCubit extends Cubit<PaymentCard> {
  PaymentCubitCubit() : super(PaymentCard());
}
