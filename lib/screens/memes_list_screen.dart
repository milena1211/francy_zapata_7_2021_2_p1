import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:francy_zapata_7_2021_2_p1/components/loader_component.dart';
import 'package:francy_zapata_7_2021_2_p1/helpers/constans.dart';
import 'package:francy_zapata_7_2021_2_p1/models/meme.dart';

class MemesListScreen extends StatefulWidget {
  @override
  _MemesListScreenState createState() => _MemesListScreenState();
}

class _MemesListScreenState extends State<MemesListScreen> {
  List<Meme> _meme = [];
  bool _showLoader = false;
  String _search = '';
  bool _isFiltered = false;

  @override
  void initState() {
    super.initState();
    _getMemes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('AQUI ESTAN LOS MEMES'),
        actions: <Widget>[
          _isFiltered
              ? IconButton(
                  onPressed: _removeFilter, icon: Icon(Icons.filter_none))
              : IconButton(
                  onPressed: _showFilter,
                  icon: Icon(Icons.filter_alt),
                )
        ],
      ),
      body: Center(
        child: _showLoader
            ? LoaderComponent(text: '... TENGA PACIENCIA ...')
            : _getContent(),
      ),
    );
  }

  void _getMemes() async {
    setState(() {
      _showLoader = true;
    });

    var url = Uri.parse(Constans.apiUrl);

    var response = await http.get(url);

    setState(() {
      _showLoader = false;
    });

    var body = response.body;
    var decodedJson = jsonDecode(body);

    if (decodedJson != null) {
      for (var item in decodedJson['data']) {
        _meme.add(Meme.fromJson(item));
      }
    }

    print(_meme);
  }

  void _removeFilter() {}

  void _showFilter() {}

  _getContent() {}
}
