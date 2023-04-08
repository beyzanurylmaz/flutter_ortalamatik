import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:myapp/screens/models/lesson.dart';

class OrtalaMatik extends StatefulWidget {
  const OrtalaMatik({super.key});

  @override
  State<OrtalaMatik> createState() => _OrtalaMatikState();
}

List<String> items = ['1 Kredi', '2 Kredi', '3 Kredi', '4 Kredi'];

class _OrtalaMatikState extends State<OrtalaMatik> {
  List<Lesson> lessons = [];
  String dersAdi = "";
  final lessonsController = TextEditingController();
  final notController = TextEditingController();

  String dropdownvalue = items.first;
  int _credit = 0;
  double ortalama = 0;

  void addLesson() {
    setState(
      () {
        lessons.add(Lesson(
            id: lessons.isNotEmpty ? lessons.last.id + 1 : 1,
            title: lessonsController.text,
            credit: _credit,
            not: int.parse(notController.text)));
      },
    );
  }

  void creditDeger() {
    setState(() {
      if (dropdownvalue == items[0]) {
        _credit = 1;
      }
      if (dropdownvalue == items[1]) {
        _credit = 2;
      }
      if (dropdownvalue == items[2]) {
        _credit = 3;
      }
      if (dropdownvalue == items[3]) {
        _credit = 4;
      }
    });
  }

  void ortalamaHesapla() {
    setState(() {
      int dersOrtalamasi = 0;
      int ortalamalar = 0;
      int toplamKredi = 0;
      if (lessons.isNotEmpty) {
        for (var item in lessons) {
          dersOrtalamasi = item.not * item.credit;
          ortalamalar = ortalamalar + dersOrtalamasi;
          toplamKredi = toplamKredi + item.credit;
        }
        ortalama = ortalamalar / toplamKredi;
      } else {
        ortalama = 0;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("OrtalaMatik"),
      ),
      floatingActionButton: FloatingActionButton(
        foregroundColor: Colors.black,
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
        onPressed: () {
          setState(() {
            creditDeger();
            addLesson();
            ortalamaHesapla();
            lessonsController.clear();
            notController.clear();
          });
        },
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              controller: lessonsController,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                labelText: "Ders Adı",
                contentPadding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Bu alan boş bırakılamaz';
                }
                return null;
              },
            ),
          ),
          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: DropdownButtonFormField<String>(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                          borderSide:
                              const BorderSide(width: 3, color: Colors.amber),
                        ),
                      ),
                      value: dropdownvalue,
                      icon: const Icon(Icons.keyboard_arrow_down),
                      items: items.map((String items) {
                        return DropdownMenuItem(
                          value: items,
                          child: Text(items),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          dropdownvalue = newValue!;
                        });
                      },
                    ),
                  ),
                ),
                Expanded(
                  child: TextFormField(
                    controller: notController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: "Ders Notu",
                      contentPadding: const EdgeInsets.fromLTRB(20, 23, 20, 23),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(width: 2, color: Colors.amber),
              ),
            ),
            height: 1,
            width: double.infinity,
          ),
          Container(
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: RichText(
                text: TextSpan(
                  text: "Ortalama :",
                  style: const TextStyle(
                    fontSize: 34,
                    color: Colors.black,
                  ),
                  children: <TextSpan>[
                    TextSpan(
                      text: " $ortalama",
                      style: const TextStyle(fontSize: 34, color: Colors.red),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Container(
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(width: 2, color: Colors.amber),
              ),
            ),
            height: 1,
            width: double.infinity,
          ),
          Expanded(
            flex: 3,
            child: Container(
              padding: const EdgeInsets.all(10),
              alignment: Alignment.topCenter,
              child: ListView.separated(
                separatorBuilder: (context, index) => const Divider(
                  height: 5,
                  color: Colors.transparent,
                ),
                itemCount: lessons.length,
                itemBuilder: (BuildContext context, int index) {
                  Lesson item = lessons[index];
                  return Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.orange,
                        width: 1.0,
                      ),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: ListTile(
                      tileColor: Colors.orange[100],
                      title: InkWell(
                        onLongPress: () {
                          setState(() {
                            lessons.remove(item);
                            ortalamaHesapla();
                          });
                        },
                        child: Container(
                          padding: const EdgeInsets.only(bottom: 3),
                          margin: const EdgeInsets.only(bottom: 10),
                          child: Text(
                            item.title,
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.black,
                            ),
                          ),
                          decoration: const BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                color: Colors.grey,
                                width: 1.0,
                              ),
                            ),
                          ),
                        ),
                      ),
                      subtitle: InkWell(
                        child: RichText(
                          text: TextSpan(
                            text: "Kredi :",
                            style: const TextStyle(
                              fontSize: 17,
                              color: Colors.grey,
                            ),
                            children: <TextSpan>[
                              TextSpan(
                                text: " ${item.credit}",
                                style: const TextStyle(
                                    fontSize: 18, color: Colors.red),
                              ),
                              const TextSpan(
                                text: " Notu :",
                                style:
                                    TextStyle(fontSize: 17, color: Colors.grey),
                              ),
                              TextSpan(
                                text: " ${item.not}",
                                style:
                                    TextStyle(fontSize: 17, color: Colors.red),
                              ),
                            ],
                          ),
                        ),
                        onLongPress: () {
                          setState(() {
                            lessons.remove(item);
                            ortalamaHesapla();
                          });
                        },
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          Container(
            color: Colors.grey[180],
            child: Align(
              alignment: Alignment.bottomLeft,
              child: Container(
                margin:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: RichText(
                  text: const TextSpan(
                    style: TextStyle(fontSize: 18, color: Colors.grey),
                    children: <TextSpan>[
                      TextSpan(
                        text: "Not:",
                        style: TextStyle(
                            color: Colors.red, fontWeight: FontWeight.bold),
                      ),
                      TextSpan(text: " Dersi Silmek İçin Sağa Kaydır!:")
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
