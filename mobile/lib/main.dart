import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'app/app.dart';

void main() async {
  // Initialize app dependencies
  await initializeApp();
  
  // Run the app with Riverpod
  runApp(
    const ProviderScope(
      child: LawConnectApp(),
    ),
  );
}