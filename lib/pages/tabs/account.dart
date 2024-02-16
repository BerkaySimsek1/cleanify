import 'package:cleanify/firebase_methods/auth_methods.dart';
import 'package:cleanify/pages/signupeditprofile.dart';
import 'package:cleanify/pages/signuplogin.dart';
import 'package:flutter/material.dart';
import '../../elements/project_elements.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({Key? key}) : super(key: key);

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: ProjectColors.projectBackgroundColor,
        body: ListView(children: [
          const Padding(
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: ProfileSection(
                  userName: "null",
                  fullName: "null",
                  age: "null",
                  location: "null",
                  postCount: 0)),
          const SizedBox(height: 10),
          MyListTile(
              subject: "Edit profile",
              myIcon: const Icon(Icons.edit),
              onTap: () {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const SignUpEditProfile()));
              }),
          MyListTile(
              subject: "Log out",
              myIcon: const Icon(Icons.logout),
              onTap: () {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const LoginScreen()));
                Auth().logOut();
              }),
          MyListTile(
              subject: "Delete account",
              myIcon: const Icon(Icons.delete),
              onTap: () {})
        ]));
  }
}

class ProfileSection extends StatelessWidget {
  final String userName;
  final String age;
  final String location;
  final int postCount;
  final String fullName;

  const ProfileSection(
      {Key? key,
      required this.userName,
      required this.fullName,
      required this.age,
      required this.location,
      required this.postCount})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 360,
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(20)),
            color: ProjectColors.projectPrimaryWidgetColor),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          const CircleAvatar(radius: 90, backgroundColor: Colors.white
              // child: Image.asset('assets/user_avatar.png')
              ),
          const SizedBox(height: 20),
          Text(userName,
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          Text(fullName,
              style: const TextStyle(color: Colors.white, fontSize: 15)),
          const SizedBox(height: 5),
          Text('Age: $age',
              style: const TextStyle(color: Colors.white, fontSize: 15)),
          const SizedBox(height: 5),
          Text('Location: $location',
              style: const TextStyle(color: Colors.white, fontSize: 15)),
          const SizedBox(height: 5),
          Text('Amount of posts: $postCount',
              style: const TextStyle(color: Colors.white, fontSize: 15))
        ]));
  }
}

class MyListTile extends StatelessWidget {
  final Icon myIcon;
  final String subject;
  final VoidCallback? onTap;

  const MyListTile(
      {Key? key, required this.subject, required this.myIcon, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Card(
            child: ListTile(
                title: Text(subject,
                    style: const TextStyle(
                        color: Color.fromARGB(255, 95, 95, 95),
                        fontSize: 15,
                        fontWeight: FontWeight.w400)),
                onTap: onTap,
                leading: Container(
                    alignment: Alignment.center,
                    height: 40,
                    width: 40,
                    child: myIcon),
                trailing: const Icon(Icons.chevron_right))));
  }
}
