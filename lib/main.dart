import 'package:flutter/material.dart';
import 'package:onderliftmobil/firebase_options.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:onderliftmobil/pages/login.dart';
import 'package:onderliftmobil/pages/signup.dart';
import 'package:onderliftmobil/pages/AnaSayfa.dart';
import 'package:onderliftmobil/pages/bakim.dart';
import 'package:onderliftmobil/pages/hata.dart';
import 'package:onderliftmobil/pages/belge.dart';
import 'package:onderliftmobil/pages/profil.dart';
import 'package:onderliftmobil/pages/ayarlar.dart';
import 'package:onderliftmobil/pages/makineler.dart';
import 'package:onderliftmobil/pages/incele.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        // Arka plan ve metin renklerini buradan değiştirebilirsiniz
        backgroundColor: Colors.white,
        cardColor: Colors.black,
      ),
      home: Scaffold(
        body: LoginScreen(),
      ),
      routes: {
        '/login': (context) => LoginScreen(),
        '/register': (context) => RegisterScreen(),
        '/main': (context) => AnaSayfa(),
        '/bakim': (context) => BakimScreen(),
        '/hata': (context) => HataScreen(),
        '/belge': (context) => BelgeScreen(),
        '/profil': (context) => ProfilScreen(),
        '/ayar': (context) => AyarlarScreen(),
        '/makineler': (context) => MakinelerScreen(),
        '/incele': (context) => InceleScreen(),
      },
    );
  }
}
