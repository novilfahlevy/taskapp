// void main() {
//   // Simulasi 1
//   print('Sedang mengambil data dari internet...');
//   print('Data: [1, 2, 3]');
//   print('Data berhasil diambil!');
// }

// void main() {
//   // Simulasi 2
  
//   print('Sedang mengambil data dari internet...');

//   Future.delayed(Duration(seconds: 3), () => print('Data: [1, 2, 3]'));

//   print('Data berhasil diambil!');
// }

void main() {
  // Simulasi 3
  
  print('Sedang mengambil data dari SIPLO...');

  var angkaFuture = Future.delayed(
    Duration(seconds: 3),
    () => { 'nim': '2109116095', 'nama': 'Muhammad Novil Fahlevy' }
  );

  angkaFuture
    .then((data) => print('Data: $data'))
    .then((_) => print('Data berhasil diambil!'));
}