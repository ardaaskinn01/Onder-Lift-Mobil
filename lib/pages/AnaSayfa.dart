import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

var currentUser = FirebaseAuth.instance.currentUser;

class AnaSayfa extends StatefulWidget {
  @override
  _AnaSayfaState createState() => _AnaSayfaState();
}

class CustomPopup extends StatefulWidget {
  @override
  _CustomPopupState createState() => _CustomPopupState();
}

class _CustomPopupState extends State<CustomPopup> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  late String _username = ''; // Kullanıcı adını saklamak için değişken
  String? _selectedMachineType;
  TextEditingController _machineIdController = TextEditingController();
  TextEditingController _machineNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        'Makine Ekle',
        style: TextStyle(
          fontSize: 20, // Yazı boyutu
          color: Color(0xFF222F5A), // Yazı rengi
        ),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Makine Adı:'),
          TextFormField(
            controller: _machineNameController,
            decoration: InputDecoration(
              hintText: 'Makine Adı girin',
            ),
          ),
          Text('Makine Türü:'),
          DropdownButton<String>(
            value: _selectedMachineType,
            items: ['ESP', 'CSP'].map((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
            onChanged: (String? value) {
              setState(() {
                _selectedMachineType = value;
              });
            },
            isExpanded: true,
            hint: Text('Seçiniz'),
          ),
          SizedBox(height: 10), // Boşluk ekleyin
          Text('Makine ID:'),
          TextFormField(
            controller: _machineIdController,
            decoration: InputDecoration(
              hintText: 'Makine ID girin',
            ),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () async {
            try {
              if (currentUser != null) {
                _username = currentUser!.displayName!;
                // Firestore'da kullanıcı adı olarak kullanılacak işlemler
              } else {
                // Kullanıcı oturum açmamış, bir hata durumu veya giriş yapılmamış
              }
              // Firestore'a makine ekleme işlemi
              await _firestore
                  .collection('Users') // Üst koleksiyon
                  .doc(_username) // Belirli bir kullanıcının belgesi
                  .collection('Makineler') // Makineler koleksiyonu
                  .doc(_machineNameController
                      .text) // Makine adını belge adı olarak kullan
                  .set({
                'id': _machineIdController.text,
                'tur': _selectedMachineType,
              });
              // Pop-up'ı kapat
              Navigator.of(context).pop();
            } catch (e) {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: Text('Hata Oluştu'),
                  content: Text('Bir hata oluştu: $e'),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: Text('Tamam'),
                    ),
                  ],
                ),
              );
            }
          },
          child: Text(
            'Ekle',
            style: TextStyle(
              fontSize: 18, // Yazı boyutu
              color: Color(0xFF222F5A), // Yazı rengi
            ),
          ),
        ),
      ],
    );
  }
}

