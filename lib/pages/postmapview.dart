import 'dart:async';

import 'package:cleanify/elements/project_elements.dart';
import 'package:cleanify/pages/tabbar.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class PostMapView extends StatefulWidget {
  const PostMapView({super.key});

  @override
  State<PostMapView> createState() => _PostMapViewState();
}

//aim to view one marker(defined by user)
class _PostMapViewState extends State<PostMapView> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  static const fakeUserPollutionLocation = LatLng(39.93774183294341,
      32.859935440843024); //marker location that selected by user while posting (need instance from firebase)

  static const CameraPosition firstPosition = CameraPosition(
      target: fakeUserPollutionLocation,
      zoom:
          15); // firstPosition coordinations must match with fakeUserPollutionLocation coordinations

  final Marker fakeUserPollutionMarker = const Marker(
      markerId: MarkerId("pollution"),
      position:
          fakeUserPollutionLocation, //marker that selected by user while posting (need instance from firebase)
      infoWindow:
          InfoWindow(title: "Pollution")); //might add author username here

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(5),
        child: Scaffold(
            appBar: const CommonAppbar(preference: "back"),
            body: Container(
                decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(15)),
                    shape: BoxShape.rectangle,
                    border: Border.all(
                        width: 3, color: ProjectColors.imageBorderColor)),
                child: GoogleMap(
                    mapType: MapType.normal,
                    initialCameraPosition: firstPosition,
                    onMapCreated: (GoogleMapController controller) {
                      _controller.complete(controller);
                    },
                    markers: {fakeUserPollutionMarker}))));
  }
}
