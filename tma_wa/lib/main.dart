import 'package:flutter/material.dart';
import 'dart:html' as html;
import 'package:firebase_core/firebase_core.dart';
import 'authservice.dart';
import 'signup.dart';

FirebaseOptions options = const FirebaseOptions(
    apiKey: "AIzaSyCTz06aptkxVRkgO-z4eAV77Cj70Ff8kts",
    authDomain: "taskninjaplus.firebaseapp.com",
    projectId: "taskninjaplus",
    storageBucket: "taskninjaplus.appspot.com",
    messagingSenderId: "695133719561",
    appId: "1:695133719561:web:89588e4c0659a18454bcd8",
    measurementId: "G-QT936Z491N");

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: options);
  runApp(const AuthPage());
}

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: '6Scheduler Authentication',
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  String _userEmail = '';
  String _userPass = '';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            backgroundColor: const Color.fromARGB(255, 46, 46, 46),
            body: Center(
              child: Container(
                  width: 600,
                  height: 450,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/image/background.png"),
                      fit: BoxFit.cover,

                      /*color: Color.fromARGB(255, 154, 188, 134),
                  borderRadius: BorderRadius.circular(25),*/
                    ),
                  ),
                  child: Center(
                    child: Container(
                        width: 600,
                        height: 450,
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(100, 244, 246, 233),
                          borderRadius: BorderRadius.circular(25),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Text("Log In",
                                style: TextStyle(
                                  fontSize: 60,
                                  color: Color.fromARGB(200, 13, 15, 41),
                                )),
                            const SizedBox(
                              height: 50,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(10),
                              child: TextField(
                                onChanged: (value) {
                                  setState(() {
                                    _userEmail = value;
                                  });
                                },
                                decoration: const InputDecoration(
                                    hintText: "Email Address",
                                    suffixIcon: Icon(Icons.email)),
                              ),
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(10),
                              child: TextField(
                                onChanged: (value) {
                                  setState(() {
                                    _userPass = value;
                                  });
                                },
                                decoration: const InputDecoration(
                                    hintText: "Password",
                                    suffixIcon: Icon(Icons.password)),
                                obscureText: true,
                              ),
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            OutlinedButton(
                                onPressed: () {
                                  print('Sign In Button Works');
                                  FirebaseAuthServices
                                      .signInWithEmailAndPassword(
                                          _userEmail, _userPass, context);
                                  print('Sign In Method Works');
                                },
                                child: const Text("Log In",
                                    style: TextStyle(
                                      fontSize: 25,
                                      color: Color.fromARGB(200, 13, 15, 41),
                                    ))),
                            const SizedBox(
                              height: 10,
                            ),
                            const Text("Don't have an account?"),
                            OutlinedButton(
                              child: const Text('Sign Up',
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: Color.fromARGB(200, 13, 15, 41),
                                  )),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => SecondPage()),
                                );
                              },
                            ),
                            const SizedBox(
                              height: 10,
                            ),

                            //Comment out this part of the code in the NON-TEST File!
                            // BottomAppBar(
                            //   child: Container(
                            //     padding: EdgeInsets.symmetric(
                            //         horizontal: 16.0, vertical: 8.0),
                            //     child: Text('You entered: $_userEmail and $_userPass'),
                            //   ),
                            // ),
                          ],
                        )),
                  )),
            )));
  }
}
