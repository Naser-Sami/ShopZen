import 'dart:developer';

import 'package:flutter/material.dart';

import 'package:geolocator/geolocator.dart';
import 'package:go_router/go_router.dart';
import 'package:place_picker_google/place_picker_google.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '/core/_core.dart' show IGeolocatorService, sl;
import '/config/_config.dart' show NotificationsIconWidget, TPadding, TextWidget, TSize;

class AddNewAddressScreen extends StatefulWidget {
  static const String routeName = 'new-address';
  const AddNewAddressScreen({super.key});

  @override
  State<AddNewAddressScreen> createState() => _AddNewAddressScreenState();
}

class _AddNewAddressScreenState extends State<AddNewAddressScreen> {
  LatLng latLng = const LatLng(0, 0);
  // String? mapStyle;
  String apiKey = '';

  @override
  void initState() {
    _getCurrentLocation();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // _loadMapStyle();
  }

  Future<Position> _getCurrentLocation() async {
    await sl<IGeolocatorService>().requestPermission();
    return await sl<IGeolocatorService>().getCurrentPosition();
  }

  // Future<void> _loadMapStyle() async {
  //   final stylePath = TFunctions.isDarkMode(context)
  //       ? 'assets/map/map_style_night.json'
  //       : 'assets/map/map_style_light.json';

  //   final style = await rootBundle.loadString(stylePath);
  //   setState(() {
  //     mapStyle = style;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
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
            // mapsBaseUrl: mapStyle,
            myLocationButtonEnabled: true,
            onPlacePicked: (LocationResult result) {
              context.pop<LocationResult>(result);
              log("Place picked: ${result.formattedAddress}");
            },
            initialLocation: LatLng(position?.latitude ?? 0, position?.longitude ?? 0),
            usePinPointingSearch: true,
            searchInputConfig: const SearchInputConfig(
              padding: EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 8.0,
              ),
              textDirection: TextDirection.ltr,
            ),

            enableNearbyPlaces: false,
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
