// test/widget_test.dart

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

// Penting: Pastikan path impor ini benar!
// 'p3l' harus sesuai dengan nama paket Anda di pubspec.yaml (baris 'name: p3l').
// File 'main.dart' harus berada di dalam direktori 'lib' dari paket tersebut.
import 'package:MOBILEP3L/main.dart'; // Jika nama paket Anda berbeda, ganti 'p3l'

void main() {
  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    // Bangun aplikasi kita dan picu sebuah frame.
    // Pastikan kelas 'MyApp' didefinisikan di 'package:p3l/main.dart'
    await tester.pumpWidget(const MyApp());

    // Verifikasi bahwa counter kita dimulai dari 0.
    expect(find.text('0'), findsOneWidget);
    expect(find.text('1'), findsNothing);

    // Ketuk ikon '+' dan picu sebuah frame.
    // Pastikan FloatingActionButton Anda menggunakan Icons.add
    await tester.tap(find.byIcon(Icons.add));
    await tester
        .pump(); // Panggil pump() setelah interaksi untuk membangun ulang widget

    // Verifikasi bahwa counter kita telah bertambah.
    expect(find.text('0'), findsNothing);
    expect(find.text('1'), findsOneWidget);
  });
}
