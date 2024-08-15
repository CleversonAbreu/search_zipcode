import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'core/injection/locator.dart';
import 'modules/zipcode/presentation/cubit/zipcode_cubit.dart';
import 'modules/zipcode/presentation/pages/zipcode_page.dart';

void main() {
  setupLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Busca CEP',
      home: BlocProvider(
        create: (_) => locator<ZipcodeCubit>(),
        child: ZipcodePage(),
      ),
    );
  }
}
