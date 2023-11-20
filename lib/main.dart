import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social/remote/cache_helper.dart';
import 'package:social/remote/dio_helper.dart';
import 'package:social/screens/login/screen/login_screen.dart';
import 'package:social/social_layout/cubit/cubit.dart';
import 'package:social/social_layout/cubit/states.dart';
import 'package:social/social_layout/home_screen/layout_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  DioHelper.init();
  await CacheHelper.init();
  Widget widget;
 String? uId = await CacheHelper.getData(key: 'uId');
  print(uId.toString());
  // ignore: unnecessary_null_comparison
  if (uId != null) {
    widget = const HomeScreen();
  } else {
    widget = LoginScreen();
  }
  runApp(MyApp(
    startWidget: widget,
  ));
}

class MyApp extends StatelessWidget {
  final Widget startWidget;

  const MyApp({super.key, required this.startWidget,});

  @override
  Widget build(BuildContext context) {
       return BlocProvider(
      create: (context) => SocialCubit(SocialInitialState()),
      child: Builder(
          builder: (context) {
            return MaterialApp(
              theme: ThemeData(
                appBarTheme: const AppBarTheme(
                  systemOverlayStyle: SystemUiOverlayStyle(
                    statusBarColor: Colors.white,
                    statusBarIconBrightness: Brightness.dark,
                  ),
                  backgroundColor: Colors.white,
                  elevation: 0.0,
                ),
              ),
              debugShowCheckedModeBanner: false,
              home: startWidget,
            );
          }
      ),
    );
  }
}
