import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:helperguide/firebase/firebase_auth.dart';
import 'package:provider/provider.dart';

import '../controllers/signup_provider.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        color: Colors.white,
        child: Stack(
          fit: StackFit.expand,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                RotatedBox(quarterTurns: 2, child: Image.asset('assets/background.png'),),
                const Expanded(child: SizedBox.shrink()),
                Image.asset('assets/background.png'),
              ],
            ),
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(5, 100, 5, 20),
                  child: Image.asset('assets/helper logo.png', width: 150, height: 150,),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                  child: Container(
                    color: const Color(0x32A1C3FC),
                    height: 40,
                    child: Row(
                      children: [
                        const SizedBox(width: 5,),
                        Expanded(
                          child: TextButton(
                            onPressed: () { },
                            style: const ButtonStyle(
                                backgroundColor: MaterialStatePropertyAll(Colors.white)
                            ),
                            child: const Text(
                              "Sign In",
                              style: TextStyle(
                                color: Color(0xFFDB3231),
                                fontSize: 15,
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: TextButton(
                            onPressed: () {
                              Provider.of<SignUpProvider>(context, listen: false).resetControllers();
                              Navigator.pop(context);
                              Navigator.pushNamed(context, '/signUpScreen');
                            },
                            child: const Text(
                              "Register",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Color(0xFF151A4F),
                                fontSize: 15,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(30, 10, 30, 30),
                  child: SizedBox(
                    child: TextFormField(
                      maxLines: 1,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 18.0,
                      ),
                      cursorColor: Colors.black,
                      textAlignVertical: TextAlignVertical.center,
                      controller: context.watch<SignUpProvider>().email,
                      decoration: const InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0xFFA1C3FC), width: 1.0),
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        hintText: "Your Email",
                        hintStyle: TextStyle(
                            fontSize: 18,
                            color: Colors.black,
                            letterSpacing: 0.5
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(30, 0, 30, 10),
                  child: SizedBox(
                    child: TextFormField(
                      maxLines: 1,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 18.0,
                      ),
                      cursorColor: Colors.black,
                      textAlignVertical: TextAlignVertical.center,
                      obscureText: true,
                      controller: context.watch<SignUpProvider>().password,
                      decoration: const InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0xFFA1C3FC), width: 1.0),
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        hintText: "Your Password",
                        hintStyle: TextStyle(
                            fontSize: 18,
                            color: Colors.black,
                            letterSpacing: 0.5
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(30, 10, 30, 10),
                  child: SizedBox(
                    width: 250,
                    child: TextButton(
                      onPressed: () async {
                        AuthService().signInWithEmailAndPassword(Provider.of<SignUpProvider>(context, listen: false).email.text, Provider.of<SignUpProvider>(context, listen: false).password.text).whenComplete(() {
                          if(Provider.of<User?>(context, listen: false) == null) {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  backgroundColor: Colors.grey.shade200,
                                  shape: const OutlineInputBorder(
                                    borderSide: BorderSide(color: Color(0xFF242424), width: 1.0),
                                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                                  ),
                                  content: const SizedBox(
                                    width: 300,
                                    child: Text(
                                      'Incorrect Username/Password',
                                      style: TextStyle(
                                        fontSize: 18,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                  actions: [
                                    ElevatedButton(
                                      onPressed: () async {
                                        Navigator.pop(context);
                                      },
                                      child: const Text('Try Again'),
                                    ),
                                  ],
                                );
                              },
                            );
                          }
                          else {
                            Provider.of<SignUpProvider>(context, listen: false).resetControllers();
                          }
                        });
                      },
                      style: const ButtonStyle(
                          backgroundColor: MaterialStatePropertyAll(Color(0xFF151A4F),)
                      ),
                      child: const Text(
                        "Sign In",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(30, 10, 30, 10),
                  child: SizedBox(
                    width: 250,
                    child: TextButton(
                      onPressed: () {
                        Provider.of<SignUpProvider>(context, listen: false).resetControllers();
                        Navigator.pop(context);
                        Navigator.pushNamed(context, '/signUpScreen');
                      },
                      child: Row(
                        children: const [
                          Text(
                            "Don't have an Account? ",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                            ),
                          ),
                          Text(
                            "Sign Up",
                            style: TextStyle(
                              color: Color(0xFFDB3231),
                              fontSize: 15,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
