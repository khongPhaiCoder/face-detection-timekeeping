import 'package:fda_app/config/router/route_generator.dart';
import 'package:fda_app/data/home/bloc/home_bloc.dart';
import 'package:fda_app/data/user/bloc/user_bloc.dart';
import 'package:fda_app/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  BlocProvider.of<HomeBloc>(navigatorKey.currentContext!).add(FetchHome(
      BlocProvider.of<UserBloc>(navigatorKey.currentContext!).state.user.id!));

  print('Handling a background message ${message.messageId}');
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  bool? isLogin = prefs.getBool('isLogin');
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseMessaging messaging = FirebaseMessaging.instance;

  NotificationSettings settings = await messaging.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );

  print('User granted permission: ${settings.authorizationStatus}');
  try {
    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print('User granted permission');
      final fcmToken = await FirebaseMessaging.instance.getToken();
      print(fcmToken);
      prefs.setString("fcmToken", fcmToken.toString());

      FirebaseMessaging.onBackgroundMessage(
          _firebaseMessagingBackgroundHandler);

      FirebaseMessaging.onMessage.listen(
        (RemoteMessage message) {
          BlocProvider.of<HomeBloc>(navigatorKey.currentContext!).add(FetchHome(
              BlocProvider.of<UserBloc>(navigatorKey.currentContext!)
                  .state
                  .user
                  .id!));

          print("onMessage: $message");
        },
      );
      FirebaseMessaging.onMessageOpenedApp
          .listen((RemoteMessage message) async {
        print("onMessageOpenedApp: $message");
        BlocProvider.of<HomeBloc>(navigatorKey.currentContext!).add(FetchHome(
            BlocProvider.of<UserBloc>(navigatorKey.currentContext!)
                .state
                .user
                .id!));
      });
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      print('User granted provisional permission');
    } else {
      print('User declined or has not accepted permission');
    }
  } catch (e) {
    print(e);
  }
  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: await getTemporaryDirectory(),
  );
  runApp(AppView(isLogin: isLogin));
}

class AppView extends StatefulWidget {
  final bool? isLogin;

  const AppView({super.key, this.isLogin});

  @override
  State<AppView> createState() => _AppViewState();
}

class _AppViewState extends State<AppView> {
  final _route = RouteGenerator();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => UserBloc(),
          ),
          BlocProvider(
            create: (context) => HomeBloc(),
          ),
        ],
        child: MaterialApp(
          builder: (context, child) {
            return MediaQuery(
              child: child!,
              data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
            );
          },
          theme: ThemeData(
            scaffoldBackgroundColor: Color(0xFFF5F5F3),
          ),
          initialRoute:
              widget.isLogin != null && widget.isLogin == true ? '/home' : '/',
          onGenerateRoute: _route.generateRoute,
          debugShowCheckedModeBanner: false,
          navigatorKey: navigatorKey,
        ));
  }
}
