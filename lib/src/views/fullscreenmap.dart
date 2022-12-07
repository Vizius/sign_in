import 'package:flutter/material.dart';
import 'package:mapbox_gl/mapbox_gl.dart';

class FullScreenMap extends StatefulWidget {
  static const String routerName ='full';

  @override
  State<FullScreenMap> createState() => _FullScreenMapState();
}

class _FullScreenMapState extends State<FullScreenMap> {
  static const String ACCESS_TOKEN = 'sk.eyJ1IjoibXNhcmFiaWEiLCJhIjoiY2xiZHNqY240MDRsdTNubmsycmo5bDE5dCJ9.KF2rTjr_ahSQPYBQiDIFLg';

  late MapboxMapController mapController;
  final center = LatLng(-39.7984442,-73.2175568);

  void _onMapCreated(MapboxMapController controller)
  {
    mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack
      (
        children: [
         Container(
          width: double.infinity,
          height: 800,
          child: MapboxMap(
            styleString: 'mapbox://styles/msarabia/clbdtp7bw000b15rs6buye138',
            accessToken: ACCESS_TOKEN,
            onMapCreated: _onMapCreated,
            initialCameraPosition:  CameraPosition(
              target: center,
              zoom: 16
            )
          ),
          
        ),
        SafeArea(
          child: Positioned(
            child: IconButton(
              icon: Icon(Icons.arrow_back_ios_new,size: 40,color: Colors.white,),
              onPressed: () {
                Navigator.of(context).pop();
              },
          )),
        ),
      ],
      )
    );
   
  }
}