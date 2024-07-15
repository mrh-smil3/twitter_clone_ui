# Desain Figma

[Figma](https://www.figma.com/file/5SuXny1LLj3s2ezR1dsc6x/Twitter-UI-Screens?type=design&node-id=4%3A1224&mode=design&t=BEnNbgYUXZrRzUL9-1)

## Steps

1. Penambahan Dependency dan Penambahan Asset pada file pubspec.yaml

   - Buka file pubspec.yaml.
   - Di bagian dependencies, tambahkan dependency yang diperlukan untuk paket Flutter yang ingin Anda gunakan.
   - Di bagian flutter, tambahkan asset seperti gambar atau font yang akan digunakan dalam aplikasi.

2. Pembuatan Halaman UI

   - Buat sebuah file untuk halaman UI.
   - Definisikan struktur UI menggunakan widget-tree seperti Scaffold, AppBar, Container, Column, atau Row.

3. Pembuatan Widgets

   - Buat widget terpisah untuk bagian-bagian yang dapat digunakan kembali dari UI Anda.
   - Pisahkan UI menjadi bagian-bagian yang logis seperti header, body, atau footer.

4. Pembuatan State

   - Penggunaan stateless widget.
   - Buat state menggunakan setState(), Provider, dan state lainnya.

5. Pembuatan Resource

   - Buat file terpisah untuk menyimpan resource seperti warna, string, atau nilai konstan lainnya.

6. Pembuatan Model

   - Membuat model untuk merepresentasikan data.
   - Gunakan model untuk menyimpan dan mengelola data dari sumber eksternal seperti API atau database.

7. Pembuatan Helper
   - Buat fungsi bantuan atau kelas yang membantu dalam menjalankan tugas-tugas tertentu, seperti pemformatan data, validasi input, atau akses ke fitur-fitur perangkat.

# Add API

# Konfigurasi Firebase

1. Membuat proyek baru di firebase console
2. Menambahkan file 'google-services.json' untuk android
3. Mengaktifkan layanan storage, auth dan firestore di firebase

# Konfigurasi Dependensi Flutter

1. Menambahkan dependensi firebase di file 'pubspec.yaml'
   dependencies:
   flutter:
   sdk: flutter
   firebase_core: ^1.10.5
   firebase_auth: ^4.4.3
   cloud_firestore: ^3.1.5
   firebase_storage: ^10.2.7

2. Jalankan 'flutter pub get' untuk menginstal dependensinya

# Menggunakan Firebase API dalam Flutter

1. Menginisialisasikan firebase di 'main.dart'
   import 'package:firebase_core/firebase_core.dart';

2. Authenkasi pengguna
   import 'package:firebase_auth/firebase_auth.dart';

   // Login dengan email dan password
   Future<User?> signInWithEmailPassword(String email, String password) async {
   try {
   UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
   email: email,
   password: password,
   );
   return userCredential.user;
   } catch (e) {
   print(e.toString());
   return null;
   }
   }

3. Menggunakan firestore untuk menyimpan data
   import 'package:cloud_firestore/cloud_firestore.dart';

   // Menyimpan data pengguna
   Future<void> saveUserData(String userId, String username, String fullName, String profilePicUrl) async {
   try {
   await FirebaseFirestore.instance.collection('users').doc(userId).set({
   'username': username,
   'fullName': fullName,
   'profilePicUrl': profilePicUrl,
   });
   } catch (e) {
   print(e.toString());
   }
   }

4. Menggunakan firestore untuk mengambil data
   // Mendapatkan data pengguna berdasarkan ID
   Future<DocumentSnapshot> getUserData(String userId) async {
   DocumentSnapshot snapshot = await FirebaseFirestore.instance.collection('users').doc(userId).get();
   return snapshot;
   }

5. Menggunakan firebase storage untuk upload file
   import 'package:firebase_storage/firebase_storage.dart';

   // Upload foto profil
   Future<String> uploadProfilePicture(String userId, String imagePath) async {
   try {
   Reference ref = FirebaseStorage.instance.ref().child('profile_images').child(userId + '.jpg');
   UploadTask uploadTask = ref.putFile(File(imagePath));
   TaskSnapshot taskSnapshot = await uploadTask;
   String downloadUrl = await taskSnapshot.ref.getDownloadURL();
   return downloadUrl;
   } catch (e) {
   print(e.toString());
   return '';
   }
   }

   > > > > > > > cece072 (api)
