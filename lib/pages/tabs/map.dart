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

//aim to view multiple markers at once(all down below)

  static const CameraPosition firstPosition = CameraPosition(
      target: LatLng(39.93327778, 32.85980556),
      zoom: 14); //might be any of markers(randomly)

  static const CameraPosition _kPollution =
      CameraPosition(target: fakePollutionLocation3, zoom: 16);

  static const fakePollutionLocation1 =
      LatLng(39.969288685174085, 32.84964733086899);
  static const fakePollutionLocation2 =
      LatLng(39.94697977379295, 32.86970575371591);
  static const fakePollutionLocation3 =
      LatLng(39.930394111555934, 32.840339174580635); //fake coordinates
  static const fakePollutionLocation4 =
      LatLng(39.913301649140536, 32.8721966695995);
  static const fakePollutionLocation5 =
      LatLng(39.96205415960526, 32.8908129836828); //fake coordinates
  static const fakePollutionLocation6 =
      LatLng(39.93158164476553, 32.85855004218636);

  final Marker fakePollutionMarker1 = const Marker(
      markerId: MarkerId("pollution"),
      position: fakePollutionLocation1,
      infoWindow: InfoWindow(title: "Pollution1"));
  final Marker fakePollutionMarker2 = const Marker(
      markerId: MarkerId("pollution"),
      position: fakePollutionLocation2,
      infoWindow: InfoWindow(title: "Pollution2")); //fake markers
  final Marker fakePollutionMarker3 = const Marker(
      markerId: MarkerId("pollution"),
      position: fakePollutionLocation3,
      infoWindow: InfoWindow(title: "Pollution3"));
  final Marker fakePollutionMarker4 = const Marker(
      markerId: MarkerId("pollution"),
      position: fakePollutionLocation4,
      infoWindow: InfoWindow(title: "Pollution4")); //fake markers
  final Marker fakePollutionMarker5 = const Marker(
      markerId: MarkerId("pollution"),
      position: fakePollutionLocation5,
      infoWindow: InfoWindow(title: "Pollution4"));
  final Marker fakePollutionMarker6 = const Marker(
      markerId: MarkerId("pollution"),
      position: fakePollutionLocation6,
      infoWindow: InfoWindow(title: "Pollution4"));

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
                    initialCameraPosition: firstPosition,
                    onMapCreated: (GoogleMapController controller) {
                      _controller.complete(controller);
                    },
                    markers: {
                      fakePollutionMarker1,
                      fakePollutionMarker2,
                      fakePollutionMarker3,
                      fakePollutionMarker4,
                      fakePollutionMarker5,
                      fakePollutionMarker6
                    })),
            bottomNavigationBar: FloatingActionButton.extended(
                backgroundColor: Theme.of(context).colorScheme.inversePrimary,
                onPressed: _goToThePollution,
                label: const Text('To the pollution'),
                icon: const Icon(Icons.directions_boat))));
  }

  Future<void> _goToThePollution() async {
    final GoogleMapController controller = await _controller
        .future; //to navigate between camerapositions on the map
    await controller.animateCamera(CameraUpdate.newCameraPosition(_kPollution));
  }
}
