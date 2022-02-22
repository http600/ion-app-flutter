import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:intl_phone_field/phone_number.dart';
import 'package:ion_flutter_app/pages/player/players.dart';

class PortalBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => PortalController());
    Get.lazyPut(() => PlayerController());
    // Get.lazyPut(() => MeetingController());
  }
}

class PortalController extends GetxController {
  late PhoneNumber phoneNumber;
  String authCode = '';

  @override
  @mustCallSuper
  void onInit() async {
    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void handleTakeIn() {
    Get.off(() => PlayerView(), binding: PlayerBinding());
  }
}

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
                Spacer(),
                Container(
                  child: IntlPhoneField(
                    decoration: InputDecoration(
                      labelText: 'Phone Number',
                      border: OutlineInputBorder(
                        borderSide: BorderSide(),
                      ),
                    ),
                    initialCountryCode: 'IN',
                    onChanged: (phone) {
                      onInputChanged(phone);
                    },
                  ),
                ),
                Container(
                  child: TextFormField(
                    obscureText: true,
                    enableSuggestions: false,
                    autocorrect: false,
                    onChanged: (String text) => onChangedTextFormField(text),
                    onFieldSubmitted: (String text) =>
                        onFieldSubmittedTextFormField(text),
                  ),
                ),
                Container(
                  child: Row(
                    children: [
                      Center(
                        child: TextButton(
                            onPressed: onPressedTextButton,
                            child: Text('TAKE ME IN')),
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
    // print('onInputChanged: ' + number.toString());
    controller.phoneNumber = number;
  }

  void onPressedTextButton() {
    // print(controller.phoneNumber.phoneNumber);
    // print(controller.authCode);
    if (controller.phoneNumber.number.endsWith(controller.authCode))
      controller.handleTakeIn();
  }

  onChangedTextFormField(String text) {
    // print('onChangedTextFormField: ' + text);
    controller.authCode = text;
  }

  onFieldSubmittedTextFormField(String text) {
    // print('onFieldSubmittedTextFormField: ' + text);
  }
}
