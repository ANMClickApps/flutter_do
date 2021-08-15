//@dart=2.9

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_digitalocean/model/app_data_model.dart';
import 'package:flutter_digitalocean/request_helper.dart';
import 'package:provider/provider.dart';
import 'package:ssh/ssh.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AppDataModel(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String keyID;
  String dropletID;
  String _result;

  @override
  void initState() {
    // TODO: implement initState
    keyID = '';
    dropletID = '';
    _result = '';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  Color.fromRGBO(92, 19, 73, 1.0))),
                          onPressed: createdNewDroplet,
                          child: Text(
                            'create droplet'.toUpperCase(),
                          ),
                        ),
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  Color.fromRGBO(92, 19, 73, 1.0))),
                          onPressed: () async {
                            await RequestHelper.getListAllDroplet(
                              context: context,
                              id: Provider.of<AppDataModel>(context,
                                      listen: false)
                                  .getDropletID,
                            );
                          },
                          child: Text(
                            'get ip address'.toUpperCase(),
                          ),
                        ),
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  Color.fromRGBO(92, 19, 73, 1.0))),
                          onPressed: () async {
                            onClickShell(
                                host: Provider.of<AppDataModel>(context,
                                        listen: false)
                                    .getIpAddress);
                          },
                          child: Text(
                            'connect'.toUpperCase(),
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 20.0),
                  Text('SSH key ID: $keyID'),
                  SizedBox(height: 10.0),
                  Text('Droplet ID: $dropletID'),
                  SizedBox(height: 20.0),
                  Text(_result),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> createdNewDroplet() async {
    print('Start');
    var _res = await RequestHelper.createNewSshKey(
        publicKey:
            'ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDm65Q/ePHt0tObpUeHAZrioJ8WOjIUkD6Al1jasAryEXmk/qfRjbm1rT0cLY9OEa53u6ExlpWuzZrzH2faIzfP7DkpZBhPZD1H/dtLAyFtbXAbgE2Yr7SuHzVVQzxXc7/Z0R113JwQ3ndFmT/0W47mSqfO3xuY2CiKtcpTilucbn9vh/Wuo5qXgG7alerxsBR1gzO9xyraltDVY+RiNAaBgCBYtAFCNwKeVj0awRs1Dznk3i+aFH0zs9NTsdy5m8jGOtLCDPHmgzqjy38tzKcyidxG6tB0HzHu0e7XUmZ3PHybSJpN/sDIK/8z3PVBCHfeaLjxJ4QaGcDjEkh4FcaH alex@n256');

    if (_res.toString() != 'failed') {
      print('ID key: $_res');
      var _resDroplet = await RequestHelper.createNewDrople(sshKeyID: _res);

      if (_resDroplet.toString() != 'failed') {
        print(_resDroplet);
        Provider.of<AppDataModel>(context, listen: false)
            .updateDropletID(_resDroplet);
        setState(() {
          keyID = _res.toString();
          dropletID = _resDroplet.toString();
        });
      }
    }
  }

  Future<void> onClickShell({String host}) async {
    var client = SSHClient(
      host: host,
      port: 22,
      username: "root",
      passwordOrKey: {
        "privateKey": '''-----BEGIN RSA PRIVATE KEY-----
...Your PRIVATE KEY......
-----END RSA PRIVATE KEY-----'''
      },
    );

    try {
      String result = await client.connect();
      if (result == "session_connected") {
        result = await client.startShell(
            // ptyType: "xterm",
            callback: (dynamic res) {
          setState(() {
            _result += res;
          });
        });

        if (result == "shell_started") {
          print(await client.writeToShell(
              "wget https://raw.githubusercontent.com/Nyr/openvpn-install/a6048d509fff11c28cbabc36633f76c1ac5ce988/openvpn-install.sh && bash openvpn-install.sh\n"));
          print(await client.writeToShell("\n"));
          print(await client.writeToShell("\n"));
          print(await client.writeToShell("\n"));
          print(await client.writeToShell("\n"));
          print(await client.writeToShell("\n"));
          print(await client.writeToShell("\n"));
          print(await client.writeToShell("\n"));

          // Future.delayed(const Duration(seconds: 20), () async {
          //   await client.closeShell();
          // });

        }
      }
    } on PlatformException catch (e) {
      print('Error: ${e.code}\nError Message: ${e.message}');
    }
  }
}
