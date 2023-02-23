import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:helperguide/screens/home_screen.dart';
import 'package:helperguide/screens/signin_screen.dart';
import 'package:helperguide/screens/visitor_home_screen.dart';
import 'package:provider/provider.dart';

import 'controllers/home_screen_provider.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User?>(context);
    Provider.of<HomeScreenProvider>(context, listen: false).setCurrent(0);
    if(user == null) {
      return const SignInScreen();
    }
    else if(user.email!.contains("@uhb.edu.sa") || user.email!.contains("@helper.com"))
    {
      return const HomeScreen();
    }
    else {
      return const VisitorHome();
    }
  }
}