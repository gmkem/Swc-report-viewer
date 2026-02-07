import 'package:flutter/material.dart';

void main() {
  runApp(const SWCApp());
}

class SWCApp extends StatelessWidget {
  const SWCApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ตรวจสอบรายงาน SWC',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ตรวจสอบรายงาน SWC'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'ระบบรับแจ้งเรื่องร้องเรียน\nโรงเรียนศรีวิชัยวิทยา',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}