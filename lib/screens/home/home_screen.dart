import 'package:flutter/material.dart';
import '../../widgets/app_drawer.dart';

import '../../core/constants/app_sizes.dart';
import '../../core/constants/app_strings.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const AppDrawer(),
      appBar: AppBar(
        title: const Text(AppStrings.appTitle),
      ),
      body: Padding(
        padding: const EdgeInsets.all(AppSizes.lg),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.android,
                size: 80,
              ),

              const SizedBox(height: AppSizes.lg),

              const Text(
                AppStrings.welcome,
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: AppSizes.sm),

              const Text(
                AppStrings.homeDescription,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}