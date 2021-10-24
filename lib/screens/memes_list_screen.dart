import 'dart:convert';

import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:francy_zapata_7_2021_2_p1/components/loader_component.dart';
import 'package:francy_zapata_7_2021_2_p1/helpers/constans.dart';
import 'package:francy_zapata_7_2021_2_p1/models/meme.dart';
import 'package:francy_zapata_7_2021_2_p1/screens/meme_detail_screen.dart';
import 'package:http/http.dart' as http;

class memesListScreen extends StatefulWidget {
  const memesListScreen({Key? key}) : super(key: key);

  @override
  _memesListScreenState createState() => _memesListScreenState();
}

class _memesListScreenState extends State<memesListScreen> {
  List<Meme> list = [];
  List<Meme> filter = [];
  bool searched = false;
  bool loader = false;
  @override
  void initState() {
    super.initState();
    getdata();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: loader
          ? loaderComponent(
              text: 'Por favor espere, ... Nosotros también estamos buscando!',
            )
          : _content(),
    );
  }

  Widget _content() {
    return Scaffold(
      appBar: AppBar(
        title: !searched
            ? Text('Ahi le dejo')
            : TextField(
                onChanged: (value) {
                  filterName(value);
                },
                decoration: const InputDecoration(
                    icon: Icon(
                      Icons.search,
                      color: Colors.white,
                    ),
                    hintText: "Diga que busca",
                    hintStyle: TextStyle(color: Colors.white)),
              ),
        actions: [
          searched
              ? IconButton(
                  icon: const Icon(Icons.cancel),
                  onPressed: () {
                    setState(() {
                      searched = false;
                      filter = list;
                    });
                  },
                )
              : IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: () {
                    setState(() {
                      searched = true;
                    });
                  },
                )
        ],
        backgroundColor: const Color(0xFF12B0E8),
      ),
      body: _author(),
    );
  }

  Widget _author() {
    return ListView(
      children: filter.map((e) {
        return Card(
          child: Flexible(
            child: InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => memeDetailScreen(
                              meme: e,
                            )));
              },
              child: Container(
                margin: EdgeInsets.all(10),
                padding: EdgeInsets.all(5),
                decoration: new BoxDecoration(
                  color: Colors.purpleAccent.shade200,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(40),
                      child: Image.network(
                        e.submissionUrl.contains('http')
                            ? e.submissionUrl
                            : 'https://i.pinimg.com/474x/47/d3/f8/47d3f80be9afc6aa8a4bbb64015c24f7.jpg',
                        fit: BoxFit.cover,
                        height: 80,
                        width: 80,
                      ),
                    ),
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.symmetric(horizontal: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Column(
                              children: [
                                Container(
                                    constraints: BoxConstraints(maxWidth: 100),
                                    child: Text(
                                      (e.submissionTitle == null)
                                          ? " "
                                          : e.submissionTitle,
                                      style: TextStyle(
                                          fontWeight: FontWeight.w400,
                                          color: Colors.black87,
                                          fontSize: 17.0),
                                    )),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    Icon(Icons.settings_power),
                  ],
                ),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  void filterName(value) {
    setState(() {
      filter = list
          .where((element) => element.submissionTitle
              .toLowerCase()
              .contains(value.toString().toLowerCase()))
          .toList();
    });
  }

  void getdata() async {
    setState(() {
      loader = true;
    });
    var connecResult = await Connectivity().checkConnectivity();
    if (connecResult == ConnectivityResult.none) {
      setState(() {
        loader = false;
      });
      await showAlertDialog(
          context: context,
          title: 'ERROR!',
          message: 'Verifica tu conexion a internet!',
          actions: <AlertDialogAction>[
            const AlertDialogAction(key: null, label: 'Aceptar')
          ]);
      return;
    }
    var url = Uri.parse(Constans.apiUrl);
    var response = await http.get(
      url,
      headers: {
        'content-type': 'application/json',
        'accept': 'application/json'
      },
    );
    var body = response.body;
    var decodedJson = jsonDecode(body);

    if (decodedJson != null) {
      for (var item in decodedJson['data']) {
        list.add(Meme.fromJson(item));
      }
      filter = list;
    }
    setState(() {
      loader = false;
    });
  }
}
