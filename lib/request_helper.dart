import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_digitalocean/model/app_data_model.dart';
import 'package:provider/provider.dart';

import '.varialble.dart';
import 'package:http/http.dart' as http;

import 'model/droplets_model.dart';

class RequestHelper {
  final String host;
  final String key;
  RequestHelper({
    required this.host,
    required this.key,
  });

  static Future<dynamic> createNewSshKey({
    required String publicKey,
  }) async {
    var url = 'https://api.digitalocean.com/v2/account/keys';
    Map<String, dynamic> _body = {
      "public_key": publicKey,
      "name": "My SSH Public Key"
    };

    http.Response response = await http.post(Uri.parse(url),
        headers: {
          'content-Type': 'application/json',
          'Authorization': 'Bearer $tokenDO'
        },
        body: jsonEncode(_body));

    print('Status code is: ${response.statusCode}');
    try {
      if (response.statusCode == 201) {
        print('Key added');

        String _data = response.body;
        var _decodeData = jsonDecode(_data);
        return (_decodeData['ssh_key']['id']);
      } else {
        print('failed key add');
        return 'failed';
      }
    } catch (e) {
      print('Failed error: $e');
      return 'FAILED';
    }
  }

  static Future<dynamic> createNewDrople({required int sshKeyID}) async {
    var url = 'https://api.digitalocean.com/v2/droplets';
    Map<String, dynamic> _body = {
      "name": "example.com",
      "region": "nyc3",
      "size": "s-1vcpu-1gb",
      "image": "ubuntu-18-04-x64",
      "ssh_keys": [sshKeyID],
      "backups": false,
      "ipv6": true,
      "private_networking": null,
      "tags": ["test"],
      "volumes": null,
      "user_data": null,
    };

    http.Response response = await http.post(Uri.parse(url),
        headers: {
          'content-Type': 'application/json',
          'Authorization': 'Bearer $tokenDO'
        },
        body: jsonEncode(_body));

    print('Status code is: ${response.statusCode}');
    try {
      if (response.statusCode == 202) {
        print('Droplet created');

        String _data = response.body;
        var _decodeData = jsonDecode(_data);
        return (_decodeData['droplet']['id']);
      } else {
        print('failed created droplet');
        return 'failed';
      }
    } catch (e) {
      print('Failed error: $e');
      return 'FAILED';
    }
  }

  static Future<dynamic> getListAllDroplet(
      {required BuildContext context, required int id}) async {
    var url = 'https://api.digitalocean.com/v2/droplets';
    http.Response response = await http.get(
      Uri.parse(url),
      headers: {
        'content-Type': 'application/json',
        'Authorization': 'Bearer $tokenDO'
      },
    );

    print('Status code : ${response.statusCode}');

    try {
      if (response.statusCode == 200) {
        print('List All Droplet OK');
        final dropletsList = dropletsListFromJson(response.body);

        List<Droplet> _list = dropletsList.droplets;
        print('Length is ${_list.length}');
        _list.forEach((item) {
          if (item.id == id) {
            List<V4> _listIp = item.networks.v4;
            _listIp.forEach((element) {
              if (element.type == 'public') {
                print(element.ipAddress);
                //save ip
                Provider.of<AppDataModel>(context, listen: false)
                    .updateIpAddress(element.ipAddress);
                return;
              } else {
                print('not public');
              }
            });
          } else {
            print('failed ID');
          }
        });
      } else {
        print('failed');
        return 'failed';
      }
    } catch (e) {
      print(e);
      return;
    }
  }
}
