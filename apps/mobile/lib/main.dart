import 'package:flutter/material.dart';
import 'package:core/core.dart';

void main() {
  runApp(const NoteventureApp());
}

class NoteventureApp extends StatelessWidget {
  const NoteventureApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppConstants.appName,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                AppConstants.appName,
                style: const TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              Text('Version: ${AppConstants.appVersion}'),
              Text('Starting Points: ${AppConstants.startingPoints}'),
              const SizedBox(height: 16),
              const Text('Project setup complete! 🎉'),
            ],
          ),
        ),
      ),
    );
  }
}
