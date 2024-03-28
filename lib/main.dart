import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:newtronic_apps/data/service/database_service.dart';
import 'package:newtronic_apps/data/viewmodel/home_viewmodel.dart';
import 'package:newtronic_apps/view/downloaded_view.dart';
import 'package:newtronic_apps/view/home_view.dart';
import 'package:provider/provider.dart';

import 'splash_screen.dart';
import 'utils/size_config.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(<DeviceOrientation>[
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown
  ]).then((value) => runApp(const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SizeConfig.initOnStartUp(context);

    return MultiProvider(
        providers: [
          ChangeNotifierProvider(
              create: (context) => HomeViewModel(
                    databaseService: DatabaseService(),
                  )),
        ],
        builder: (context, child) {
          return MaterialApp(
            title: 'Flutter Demo',
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              fontFamily: 'Manrope',
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
              appBarTheme: const AppBarTheme(
                backgroundColor: Colors.white,
                elevation: 1,
                foregroundColor: Colors.black,
                surfaceTintColor: Colors.white,
                titleTextStyle: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 22,
                    color: Colors.black),
              ),
            ),
            initialRoute: SplashScreen.routeName,
            routes: {
              SplashScreen.routeName: (context) => const SplashScreen(),
              HomeView.routeName: (context) => const HomeView(),
              DownloadedView.routeName: (context) => const DownloadedView(),
            },
          );
        });
  }
}
