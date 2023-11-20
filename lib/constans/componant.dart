import 'dart:io';
import 'package:flutter/material.dart';
import '../remote/cache_helper.dart';
import '../screens/login/screen/login_screen.dart';

void singOut(context) {
  CacheHelper.removeData(key: 'uId').then((value) {
    if (value) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => LoginScreen(),
        ),
      );
    }
  });
}

String uId = '';

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}



// if(state is ShopSuccessHomeDataState ){
// return productsBuilder(state.homeModel,state.categoriesModel,context);
// }else{
// return const Center(child: CircularProgressIndicator());
// }
