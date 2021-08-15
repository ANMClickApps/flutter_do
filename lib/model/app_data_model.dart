import 'package:flutter/material.dart';

class AppDataModel with ChangeNotifier {
  int _idDroplet = 0;
  String _ipAddress = '';

  //droplet id
  int get getDropletID => _idDroplet;
  void updateDropletID(int id) {
    _idDroplet = id;
    notifyListeners();
  }

  //ipaddress (host)
  String get getIpAddress => _ipAddress;
  void updateIpAddress(String ip) {
    _ipAddress = ip;
    notifyListeners();
  }
}
