import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:onderliftmobil/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  String _name = '';
  String _mail = '';
  String _username = '';
  String _password = '';
  final firebaseAuth = FirebaseAuth.instance;

  Future<void> _handleLogin(BuildContext context) async {
    if (_mail.isEmpty || _password.isEmpty || _name.isEmpty || _username.isEmpty) {
      // Tüm alanların doldurulduğunu kontrol edin
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Hata'),
            content: Text('Lütfen tüm alanları doldurun.'),
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
      // Kullanıcıyı Firebase'e kaydet
      final UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _mail,
        password: _password,
      );
      await userCredential.user!.updateDisplayName(_username);
      Navigator.pushNamed(context, "/login");
    } catch (e) {
      // Kayıt işlemi başarısız olduğunda hatayı göster
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Hata'),
            content: Text('Kullanıcı kaydedilirken bir hata oluştu: $e'),
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

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      // Geri tuşuna basıldığında
      onWillPop: () async {
        // Login ekranına geri dön
        Navigator.pushNamed(context, "/login");
        // Geri tuşunun varsayılan işlevini devre dışı bırak
        return false;
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: null,
        body: Center(
          child: Container(
            constraints: BoxConstraints(
              maxHeight: 850.0,
              maxWidth: 850.0,
            ),
            child: Stack(
              children: [
                Align(
                  alignment: Alignment(0, -0.6),
                  child: FractionallySizedBox(
                    widthFactor: 0.8,
                    heightFactor: 0.075,
                    child: TextField(
                      onChanged: (value) {
                        setState(() {
                          _name = value;
                        });
                      },
                      decoration: InputDecoration(
                        hintText: 'İsim',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(
                            color: Colors.black,
                            width: 3,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment(0, -0.35),
                  child: FractionallySizedBox(
                    widthFactor: 0.8,
                    heightFactor: 0.075,
                    child: TextField(
                      onChanged: (value) {
                        setState(() {
                          _username = value;
                        });
                      },
                      decoration: InputDecoration(
                        hintText: 'Kullanıcı Adı',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(
                            color: Colors.black,
                            width: 3,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment(0, -0.1),
                  child: FractionallySizedBox(
                    widthFactor: 0.8,
                    heightFactor: 0.075,
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
                            width: 3,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment(0, 0.15),
                  child: FractionallySizedBox(
                    widthFactor: 0.8,
                    heightFactor: 0.075,
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
                            width: 3,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment(0, 0.45),
                  child: ElevatedButton(
                    onPressed: () {
                      _handleLogin(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFFBE1522),
                      padding: EdgeInsets.symmetric(
                        vertical: MediaQuery.of(context).size.height * 0.02,
                        horizontal: MediaQuery.of(context).size.width * 0.09,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    child: Text(
                      'Kaydı Tamamla',
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
      ),
    );
  }
}