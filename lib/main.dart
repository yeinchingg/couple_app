import 'package:flutter/material.dart';
import 'screens/photo.dart'; // 確保你有匯入 photo.dart

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: PhotoWallPage(), // ✅ 正確的 widget 名稱
    );
  }
}

