import 'package:francy_zapata_7_2021_2_p1/models/data.dart';

class Memes {
  int total = 0;
  int count = 0;
  List<Data> data = [];

  Memes({required this.total, required this.count, required this.data});

  Memes.fromJson(Map<String, dynamic> json) {
    total = json['total'];
    count = json['count'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data.add(Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total'] = this.total;
    data['count'] = this.count;
    data['data'] = this.data.map((v) => v.toJson()).toList();
    return data;
  }
}
