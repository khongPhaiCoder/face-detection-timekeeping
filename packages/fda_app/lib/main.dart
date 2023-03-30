import 'package:fda_app/config/router/route_generator.dart';
import 'package:fda_app/data/user/bloc/user_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  bool? isLogin = prefs.getBool('isLogin');

  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: await getTemporaryDirectory(),
  );
  runApp(AppView(isLogin: isLogin));
}

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

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
