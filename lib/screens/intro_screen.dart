import 'package:flutter/material.dart';
import 'package:helperguide/controllers/edit_events_provider.dart';
import 'package:helperguide/controllers/home_screen_provider.dart';
import 'package:provider/provider.dart';

import '../controllers/edit_activities_provider.dart';
import '../controllers/edit_university_provider.dart';

class IntroScreen extends StatelessWidget {
  const IntroScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  child: Row(
                    children: [
                      Expanded(child: Image.asset('assets/find.png', height: 70,)),
                      const SizedBox(width: 10,),
                      Expanded(
                        flex: 3,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: const [
                            Text(
                              "Find",
                              style: TextStyle(
                                fontSize: 30,
                                color: Color(0xFF428DFC),
                              ),
                            ),
                            Text(
                              "Explore all the events and activities around you among the members of your university",
                              style: TextStyle(
                                fontSize: 15,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                  child: Row(
                    children: [
                      Expanded(child: Image.asset('assets/interact.png', height: 70,)),
                      const SizedBox(width: 10,),
                      Expanded(
                        flex: 3,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: const [
                            Text(
                              "Interact",
                              style: TextStyle(
                                fontSize: 30,
                                color: Color(0xFFDB3231),
                              ),
                            ),
                            Text(
                              "Ease of interaction with all university members and participation in courses",
                              style: TextStyle(
                                fontSize: 15,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 10, 20, 40),
                  child: Row(
                    children: [
                      Expanded(child: Image.asset('assets/share.png', height: 70,)),
                      const SizedBox(width: 10,),
                      Expanded(
                        flex: 3,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: const [
                            Text(
                              "Share",
                              style: TextStyle(
                                fontSize: 30,
                                color: Color(0xFFA1C3FC),
                              ),
                            ),
                            Text(
                              "Share your presence and abilities so that the spirit of cooperation and competition is created among you",
                              style: TextStyle(
                                fontSize: 15,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Center(
                  child: FloatingActionButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/wrapper');
                    },
                    backgroundColor: const Color(0xFFA1C3FC),
                    child: const RotatedBox(
                      quarterTurns: 3,
                      child: Icon(
                        Icons.arrow_forward_ios,
                        size: 50,
                      ),
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
