import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:helperguide/modules/activitiy.dart';

class HomeScreenProvider extends ChangeNotifier {
  PageController controller = PageController();
  int currentPage = 0;
  ScrollController scrollController = ScrollController();
  final DatabaseReference activitiesRef = FirebaseDatabase.instance.reference().child('activities');
  DateTime current = DateTime.now();
  FocusNode focusNode = FocusNode();
  var months = [
    " ",
    "January",
    "February",
    "March",
    "April",
    "May",
    "June",
    "July",
    "August",
    "September",
    "October",
    "November",
    "December",
  ];

  void jumpToPage(int page, User? user) {
    controller.jumpToPage(page);
    currentPage = page;
    notifyListeners();
    if((user!.email!.contains("@helper.com") || user.email!.contains("@uhb.edu.pk"))) {
      if(currentPage == 1) {
        Future.delayed(const Duration(milliseconds: 200)).whenComplete(() {
          scrollController.animateTo(current.day*60, duration: const Duration(milliseconds: 100), curve: Curves.linear);
        });
      }
    }
  }
  int getNumberOfDays() {
    if(current.month == 1 || current.month == 3 || current.month == 5 || current.month == 7 || current.month == 8 || current.month == 10 || current.month == 12) {
      return 31;
    }
    else if(current.month == 2) {
      return 28;
    }
    else {
      return 30;
    }
  }
  void setCurrentDate(DateTime value) {
    current = value;
    Future.delayed(const Duration(milliseconds: 200)).whenComplete(() {
      // focusNode.requestFocus();
      scrollController.animateTo((current.day*65) - 195, duration: const Duration(milliseconds: 100), curve: Curves.linear);
    });
    notifyListeners();
  }
  void changeDate(int day) {
    current = DateTime(current.year, current.month, day);
    notifyListeners();
    Future.delayed(const Duration(milliseconds: 200)).whenComplete(() {
      scrollController.animateTo((current.day*65) - 195, duration: const Duration(milliseconds: 100), curve: Curves.linear);
    });
    notifyListeners();
  }
  void setCurrent(int value) {
    currentPage = value;
  }
}