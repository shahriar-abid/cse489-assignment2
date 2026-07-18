import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_sizes.dart';
import '../../core/constants/app_strings.dart';
import 'custom_receiver_screen.dart';

class CustomInputScreen extends StatefulWidget {
  const CustomInputScreen({super.key});

  @override
  State<CustomInputScreen> createState() => _CustomInputScreenState();
}

class _CustomInputScreenState extends State<CustomInputScreen> {
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onProceed() {
    final message = _controller.text.trim();
    if (message.isNotEmpty) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => CustomReceiverScreen(message: message),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please enter a message")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Custom Broadcast"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(AppSizes.lg),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              "Enter custom message",
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: AppColors.text,
                  ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppSizes.xl),
            TextField(
              controller: _controller,
              decoration: const InputDecoration(
                labelText: "Message",
                hintText: "Enter text here...",
              ),
            ),
            const SizedBox(height: AppSizes.xl),
            ElevatedButton(
              onPressed: _onProceed,
              child: const Text(AppStrings.proceed),
            ),
          ],
        ),
      ),
    );
  }
}
