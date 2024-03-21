import 'package:flutter/material.dart';
import 'package:flutter_overlay_apps/flutter_overlay_apps.dart';
import 'dart:async';

void main() {
  runApp(const MyApp());
}

@pragma("vm:entry-point")
void showOverlay() {
  runApp(const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: OverLayContent()));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Hi There"),
        ),
        body: Center(
          child: ElevatedButton(
              onPressed: () async {
                // Open overlay
                await FlutterOverlayApps.showOverlay(
                    height: 700,
                    alignment: OverlayAlignment.bottomCenter);

                // send data to ovelay
                await Future.delayed(const Duration(seconds: 2));
                FlutterOverlayApps.sendDataToAndFromOverlay(
                    "Hello from PathOr");
              },
              child: const Text("showOverlay")),
        ),
      ),
    );
  }
}

class OverLayContent extends StatefulWidget {
  const OverLayContent({Key? key}) : super(key: key);

  @override
  State<OverLayContent> createState() => _MyOverlaContentState();
}

class _MyOverlaContentState extends State<OverLayContent> {
  // String _dataFromApp = "Hey send data";
  late final StreamController overlayStream;

  @override
  void initState() {
    super.initState();

    // lisent for any data from the main app
    overlayStream = FlutterOverlayApps.overlayListener();
    overlayStream.stream.listen((event) {
      // setState(() {
      //   _dataFromApp = event.toString();
      // });
    });
  }

  @override
  void dispose() {
    overlayStream.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child:Card(
        shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16)),
        // child: InkWell(
        //   onTap: () {
        //     // close overlay
        //     FlutterOverlayApps.closeOverlay();
        //   },
        //   child: Card(
        //     shape: RoundedRectangleBorder(
        //       borderRadius: BorderRadius.circular(16),
        //     ),
        //     child: Center(
        //         child: Text(
        //           _dataFromApp,
        //           style: const TextStyle(color: Colors.red),
        //         )),
        //   ),
        // ),

        //////////
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children:<Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                InkWell(
                  onTap: (){
                    FlutterOverlayApps.closeOverlay();
                  },
                  child: Icon(Icons.close),
                )
              ],
            ),
            Text(
              "Hello From PathOr",
              // _dataFromApp,
              style: const TextStyle(color: Colors.purple,fontSize: 40),
            )
          ]
        )

      /////////////
      )

    );
  }
}