import 'package:flutter/material.dart';
import '../../elements/project_elements.dart';

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: ProjectColors.projectBackgroundColor);
  }
}
