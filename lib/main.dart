import 'package:appresep/bloc/blocs.dart';
import 'package:appresep/listResep_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ResepBloc>(create: (BuildContext context) => ResepBloc()),
      ],
      child: GetMaterialApp(
        home: ListResepPage(),
      ),
    );
  }
}
