import 'package:flutter/material.dart';
import 'package:taskapp/detail_tugas.dart';

class Tugas extends StatelessWidget {
  const Tugas({
    super.key,
    required this.index,
    required this.tugas,
    required this.deskripsi,
    required this.hapusTugas
  });

  final int index;
  final String tugas;
  final String deskripsi;
  final void Function(int index) hapusTugas;

  void lihatTugas(BuildContext context, int index) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) {
          return DetailTugas(
            index: index,
            tugas: tugas,
            deskripsi: deskripsi
          );
        }
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: ListTile(
        title: Text(tugas),
        subtitle: Text(deskripsi),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: const Icon(Icons.remove_red_eye),
              onPressed: () => lihatTugas(context, index),
            ),
            IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () => hapusTugas(index),
            ),
          ],
        ),
        shape: RoundedRectangleBorder(
          side: const BorderSide(
            color: Colors.blue,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}