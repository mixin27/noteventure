import 'package:flutter/material.dart';
import 'package:core/core.dart';
import 'package:ui/ui.dart';

void main() {
  runApp(const NoteventureApp());
}

class NoteventureApp extends StatelessWidget {
  const NoteventureApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: AppConstants.appName,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
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

              SizedBox(height: AppSpacing.lg),

              // Test shared ui
              CustomCard(
                onTap: () {},
                child: Column(
                  children: [
                    CustomButton(text: 'Fill Button', onPressed: () {}),
                    SizedBox(height: AppSpacing.md),
                    CustomButton(
                      text: 'Outlined Button',
                      onPressed: () {},
                      variant: ButtonVariant.outlined,
                    ),
                    SizedBox(height: AppSpacing.md),
                    CustomButton(
                      text: 'Text Button',
                      onPressed: () {},
                      variant: ButtonVariant.text,
                    ),
                    SizedBox(height: AppSpacing.md),
                    CustomButton(
                      text: 'Loading',
                      onPressed: () {},
                      isLoading: true,
                    ),
                    SizedBox(height: AppSpacing.md),
                    CustomBadge(text: 'Badge'),
                    SizedBox(height: AppSpacing.md),
                    CustomChip(label: 'chip'),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
