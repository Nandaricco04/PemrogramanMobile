# Laporan Praktikum #11 | Pemrograman Asynchronous

## Identitas Mahasiswa

| Atribut | Nilai                        |
| ------- | -----                        |
| Nama    | Nanda Ricco Satria Indrawan  |
| NIM     | 244107060058                 |
| Kelas   | SIB-2D   

# Tugas Praktikum 11

## Praktikum 1: Mengunduh Data dari Web Service (API)

### Langkah 1: Buat Project Baru

![Praktikum 1](img/prak1_1.png)

### Langkah 2: Cek file pubspec.yaml

![Praktikum 1](img/prak1_2.png)

### Langkah 3: Buka file main.dart

### **Soal 1**
Tambahkan nama panggilan Anda pada title app sebagai identitas hasil pekerjaan Anda.

![Praktikum 1](img/prak1_3.png)

### Langkah 4: Tambah method getData()

![Praktikum 1](img/prak1_4.png)

### **Soal 2**
Carilah judul buku favorit Anda di Google Books Kemudian cobalah akses di browser URI tersebut dengan lengkap seperti ini

![Praktikum 1](img/prak1_4-1.png)

![Praktikum 1](img/prak1_4-2.png)

### Langkah 5: Tambah kode di ElevatedButton

![Praktikum 1](img/prak1_5.png)

### **Soal 3**
Jelaskan maksud kode langkah 5 tersebut terkait substring dan catchError!, lalu Capture hasil praktikum Anda berupa GIF dan lampirkan di README.

Penjelasan kode langkah 5:

Kode pada onPressed ElevatedButton memiliki beberapa bagian penting:

1. substring(0, 450):

- Method substring(0, 450) digunakan untuk memotong string hasil response dari API
- Mengambil karakter dari indeks 0 sampai 450 (450 karakter pertama)
- Tujuannya adalah untuk membatasi jumlah data yang ditampilkan di UI agar tidak terlalu banyak
- Jika tidak menggunakan substring, seluruh response JSON (yang bisa sangat panjang) akan ditampilkan dan membuat UI terlihat berantakan

2. catchError((_)):

- Method catchError() digunakan untuk menangkap dan mengelola error yang mungkin terjadi saat memanggil API
- Jika terjadi error (misalnya: tidak ada koneksi internet, timeout, URL tidak valid, dll), maka blok kode dalam catchError akan dieksekusi
- Parameter (_) menandakan bahwa kita tidak menggunakan object error yang ditangkap
- Dalam blok catchError, result diisi dengan pesan "An error occurred" untuk memberitahu user bahwa terjadi kesalahan
- setState(() {}) dipanggil untuk memperbarui UI dan menampilkan pesan error kepada user

Outputnya

![Praktikum 1](img/prak1_5.gif)

## Praktikum 2: Menggunakan await/async untuk menghindari callbacks

### Langkah 1: Buka file main.dart

![Praktikum 2](img/prak2_1.png)

### Langkah 2: Tambah method count()

![Praktikum 2](img/prak2_2.png)

### Langkah 3: Panggil count()

![Praktikum 2](img/prak2_3.png)

### Langkah 4: Run

### **Soal 4**
Jelaskan maksud kode langkah 1 dan 2 tersebut!, lalu Capture hasil praktikum Anda berupa GIF dan lampirkan di README.

Penjelasan Langkah 1

```dart
Future<int> returnOneAsync() async {
  await Future.delayed(const Duration(seconds: 3));
  return 1;
}

Future<int> returnTwoAsync() async {
  await Future.delayed(const Duration(seconds: 3));
  return 2;
}

Future<int> returnThreeAsync() async {
  await Future.delayed(const Duration(seconds: 3));
  return 3;
}
```

- Ketiga method ini adalah fungsi asynchronous yang mengembalikan nilai Future<int>
- async menandakan fungsi berjalan di background (tidak memblokir UI)
- await Future.delayed(const Duration(seconds: 3)) = menunggu selama 3 detik sebelum menjalankan kode berikutnya (simulasi proses yang memakan waktu, seperti API call)
- Masing-masing method mengembalikan nilai berbeda:
    - returnOneAsync() → mengembalikan 1
    - returnTwoAsync() → mengembalikan 2
    - returnThreeAsync() → mengembalikan 3

Penjelasan Langkah 2

