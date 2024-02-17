import 'package:cleanify/pages/post.dart';
import 'package:flutter/material.dart';
import '../../elements/project_elements.dart';

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
                  debugPrint(index.toString());
                  return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      child: Container(
                          decoration: BoxDecoration(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(15)),
                              shape: BoxShape.rectangle,
                              border: Border.all(
                                  width: 3,
                                  color: ProjectColors.imageBorderColor)),
                          height: 450,
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Row(children: [
                                      CircleAvatar(
                                          radius: 20,
                                          backgroundImage: AssetImage(
                                              'assets/profilepicture.jpg')),
                                      SizedBox(width: 10),
                                      Expanded(
                                          flex: 3,
                                          child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text('Full Name',
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 16)),
                                                Text('username',
                                                    style: TextStyle(
                                                        color: Colors.grey))
                                              ])),
                                      Spacer(),
                                      Text('Date Posted',
                                          style: TextStyle(color: Colors.grey))
                                    ])),
                                const Expanded(
                                  flex: 1,
                                  child: Padding(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 8),
                                      child: Text('Description',
                                          style: TextStyle(fontSize: 16))),
                                ),
                                Expanded(
                                    flex: 5,
                                    child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8),
                                        child: Container(
                                            height: 300,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    const BorderRadius.all(
                                                        Radius.circular(5)),
                                                shape: BoxShape.rectangle,
                                                border: Border.all(
                                                    width: 2,
                                                    color: ProjectColors
                                                        .imageBorderColor)),
                                            child: const Center(
                                                child: Text('Media Asset'))))),
                                const Expanded(
                                  flex: 1,
                                  child: Padding(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 8),
                                      child: Row(children: [
                                        Icon(Icons.location_on,
                                            color: Colors.grey),
                                        SizedBox(width: 5),
                                        Text('Location',
                                            style:
                                                TextStyle(color: Colors.grey))
                                      ])),
                                )
                              ])));
                }),
                separatorBuilder: (context, index) {
                  return const Divider(color: Colors.white);
                },
                itemCount: 15),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) {
                  return const PostPage();
                }));
              },
              backgroundColor: Theme.of(context).colorScheme.inversePrimary,
              child: const Icon(Icons.add),
            )));
  }
}

//advanced widget models:

//class PollutionView extends StatelessWidget {
//  final String authorName;
//  final String pollutionLocation;
//  const PollutionView(
//      {Key? key, required this.authorName, required this.pollutionLocation})
//      : super(key: key);
//
//  @override
//  Widget build(BuildContext context) {
//    return Stack(children: [
//      Padding(
//          padding: const EdgeInsets.only(
//                top: 18.0,
//              ) +
//              const EdgeInsets.symmetric(horizontal: 10),
//          child: Container(
//              decoration: const BoxDecoration(
//                  color: ProjectColors.projectDefaultColor,
//                  borderRadius: BorderRadius.all(Radius.circular(20))),
//              height: 150,
//              width: 150,
//              child:
//                  Column(mainAxisAlignment: MainAxisAlignment.end, children: [
//                const Spacer(flex: 4),
//                Expanded(
//                    flex: 5,
//                    child: TextButton(
//                        onPressed: () {},
//                        child: Text(authorName,
//                            style: ProjectTextStyles.styleListViewGeneral))),
//                Expanded(
//                    flex: 4,
//                    child: Text(pollutionLocation, textAlign: TextAlign.center))
//              ]))),
//      Padding(
//          padding: const EdgeInsets.only(bottom: 20, left: 47.5),
//          child: ClipRRect(borderRadius: BorderRadius.circular(500.0)))
//    ]);
//  }
//}

// class ListView2 extends StatefulWidget {
//   const ListView2({super.key});
// 
//   @override
//   State<ListView2> createState() => _ListView2State();
// }
// 
// class _ListView2State extends State<ListView2> {
//   @override
//   Widget build(BuildContext context) {
//     return ListView.builder(
//         itemCount: 10,
//         scrollDirection: Axis.horizontal,
//         itemBuilder: (context, index) {
//           return Row(children: [
//             SizedBox(
//                 height: 300,
//                 child: ListView(
//                     shrinkWrap: true,
//                     scrollDirection: Axis.horizontal,
//                     children: const [
//                       PollutionView(
//                           authorName: "author", pollutionLocation: "location")
//                     ]))
//           ]);
//         });
//   }
// }