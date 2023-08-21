import 'dart:async';

import 'package:digital_business_cards/database/DatabaseHelper.dart';
import 'package:flutter/material.dart';

/**
 * Class based on the code from Flutter Documentation: https://docs.flutter.dev/data-and-backend/state-mgmt/simple
 */
class CardProvider extends ChangeNotifier {
  List<Map<String, dynamic>> _data = [];

  List<Map<String, dynamic>> get data => _data;

  void updateData(List<Map<String, dynamic>> newData) {
    _data = newData;
    notifyListeners();
  }

  void listenToDataChanges() {
    DatabaseHelper.dataStream.listen((data) {
      updateData(data);
    });
  }
}