``` dart
Future count() async {
  int total = 0;
  total = await returnOneAsync();
  total += await returnTwoAsync();
  total += await returnThreeAsync();
  setState(() {
    result = total.toString();
  });
}
```

- Method count() adalah fungsi yang menggabungkan hasil dari ketiga method di atas
- int total = 0; = inisialisasi variable total dengan nilai 0
- total = await returnOneAsync(); = tunggu hingga returnOneAsync() selesai, hasilnya (1) disimpan ke total → total = 1
- total += await returnTwoAsync(); = tunggu hingga returnTwoAsync() selesai, tambahkan hasilnya (2) ke total → total = 1 + 2 = 3
- total += await returnThreeAsync(); = tunggu hingga returnThreeAsync() selesai, tambahkan hasilnya (3) ke total → total = 3 + 3 = 6
- setState(() { result = total.toString(); }) = tampilkan hasil akhir (6) di UI

Outputnya

![Praktikum 2](img/prak2_4.gif)

## Praktikum 3: Menggunakan Completer di Future

### Langkah 1: Buka main.dart

![Praktikum 3](img/prak3_1.png)

### Langkah 2: Tambahkan variabel dan method

![Praktikum 3](img/prak3_2.png)

### Langkah 3: Ganti isi kode onPressed()

![Praktikum 3](img/prak3_3.png)

### Langkah 4: Run

### **Soal 5**
Jelaskan maksud kode langkah 2 tersebut!, Capture hasil praktikum Anda berupa GIF dan lampirkan di README

``` dart
late Completer completer;

Future getNumber() {
  completer = Completer<int>();
  calculate();
  return completer.future;
}

Future calculate() async {
  await Future.delayed(const Duration(seconds : 5));
  completer.complete(42);
}
```

1. late Completer completer;
- Keyword late menunjukkan variable akan diinisialisasi nanti, bukan saat deklarasi. Completer adalah class untuk mengontrol Future secara manual, memungkinkan kita menentukan kapan Future selesai dan nilai apa yang dikembalikan.

2. Future getNumber()
- Method mengembalikan Future<int>, berjanji akan memberikan nilai integer di masa depan
- completer = Completer<int>() membuat object Completer baru untuk mengelola nilai integer
- calculate() memanggil method yang akan menjalankan proses asynchronous
- return completer.future mengembalikan Future yang akan diselesaikan oleh method calculate() nanti

3. Future calculate() async
- Method async ini menjalankan proses panjang secara asynchronous
- await Future.delayed(const Duration(seconds: 5)) menunggu selama 5 detik (simulasi pekerjaan berat seperti API call atau database query)
- completer.complete(42) menyelesaikan Future dengan mengembalikan nilai 42

Outputnya

![Praktikum 3](img/prak3_4.gif)

### Langkah 5: Ganti method calculate()

![Praktikum 3](img/prak3_5.png)

### Langkah 6: Pindah ke onPressed()

![Praktikum 3](img/prak3_6.png)

### **Soal 6**
Jelaskan maksud perbedaan kode langkah 2 dengan langkah 5-6 tersebut!, Capture hasil praktikum Anda berupa GIF dan lampirkan di README

Langkah 2 (Kode awal)
``` dart
// Method calculate() - Langkah 2
Future calculate() async {
  await Future.delayed(const Duration(seconds: 5));
  completer.complete(42);
}

// onPressed() - Langkah 2
onPressed: () {
  getNumber().then((value) {
    setState(() {
      result = value.toString();
    });
  });
}
```

Langkah 5 & 6 (Kode dengan Error Handling)
``` dart
// Method calculate() - Langkah 5
Future calculate() async {
  try {
    await Future.delayed(const Duration(seconds: 5));
    completer.complete(42);
  } catch (_) {
    completer.completeError({});
  }
}

// onPressed() - Langkah 6
onPressed: () {
  getNumber().then((value) {
    setState(() {
      result = value.toString();
    });
  }).catchError((e) {
    result = 'An error occurred';
  });
}
```

**Perbedaan Method calculate() dan onPressed() - Langkah 2 vs Langkah 5-6**

**1. Method calculate() - Langkah 2 vs Langkah 5**
- Langkah 2 (Tanpa Penanganan Error)
    - Kode ini langsung menjalankan Future.delayed() dan completer.complete(42) tanpa mekanisme penanganan error atau exception, sehingga jika terjadi error, aplikasi bisa mengalami crash atau Future tidak akan pernah selesai. Risiko ini sangat tinggi untuk production environment.

