import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:onderliftmobil/firebase_options.dart';

var currentUser = FirebaseAuth.instance.currentUser;

class MakinelerScreen extends StatefulWidget {
  @override
  _MakinelerScreenState createState() => _MakinelerScreenState();
}

class _MakinelerScreenState extends State<MakinelerScreen> {
  late String _username = ''; // Kullanıcı adını saklamak için değişken

  @override
  void initState() {
    super.initState();
    _getUsername(); // Widget oluşturulduğunda kullanıcı adını al
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
    return Scaffold(
      appBar: null,
      body: Center(
        child: Stack(
          children: [
            Align(
              alignment: Alignment.center,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection('Users')
                          .doc(_username)
                          .collection('Makineler')
                          .orderBy("createdAt", descending: true)
                          .snapshots(),
                      builder: (context, snapshot) {
                        // StreamBuilder'ın içinde _username kullanarak işlem yapın
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return CircularProgressIndicator();
                        }
                        if (!snapshot.hasData) {
                          return Text('Veri bulunamadı');
                        }
                        var machines = snapshot.data?.docs;
                        return DataTable(
                          columnSpacing: 30,
                          columns: [
                            DataColumn(label: Text('   ID')),
                            DataColumn(label: Text('İsim')),
                            DataColumn(label: Text('Tür')),
                            DataColumn(label: Text(' İncele')),
                            DataColumn(label: Text('    Sil')),
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
                                  icon: Icon(Icons.visibility,
                                      color: Color(0xFF222F5A)),
                                  onPressed: () {
                                    // İnceleme işlemi
                                  },
                                ),
                              ),
                              DataCell(
                                IconButton(
                                  icon: Icon(Icons.delete,
                                      color: Color(0xFFBE1522)),
                                  onPressed: () {
                                    // Firestore'dan belgeyi silme
                                    var machineIdToDelete = machine[
                                    'id']; // Silinecek makinenin ID'si
                                    FirebaseFirestore.instance
                                        .collection('Users')
                                        .doc(_username)
                                        .collection('Makineler')
                                        .where('id',
                                        isEqualTo: machineIdToDelete)
                                        .get()
                                        .then((querySnapshot) {
                                      querySnapshot.docs.forEach((doc) {
                                        doc.reference.delete();
                                        print('Belge başarıyla silindi.');
                                      });
                                    }).catchError((error) {
                                      print('Hata oluştu: $error');
                                    });
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
            ),
          ],
        ),
      ),
    );
  }
}
