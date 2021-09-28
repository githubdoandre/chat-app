import 'dart:convert';

import 'package:chat_app/models/threads.dart';
import 'package:flutter/services.dart' show rootBundle;

class ThreadsRepository {
  Future<List<ThreadsModel>> getList(String filter) async {
    String data = await rootBundle.loadString('assets/json/threads.json');
    var jsonResult = json.decode(data);

    List<dynamic> list =
        jsonResult.map((doc) => ThreadsModel.fromJson(doc)).toList();

    if (filter.isNotEmpty) {
      list = list.where((element) {
        return element.name.toLowerCase().contains(filter.toLowerCase());
      }).toList();
    }

    list = list.cast<ThreadsModel>();
    return list;
  }
}
