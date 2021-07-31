import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:kurir_zahra/cubit/pesanan_cubit.dart';
import 'package:kurir_zahra/cubit/user_cubit.dart';
import 'package:kurir_zahra/ui/pages/pages.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    HttpOverrides.global = new MyHttpOverrides();
    return MultiProvider(
      providers: [
        BlocProvider(
          create: (_) => UserCubit(),
        ),
        BlocProvider(
          create: (_) => PesananCubit(),
        ),
      ],
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        home: SplashScreenPage(),
      ),
    );
  }
}
