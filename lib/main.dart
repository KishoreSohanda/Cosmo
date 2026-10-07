import 'package:flutter/material.dart';

import 'app/router/app_router.dart';
import 'app/theme/app_theme.dart';

void main() {
  runApp(const CosmoApp());
}

class CosmoApp extends StatelessWidget {
  const CosmoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Cosmo',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkTheme,
      routerConfig: AppRouter.router,
    );
  }
}