- Langkah 5 (Dengan Try-Catch)
    - Dengan mengimplementasikan blok try-catch, kode dapat mengatasi kemungkinan terjadinya error secara lebih aman dan robust. Blok try melakukan eksekusi kode normal dengan delay 5 detik kemudian complete dengan value 42, sementara blok catch menangkap exception dan memanggil completer.completeError() untuk menyelesaikan Future dengan status error, sehingga memberikan proteksi terhadap kemungkinan terjadinya error.

**2. Method onPressed() - Langkah 2 vs Langkah 6:**
- Langkah 2 (Tanpa catchError)
    - Kode hanya mempunyai handler .then() untuk menangani hasil yang berhasil, sehingga apabila Future selesai dengan error, tidak ada handler yang menanganinya dan bisa menghasilkan unhandled error yang tidak terkelola.

- Langkah 6 (Dengan catchError)
    - Kode mempunyai handler .then() untuk menangani hasil yang berhasil dan handler .catchError() untuk menangani jika terjadi error. Apabila completer.completeError() dijalankan, error akan ditangkap di .catchError() dan menampilkan pesan "An error occurred" kepada user sebagai feedback, sehingga lebih user-friendly karena memberikan notifikasi jika terjadi error.

Outputnya

![Praktikum 3](img/prak3_6.gif)

## Praktikum 4: Memanggil Future secara paralel

### Langkah 1: Buka file main.dart

![Praktikum 4](img/prak4_1.png)

### Langkah 2: Edit onPressed()

![Praktikum 4](img/prak4_2.png)

### Langkah 3: Run

### **Soal 7**
Capture hasil praktikum Anda berupa GIF dan lampirkan di README.

![Praktikum 4](img/prak4_3.gif)

### Langkah 4: Ganti variabel futureGroup

### **Soal 8**
Jelaskan maksud perbedaan kode langkah 1 dan 4!

Langkah 1 - Menggunakan FutureGroup
```dart
void returnFG() {
  FutureGroup<int> futureGroup = FutureGroup<int>();
  futureGroup.add(returnOneAsync());
  futureGroup.add(returnTwoAsync());
  futureGroup.add(returnThreeAsync());
  futureGroup.close();
  futureGroup.future.then((List<int> value) {
    int total = 0;
    for (var element in value) {
      total += element;
    }
    setState(() {
      result = total.toString();
    });
  });
}
```

Langkah 4 - Menggunakan Future.wait
``` dart
void returnFG() {
  final futures = Future.wait<int>([
    returnOneAsync(),
    returnTwoAsync(),
    returnThreeAsync(),
  ]);
  futures.then((List<int> value) {
    int total = 0;
    for (var element in value) {
      total += element;
    }
    setState(() {
      result = total.toString();
    });
  });
}
```

**Perbedaan kode langkah 1 dan 4**

**1. Cara Membuat dan Mengelola Future**
- Langkah 1 (FutureGroup)
    - Menggunakan class FutureGroup dari package async/async.dart, kita dapat membuat instance FutureGroup<int>() dan menambahkan Future secara individual menggunakan method .add(). Setelah itu, wajib memanggil .close() untuk memberikan signal bahwa tidak ada Future lagi yang akan dimasukkan, kemudian mengakses hasil melalui futureGroup.future.then(). Implementasi ini memerlukan import import 'package:async/async.dart';.

- Langkah 4 (Future.wait)
    - Menggunakan method Future.wait() yang merupakan built-in functionality dari Dart, kita dapat langsung menerima List of Futures sebagai parameter dalam bentuk array [...] tanpa memerlukan pemanggilan .close() karena list sudah bersifat final. Method ini langsung mengembalikan Future yang dapat di-chain dengan .then() dan tidak membutuhkan import tambahan karena sudah tersedia di dart:async yang built-in.

**2. Sintaks**
- Langkah 1 (FutureGroup)
    - FutureGroup lebih verbose dengan banyak baris kode dan memerlukan 5 langkah eksekusi: buat instance, add Future 1, add Future 2, add Future 3, kemudian close. Approach ini cocok digunakan jika jumlah Future bersifat dinamis atau ditambahkan secara kondisional, namun menghasilkan struktur kode yang lebih panjang dan detail.

