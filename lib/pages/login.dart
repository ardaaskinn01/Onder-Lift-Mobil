import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:onderliftmobil/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String _mail = '';
  String _password = '';
  final firebaseAuth = FirebaseAuth.instance;

  void _handleLogin(BuildContext context) async {
    if (_mail.isEmpty || _password.isEmpty) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Hata'),
            content: Text('Lütfen kullanıcı adı ve şifre girin.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('Tamam'),
              ),
            ],
          );
        },
      );
      return;
    }

    try {
      // Kullanıcıyı Firebase Authentication ile doğrula
      final UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _mail,
        password: _password,
      );

      // Kullanıcı başarıyla giriş yaptığında, ana ekran sayfasına yönlendir
      Navigator.pushNamed(context, "/main");
    } catch (e) {
      // Doğrulama işlemi başarısız olduğunda kullanıcıya hata göster
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Hata'),
            content: Text('Giriş yapılırken bir hata oluştu: $e'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('Tamam'),
              ),
            ],
          );
        },
      );
    }
  }

  void _handleSignUp(BuildContext context) {
    Navigator.pushNamed(context, "/register");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: null,
      backgroundColor: Colors.white,
      body: Center(
        child: Container(
          constraints: BoxConstraints(
            maxHeight: 850.0,
            maxWidth: 850.0,
          ),
          child: Stack(
            children: [
              Align(
                alignment: Alignment(0, -0.9),
                child: FractionallySizedBox(
                  widthFactor: 0.4,
                  heightFactor: 0.3,
                  child: Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/images/logo.png'),
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment(0, -0.3),
                child: FractionallySizedBox(
                  heightFactor: 0.075,
                  widthFactor: 0.8,
                  child: TextField(
                    onChanged: (value) {
                      setState(() {
                        _mail = value;
                      });
                    },
                    decoration: InputDecoration(
                      hintText: 'E-Mail',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide(
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment(0, -0.1),
                child: FractionallySizedBox(
                  heightFactor: 0.075,
                  widthFactor: 0.8,
                  child: TextField(
                    onChanged: (value) {
                      setState(() {
                        _password = value;
                      });
                    },
                    obscureText: true,
                    decoration: InputDecoration(
                      hintText: 'Şifre',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide(
                          color: Colors.black,
                          width: 0.2,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment(0, 0.2),
                child: ElevatedButton(
                  onPressed: () {
                    _handleLogin(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF222F5A),
                    padding: EdgeInsets.symmetric(
                      vertical: MediaQuery.of(context).size.height * 0.02,
                      horizontal: MediaQuery.of(context).size.width * 0.2,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  child: Text(
                    'Giriş Yap',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.normal,
                      fontSize: 15,
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment(0, 0.4),
                child: ElevatedButton(
                  onPressed: () {
                    _handleSignUp(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFFBE1522),
                    padding: EdgeInsets.symmetric(
                      vertical: MediaQuery.of(context).size.height * 0.02,
                      horizontal: MediaQuery.of(context).size.width * 0.21,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  child: Text(
                    'Kayıt Ol',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.normal,
                      fontSize: 15,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}