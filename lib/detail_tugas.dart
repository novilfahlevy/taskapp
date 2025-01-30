import 'package:flutter/material.dart';

class DetailTugas extends StatelessWidget {
  const DetailTugas({
    super.key,
    required this.index,
    required this.tugas,
    required this.deskripsi
  });

  final int index;
  final String tugas;
  final String deskripsi;

  void kembali(BuildContext context) {
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('TaskApp', style: TextStyle(color: Colors.white)),
          backgroundColor: Colors.blue,
          leading: IconButton(
            icon: const Icon(Icons.chevron_left, color: Colors.white),
            onPressed: () => kembali(context),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Detail Tugas',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Text(
                'Tugas: $tugas',
                style: const TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 10),
              Text(
                'Deskripsi: $deskripsi',
                style: const TextStyle(fontSize: 18),
              ),
            ],
          ),
        ),
      ),
    );
  }
}