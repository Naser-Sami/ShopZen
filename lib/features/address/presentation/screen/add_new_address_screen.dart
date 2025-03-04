import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;

import 'package:geolocator/geolocator.dart';
import 'package:go_router/go_router.dart';
import 'package:place_picker_google/place_picker_google.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '/core/_core.dart' show IGeolocatorService, sl, TValidator;
import '/config/_config.dart'
    show TPadding, TextWidget, TSize, TRadius, TextFormFieldComponent;

class AddNewAddressScreen extends StatefulWidget {
  static const String routeName = 'new-address';
  const AddNewAddressScreen({super.key});

  @override
  State<AddNewAddressScreen> createState() => _AddNewAddressScreenState();
}

class _AddNewAddressScreenState extends State<AddNewAddressScreen> {
  LatLng latLng = const LatLng(0, 0);
  String apiKey = 'AIzaSyDHHc9azYoOJWCgw7t-EkbrhOlRuLOiW2M';

  String? mapStyle;
  bool isDefaultAddress = false;

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
    _getCurrentLocation();
    super.initState();
  }

  Future<Position> _getCurrentLocation() async {
    await sl<IGeolocatorService>().requestPermission();
    return await sl<IGeolocatorService>().getCurrentPosition();
  }

  void _onIsDefaultAddressChanged(bool value) {
    // setState(() {
    isDefaultAddress = value;
    // });
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
                  showModalBottomSheet(
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
                                margin:
                                    const EdgeInsets.symmetric(vertical: TPadding.p16),
                                decoration: BoxDecoration(
                                  color:
                                      theme.colorScheme.outline.withValues(alpha: 0.20),
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
                                hintText: 'Choose a nickname.',
                                controller: _addressNicknameController,
                                onChanged: (String? value) {
                                  _addressNicknameController.text = value ?? '';
                                },
                                validator: (String? value) =>
                                    TValidator.validateEmptyText(
                                        'Address Nickname', value),
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
                                  Checkbox.adaptive(
                                    value: isDefaultAddress,
                                    onChanged: (bool? value) {
                                      _onIsDefaultAddressChanged(value!);
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
                                  context.pop();
                                },
                                child: const Text('Add'),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
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
            onPlacePicked: (LocationResult result) {
              context.pop<LocationResult>(result);

              log("Place picked: ${result.formattedAddress}");
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
      // bottomSheet: AnimatedContainer(
      //   height: bottomSheet ? 400 : 0,
      //   duration: const Duration(milliseconds: 300),
      //   decoration: BoxDecoration(
      //     color: theme.colorScheme.surface,
      //     borderRadius: const BorderRadius.only(
      //       topLeft: Radius.circular(TRadius.r16),
      //       topRight: Radius.circular(TRadius.r16),
      //     ),
      //   ),
      //   child: Padding(
      //     padding: const EdgeInsets.all(TPadding.p20).copyWith(top: 0),
      //     child: SingleChildScrollView(
      //       child: Column(
      //         children: [
      //           GestureDetector(
      //             onTap: () => _onShowBottomSheet(false),
      //             onPanDown: (details) => _onShowBottomSheet(false),
      //             child: Container(
      //               height: 6,
      //               width: 64,
      //               margin: const EdgeInsets.symmetric(vertical: TPadding.p16),
      //               decoration: BoxDecoration(
      //                 color: theme.colorScheme.outline.withValues(alpha: 0.20),
      //                 borderRadius: BorderRadius.circular(10),
      //               ),
      //             ),
      //           ),
      //           Row(
      //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //             children: [
      //               TextWidget(
      //                 'Address',
      //                 style: theme.textTheme.titleLarge,
      //               ),
      //               IconButton(
      //                 onPressed: () => _onShowBottomSheet(false),
      //                 icon: const Icon(
      //                   Icons.close,
      //                 ),
      //               ),
      //             ],
      //           ),
      //           ElevatedButton(
      //             onPressed: () {
      //               context.pop();
      //             },
      //             child: const Text('Add'),
      //           ),
      //         ],
      //       ),
      //     ),
      //   ),
      // ),
    );
  }
}

/**
 * 
class _AddNewAddressScreenState extends State<AddNewAddressScreen> {
  final Completer<GoogleMapController> _controller = Completer<GoogleMapController>();

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  static const CameraPosition _kLake = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(37.43296265331129, -122.08832357078792),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414);

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('New Address'),
        actions: const [NotificationsIconWidget()],
        bottom: PreferredSize(
          preferredSize: Size(MediaQuery.of(context).size.width, 10),
          child: const Padding(
            padding: EdgeInsets.symmetric(horizontal: TPadding.p20),
            child: Divider(),
          ),
        ),
      ),
      body: GoogleMap(
        mapType: MapType.hybrid,
        initialCameraPosition: _kGooglePlex,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _goToTheLake,
        label: const Text('To the lake!'),
        icon: const Icon(Icons.directions_boat),
      ),
    );
  }

  Future<void> _goToTheLake() async {
    final GoogleMapController controller = await _controller.future;
    await controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
  }
}
 */
