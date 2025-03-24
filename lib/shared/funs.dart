
import 'package:flutter/material.dart';

import '../data/cache_helper/cache_helper.dart';
import '../ui/login/login.dart';

void navigateTo(context, widget) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => widget,
    ),
  );
}

void navigateAndReplacement(context, widget) {
  Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(
      builder: (context) => widget,
    ),
    (route) => false,
  );
}

void onSkipBoarding(context, widget) {
  CacheHelper.saveData(key: 'onBoarding', value: true).then(
    (value) {
      if (value!) {
        navigateAndReplacement(context, widget);
      }
    },
  );
}


void signOut(context) {
  CacheHelper.removeData(key: 'token').then(
        (value) {
      if (value) {
        navigateAndReplacement(context, LoginScreen());
      }
    },
  );
}
