import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_sizes.dart';

class BatteryScreen extends StatefulWidget {
  const BatteryScreen({super.key});

  @override
  State<BatteryScreen> createState() => _BatteryScreenState();
}

class _BatteryScreenState extends State<BatteryScreen> {
  static const EventChannel _eventChannel =
      EventChannel('com.example.assignment2/battery');
  
  StreamSubscription? _subscription;
  int _level = 0;

  @override
  void initState() {
    super.initState();
    _startListening();
  }

  void _startListening() {
    _subscription = _eventChannel.receiveBroadcastStream().listen((event) {
      if (event is Map) {
        setState(() {
          _level = event['level'] ?? 0;
        });
      }
    });
  }

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }

  IconData _getBatteryIcon() {
    if (_level >= 90) return Icons.battery_full;
    if (_level >= 80) return Icons.battery_6_bar;
    if (_level >= 60) return Icons.battery_5_bar;
    if (_level >= 40) return Icons.battery_4_bar;
    if (_level >= 20) return Icons.battery_3_bar;
    if (_level >= 10) return Icons.battery_2_bar;
    return Icons.battery_alert;
  }

  Color _getBatteryColor() {
    if (_level <= 15) return Colors.red;
    if (_level <= 30) return Colors.orange;
    return AppColors.primary;
  }

  @override
  Widget build(BuildContext context) {
    final orientation = MediaQuery.of(context).orientation;
    final isLandscape = orientation == Orientation.landscape;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Battery Percentage"),
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppSizes.lg),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "System Battery Receiver",
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: AppColors.text,
                    ),
              ),
              SizedBox(height: isLandscape ? AppSizes.md : AppSizes.xl),
              Icon(
                _getBatteryIcon(),
                size: isLandscape ? 100 : 150,
                color: _getBatteryColor(),
              ),
              SizedBox(height: isLandscape ? AppSizes.md : AppSizes.xl),
              const Text(
                "Current Battery Level",
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.grey,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: AppSizes.sm),
              Text(
                "$_level%",
                style: TextStyle(
                  fontSize: isLandscape ? 48 : 64,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
