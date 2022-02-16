import 'package:get/get.dart';
import 'package:ion_flutter_app/pages/chat/chat_page.dart';
import 'package:ion_flutter_app/pages/login/portal.dart';
import 'package:ion_flutter_app/pages/player/players.dart';

import '../pages/meeting/meeting_page.dart';
import '../pages/player/players.dart';
import '../pages/settings/settings_page.dart';

part 'app_routes.dart';

// ignore: avoid_classes_with_only_static_members
class AppPages {
  static String init = Routes.Home.nameToRoute();

  static final routes = [
    /*GetPage(
      name: '/login',
      title: 'Login View',
      page: () => LoginView(),
      binding: LoginBinding(),
    ),*/
    GetPage(
      name: '/meeting',
      title: 'Meeting View',
      page: () => MeetingView(),
      binding: MeetingBinding(),
    ),
    GetPage(
      name: '/settings',
      title: 'Settings View',
      page: () => SettingsView(),
      binding: SettingsBinding(),
    ),
    GetPage(
      name: '/chat',
      title: 'Chat View',
      page: () => ChatView(),
      binding: ChatBinding(),
    ),
    GetPage(
      name: '/player',
      title: 'Player View',
      page: () => PlayerView(),
      binding: PlayerBinding(),
    ),
    GetPage(
        name: '/portal', page: () => PortalView(), binding: PortalBinding()),
  ];
}
