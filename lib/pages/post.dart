import 'dart:io';
import 'package:cleanify/elements/project_elements.dart';
import 'package:cleanify/firebase_methods/firestore_methods.dart';
import 'package:cleanify/pages/mapselect.dart';
import 'package:cleanify/pages/tabbar.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:path/path.dart';

class PostPage extends StatefulWidget {
  const PostPage({Key? key}) : super(key: key);

  @override
  State<PostPage> createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {
  bool mediaRemains = false;
  bool mapSelected = false;
  String description = "";
  late firebase_storage.UploadTask uploadTask;
  File? _selectedImage;
  double longtitude = 0;
  double latitude = 0;

  firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;
  final ImagePicker _picker = ImagePicker();
  late String photoPath = defaultPhoto;
  String defaultPhoto =
      'https://soccerpointeclaire.com/wp-content/uploads/2021/06/default-profile-pic-e1513291410505.jpg';
  int count = 0;
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
                                        color:
                                            ProjectColors.defaultTextColor))),
                        TextField(
                            maxLength: 300,
                            onChanged: (value) {
                              setState(() {
                                description = value;
                              });
                              debugPrint("description is: $description");
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
                                                              mediaRemains =
                                                                  true;
                                                              imgFromGallery();
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
                                                              mediaRemains =
                                                                  true;
                                                              imgFromCamera();
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
                                        LatLng? result =
                                            await Navigator.of(context).push(
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        const MapSelect()));
                                        if (result != null) {
                                          longtitude = result.longitude;
                                          latitude = result.latitude;
                                          setState(() {
                                            mapSelected = true;
                                          });
                                        } else {
                                          setState(() {
                                            mapSelected = false;
                                          });
                                        }
                                      },
                                      color: mapSelected
                                          ? Colors.green
                                          : Colors.red,
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
                                          firestoreMethods()
                                              .validateAndSubmitPost(
                                                  description,
                                                  photoPath,
                                                  longtitude,
                                                  latitude);
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
                            ? SizedBox(
                                height: 200,
                                width: 200,
                                child: Image.file(_selectedImage!,
                                    fit: BoxFit.cover))
                            : const Text("Please select an image")
                      ]);
                })));
  }

  Future uploadFile() async {
    if (_selectedImage == null) return;
    final fileName = basename(_selectedImage!.path);
    final destination = 'files/$fileName';
    try {
      final ref = firebase_storage.FirebaseStorage.instance
          .ref(destination)
          .child('/post');
      uploadTask = ref.putData(await _selectedImage!.readAsBytes());
      photoPath = await (await uploadTask).ref.getDownloadURL();

      setState(() {});
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future imgFromGallery() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      _selectedImage = File(pickedFile.path);
      Future.delayed(const Duration(microseconds: 1));
      setState(() {});
      uploadFile();
    } else {
      debugPrint('No image selected');
    }
  }

  Future imgFromCamera() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.camera);

    if (pickedFile != null) {
      _selectedImage = File(pickedFile.path);
      Future.delayed(const Duration(microseconds: 1));
      setState(() {});
      uploadFile();
    } else {
      debugPrint('No image selected');
    }
  }
}
