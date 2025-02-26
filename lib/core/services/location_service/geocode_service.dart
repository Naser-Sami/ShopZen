import 'package:geocode/geocode.dart';

abstract class IGeoCodeService {
  Future<Address> getAddressFromCoordinates(double latitude, double longitude);
  Future<Coordinates> getCoordinatesFromAddress(String address);
}

class GeoCodeServiceImpl implements IGeoCodeService {
  GeoCode geoCode = GeoCode();

  @override
  Future<Coordinates> getCoordinatesFromAddress(String address) async =>
      await geoCode.forwardGeocoding(address: address);

  @override
  Future<Address> getAddressFromCoordinates(double latitude, double longitude) async =>
      await geoCode.reverseGeocoding(latitude: latitude, longitude: longitude);
}
