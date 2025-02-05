import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:taskapp/tugas.dart';

void main() {
  runApp(const TaskApp());
}

class TaskApp extends StatefulWidget {
  const TaskApp({super.key});

  @override
  State<TaskApp> createState() => _TaskAppState();
}

class _TaskAppState extends State<TaskApp> {
  List<Map<String, dynamic>> tugas = [];

  bool loading = true;

  bool loadingTambahTugas = false;

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  TextEditingController tugasController = TextEditingController();

  TextEditingController deskripsiController = TextEditingController();

  void tambahTugas(String tugas, String deskripsi) {
    if (formKey.currentState!.validate()) {
      setState(() => loadingTambahTugas = true);

      final tugasFuture = Dio().post('https://jsonplaceholder.typicode.com/todos', data: {
        'title': tugas,
        'completed': false,
      });
      
      tugasFuture.then((response) {
        if (response.statusCode == 201) {
          setState(() {
            this.tugas.add({
              'id': response.data['id'],
              'tugas': tugas,
              'deskripsi': deskripsi,
            });
            loadingTambahTugas = false;
          });
        }
      });
    } 
  }

  void hapusTugas(int index) => setState(() => tugas.removeAt(index));

  void ambilDataTugas() {
    final tugasFuture = Dio().get('https://jsonplaceholder.typicode.com/todos');

    tugasFuture.then((response) {
      setState(() => loading = false);

      if (response.statusCode == 200) {
        final tugas = response.data;
        tugas.forEach((tugas) {
          setState(() {
            this.tugas.add({
              'id': tugas['id'],
              'tugas': tugas['title'],
              'deskripsi': tugas['completed'] ? 'Selesai' : 'Belum selesai',
            });
          });
        });
      }
    });
  }

  @override
  void initState() {
    super.initState();
    ambilDataTugas();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('TaskApp', style: TextStyle(color: Colors.white)),
          backgroundColor: Colors.blue,
        ),
        body: Form(
          key: formKey,
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                TextFormField(
                  controller: tugasController,
                  decoration: InputDecoration(
                    labelText: 'Tugas',
                    hintText: 'Contoh: Lari pagi',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    )
                  ),
                  validator: (value) => value!.isEmpty ? 'Tidak boleh kosong' : null,
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: deskripsiController,
                  decoration: InputDecoration(
                    labelText: 'Deskripsi',
                    hintText: 'Contoh: 20 KM',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    )
                  ),
                  validator: (value) => value!.isEmpty ? 'Tidak boleh kosong' : null,
                ),
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: loadingTambahTugas
                      ? null
                      : () {
                        tambahTugas(tugasController.text, deskripsiController.text);
                        tugasController.clear();
                        deskripsiController.clear();
                      },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.all(20),
                      backgroundColor: Colors.blue,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: loadingTambahTugas
                      ? const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                          ),
                        )
                      : const Text('Tambah Tugas'),
                  ),
                ),
          
                const SizedBox(height: 50),
          
                Builder(
                  builder: (context) {
                    if (loading) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    return ListView.builder(
                      shrinkWrap: true,
                      itemCount: tugas.length,
                      itemBuilder: (context, index) {
                        return Tugas(
                          index: index,
                          id: tugas[index]['id']!,
                          tugas: tugas[index]['tugas']!,
                          deskripsi: tugas[index]['deskripsi']!,
                          hapusTugas: hapusTugas
                        );
                      },
                    );
                  }
                )
              ]
            ),
          )
        ),
      ),
    );
  }
}