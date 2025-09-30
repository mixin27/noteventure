import 'package:flutter/material.dart';
import 'package:ui/ui.dart';

import '../routes/app_router.dart';

class NoteventureApp extends StatelessWidget {
  const NoteventureApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Noteventure',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      routerConfig: AppRouter.router,
    );
  }
}
