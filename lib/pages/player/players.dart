import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ion/pages/meeting/meeting_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Provider extends GetConnect {
  Future<List<dynamic>> fetchPlayer() async {
    final result = await get('https://randomuser.me/api/?results=10');
    if (result.status.hasError) {
      return List.empty();
    } else {
      return result.body['results'];
    }
  }
}

class PlayerBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => PlayerController());
    Get.lazyPut(() => MeetingController());
  }
}

class PlayerController extends GetxController with StateMixin<List<dynamic>> {
  final _meetingController = Get.find<MeetingController>();
  late SharedPreferences prefs;
  late var _server = ''.obs;
  late var _sid = ''.obs;
  late List<dynamic> _value = [];

  @override
  @mustCallSuper
  void onInit() async {
    super.onInit();
    prefs = await SharedPreferences.getInstance();
    _server.value = prefs.getString('server') ?? '101.34.243.201';
    _sid.value = prefs.getString('room') ?? 'test room';
    fetchMore();
  }

  @override
  void onClose() {
    super.onClose();
  }

  bool handleJoin() {
    if (_server.value.length == 0 || _sid.value.length == 0) {
      return false;
    }
    prefs.setString('server', _server.value);
    prefs.setString('room', _sid.value);
    _meetingController.connect();
    Get.to(() => MeetingView());
    return true;
  }

  void fetchMore() {
    Provider().fetchPlayer().then((value) {
      _value.addAll(value);
      change(_value, status: RxStatus.success());
    }, onError: (error) {
      change(List.of([]), status: RxStatus.error(error.toString()));
    });
  }
}

class PlayerView extends GetView<PlayerController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: controller.obx((_values) => Center(child: ListView.builder(
                itemBuilder: (BuildContext context, int index) {
              if (null == _values) return Card();
              if (index >= _values.length) {
                controller.fetchMore();
                return Center(child: CircularProgressIndicator());
              }
              return Card(
                child: Column(
                  children: [
                    ListTile(
                      title: Text(_values[index]['name']['first']),
                      subtitle: Text(_values[index]['name']['last']),
                      leading: CircleAvatar(
                        backgroundImage: NetworkImage(
                            _values[index]['picture']['thumbnail']),
                      ),
                      onTap: () {
                        controller.handleJoin();
                      },
                    )
                  ],
                ),
              );
            }))));
  }
}