- Langkah 4 (Future.wait)
    - Future.wait() lebih ringkas dan clean dengan sedikit baris kode, menggunakan pendekatan deklaratif di mana semua Future didefinisikan dalam satu list secara langsung. Approach ini mudah dibaca dan dipahami karena struktur yang simple, dan cocok digunakan ketika semua Future sudah diketahui di awal dan jumlahnya tetap.

**Kesimpulan**

Kedua pendekatan mencapai tujuan yang sama (menjalankan multiple Future secara paralel), tetapi:
- FutureGroup: Lebih fleksibel tetapi lebih verbose, memerlukan package eksternal
- Future.wait: Lebih sederhana, clean, dan merupakan cara standar/idiomatis di Dart

## Praktikum 5: Menangani Respon Error pada Async Code

### Langkah 1: Buka file main.dart

![Praktikum 5](img/prak5_1.png)

### Langkah 2: ElevatedButton

![Praktikum 5](img/prak5_2.png)

### Langkah 3: Run

### **Soal 9**
Capture hasil praktikum Anda berupa GIF dan lampirkan di README

![Praktikum 5](img/prak5_3.gif)

### Langkah 4: Tambah method handleError()

![Praktikum 5](img/prak5_4.png)

### **Soal 10**
Panggil method handleError() tersebut di ElevatedButton, lalu run. Apa hasilnya? Jelaskan perbedaan kode langkah 1 dan 4!

**Hasil yang ditampilkan**

Ketika tombol "GO!" ditekan, setelah 2 detik aplikasi akan menampilkan:

- Di layar (UI): "Exception: Something terrible happened!"
- Di console: "Complete"

**Perbedaan Kode Langkah 1 dan Langkah 4**

Langkah 1 - Error Handling dengan .then().catchError().whenComplete()
``` dart
onPressed: () {
  returnError()
      .then((value) {
        setState(() {
          result = 'Success';
        });
      })
      .catchError((onError) {
        setState(() {
          result = onError.toString();
        });
      })
      .whenComplete(() => print('Complete'));
}
```

Langkah 4 - Error Handling dengan try-catch-finally
``` dart
Future handleError() async {
  try {
    await returnError();
  } catch (error) {
    setState(() {
      result = error.toString();
    });
  } finally {
    print('Complete');
  }
}

// Dipanggil di onPressed
onPressed: () {
  handleError();
}
```

**Perbedaan**

**1. Pendekatan Error Handling**
- Langkah 1 (Functional/Chaining approach)
    - Menggunakan method chaining dengan .then(), .catchError(), dan .whenComplete() dengan pendekatan functional programming style, di mana error handling dilakukan dengan callback functions dan kode ditulis inline di dalam onPressed().

- Langkah 4 (Imperative/try-catch approach)
    - Menggunakan try-catch-finally yang lebih tradisional dengan pendekatan imperative programming style, di mana error handling menggunakan blok try-catch dan kode dipisahkan ke method handleError() yang terpisah.

**2. Struktur Kode**
- Langkah 1
    - Dengan pendekatan method chaining, semua logic error handling ada di dalam onPressed() sehingga lebih ringkas untuk kasus sederhana, namun method chaining membuat kode horizontal dan bisa panjang ke samping.

- Langkah 4
    - Dengan memisahkan logic error handling ke method terpisah, kode menjadi lebih modular dan reusable, struktur kode lebih vertikal dan mudah dibaca, serta onPressed() menjadi lebih clean dan fokus pada business logic.

**3. Penggunaan async/await**
- Langkah 1
    - Pendekatan ini tidak menggunakan await secara eksplisit, melainkan mengandalkan Promise-like pattern dengan .then(), sehingga dapat menangani asynchronous operation tanpa perlu method async.

- Langkah 4
    - Pendekatan ini menggunakan async/await secara eksplisit dengan method yang harus ditandai dengan async, sehingga lebih mudah dibaca seperti kode synchronous dan menggunakan await untuk menunggu Future selesai.

**4. Error Object**
- Langkah 1
    - Parameter di catchError adalah onError yang langsung dikonversi ke string menggunakan onError.toString().

- Langkah 4
    - Parameter di catch adalah error yang langsung dikonversi ke string menggunakan error.toString(), sehingga secara fungsional sama dengan pendekatan catchError, hanya penamaan parameter yang berbeda.

**5. Completion Handler**
- Langkah 1
    - Menggunakan .whenComplete(() => print('Complete')) yang dijalankan setelah .then() atau .catchError() selesai, tanpa memperhatikan apakah Future berhasil atau gagal.

