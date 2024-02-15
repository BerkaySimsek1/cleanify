import 'package:cleanify/elements/project_elements.dart';
import 'package:cleanify/pages/tabbar.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController email = TextEditingController();
  final TextEditingController username = TextEditingController();
  final TextEditingController password = TextEditingController();
  final TextEditingController password2 = TextEditingController();
  bool pageState = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
          ),
          backgroundColor: const Color.fromARGB(255, 78, 117, 97),
          leading: null,
          title: const Center(child: Text("Cleanify")),
        ),
        backgroundColor: ProjectColors.projectBackgroundColor,
        body: SingleChildScrollView(
            child: pageState
                ? Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30, vertical: 30),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          const Text('Login',
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold)),
                          const SizedBox(height: 20),
                          TextField(
                              onChanged: (value) {
                                setState(() {});
                              },
                              maxLines: 1,
                              decoration: const InputDecoration(
                                  isDense: true,
                                  hintText: 'Username',
                                  labelText: "Enter your username",
                                  border: OutlineInputBorder())),
                          const SizedBox(height: 20),
                          TextField(
                              maxLength: 20,
                              onChanged: (value) {
                                setState(() {});
                              },
                              maxLines: 1,
                              decoration: const InputDecoration(
                                  isDense: true,
                                  hintText: 'Enter your password',
                                  labelText: "Password",
                                  border: OutlineInputBorder())),
                          Padding(
                            padding: const EdgeInsets.only(left: 185),
                            child: TextButton(
                                onPressed: () {},
                                child: const Text("Forgot password?",
                                    style: ProjectTextStyles
                                        .styleListViewGeneral)),
                          ),
                          ElevatedButton(
                              onPressed: () {
                                Navigator.of(context)
                                    .push(MaterialPageRoute(builder: (context) {
                                  return const MainTabBar();
                                }));
                              },
                              child: const Text(
                                'Login',
                                style: ProjectTextStyles.styleListViewGeneral,
                              )),
                          const SizedBox(height: 20),
                          const Row(children: [
                            Expanded(child: Divider(thickness: 2)),
                            Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 10),
                                child: Center(
                                    child: Text("Or",
                                        style: TextStyle(fontSize: 20)))),
                            Expanded(child: Divider(thickness: 2))
                          ]),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 30),
                                    child: MaterialButton(
                                        onPressed: () {},
                                        color: Colors.white,
                                        elevation: 0,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child: SizedBox(
                                            width: 60,
                                            height: 60,
                                            child: Center(
                                                child: Image.asset(
                                                    "assets/google.png",
                                                    fit: BoxFit.contain,
                                                    width: 70))))),
                                Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 30),
                                    child: MaterialButton(
                                        onPressed: () {},
                                        color: Colors.white,
                                        elevation: 0,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child: SizedBox(
                                            width: 60,
                                            height: 60,
                                            child: Center(
                                                child: Image.asset(
                                                    "assets/facebook.png",
                                                    fit: BoxFit.contain,
                                                    width: 50,
                                                    height: 50)))))
                              ]),
                          const SizedBox(height: 10),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text("Don't have an account?"),
                                TextButton(
                                    onPressed: () {
                                      setState(() {
                                        pageState = !pageState;
                                        print(pageState);
                                      });
                                    },
                                    child: const Text('Sign Up',
                                        style: ProjectTextStyles
                                            .styleListViewGeneral))
                              ])
                        ]))
                : Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30, vertical: 30),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          const Text('Create an Account',
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold)),
                          const SizedBox(height: 20),
                          TextField(
                              controller: email,
                              maxLines: 1,
                              decoration: const InputDecoration(
                                  isDense: true,
                                  labelText: "E-mail",
                                  hintText: 'Enter your e-mail',
                                  border: OutlineInputBorder())),
                          const SizedBox(height: 20),
                          TextField(
                              controller: username,
                              maxLines: 1,
                              decoration: const InputDecoration(
                                  isDense: true,
                                  labelText: "Username",
                                  hintText: 'Enter your username',
                                  border: OutlineInputBorder())),
                          const SizedBox(height: 20),
                          TextField(
                              controller: password,
                              maxLength: 20,
                              maxLines: 1,
                              decoration: const InputDecoration(
                                  isDense: true,
                                  labelText: "Password",
                                  hintText: 'Enter your password',
                                  border: OutlineInputBorder())),
                          const SizedBox(height: 20),
                          TextField(
                              controller: password2,
                              maxLength: 20,
                              maxLines: 1,
                              decoration: const InputDecoration(
                                  isDense: true,
                                  labelText: "Confirm Password",
                                  hintText: 'Confirm your password',
                                  border: OutlineInputBorder())),
                          const SizedBox(height: 5),
                          ElevatedButton(
                              onPressed: () {
                                signUp(
                                    email: email.text,
                                    password: password.text,
                                    username: username.text);
                                setState(() {
                                  pageState = !pageState;
                                });
                              },
                              child: const Text('Sign Up',
                                  style:
                                      ProjectTextStyles.styleListViewGeneral)),
                          const SizedBox(height: 10),
                          const Row(children: [
                            Expanded(child: Divider(thickness: 2)),
                            Padding(
                                padding: EdgeInsets.symmetric(horizontal: 10.0),
                                child: Center(
                                    child: Text("Or",
                                        style: TextStyle(fontSize: 20)))),
                            Expanded(child: Divider(thickness: 2))
                          ]),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 25),
                                    child: MaterialButton(
                                        onPressed: () {},
                                        color: Colors.white,
                                        elevation: 0,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child: SizedBox(
                                            width: 60,
                                            height: 60,
                                            child: Center(
                                                child: Image.asset(
                                                    "assets/google.png",
                                                    fit: BoxFit.contain,
                                                    width: 70))))),
                                Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 15, vertical: 25),
                                    child: MaterialButton(
                                        onPressed: () {},
                                        color: Colors.white,
                                        elevation: 0,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child: SizedBox(
                                            width: 60,
                                            height: 60,
                                            child: Center(
                                                child: Image.asset(
                                                    "assets/facebook.png",
                                                    fit: BoxFit.contain,
                                                    width: 50,
                                                    height: 50)))))
                              ]),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text("Already have an account?"),
                                TextButton(
                                    onPressed: () {
                                      setState(() {
                                        pageState = !pageState;
                                        print(pageState);
                                      });
                                    },
                                    child: const Text('Login',
                                        style: ProjectTextStyles
                                            .styleListViewGeneral))
                              ])
                        ]))));
  }
}

Future<String> signUp(
    {required String email,
    required String password,
    required String username,
    String res = "Some error occured"}) async {
  try {
    if (email.isNotEmpty && password.isNotEmpty) {
      UserCredential cred = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      AppUser user = AppUser(
          email: email,
          password: password,
          username: username,
          uid: cred.user!.uid);
      await FirebaseFirestore.instance
          .collection("users")
          .doc(cred.user!.uid)
          .set(user.toJson());
      res = "Success";
      return res;
    }
  } catch (error) {
    res = error.toString();
    return res;
  }
  return res;
}

class AppUser {
  final String email;
  final String password;
  final String username;
  final String uid;

  AppUser({
    required this.email,
    required this.password,
    required this.username,
    required this.uid,
  });

  Map<String, dynamic> toJson() => {
        'email': email,
        'password': password,
        'username': username,
        'uid': uid,
      };

  static AppUser fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return AppUser(
      email: snapshot['email'],
      password: snapshot['password'],
      username: snapshot['username'],
      uid: snapshot['uid'],
    );
  }
}
