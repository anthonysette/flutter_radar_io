import 'package:flutter/material.dart';

import 'package:flutter/services.dart';
import 'package:flutter_radar_io/flutter_radar_io.dart';
import 'package:permission_handler/permission_handler.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Radar.io Example'),
        ),
        body: ListView(
          children: [
            StreamBuilder(
              stream: FlutterRadarIo.radarStream,
              initialData: "no data",
              builder: (BuildContext context, AsyncSnapshot snapshot){
                if(snapshot.hasData){
                  return Text(snapshot.data.toString());
                }
                return Text("NO DATA");
              },
            ),
            MaterialButton(
              child: Center(
                child: Text(
                  "Request Permissions",
                ),
              ),
              onPressed: () async {
                try {
                  await Permission.locationAlways.request();
                } on PlatformException {
                  print('There has been an error');
                }
              },
            ),
            MaterialButton(
              child: Center(
                child: Text(
                  "Initialize",
                ),
              ),
              onPressed: () async {
                bool result = await FlutterRadarIo.initialize(
                    publishableKey:
                        'prj_test_pk_83e44ccd6f6800ba394e2f28c8d96f315eb611ea');
                print(result);
              },
            ),
            MaterialButton(
              child: Center(
                child: Text(
                  "Set Log Level",
                ),
              ),
              onPressed: () async {
                bool result = await FlutterRadarIo.setLogLevel(level: 'none');
                print(result);
              },
            ),
            MaterialButton(
              child: Center(
                child: Text(
                  "Set User Id",
                ),
              ),
              onPressed: () async {
                bool result =
                    await FlutterRadarIo.setUserId(uid: 'new-device');
                print(result);
              },
            ),
            MaterialButton(
              child: Center(
                child: Text(
                  "Get User Id",
                ),
              ),
              onPressed: () async {
                String result = await FlutterRadarIo.getUserId();
                print(result);
              },
            ),
            MaterialButton(
              child: Center(
                child: Text(
                  "Set Metadata",
                ),
              ),
              onPressed: () async {
                Map<String, dynamic> temp = {"test": true};
                bool result = await FlutterRadarIo.setMetadata(metadata: temp);
                print(result);
              },
            ),
            MaterialButton(
              child: Center(
                child: Text(
                  "Get Metadata",
                ),
              ),
              onPressed: () async {
                Map<String, dynamic> result =
                    await FlutterRadarIo.getMetaData();
                print(result);
              },
            ),
            MaterialButton(
              child: Center(
                child: Text(
                  "Set Description",
                ),
              ),
              onPressed: () async {
                bool result = await FlutterRadarIo.setDescription(
                    description: "Test description.");
                print(result);
              },
            ),
            MaterialButton(
              child: Center(
                child: Text(
                  "Get Description",
                ),
              ),
              onPressed: () async {
                String result = await FlutterRadarIo.getDescription();
                print(result);
              },
            ),
            MaterialButton(
              child: Center(
                child: Text(
                  "Track Once",
                ),
              ),
              onPressed: () async {
                try {
                  Map<String, dynamic> test = await FlutterRadarIo.trackOnce();
                  print(test["status"]);
                  print(test["user"]);
                  print(test["location"]);
                  print(test["events"]);
                } on PlatformException {
                  print('There has been an error');
                }
              },
            ),
            MaterialButton(
              child: Center(
                child: Text(
                  "Is Tracking",
                ),
              ),
              onPressed: () async {
                bool test = await FlutterRadarIo.isTracking();
                print(test);
              },
            ),
            MaterialButton(
              child: Center(
                child: Text(
                  "Start Tracking",
                ),
              ),
              onPressed: () async {
                bool test =
                    await FlutterRadarIo.startTracking(mode: "continuous");
                print(test);
              },
            ),
            MaterialButton(
              child: Center(
                child: Text(
                  "Stop Tracking",
                ),
              ),
              onPressed: () async {
                bool test = await FlutterRadarIo.stopTracking();
                print(test);
              },
            )
          ],
        ),
      ),
    );
  }
}
