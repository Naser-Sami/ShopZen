import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:shop_zen/features/_features.dart' show AddressEntity;

part 'address_state.dart';

class AddressCubit extends HydratedCubit<AddressState> {
  AddressCubit()
      : super(
            const AddressState(address: [], defaultAddress: false, selectedAddress: ''));

  void addAddress(AddressEntity address) =>
      emit(state.copyWith(address: [...state.address, address]));

  void selectAddress(String id) {
    emit(state.copyWith(selectedAddress: id));
  }

  void checkDefaultAddress(AddressEntity? address) {
    if (address == null) {
      emit(state.copyWith(defaultAddress: false));
      return;
    }
    if (address.isDefaultAddress) {
      emit(state.copyWith(defaultAddress: true));
    } else {
      emit(state.copyWith(defaultAddress: false));
    }
  }

  void setAsDefaultAddress(bool value, {AddressEntity? address}) {
    if (address == null) {
      List<AddressEntity> updatedList = [];

      if (value) {
        for (var element in state.address) {
          updatedList.add(element.copyWith(isDefaultAddress: false));
        }
      }
      emit(state.copyWith(defaultAddress: value, address: updatedList));
      return;
    }

    // Update all addresses to ensure only one default address exists
    final updatedList = state.address.map((addr) {
      return addr.id == address.id
          ? addr.copyWith(isDefaultAddress: true)
          : addr.copyWith(isDefaultAddress: false);
    }).toList();

    emit(state.copyWith(address: updatedList, defaultAddress: value));
  }

  void updateAddress(AddressEntity address) {
    final updatedList = [...state.address];
    int index = state.address.indexWhere((element) => element.id == address.id);
    updatedList[index] = address;
    emit(state.copyWith(address: updatedList));
  }

  void deleteAddress(AddressEntity address) {
    emit(state.copyWith(
        address: state.address.where((element) => element.id != address.id).toList()));
  }

  void deleteAllAddress() {
    emit(state.copyWith(address: []));
  }

  @override
  AddressState? fromJson(Map<String, dynamic> json) {
    return AddressState.fromJson(json);
  }

  @override
  Map<String, dynamic>? toJson(AddressState state) {
    return state.toJson();
  }
}
