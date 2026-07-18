import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_sizes.dart';
import '../../core/constants/app_strings.dart';
import 'battery_screen.dart';
import 'custom_input_screen.dart';

class BroadcastSelectionScreen extends StatefulWidget {
  const BroadcastSelectionScreen({super.key});

  @override
  State<BroadcastSelectionScreen> createState() => _BroadcastSelectionScreenState();
}

class _BroadcastSelectionScreenState extends State<BroadcastSelectionScreen> {
  final List<String> _options = [
    'Custom Broadcast Receiver',
    'System Battery Notification Receiver',
  ];
  String? _selectedOption;

  @override
  void initState() {
    super.initState();
    _selectedOption = _options[0];
  }

  void _onProceed() {
    if (_selectedOption == _options[0]) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => const CustomInputScreen()),
      );
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => const BatteryScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.broadcast),
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppSizes.lg),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                "Select a broadcast type",
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: AppColors.text,
                    ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: AppSizes.xl),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: AppSizes.md),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(AppSizes.borderRadius),
                  border: Border.all(color: Colors.grey.shade300),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: _selectedOption,
                    isExpanded: true,
                    items: _options.map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (newValue) {
                      setState(() {
                        _selectedOption = newValue;
                      });
                    },
                  ),
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
      ),
    );
  }
}
