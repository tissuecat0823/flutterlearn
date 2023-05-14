import 'package:flutter/material.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('설정'),
        centerTitle: true,
        //backgroundColor: const Color(0xFF212121),
      ),
      body: const Center(
        child: Text('Settings'),
      ),
    );
  }
}
