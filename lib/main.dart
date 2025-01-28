import 'package:flutter/material.dart';

void main() {
  runApp(const TaskApp());
}

class TaskApp extends StatefulWidget {
  const TaskApp({super.key});

  @override
  State<TaskApp> createState() => _TaskAppState();
}

class _TaskAppState extends State<TaskApp> {
  List<Map<String, String>> tugas = [];

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  TextEditingController tugasController = TextEditingController();

  TextEditingController deskripsiController = TextEditingController();

  void tambahTugas(String tugas, String deskripsi) {
    if (formKey.currentState!.validate()) {
      setState(() {
        this.tugas.add({
          'tugas': tugas,
          'deskripsi': deskripsi,
        });
      });
    } 
  }

  void hapusTugas(int index) => setState(() => tugas.removeAt(index));

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
          child: Padding(
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
                    onPressed: () {
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
                    child: const Text('Tambah'),
                  ),
                ),
          
                const SizedBox(height: 50),
          
                for (int i = 0; i < tugas.length; i++)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: ListTile(
                      title: Text(tugas[i]['tugas']!),
                      subtitle: Text(tugas[i]['deskripsi']!),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () => hapusTugas(i),
                      ),
                      shape: RoundedRectangleBorder(
                        side: const BorderSide(
                          color: Colors.blue,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}