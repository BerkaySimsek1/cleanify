import 'package:flutter/material.dart';
import '../../elements/project_elements.dart';
import "package:cleanify/widgets/home_page_widgets.dart";

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 3.0),
      child: Scaffold(
          backgroundColor: ProjectColors.projectBackgroundColor,
          body: ListView.separated(
              scrollDirection: Axis.vertical,
              itemBuilder: ((context, index) {
                print(index);
                return const ImageContainer();
              }),
              separatorBuilder: (context, index) {
                return const Divider(color: Colors.white);
              },
              itemCount: 15)),
    );
  }
}
