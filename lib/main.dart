import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

void main() {
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
      home: LoginScreen(),
      routes: {
        '/login': (context) => LoginScreen(),
        '/register': (context) => RegisterScreen(),
      },
    );
  }
}

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String _username = '';
  String _password = '';

  void _handleLogin() {
    if (_username.isEmpty || _password.isEmpty) {
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
    else {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => AnaSayfa(),
        ),
      );
    }
    // Giriş işlemlerini burada yapabilirsiniz
  }

  void _handleSignUp() {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => RegisterScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
                        _username = value;
                      });
                    },
                    decoration: InputDecoration(
                      hintText: 'Kullanıcı Adı',
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
                  onPressed: _handleLogin,
                  style: ElevatedButton.styleFrom(
                    primary: Color(0xFF222F5A),
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
                  onPressed: _handleSignUp,
                  style: ElevatedButton.styleFrom(
                    primary: Color(0xFFBE1522),
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

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  String _name = '';
  String _username = '';
  String _password = '';
  // Giriş işlemlerini burada yapabilirsiniz

  void _handleSignUp() {
    if (_username.isEmpty || _password.isEmpty || _name.isEmpty) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Hata'),
            content: Text('Lütfen tüm bilgilerinizi girin.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(); // Dialogu kapat
                },
                child: Text('Tamam'),
              ),
            ],
          );
        },
      );
    } else {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => LoginScreen(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: null,
      // Header'ı gizlemek için bu kısmı kaldırabilirsiniz
      body: Center(
        child: Container(
          constraints: BoxConstraints(
            maxHeight: 850.0,
            maxWidth: 850.0,
          ), // Constraints için ekstra noktalı virgülü kaldırın
          child: Stack(
            children: [
              Align(
                alignment: Alignment(0, -0.5),
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
                alignment: Alignment(0, -0.25),
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
                alignment: Alignment(0, 0),
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
                alignment: Alignment(0, 0.4),
                child: ElevatedButton(
                  onPressed: _handleSignUp,
                  style: ElevatedButton.styleFrom(
                    primary: Color(0xFFBE1522),
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
    );
  }
}
class AnaSayfa extends StatefulWidget {
  @override
  _AnaSayfaState createState() => _AnaSayfaState();
}

class _AnaSayfaState extends State<AnaSayfa> {

  // Giriş işlemlerini burada yapabilirsiniz
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: null,
      // Header'ı gizlemek için bu kısmı kaldırabilirsiniz
      body: Center(
        child: Container(
          constraints: BoxConstraints(
            maxHeight: 850.0,
            maxWidth: 850.0,
          ), // Constraints için ekstra noktalı virgülü kaldırın
          child: Stack(
            children: [

            ],
          ),
        ),
      ),
    );
  }
}