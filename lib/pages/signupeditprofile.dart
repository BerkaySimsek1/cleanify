import 'dart:io';

import 'package:cleanify/pages/tabbar.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../elements/project_elements.dart';

class SignUpEditProfile extends StatefulWidget {
  const SignUpEditProfile({super.key});

  @override
  State<SignUpEditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<SignUpEditProfile> {
  final TextEditingController fullName = TextEditingController();
  final TextEditingController age = TextEditingController();
  bool fullNameRemains = false;
  bool ageRemains = false;
  File? _selectedImage;
  String defaultPhoto =
      'https://soccerpointeclaire.com/wp-content/uploads/2021/06/default-profile-pic-e1513291410505.jpg';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: ProjectColors.projectBackgroundColor,
        appBar: const CommonAppbar(preference: "back"),
        body: SingleChildScrollView(
            child: Padding(
                padding: const EdgeInsets.all(30),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const Text("Complete Your Profile",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 20),
                      Container(
                          height: 150,
                          child: _selectedImage != null
                              ? Image.file(_selectedImage!,
                                  fit: BoxFit.fitHeight)
                              : Image.network(defaultPhoto,
                                  fit: BoxFit.fitHeight)),
                      const SizedBox(height: 20),
                      ElevatedButton(
                          onPressed: () {
                            showModalBottomSheet(
                                context: context,
                                builder: (BuildContext context) {
                                  return Container(
                                      padding: const EdgeInsets.all(10),
                                      child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            ListTile(
                                                title: const Text(
                                                    "From Gallery",
                                                    style: ProjectTextStyles
                                                        .styleListViewGeneral),
                                                onTap: () {
                                                  _pickImageFromGallery();
                                                  Navigator.of(context).pop();
                                                }),
                                            ListTile(
                                                title: const Text("Take Photo",
                                                    style: ProjectTextStyles
                                                        .styleListViewGeneral),
                                                onTap: () {
                                                  _pickImageFromCamera();
                                                  Navigator.of(context).pop();
                                                })
                                          ]));
                                });
                          },
                          child: const Text("Change Profile Picture",
                              style: ProjectTextStyles.styleListViewGeneral)),
                      const SizedBox(height: 20),
                      TextField(
                          controller: fullName,
                          maxLines: 1,
                          decoration: const InputDecoration(
                              isDense: true,
                              hintText: "Enter your full name",
                              labelText: "Full Name",
                              border: OutlineInputBorder())),
                      const SizedBox(height: 20),
                      TextField(
                          controller: age,
                          maxLines: 1,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                              isDense: true,
                              hintText: "Enter your age",
                              labelText: "Age",
                              border: OutlineInputBorder())),
                      const SizedBox(height: 20),
                      ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).pushReplacement(
                                MaterialPageRoute(builder: (context) {
                              return const MainTabBar();
                            }));
                          },
                          child: const Text("Continue",
                              style: ProjectTextStyles.styleListViewGeneral))
                    ]))));
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
    });
  }
}