- Langkah 4
    - Menggunakan finally { print('Complete'); } yang dijalankan setelah blok try atau catch selesai, tanpa memperhatikan apakah terjadi error atau tidak.

**Kesimpulan**

Langkah 1 (.then().catchError()):

- Cocok untuk kasus sederhana dan one-liner tanpa perlu membuat method terpisah dengan pendekatan functional programming. Namun, bisa sulit dibaca jika chain-nya panjang dan tidak familiar bagi developer dari bahasa lain.

Langkah 4 (try-catch-finally):

- Lebih familiar dan mudah dipahami karena lebih mirip kode synchronous, lebih mudah dibaca, dan lebih modular dengan method terpisah. Approach ini lebih baik untuk error handling yang kompleks dan support debugging yang lebih baik, meskipun memerlukan method async terpisah.

**Outputnya**

![Praktikum 5](img/prak5_5.gif)

## Praktikum 6: Menggunakan Future dengan StatefulWidget

### Langkah 1: install plugin geolocator

![Praktikum 6](img/prak6_1.png)

### Langkah 2: Tambah permission GPS

![Praktikum 6](img/prak6_2.png)

### Langkah 3: Buat file geolocation.dart

![Praktikum 6](img/prak6_3.png)

### Langkah 4: Buat StatefulWidget

![Praktikum 6](img/prak6_4.png)

### Langkah 5: Isi kode geolocation.dart

### **Soal 11**

![Praktikum 6](img/prak6_5.png)

### Langkah 6: Edit main.dart

![Praktikum 6](img/prak6_6.png)

### Langkah 7: Run

![Praktikum 6](img/prak6_7.jpeg)

### Langkah 8: Tambahkan animasi loading

![Praktikum 6](img/prak6_8.png)

### **Soal 12**
**Jika Anda tidak melihat animasi loading tampil, kemungkinan itu berjalan sangat cepat. Tambahkan delay pada method getPosition() dengan kode await Future.delayed(const Duration(seconds: 3));**

![Praktikum 6](img/prak6_8-1.png)

**Apakah Anda mendapatkan koordinat GPS ketika run di browser? Mengapa demikian?**

![Praktikum 6](img/prak6_8-2.png)

Browser modern mendukung Geolocation API yang memungkinkan aplikasi web, termasuk Flutter web, mengakses lokasi pengguna melalui package geolocator. Namun, akurasi GPS di browser jauh lebih rendah dibanding mobile karena mengandalkan IP geolocation dan WiFi positioning daripada hardware GPS—biasanya hanya akurat hingga ratusan meter. Selain itu, API ini hanya bekerja di HTTPS atau localhost dan memerlukan izin pengguna, sehingga koordinat yang didapat sering menunjukkan lokasi ISP/provider internet daripada lokasi fisik sebenarnya.

**Capture hasil praktikum Anda berupa GIF dan lampirkan di README**

![Praktikum 6](img/prak6_8.gif)

## Praktikum 7: Manajemen Future dengan FutureBuilder

### Langkah 1: Modifikasi method getPosition()

![Praktikum 7](img/prak7_1.png)

### Langkah 2: Tambah variabel

![Praktikum 7](img/prak7_2.png)

### Langkah 3: Tambah initState()

![Praktikum 7](img/prak7_3.png)

### Langkah 4: Edit method build()

![Praktikum 7](img/prak7_4.png)

### **Soal 13**
**Apakah ada perbedaan UI dengan praktikum sebelumnya? Mengapa demikian?, Capture hasil praktikum Anda berupa GIF dan lampirkan di README**

Ya, Perbedaan UI antara Praktikum 6 dan Praktikum 7 terletak pada loading indicator. Praktikum 6 menggunakan .then() dengan manual setState() sehingga tidak ada loading indicator, layar kosong/blank selama 3 detik, dan koordinat muncul tiba-tiba setelah loading selesai. 

Sementara pada Praktikum 7 menggunakan FutureBuilder yang otomatis mendeteksi ConnectionState, sehingga ada CircularProgressIndicator saat loading, user dapat melihat feedback visual yang jelas, dan transisi smooth dari loading ke data.

Outputnya

![Praktikum 7](img/prak7_4.gif)

### Langkah 5: Tambah handling error

![Praktikum 7](img/prak7_5.png)

### **Soal 14**
**Apakah ada perbedaan UI dengan langkah sebelumnya? Mengapa demikian?, Capture hasil praktikum Anda berupa GIF dan lampirkan di README**

