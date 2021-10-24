import 'package:flutter/material.dart';

import 'package:francy_zapata_7_2021_2_p1/models/meme.dart';
import 'package:francy_zapata_7_2021_2_p1/components/loader_component.dart';

class memeDetailScreen extends StatefulWidget {
  final Meme meme;

  memeDetailScreen({required this.meme});

  @override
  _memeDetailScreenState createState() => _memeDetailScreenState();
}

class _memeDetailScreenState extends State<memeDetailScreen> {
  bool _showLoader = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.meme.submissionTitle),
      ),
      body: Stack(
        children: <Widget>[
          Column(
            children: <Widget>[_showMemeDetail()],
          ),
          _showLoader
              ? LoaderComponent(
                  text: 'Tenga paciencia ...',
                )
              : Container(),
        ],
      ),
    );
  }

  Widget _showMemeDetail() {
    return Container(
        margin: EdgeInsets.all(10),
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            Text('Imagen: ',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25)),
            Image(
              image: NetworkImage(widget.meme.submissionUrl),
              height: 350,
              width: 350,
            ),
            Text('Autor: ',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25)),
            Text(widget.meme.author, style: TextStyle(fontSize: 15)),
            Text('Id Meme: ',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25)),
            Text(widget.meme.submissionId, style: TextStyle(fontSize: 15)),
            Text('Fecha Creación: ',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25)),
            Text(widget.meme.created, style: TextStyle(fontSize: 15)),
            Text('Tiempo de consumo: ',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25)),
            Text(widget.meme.timestamp, style: TextStyle(fontSize: 15)),
            Text('Permalink: ',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25)),
            Text(widget.meme.permalink, style: TextStyle(fontSize: 15)),
          ],
        ));
  }
}
