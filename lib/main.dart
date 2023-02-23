import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:helperguide/controllers/edit_activities_provider.dart';
import 'package:helperguide/controllers/edit_events_provider.dart';
import 'package:helperguide/controllers/edit_locations_provider.dart';
import 'package:helperguide/controllers/edit_profile_provider.dart';
import 'package:helperguide/controllers/edit_university_provider.dart';
import 'package:helperguide/controllers/home_screen_provider.dart';
import 'package:helperguide/controllers/signup_provider.dart';
import 'package:helperguide/screens/edit_activities_screen.dart';
import 'package:helperguide/screens/edit_events.dart';
import 'package:helperguide/screens/edit_locations_screen.dart';
import 'package:helperguide/screens/edit_profile_screen.dart';
import 'package:helperguide/screens/edit_university_screen.dart';
import 'package:helperguide/screens/home_screen.dart';
import 'package:helperguide/screens/intro_screen.dart';
import 'package:helperguide/screens/signin_screen.dart';
import 'package:helperguide/screens/signup_screen.dart';
import 'package:helperguide/screens/splash_screen.dart';
import 'package:helperguide/wrapper.dart';
import 'package:provider/provider.dart';

import 'firebase/firebase_auth.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => SignUpProvider()),
        ChangeNotifierProvider(create: (_) => HomeScreenProvider()),
        ChangeNotifierProvider(create: (_) => EditActivitiesProvider()),
        ChangeNotifierProvider(create: (_) => EditUniversityProvider()),
        ChangeNotifierProvider(create: (_) => EditEventsProvider()),
        ChangeNotifierProvider(create: (_) => EditLocationsProvider()),
        ChangeNotifierProvider(create: (_) => EditProfileProvider()),
      ],
      child: StreamProvider<User?>.value(
        value: AuthService().user,
        initialData: null,
        catchError: (context, err) => null,
        child: MaterialApp(
          routes: {
            "/wrapper" : (context) => const Wrapper(),
            "/signInScreen" : (context) => const SignInScreen(),
            "/signUpScreen" : (context) => const SignUpScreen(),
            "/homeScreen" : (context) => const HomeScreen(),
            // "/editProfile" : (context) => const EditProfile(),
            "/editActivities" : (context) => const EditActivities(),
            "/editUniversity" : (context) => const EditUniversity(),
            "/editEvents" : (context) => const EditEvents(),
            "/editLocations" : (context) => const EditLocations(),
          },
          title: 'Helper Guide',
          home: FutureBuilder(
            future: Future.delayed(const Duration(seconds: 1)),
            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
              if(snapshot.connectionState == ConnectionState.done) {
                return const IntroScreen();
              }
              else {
                return const SplashScreen();
              }
            },
          ),
        ),
      ),
    );
  }
}
