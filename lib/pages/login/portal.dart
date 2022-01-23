import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:ion/pages/meeting/meeting_page.dart';
import 'package:ion/pages/player/players.dart';

class PortalBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => PlayerController());
    Get.lazyPut(() => MeetingController());
  }
}

class PortalController extends GetxController {}

class PortalView extends GetView<PortalController> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Container(
          padding: EdgeInsets.all(10),
          child: Container(
            child: Column(
              children: [
                Spacer(),
                Container(
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "Login or Signup",
                      style:
                          TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                Container(
                  child: InternationalPhoneNumberInput(
                      spaceBetweenSelectorAndTextField: 0,
                      scrollPadding: EdgeInsets.all(0),
                      initialValue: PhoneNumber(isoCode: 'CN'),
                      onInputChanged: (PhoneNumber number) =>
                          onInputChanged(number)),
                ),
                Container(
                  child: TextFormField(
                    obscureText: true,
                    enableSuggestions: false,
                    autocorrect: false,
                  ),
                ),
                Container(
                  child: Row(
                    children: [
                      Center(
                        child: TextButton(
                            onPressed: onPressed, child: Text('TAKE ME IN')),
                      ),
                    ],
                  ),
                ),
                Spacer(),
                Spacer(),
                Spacer(),
                Spacer(),
                Spacer(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  onInputChanged(PhoneNumber number) {
    print(number);
  }

  void onPressed() {
    Get.to(() => PlayerView());
  }
}
