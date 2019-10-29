import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:food_ordering_app/screens/Home/index.dart';
//import 'package:google_maps_flutter/google_maps_flutter.dart';

class LocationScreen extends StatefulWidget {
  @override
  LocationScreenState createState() {
    return new LocationScreenState();
  }
}

class LocationScreenState extends State<LocationScreen> {
  Uri staticMapUri;
  //GoogleMapController mapController;

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return new Scaffold(
      appBar: new AppBar(
        automaticallyImplyLeading: false,

        title: new Text(
          "Localização Atual",
          style: new TextStyle(
              color: Theme.of(context).primaryColor,
              fontWeight: FontWeight.w500,
              fontSize: 16.0),
        ),
        elevation: 0.0,
        backgroundColor: Colors.white,

        brightness: Theme.of(context).primaryColorBrightness,
      ),
      body: new Stack(
        children: <Widget>[
//          GoogleMap(
//            onMapCreated: _onMapCreated,
//          ),
          new Container(
            width: screenSize.width,
            height: screenSize.height,
            child: new Align(
              alignment: Alignment.bottomCenter,
              child: new GestureDetector(
                onTap: () {
                  Navigator.of(context).pushNamed("/HomeWithTab");
                },
                child: new Container(
                  margin: const EdgeInsets.only(bottom: 20.0),
                  child: new Text(
                    defaultTargetPlatform == TargetPlatform.android
                        ? "CONFIRMAR LOCALIZAÇÃO"
                        : "Confirmar Localização",
                    style: const TextStyle(color: Colors.white, fontSize: 14.0),
                  ),

                  width: screenSize.width - 20,
                  height: 45.0,
//                margin: new EdgeInsets.only(
//                    top: 20.0, bottom: 20.0, left: 10.0, right: 10.0),
                  alignment: FractionalOffset.center,
                  decoration: new BoxDecoration(
                    color: Colors.red,
                    borderRadius:
                        const BorderRadius.all(const Radius.circular(5.0)),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

//  void _onMapCreated(GoogleMapController controller) {
//
//
//    controller.moveCamera(CameraUpdate.newCameraPosition(
//      CameraPosition(
//        target: LatLng(currentLocation.latitude, currentLocation.longitude),
//        tilt: 30.0,
//        zoom: 17.0,
//      ),
//    ));
//    controller.addMarker(MarkerOptions(
//      position: LatLng(currentLocation.latitude, currentLocation.longitude),
////          LatLng(currentLocation['latitude'], currentLocation['longitude']),
//    ));
//    setState(() {
//      //mapController = controller;
//    });
//  }
}
