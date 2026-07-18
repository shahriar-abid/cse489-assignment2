import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_sizes.dart';
import '../../core/constants/app_strings.dart';

class ImageScreen extends StatefulWidget {
  const ImageScreen({super.key});

  @override
  State<ImageScreen> createState() => _ImageScreenState();
}

class _ImageScreenState extends State<ImageScreen> {
  late PhotoViewScaleStateController _scaleStateController;
  late PhotoViewController _photoViewController;

  @override
  void initState() {
    super.initState();
    _scaleStateController = PhotoViewScaleStateController();
    _photoViewController = PhotoViewController();
  }

  @override
  void dispose() {
    _scaleStateController.dispose();
    _photoViewController.dispose();
    super.dispose();
  }

  void _resetZoom() {
    setState(() {
      _scaleStateController.scaleState = PhotoViewScaleState.initial;
      _photoViewController.scale = null; // Resets to initial scale
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.image),
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              margin: const EdgeInsets.all(AppSizes.md),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(AppSizes.borderRadius),
                border: Border.all(color: Colors.grey.shade300),
              ),
              clipBehavior: Clip.antiAlias,
              child: PhotoView(
                imageProvider: const NetworkImage("https://picsum.photos/800/800"),
                controller: _photoViewController,
                scaleStateController: _scaleStateController,
                backgroundDecoration: const BoxDecoration(
                  color: AppColors.background,
                ),
                loadingBuilder: (context, event) => const Center(
                  child: CircularProgressIndicator(),
                ),
                errorBuilder: (context, error, stackTrace) => Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.error_outline, color: Colors.red, size: 48),
                      const SizedBox(height: AppSizes.sm),
                      const Text("Failed to load image from internet"),
                      const SizedBox(height: AppSizes.sm),
                      const Text(
                        "Check your internet connection",
                        style: TextStyle(fontSize: 12, color: Colors.grey),
                      ),
                      const SizedBox(height: AppSizes.md),
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            // Clear the cache to force a reload
                            PaintingBinding.instance.imageCache.clear();
                            PaintingBinding.instance.imageCache.clearLiveImages();
                          });
                        },
                        child: const Text("Retry"),
                      )
                    ],
                  ),
                ),
                minScale: PhotoViewComputedScale.contained,
                maxScale: PhotoViewComputedScale.covered * 2,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(AppSizes.lg),
            child: ElevatedButton.icon(
              onPressed: _resetZoom,
              icon: const Icon(Icons.refresh),
              label: const Text("Reset Zoom"),
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(200, AppSizes.buttonHeight),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