class _AnaSayfaState extends State<AnaSayfa> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  late String _username = ''; // Kullanıcı adını saklamak için değişken

  void initState() {
    super.initState();
    // Kullanıcı adını almak için fonksiyonu çağırın
    _getUsername();
  }

  Future<void> _getUsername() async {
    // Oturum açmış kullanıcıyı kontrol edin
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      // Kullanıcı adını alın
      setState(() {
        _username = user.displayName ?? '';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // Geri tuşuna basıldığında yapılacak işlemler
        return false; // Geri dönüşün engellenmesi için false döndürün
      },
      child: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: Text(''),
          leading: IconButton(
            icon: Icon(Icons.menu),
            onPressed: () {
              _scaffoldKey.currentState!.openDrawer();
            },
          ),
        ),
        body: Center(
          child: Container(
            constraints: BoxConstraints(
              maxHeight: 850.0,
              maxWidth: 850.0,
            ),
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.center,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      StreamBuilder(
                        stream: FirebaseFirestore.instance
                            .collection('Users')
                            .doc(_username) // Kullanıcının oturum açmış olduğu kullanıcı adı
                            .collection('Makineler')
                            .snapshots(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState == ConnectionState.waiting) {
                            return CircularProgressIndicator(); // Veriler yüklenirken gösterilecek işaretçi
                          }
                          if (!snapshot.hasData) {
                            return Text('Veri bulunamadı'); // Veri yoksa gösterilecek metin
                          }
                          var machines = snapshot.data?.docs;
                          return DataTable(
                            columns: [
                              DataColumn(label: Text('ID')),
                              DataColumn(label: Text('Name')),
                              DataColumn(label: Text('Type')),
                              DataColumn(label: Text('Inspect')),
                              DataColumn(label: Text('Delete')),
                            ],
                            rows: machines!.map((machine) {
                              return DataRow(cells: [
                                DataCell(
                                  Text(
                                    machine['id'],
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                DataCell(
                                  Text(
                                    machine['name'],
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                DataCell(
                                  Text(
                                    machine['type'],
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                DataCell(
                                  IconButton(
                                    icon: Icon(Icons.visibility),
                                    onPressed: () {
                                      // İnceleme işlemi
                                    },
                                  ),
                                ),
                                DataCell(
                                  IconButton(
                                    icon: Icon(Icons.delete),
                                    onPressed: () {
                                      // Silme işlemi
                                    },
                                  ),
                                ),
                              ]);
                            }).toList(),
                          );
                        },
                      ),
                    ],
                  ),
                ),
                Align(
                  alignment: Alignment.center,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      IconButton(
                        icon: Icon(Icons.add),
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return CustomPopup(); // Özelleştirilmiş pop-up gösterilsin
                            },
                          );
                        },
                      ),
                      SizedBox(height: 10), // Buton ile metin arasında boşluk
                      Text(
                        'Makine Ekle',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        drawer: Drawer(
          child: ListView(
            children: [
              DrawerHeader(
                child: Row(
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.3,
                      height: MediaQuery.of(context).size.height * 0.2,
                      child: Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('assets/images/logo.png'),
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 10), // İki Row arasında 10 birimlik boşluk
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        _username.isNotEmpty
                            ? 'Merhaba, $_username'
                            : 'Merhaba, Kullanıcı',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20), // List Tile'lar arasında 20 birimlik boşluk
              ListTile(
                contentPadding: EdgeInsets.symmetric(
                    horizontal: 20), // İçerik kenar boşlukları
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Profil',
                      style: TextStyle(
                        color: Color(0xFF222F5A), // Yazı rengi mavi
                        fontSize: 18, // Yazı boyutu 16
                        fontFamily: 'Roboto', // Yazı fontu Roboto
                        fontWeight: FontWeight.w400, // Yazı kalınlığı normal
                      ),
                    ),
                    Icon(Icons.arrow_forward_ios,
                        color: Color(0xFFBE1522),
                        size: 18), // Sağa yaslanmış ok
                  ],
                ),
                onTap: () {
                  Navigator.pushNamed(context, "/profil");
                },
              ),
              ListTile(
                contentPadding: EdgeInsets.symmetric(
                    horizontal: 20), // İçerik kenar boşlukları
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Bakım Geçmişi',
                      style: TextStyle(
                        color: Color(0xFF222F5A), // Yazı rengi mavi
                        fontSize: 18, // Yazı boyutu 16
                        fontFamily: 'Roboto', // Yazı fontu Roboto
                        fontWeight: FontWeight.w400, // Yazı kalınlığı kalın
                      ),
                    ),
                    Icon(Icons.arrow_forward_ios,
                        color: Color(0xFFBE1522),
                        size: 18), // Sağa yaslanmış ok
                  ],
                ),
                onTap: () {
                  Navigator.pushNamed(context, "/bakim");
                },
              ),
              ListTile(
                contentPadding: EdgeInsets.symmetric(
                    horizontal: 20), // İçerik kenar boşlukları
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Hata Kayıtları',
                      style: TextStyle(
                        color: Color(0xFF222F5A), // Yazı rengi mavi
                        fontSize: 18, // Yazı boyutu 16
                        fontFamily: 'Roboto', // Yazı fontu Roboto
                        fontWeight: FontWeight.w400, // Yazı kalınlığı kalın
                      ),
                    ),
                    Icon(Icons.arrow_forward_ios,
                        color: Color(0xFFBE1522),
                        size: 18), // Sağa yaslanmış ok
                  ],
                ),
                onTap: () {
                  Navigator.pushNamed(context, "/hata");
                },
              ),
              ListTile(
                contentPadding: EdgeInsets.symmetric(
                    horizontal: 20), // İçerik kenar boşlukları
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Belgeler',
                      style: TextStyle(
                        color: Color(0xFF222F5A), // Yazı rengi mavi
                        fontSize: 18, // Yazı boyutu 16
                        fontFamily: 'Roboto', // Yazı fontu Roboto
                        fontWeight: FontWeight.w400, // Yazı kalınlığı kalın
                      ),
                    ),
                    Icon(Icons.arrow_forward_ios,
                        color: Color(0xFFBE1522),
                        size: 18), // Sağa yaslanmış ok
                  ],
                ),
                onTap: () {
                  Navigator.pushNamed(context, "/belge");
                },
              ),
              ListTile(
                contentPadding: EdgeInsets.symmetric(
                    horizontal: 20), // İçerik kenar boşlukları
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Ayarlar',
                      style: TextStyle(
                        color: Color(0xFF222F5A), // Yazı rengi mavi
                        fontSize: 18, // Yazı boyutu 16
                        fontFamily: 'Roboto', // Yazı fontu Roboto
                        fontWeight: FontWeight.w400, // Yazı kalınlığı kalın
                      ),
                    ),
                    Icon(Icons.arrow_forward_ios,
                        color: Color(0xFFBE1522),
                        size: 18), // Sağa yaslanmış ok
                  ],
                ),
                onTap: () {
                  Navigator.pushNamed(context, "/ayar");
                },
              ),
              ListTile(
                contentPadding: EdgeInsets.symmetric(
                    horizontal: 20), // İçerik kenar boşlukları
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Çıkış Yap',
                      style: TextStyle(
                        color: Color(0xFFBE1522), // Yazı rengi mavi
                        fontSize: 18, // Yazı boyutu 16
                        fontFamily: 'Roboto', // Yazı fontu Roboto
                        fontWeight: FontWeight.w400, // Yazı kalınlığı kalın
                      ),
                    ), // Sağa yaslanmış ok
                  ],
                ),
                onTap: () {
                  Navigator.pushNamed(context, "/login");
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
