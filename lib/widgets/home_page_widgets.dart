import 'package:flutter/material.dart';
import 'package:cleanify/elements/project_elements.dart';

class ImageContainer extends StatelessWidget {
  const ImageContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: Container(
            decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(15)),
                shape: BoxShape.rectangle,
                border: Border.all(
                    width: 2, color: ProjectColors.imageBorderColor)),
            height: 350,
            width: 350,
            child: const ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(15)))));
  }
}

class ListView2 extends StatefulWidget {
  const ListView2({super.key});

  @override
  State<ListView2> createState() => _ListView2State();
}

class _ListView2State extends State<ListView2> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: 10,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return Row(children: [
            SizedBox(
                height: 300,
                child: ListView(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    children: const [
                      PollutionView(
                          authorName: "author", pollutionLocation: "location")
                    ]))
          ]);
        });
  }
}

class PollutionView extends StatelessWidget {
  final String authorName;
  final String pollutionLocation;
  const PollutionView(
      {Key? key, required this.authorName, required this.pollutionLocation})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Padding(
          padding: const EdgeInsets.only(
                top: 18.0,
              ) +
              const EdgeInsets.symmetric(horizontal: 10),
          child: Container(
              decoration: const BoxDecoration(
                  color: ProjectColors.projectDefaultColor,
                  borderRadius: BorderRadius.all(Radius.circular(20))),
              height: 150,
              width: 150,
              child:
                  Column(mainAxisAlignment: MainAxisAlignment.end, children: [
                const Spacer(flex: 4),
                Expanded(
                    flex: 5,
                    child: TextButton(
                        onPressed: () {},
                        child: Text(authorName,
                            style: ProjectTextStyles.styleListViewGeneral))),
                Expanded(
                    flex: 4,
                    child: Text(pollutionLocation, textAlign: TextAlign.center))
              ]))),
      Padding(
          padding: const EdgeInsets.only(bottom: 20, left: 47.5),
          child: ClipRRect(borderRadius: BorderRadius.circular(500.0)))
    ]);
  }
}
