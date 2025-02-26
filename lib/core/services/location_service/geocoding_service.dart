import 'package:geocoding/geocoding.dart';

abstract class IGeocodingService {
  Future<List<Location>> locationFromAddress(String address);
  Future<List<Placemark>> placemarkFromCoordinates(double lat, double lng);
}

class GeocodingServiceImpl implements IGeocodingService {
  final GeocodingPlatform? _geocodingPlatform = GeocodingPlatform.instance;

  @override
  Future<List<Location>> locationFromAddress(String address) async =>
      await _geocodingPlatform?.locationFromAddress(address) ?? [];

  @override
  Future<List<Placemark>> placemarkFromCoordinates(double lat, double lng) =>
      _geocodingPlatform?.placemarkFromCoordinates(lat, lng) ?? Future.value([]);
}
