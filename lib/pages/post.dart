import 'dart:io';
import 'package:cleanify/elements/project_elements.dart';
import 'package:cleanify/pages/mapselect.dart';
import 'package:cleanify/pages/tabbar.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class PostPage extends StatefulWidget {
  const PostPage({Key? key}) : super(key: key);

  @override
  State<PostPage> createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {
  bool mediaRemains = false;
  bool mapSelected = false;
  String description = "";
  File? _selectedImage;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const CommonAppbar(preference: "back"),
        backgroundColor: ProjectColors.projectBackgroundColor,
        body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20) +
                const EdgeInsets.only(top: 25),
            child: ListView.builder(
              itemCount: 1,
              itemBuilder: (context, index) {
                return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                          height: 50,
                          child: Text("Create a post",
                              style: Theme.of(context)
                                  .textTheme
                                  .displayLarge
                                  ?.copyWith(
                                      fontSize: 25,
                                      shadows: [
                                        const Shadow(
                                            offset: Offset(0.2, 1),
                                            blurRadius: 0.5)
                                      ],
                                      color: ProjectColors.defaultTextColor))),
                      TextField(
                          maxLength: 300,
                          onChanged: (value) {
                            setState(() {
                              description = value;
                              print(description);
                            });
                          },
                          maxLines: 7,
                          decoration: const InputDecoration(
                              isDense: true,
                              hintText: 'Describe the pollution',
                              labelText: "Description",
                              border: OutlineInputBorder())),
                      Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Row(children: [
                            Expanded(
                                flex: 3,
                                child: IconButton(
                                    onPressed: () {
                                      showModalBottomSheet(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return Container(
                                                padding:
                                                    const EdgeInsets.all(10),
                                                child: Column(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    children: [
                                                      ListTile(
                                                          title: const Text(
                                                              "From Gallery",
                                                              style: ProjectTextStyles
                                                                  .styleListViewGeneral),
                                                          onTap: () {
                                                            mediaRemains = true;
                                                            _pickImageFromGallery();
                                                            Navigator.of(
                                                                    context)
                                                                .pop();
                                                          }),
                                                      ListTile(
                                                          title: const Text(
                                                              "Take Photo",
                                                              style: ProjectTextStyles
                                                                  .styleListViewGeneral),
                                                          onTap: () {
                                                            _pickImageFromCamera();
                                                            Navigator.of(
                                                                    context)
                                                                .pop();
                                                          })
                                                    ]));
                                          });
                                    },
                                    color: mediaRemains
                                        ? Colors.green
                                        : Colors.red,
                                    icon: const Icon(Icons.photo),
                                    iconSize: 30)),
                            Expanded(
                                flex: 3,
                                child: IconButton(
                                    onPressed: () async {
                                      final result = await Navigator.of(context)
                                          .push(MaterialPageRoute(
                                              builder: (context) =>
                                                  MapSelect()));
                                      if (result != null) {
                                        setState(() {
                                          mapSelected = true;
                                        });
                                      } else {
                                        setState(() {
                                          mapSelected = false;
                                        });
                                      }
                                      print("mapSelected: $result");
                                    },
                                    color:
                                        mapSelected ? Colors.green : Colors.red,
                                    icon: const Icon(Icons.location_pin),
                                    iconSize: 30)),
                            const Spacer(flex: 12),
                            Expanded(
                                flex: 6,
                                child: ElevatedButton(
                                    onPressed: () {
                                      if (description.isNotEmpty &&
                                          mediaRemains &&
                                          mapSelected) {
                                        //save description, media and location to database
                                        Navigator.of(context).pop();
                                      } else {}
                                    },
                                    child: const Text("Post")))
                          ])),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: (description.isNotEmpty &&
                                  mediaRemains &&
                                  mapSelected)
                              ? []
                              : ((description.isNotEmpty &&
                                      mediaRemains &&
                                      mapSelected == false)
                                  ? [const Text("Please select a location")]
                                  : ((description.isNotEmpty &&
                                          mediaRemains == false &&
                                          mapSelected)
                                      ? [const Text("Media is required")]
                                      : ((description.isEmpty &&
                                              mediaRemains &&
                                              mapSelected)
                                          ? [
                                              const Text(
                                                  "Please enter a description")
                                            ]
                                          : ((description.isNotEmpty &&
                                                  mediaRemains == false &&
                                                  mapSelected == false)
                                              ? [
                                                  const Text(
                                                      "Media and location needed")
                                                ]
                                              : ((description.isEmpty &&
                                                      mediaRemains &&
                                                      mapSelected == false)
                                                  ? [
                                                      const Text(
                                                          "Description and location needed")
                                                    ]
                                                  : ((description.isEmpty &&
                                                          mediaRemains ==
                                                              false &&
                                                          mapSelected)
                                                      ? [
                                                          const Text(
                                                              "Description and media required")
                                                        ]
                                                      : [
                                                          const Text(
                                                              "Description, media and location required")
                                                        ]))))))),
                      const SizedBox(height: 30),
                      _selectedImage != null
                          ? Container(
                              height: 200,
                              width: 200,
                              child: Image.file(_selectedImage!,
                                  fit: BoxFit.cover))
                          : const Text("Please select an image")
                    ]);
              },
            )));
  }

  Future _pickImageFromGallery() async {
    final returnedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (returnedImage == null) return;
    setState(() {
      _selectedImage = File(returnedImage.path);
    });
  }

  Future _pickImageFromCamera() async {
    final returnedImage =
        await ImagePicker().pickImage(source: ImageSource.camera);
    if (returnedImage == null) return;
    setState(() {
      _selectedImage = File(returnedImage.path);
      _selectedImage == null ? mediaRemains = false : mediaRemains = true;
    });
  }
}


// showDialog(
//                       barrierDismissible: true,
//                       context: context,
//                       builder: (context) {
//                         return const AlertDialog(
//                           title: const Text("Version update exists"),
//                           actions: [
//                             TextButton(
//                                 onPressed: () {
//                                   Navigator.pop(context);
//                                 },
//                                 child: const Text("Close")),
//                             const SizedBox(width: 75),
//                             ElevatedButton(
//                                 onPressed: () {
//                                   Navigator.of(context).push(MaterialPageRoute(
//                                       builder: (context) {
//                                         return const AlertDialog(
//                                           title: Row(
//                                             mainAxisAlignment:
//                                                 MainAxisAlignment.spaceBetween,
//                                             children: [
//                                               const Text("Updating"),
//                                               CloseButton()
//                                             ],
//                                           ),
//                                           actions: const [
//                                             CircularProgressIndicator()
//                                           ],
//                                           actionsAlignment:
//                                               MainAxisAlignment.center,
//                                           actionsPadding:
//                                               const EdgeInsets.symmetric(
//                                                   vertical: 30),
//                                         );
//                                       },
//                                       fullscreenDialog: true,
//                                       settings: const RouteSettings()));
//                                 },
//                                 child: const Text("Update app")),
//                           ],
//                         );
//                       });
// Dialog(
//         child: SizedBox(
//             height: 400,
//             width: 400,
//             child: Stack(fit: StackFit.expand, children: [
//               InteractiveViewer(
//                 child: Image.network(
//                     "https://picsum.photos/400/400??random=${Random().nextInt(100000)}",
//                     fit: BoxFit.cover),
//               ),
//               const Positioned(right: 10, top: 10, child: CloseButton())
//             ])));  