Tidak ada perbedaan UI yang terlihat setelah menambahkan error handling karena getPosition() berjalan sukses tanpa error, sehingga kode snapshot.hasError tidak akan terpicu. Pesan "Something terrible happened!" hanya akan ditampilkan jika terjadi error seperti permission ditolak atau GPS tidak aktif. Dalam kondisi normal, FutureBuilder menampilkan CircularProgressIndicator saat ConnectionState.waiting, kemudian secara otomatis beralih menampilkan koordinat saat ConnectionState.done tanpa error. Dengan demikian, error handling berfungsi sebagai safety net yang siap menangani situasi error jika terjadi, namun tidak mengubah alur UI yang sudah berjalan normal.

Outputnya

![Praktikum 7](img/prak7_5.gif)

## Praktikum 8: Navigation route dengan Future Function

### Langkah 1: Buat file baru navigation_first.dart

![Praktikum 8](img/prak8_1.png)

### Langkah 2: Isi kode navigation_first.dart

### **Soal 15**
**Tambahkan nama panggilan Anda pada tiap properti title sebagai identitas pekerjaan Anda, Silakan ganti dengan warna tema favorit Anda.**

![Praktikum 8](img/prak8_2.png)

### Langkah 3: Tambah method di class _NavigationFirstState

![Praktikum 8](img/prak8_3.png)

### Langkah 4: Buat file baru navigation_second.dart

![Praktikum 8](img/prak8_4.png)

### Langkah 5: Buat class NavigationSecond dengan StatefulWidget

![Praktikum 8](img/prak8_5.png)

### Langkah 6: Edit main.dart

![Praktikum 8](img/prak8_6.png)

### Langkah 7: Run

### **Soal 16**
**Cobalah klik setiap button, apa yang terjadi ? Mengapa demikian ?**

Ketika button diklik (Red/Green/Blue), aplikasi akan menutup halaman kedua (NavigationSecond) dan kembali ke halaman pertama (NavigationFirst) dengan background halaman pertama berubah sesuai warna button yang dipilih. 

Hal ini terjadi karena setiap button memanggil Navigator.pop(context, color) yang mengirim data warna kembali ke halaman sebelumnya, kemudian method _navigateAndGetColor() di halaman pertama menerima warna tersebut melalui await Navigator.push() dan memanggil setState() untuk update background dengan warna

**Gantilah 3 warna pada langkah 5 dengan warna favorit Anda!, Capture hasil praktikum Anda berupa GIF dan lampirkan di README.**

Code

![Praktikum 8](img/prak8_7.png)

Outpunya

![Praktikum 8](img/prak8_7.gif)

## Praktikum 9: Memanfaatkan async/await dengan Widget Dialog

### Langkah 1: Buat file baru navigation_dialog.dart

![Praktikum 9](img/prak9_1.png)

### Langkah 2: Isi kode navigation_dialog.dart

![Praktikum 9](img/prak9_2.png)

### Langkah 3: Tambah method async

![Praktikum 9](img/prak9_3.png)

### Langkah 4: Panggil method di ElevatedButton

![Praktikum 9](img/prak9_4.png)

### Langkah 5: Edit main.dart

![Praktikum 9](img/prak9_5.png)

### Langkah 6: Run

### **Soal 17**
**Cobalah klik setiap button, apa yang terjadi ? Mengapa demikian ?**

Ketika button "Change Color" diklik, muncul AlertDialog dengan 3 pilihan warna (Red/Green/Blue), dan setelah memilih warna, dialog tertutup serta background halaman berubah sesuai warna yang dipilih.

Hal ini terjadi karena method _showColorDialog() menampilkan dialog dengan showDialog() yang memiliki barrierDismissible: false sehingga dialog hanya bisa ditutup dengan klik button, kemudian setiap TextButton memanggil Navigator.pop(context, color) untuk menutup dialog dan mengirim warna, dan setelah await showDialog() selesai, setState() dipanggil untuk update background

Perbedaan dengan Praktikum 8:

- Praktikum 8: Navigasi ke halaman baru (full screen)
- Praktikum 9: Menampilkan dialog (popup overlay)

**Gantilah 3 warna pada langkah 3 dengan warna favorit Anda!, Capture hasil praktikum Anda berupa GIF dan lampirkan di README**

Code

![Praktikum 9](img/prak9_6.png)

Outputnya

![Praktikum 9](img/prak9_6.gif)