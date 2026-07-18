import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_sizes.dart';

class CustomReceiverScreen extends StatefulWidget {
  final String message;
  const CustomReceiverScreen({super.key, required this.message});

  @override
  State<CustomReceiverScreen> createState() => _CustomReceiverScreenState();
}

class _CustomReceiverScreenState extends State<CustomReceiverScreen> {
  static const MethodChannel _triggerChannel =
      MethodChannel('com.example.assignment2/custom_broadcast_trigger');
  static const EventChannel _receiverChannel =
      EventChannel('com.example.assignment2/custom_broadcast_receiver');

  StreamSubscription? _subscription;
  String _receivedMessage = "Waiting for broadcast...";

  @override
  void initState() {
    super.initState();
    _startListening();
  }

  void _startListening() {
    _subscription = _receiverChannel.receiveBroadcastStream().listen((event) {
      setState(() {
        _receivedMessage = event.toString();
      });
    });
  }

  Future<void> _sendBroadcast() async {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Sending broadcast..."), duration: Duration(seconds: 1)),
    );
    try {
      await _triggerChannel.invokeMethod('sendCustomBroadcast', {
        'message': widget.message,
      });
    } on PlatformException catch (e) {
      debugPrint("Failed to send broadcast: ${e.message}");
    }
  }

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Broadcast Result"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(AppSizes.lg),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.broadcast_on_personal,
                size: 80,
                color: AppColors.primary,
              ),
              const SizedBox(height: AppSizes.xl),
              const Text(
                "Received Message:",
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
              const SizedBox(height: AppSizes.sm),
              Text(
                _receivedMessage,
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: AppColors.text,
                    ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: AppSizes.xl),
              ElevatedButton.icon(
                onPressed: _sendBroadcast,
                icon: const Icon(Icons.send),
                label: const Text("Send Broadcast"),
              ),
              const SizedBox(height: AppSizes.xl),
              const Text(
                "Click the button above to trigger a custom Android intent broadcast. The native BroadcastReceiver will catch it and display the message here.",
                style: TextStyle(color: Colors.grey, fontSize: 12),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
