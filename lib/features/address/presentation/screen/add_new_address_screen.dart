import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:geolocator/geolocator.dart';
import 'package:go_router/go_router.dart';
import 'package:place_picker_google/place_picker_google.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shop_zen/features/_features.dart';
import 'package:uuid/uuid.dart';

import '/core/_core.dart' show IGeolocatorService, sl, TValidator;
import '/config/_config.dart'
    show TPadding, TextWidget, TSize, TRadius, TextFormFieldComponent;

class AddNewAddressScreen extends StatefulWidget {
  static const String routeName = 'new-address';
  const AddNewAddressScreen({super.key, this.address});

  final AddressEntity? address;

  @override
  State<AddNewAddressScreen> createState() => _AddNewAddressScreenState();
}

class _AddNewAddressScreenState extends State<AddNewAddressScreen> {
  LatLng latLng = const LatLng(0, 0);
  String apiKey = 'API_SECRET_KEY';

  String? mapStyle;

  final _addressNicknameController = TextEditingController();
  final _fullAddressController = TextEditingController();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _loadMapStyle();
  }

  Future<void> _loadMapStyle() async {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final stylePath = isDarkMode
        ? 'assets/map/map_style_night.json'
        : 'assets/map/map_style_light.json';

    final style = await rootBundle.loadString(stylePath);
    setState(() {
      mapStyle = style;
    });
  }

  @override
  void initState() {
    if (widget.address != null) {
      _addressNicknameController.text = widget.address!.addressNickname;
    }
    super.initState();
  }

  Future<Position> _getCurrentLocation() async {
    if (widget.address == null) {
      final position = await sl<IGeolocatorService>().getCurrentPosition();
      latLng = LatLng(position.latitude, position.longitude);
      return position;
    } else {
      latLng = widget.address!.latLng;

      return Position(
        latitude: latLng.latitude,
        longitude: latLng.longitude,
        timestamp: DateTime.now(),
        accuracy: 0,
        altitude: 0,
        heading: 0,
        speed: 0,
        speedAccuracy: 0,
        headingAccuracy: 0,
        altitudeAccuracy: 0,
      );
    }
  }

  @override
  void dispose() {
    super.dispose();
    _addressNicknameController.dispose();
    _fullAddressController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: FutureBuilder<Position>(
        future: _getCurrentLocation(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text(snapshot.error.toString()));
          }
          final position = snapshot.data;

          return PlacePicker(
            apiKey: apiKey,
            myLocationEnabled: true,
            myLocationButtonEnabled: true,
            selectedPlaceWidgetBuilder: (context, state, selectedPlace) {
              _fullAddressController.text = selectedPlace?.name.toString() ?? '';
              return GestureDetector(
                onTap: () {
                  log("Place picked: ${selectedPlace?.latLng}");

                  latLng = selectedPlace?.latLng ?? const LatLng(0, 0);
                  addAddressBottomSheet(context);
                },
                child: Container(
                  height: 64,
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(horizontal: TPadding.p06)
                      .copyWith(top: TPadding.p16),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.outline.withValues(alpha: 0.20),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  alignment: Alignment.topCenter,
                  child: TextWidget(
                    'Add Address',
                    style: theme.textTheme.bodyLarge,
                  ),
                ),
              );
            },
            onMapCreated: (controller) {
              controller.setMapStyle(mapStyle);
            },
            myLocationFABConfig: const MyLocationFABConfig(bottom: 24, right: 24),
            initialLocation: LatLng(position?.latitude ?? 0, position?.longitude ?? 0),
            usePinPointingSearch: true,
            searchInputConfig: const SearchInputConfig(
              padding: EdgeInsets.all(24),
              textDirection: TextDirection.ltr,
            ),
            enableNearbyPlaces: false,
            autocompletePlacesSearchRadius: TSize.s08,
            searchInputDecorationConfig: SearchInputDecorationConfig(
              hintText: "Search for a building, street or ...",
              fillColor: theme.colorScheme.surface,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(TSize.s08),
                borderSide: BorderSide(
                  color: theme.colorScheme.outline,
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Future<dynamic> addAddressBottomSheet(BuildContext context) {
    final theme = Theme.of(context);
    final addressCubit = context.read<AddressCubit>();

    return showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          height: 450,
          decoration: BoxDecoration(
            color: theme.colorScheme.surface,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(TRadius.r16),
              topRight: Radius.circular(TRadius.r16),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(TPadding.p20).copyWith(top: 0),
            child: Column(
              children: [
                Container(
                  height: 6,
                  width: 64,
                  margin: const EdgeInsets.symmetric(vertical: TPadding.p16),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.outline.withValues(alpha: 0.20),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextWidget(
                      'Address',
                      style: theme.textTheme.titleLarge,
                    ),
                    IconButton(
                      onPressed: () => context.pop(),
                      icon: const Icon(
                        Icons.close,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: TSize.s16),
                TextFormFieldComponent(
                  textFieldWithTitle: true,
                  title: 'Address Nickname',
                  hintText: _addressNicknameController.text.isNotEmpty
                      ? _addressNicknameController.text
                      : 'Choose a nickname.',
                  controller: _addressNicknameController,
                  onChanged: (String? value) {
                    _addressNicknameController.text = value ?? '';
                  },
                  validator: (String? value) =>
                      TValidator.validateEmptyText('Address Nickname', value),
                ),
                const SizedBox(height: TSize.s16),
                TextFormFieldComponent(
                  textFieldWithTitle: true,
                  title: 'Full Address',
                  hintText: 'Enter your full address',
                  controller: _fullAddressController,
                ),
                const SizedBox(height: TSize.s16),
                Row(
                  children: [
                    BlocSelector<AddressCubit, AddressState, bool>(
                      selector: (state) => state.defaultAddress,
                      builder: (context, state) {
                        return Checkbox.adaptive(
                          value: state,
                          onChanged: (bool? value) {
                            addressCubit.setAsDefaultAddress(value ?? false,
                                address: widget.address);
                          },
                        );
                      },
                    ),
                    const TextWidget(
                      'Make this as a default address',
                    )
                  ],
                ),
                const SizedBox(height: TSize.s16),
                ElevatedButton(
                  onPressed: () {
                    if (widget.address != null) {
                      addressCubit.updateAddress(AddressEntity(
                        id: widget.address!.id,
                        street: '',
                        city: '',
                        state: '',
                        zipCode: '',
                        country: '',
                        addressNickname: _addressNicknameController.text,
                        fullAddress: _fullAddressController.text,
                        isDefaultAddress: addressCubit.state.defaultAddress,
                        latLng: LatLng(latLng.latitude, latLng.longitude),
                      ));
                    } else {
                      addressCubit.addAddress(
                        AddressEntity(
                          id: const Uuid().v4(),
                          street: '',
                          city: '',
                          state: '',
                          zipCode: '',
                          country: '',
                          addressNickname: _addressNicknameController.text,
                          fullAddress: _fullAddressController.text,
                          isDefaultAddress: addressCubit.state.defaultAddress,
                          latLng: LatLng(latLng.latitude, latLng.longitude),
                        ),
                      );
                    }

                    context.pop();
                    context.pop();
                  },
                  child: widget.address != null
                      ? const TextWidget('Update')
                      : const TextWidget('Add'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
