import 'dart:async';
import 'dart:developer';
import 'dart:isolate';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/services.dart';
import 'dart:convert';

import '/features/your_location/_locations.dart';

class SearchLocationCubit extends Cubit<List<CountryModel>> {
  SearchLocationCubit() : super([]);

  List<CountryModel> _allLocations = [];

  /// Load JSON in the main thread, then send it to an Isolate for parsing
  Future<void> loadLocations(String filePath) async {
    try {
      WidgetsFlutterBinding.ensureInitialized(); // Ensure binding is initialized

      String jsonString = await rootBundle.loadString(filePath);

      final ReceivePort receivePort = ReceivePort();
      await Isolate.spawn(_parseJsonInIsolate, receivePort.sendPort);

      final sendPort = await receivePort.first as SendPort;
      final responsePort = ReceivePort();

      sendPort.send([jsonString, responsePort.sendPort]);

      _allLocations = await responsePort.first as List<CountryModel>;

      emit([]);
    } catch (e) {
      log("Error: $e");
      emit([]);
    }
  }

  /// Search function
  void search(String query) {
    if (query.isEmpty) {
      emit([]);
      return;
    }

    final results = _allLocations.where((country) {
      bool matchesCountry = country.country!.toLowerCase().contains(query.toLowerCase());
      bool matchesCity =
          country.cities!.any((city) => city.toLowerCase().contains(query.toLowerCase()));

      return matchesCountry || matchesCity;
    }).toList();

    emit(results);
  }
}

/// **Isolate Function to Parse JSON**
void _parseJsonInIsolate(SendPort sendPort) async {
  final ReceivePort responsePort = ReceivePort();
  sendPort.send(responsePort.sendPort);

  await for (var message in responsePort) {
    String jsonString = message[0]; // Get the JSON string instead of file path
    SendPort replyPort = message[1];

    try {
      final data = jsonDecode(jsonString);

      List<CountryModel> parsedList = (data['data'] as List<dynamic>)
          .map((item) => CountryModel.fromJson(item as Map<String, dynamic>))
          .toList();

      replyPort.send(parsedList);
    } catch (e) {
      log("Error in Isolate: $e");
      replyPort.send([]);
    }
  }
}
