import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../controllers/home_screen_provider.dart';
import '../firebase/firebase_auth.dart';
import 'home_screen.dart';

class VisitorHome extends StatelessWidget {
  const VisitorHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    User? user = Provider.of<User?>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        child: Container(
          color: const Color(0xFF428DFC),
          height: 70,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Expanded(
                  child: TextButton(
                    child: Column(
                      children: [
                        Icon(
                          Icons.home,
                          color: context.watch<HomeScreenProvider>().currentPage == 0 ? Colors.black : Colors.white,
                        ),
                        Text(
                          'Home',
                          style: TextStyle(
                            color: context.watch<HomeScreenProvider>().currentPage == 0 ? Colors.black : Colors.white,
                            fontSize: 15,
                          ),
                        )
                      ],
                    ),
                    onPressed: () {
                      Provider.of<HomeScreenProvider>(context, listen: false).jumpToPage(0, user);
                    },
                  )
              ),
              Expanded(
                  child: TextButton(
                    child: Column(
                      children: [
                        Icon(
                          Icons.note_rounded,
                          color: context.watch<HomeScreenProvider>().currentPage == 1 ? Colors.black : Colors.white,
                        ),
                        Text(
                          'Registration',
                          style: TextStyle(
                            color: context.watch<HomeScreenProvider>().currentPage == 1 ? Colors.black : Colors.white,
                            fontSize: 15,
                          ),
                        )
                      ],
                    ),
                    onPressed: () {
                      Provider.of<HomeScreenProvider>(context, listen: false).jumpToPage(1, user);
                    },
                  )
              ),
              Expanded(
                  child: TextButton(
                    child: Column(
                      children: [
                        Icon(
                          Icons.account_circle_outlined,
                          color: context.watch<HomeScreenProvider>().currentPage == 2 ? Colors.black : Colors.white,
                        ),
                        Text(
                          'Account',
                          style: TextStyle(
                            color: context.watch<HomeScreenProvider>().currentPage == 2 ? Colors.black : Colors.white,
                            fontSize: 15,
                          ),
                        )
                      ],
                    ),
                    onPressed: () {
                      Provider.of<HomeScreenProvider>(context, listen: false).jumpToPage(2, user);
                    },
                  )
              ),
            ],
          ),
        ),
      ),
      body: PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: context.watch<HomeScreenProvider>().controller,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                padding: const EdgeInsets.all(20),
                decoration: const BoxDecoration(
                  color: Color(0xFF428DFC),
                  borderRadius: BorderRadius.only(bottomLeft: Radius.circular(30), bottomRight: Radius.circular(30)),
                ),
                height: MediaQuery.of(context).size.height/4.5,
                width: double.maxFinite,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Expanded(child: SizedBox.shrink()),
                    Text(
                      " Hi ${user!.displayName == null ? "${user!.displayName}": ""} !",
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold
                      ),
                    ),
                    const SizedBox(height: 10,),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: const [
                        Icon(
                          Icons.location_on,
                          color: Colors.white,
                          size: 30,
                        ),
                        Text(
                          " Hafr Al-Batin University",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20,),
                  ],
                ),
              ),
              const SizedBox(height: 10,),
              Padding(
                padding: const EdgeInsets.fromLTRB(30, 10, 30, 10),
                child: SizedBox(
                  height: 25,
                  child: Row(
                    children: [
                      const Text(
                        "University Information",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                      const Expanded(child: SizedBox.shrink()),
                      user.email!.contains("helper.com") ? IconButton(
                        splashRadius: 25,
                        padding: EdgeInsets.zero,
                        icon: const Icon(
                          Icons.edit,
                        ),
                        onPressed: () {
                          Navigator.pushNamed(context, "/editUniversity");
                        },
                      ) : const SizedBox.shrink(),
                    ],
                  ),
                ),
              ),
              const UniversityInformation(),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                padding: const EdgeInsets.all(20),
                decoration: const BoxDecoration(
                  color: Color(0xFF428DFC),
                  borderRadius: BorderRadius.only(bottomLeft: Radius.circular(30), bottomRight: Radius.circular(30)),
                ),
                height: MediaQuery.of(context).size.height/4.5,
                width: double.maxFinite,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Expanded(child: SizedBox.shrink()),
                    Text(
                      " Hi ${user!.displayName == null ? "${user!.displayName}": ""} !",
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold
                      ),
                    ),
                    const SizedBox(height: 10,),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: const [
                        Icon(
                          Icons.location_on,
                          color: Colors.white,
                          size: 30,
                        ),
                        Text(
                          " Hafr Al-Batin University",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20,),
                  ],
                ),
              ),
              const SizedBox(height: 10,),
              Padding(
                padding: const EdgeInsets.fromLTRB(30, 5, 30, 5),
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    color: Color(0xFFA1C3FC),
                  ),
                  child: ListTile(
                    contentPadding: EdgeInsets.zero,
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: const [
                        SizedBox(height: 5,),
                        Text(
                          "شروط و ضوابط القبول",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 25,
                              fontWeight: FontWeight.bold
                          ),
                          textDirection: TextDirection.rtl,
                        ),
                        SizedBox(height: 5,),
                        Text(
                          '''- أن يكون الطالب سعودياً أو من أم سعودية.
- أن يكون الطالب قد حصل على الشهادة الثانوية السعودية أو ما يعادلها في العام الحالي أو الأربع سنوات الماضية  
- أن يكون الطالب قد تقدم لاختباري القدرات العامة والتحصيلي المقدمين من المركز الوطني للقياس .
- ألا يكون للطالب سجل حالي أو سابق في جامعة حفر الباطن.''',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                          ),
                          textDirection: TextDirection.rtl,
                        ),
                        SizedBox(height: 5,),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10,),
              Padding(
                padding: const EdgeInsets.fromLTRB(30, 5, 30, 5),
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    color: Color(0xFFA1A3FC),
                  ),
                  child: ListTile(
                    contentPadding: EdgeInsets.zero,
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const SizedBox(height: 5,),
                        const Text(
                          "رابط موقع الجامعه الرسمي",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.bold
                          ),
                          textDirection: TextDirection.rtl,
                        ),
                        const SizedBox(height: 5,),
                        Text(
                          "https://portal.uhb.edu.sa",
                          style: TextStyle(
                            color: Colors.blue.shade800,
                            fontSize: 18,
                          ),
                        ),
                        const SizedBox(height: 5,),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                padding: const EdgeInsets.all(20),
                decoration: const BoxDecoration(
                  color: Color(0xFF428DFC),
                  borderRadius: BorderRadius.only(bottomLeft: Radius.circular(30), bottomRight: Radius.circular(30)),
                ),
                height: MediaQuery.of(context).size.height/4.5,
                width: double.maxFinite,
                child: Column(
                  children: const [
                    Expanded(child: SizedBox.shrink()),
                    Text(
                      "Profile Information",
                      style: TextStyle(
                        fontSize: 25,
                        color: Colors.white,
                      ),
                    ),
                    Expanded(child: SizedBox.shrink()),
                  ],
                ),
              ),
              const SizedBox(height: 10,),
              Padding(
                padding: const EdgeInsets.fromLTRB(30, 30, 30, 5),
                child: Row(
                  children: [
                    const SizedBox(
                      width: 110,
                      child: Text(
                        "Full name: ",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        user.displayName != null ? user.displayName! : " ",
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                        ),
                        overflow: TextOverflow.visible,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(30, 30, 30, 5),
                child: Row(
                  children: [
                    const SizedBox(
                      width: 110,
                      child: Text(
                        "Email: ",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        user.email ??  " ",
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                        ),
                        overflow: TextOverflow.visible,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(30, 30, 30, 5),
                child: Row(
                  children: [
                    const SizedBox(
                      width: 110,
                      child: Text(
                        "Role: ",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        user.email!.contains("@helper.com") ? "Admin" : user.email!.contains("@uhb.edu.sa") ? "User": "Visitor",
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          overflow: TextOverflow.visible,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const Expanded(child: SizedBox.shrink()),
              Padding(
                padding: const EdgeInsets.fromLTRB(30, 10, 30, 10),
                child: SizedBox(
                  width: 250,
                  child: TextButton(
                    onPressed: () async {
                      AuthService().signOut();
                    },
                    style: const ButtonStyle(
                        backgroundColor: MaterialStatePropertyAll(Color(0xFF151A4F),)
                    ),
                    child: const Text(
                      "Sign Out",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10,),
            ],
          ),
        ],
      ),
    );
  }
}
