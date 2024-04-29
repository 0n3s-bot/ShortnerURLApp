import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:urlshortener/bloc/BMI/bmi_provider.dart';
import 'package:urlshortener/bloc/BMI/bmi_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Url Shortener',
      theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
          appBarTheme: AppBarTheme(
              titleTextStyle: TextStyle(
                  fontSize: 22,
                  color: Colors.black,
                  fontWeight: FontWeight.w500))),
      home: MultiProvider(providers: [
        ChangeNotifierProvider(create: (context) => BmiProvider()),
        // Provider<BmiProvider>(
        //   create: (_) => BmiProvider(),
        // ),
      ], child: BmiScreen()),
      // BlocProvider(
      //   create: (context) => HomeBloc(),
      //   child: const MyHomePageScreen(),
      // ),
    );
  }
}
