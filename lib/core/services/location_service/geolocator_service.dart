import 'dart:async';
import 'dart:developer';

import 'package:geolocator/geolocator.dart';

abstract class IGeolocatorService {
  Future<Position> getCurrentPosition();
  Future<Position?> getLastKnownPosition();
  Future<LocationAccuracyStatus> getLocationAccuracy();
  Future<bool> isLocationServiceEnabled();
  Future<LocationPermission> checkPermission();
  Future<LocationPermission> requestPermission();
  Future<Position> determinePosition();
  double distanceBetween(double startLatitude, double startLongitude, double endLatitude,
      double endLongitude);
  double bearingBetween(double startLatitude, double startLongitude, double endLatitude,
      double endLongitude);
  StreamSubscription<Position> getPositionStream();
  StreamSubscription<ServiceStatus> getServiceStatusStream();
}

class GeolocatorServiceImpl implements IGeolocatorService {
  LocationSettings locationSettings = const LocationSettings(
    distanceFilter: 100,
  );

  @override
  Future<Position> getCurrentPosition() async {
    await Geolocator.requestPermission();
    return await Geolocator.getCurrentPosition(locationSettings: locationSettings);
  }

  @override
  Future<Position?> getLastKnownPosition() async =>
      await Geolocator.getLastKnownPosition();

  @override
  Future<LocationAccuracyStatus> getLocationAccuracy() async =>
      await Geolocator.getLocationAccuracy();

  @override
  Future<bool> isLocationServiceEnabled() async =>
      await Geolocator.isLocationServiceEnabled();

  @override
  Future<LocationPermission> checkPermission() async =>
      await Geolocator.checkPermission();

  @override
  Future<LocationPermission> requestPermission() async =>
      await Geolocator.requestPermission();

  @override
  Future<Position> determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await requestPermission();

      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await getCurrentPosition();
  }

  @override
  StreamSubscription<Position> getPositionStream() {
    StreamSubscription<Position> positionStream =
        Geolocator.getPositionStream(locationSettings: locationSettings)
            .listen((Position? position) {
      log(position == null
          ? 'Unknown'
          : '${position.latitude.toString()}, ${position.longitude.toString()}');
    });

    return positionStream;
  }

  @override
  StreamSubscription<ServiceStatus> getServiceStatusStream() {
    StreamSubscription<ServiceStatus> serviceStatusStream =
        Geolocator.getServiceStatusStream().listen((ServiceStatus status) {
      log(status.toString());
    });

    return serviceStatusStream;
  }

  @override
  double distanceBetween(double startLatitude, double startLongitude, double endLatitude,
          double endLongitude) =>
      Geolocator.distanceBetween(
          startLatitude, startLongitude, endLatitude, endLongitude);

  @override
  double bearingBetween(double startLatitude, double startLongitude, double endLatitude,
          double endLongitude) =>
      Geolocator.bearingBetween(startLatitude, startLongitude, endLatitude, endLongitude);
}
