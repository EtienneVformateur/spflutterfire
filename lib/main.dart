import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: "AIzaSyDMkFw-zbcuEWrnpP2M34PbnEea3hyipyk",
          appId: "1:399114904245:web:cf8d1219b1af2b721514fc",
          messagingSenderId: "399114904245",
          projectId: "sitewebmobile-bcd73"),
    );
  } else {
    await Firebase.initializeApp();
  }
  runApp(const MaterialApp(
    home: MyApp(),
    debugShowCheckedModeBanner: false,
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final emailController = TextEditingController();
  final mdpController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("SUPER APPLICATION"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          TextFormField(
            decoration: InputDecoration(hintText: "Entrez votre email"),
            controller: emailController,
          ),
          TextFormField(
            decoration: InputDecoration(hintText: "Entrez votre mdp"),
            obscureText: true,
            controller: mdpController,
          ),
          TextButton(
              onPressed: () async {
                try {
                  String textEmail = emailController.text;
                  String textMdp = mdpController.text;
                  UserCredential userCredential = await FirebaseAuth.instance
                      .createUserWithEmailAndPassword(
                          email: textEmail, password: textMdp);
                  print("ok");
                } on FirebaseAuthException catch (e) {
                  if (e.code == 'user-not-found') {
                    print('No user found for that email.');
                  } else if (e.code == 'wrong-password') {
                    print('Wrong password provided for that user.');
                  }
                }
              },
              child: Text("Se connecter"))
        ],
      ),
    );
  }
}
