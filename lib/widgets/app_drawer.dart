import 'package:flutter/material.dart';

import '../core/constants/app_strings.dart';
import '../screens/audio/audio_screen.dart';
import '../screens/broadcast/broadcast_selection_screen.dart';
import '../screens/image/image_screen.dart';
import '../screens/video/video_screen.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Center(
              child: Text(
                AppStrings.appTitle,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),

          ListTile(
            leading: const Icon(Icons.battery_full),
            title: const Text(AppStrings.broadcast),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const BroadcastSelectionScreen(),
                ),
              );
            },
          ),

          ListTile(
            leading: const Icon(Icons.image),
            title: const Text(AppStrings.image),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const ImageScreen(),
                ),
              );
            },
          ),

          ListTile(
            leading: const Icon(Icons.video_library),
            title: const Text(AppStrings.video),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const VideoScreen(),
                ),
              );
            },
          ),

          ListTile(
            leading: const Icon(Icons.audiotrack),
            title: const Text(AppStrings.audio),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const AudioScreen(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}