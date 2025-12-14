import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'data/repository/in_memory_repository.dart';
import 'presentation/bloc/export_bloc.dart';
import 'presentation/pages/export_pages.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // For Firestore-based runs, initialize Firebase here.
  final repo = InMemoryRepository();
  runApp(MyApp(repo: repo));
}

class MyApp extends StatelessWidget {
  final InMemoryRepository repo;
  const MyApp({super.key, required this.repo});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'McD Bot Queue',
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.red),
      home: BlocProvider(create: (_) => OrderBloc(), child: const HomePage()),
    );
  }
}
