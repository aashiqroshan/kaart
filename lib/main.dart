import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_kaart/bloc/kaart_bloc.dart';
import 'package:the_kaart/pages/home_screen.dart';
import 'package:the_kaart/services/services.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
 MyApp({super.key});

  final serv = Services();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => KaartBloc(services: Services()),
      child: MaterialApp(
      theme: ThemeData(primarySwatch: Colors.blue),
      debugShowCheckedModeBanner: false,
      home: const HomeScreen(),
    ),
    );
  }
}
