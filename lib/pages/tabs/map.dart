import 'dart:async';
import 'package:cleanify/elements/project_elements.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => MapPageState();
}

class MapPageState extends State<MapPage> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  static const CameraPosition _kGooglePlex =
      CameraPosition(target: LatLng(39.93327778, 32.85980556), zoom: 14);

  static const CameraPosition _kPollution =
      CameraPosition(target: _pollution, zoom: 16);

  static const _pollution = LatLng(39.93774183294341, 32.859935440843024);

  final Marker locationMarker = const Marker(
      markerId: MarkerId("pollution"),
      position: _pollution,
      infoWindow: InfoWindow(title: "Pollution"));

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: Scaffold(
          body: Container(
            decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(15)),
                shape: BoxShape.rectangle,
                border: Border.all(
                    width: 3, color: ProjectColors.imageBorderColor)),
            child: GoogleMap(
                mapType: MapType.normal,
                initialCameraPosition: _kGooglePlex,
                onMapCreated: (GoogleMapController controller) {
                  _controller.complete(controller);
                },
                markers: const {}),
          ),
          floatingActionButton: FloatingActionButton.extended(
              backgroundColor: Theme.of(context).colorScheme.inversePrimary,
              onPressed: _goToThePollution,
              label: const Text('To the pollution'),
              icon: const Icon(Icons.directions_boat))),
    );
  }

  Future<void> _goToThePollution() async {
    final GoogleMapController controller = await _controller.future;
    await controller.animateCamera(CameraUpdate.newCameraPosition(_kPollution));
  }
}
