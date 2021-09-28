import 'package:flutter/cupertino.dart';
import 'dart:convert';

import 'package:intl/intl.dart';

class UtilsService {
  Image imageFromBase64String(String base64String) {
    final startIndex = base64String.indexOf('base64');
    String base64 = base64String.substring(startIndex + 7);

    return Image.memory(base64Decode(base64));
  }

  String getDate(String datetime) {
    var parsedDate = DateTime.parse(datetime);
    var formatter = new DateFormat('dd/MM/yyyy');

    String formattedTime = DateFormat('kk:mm:a').format(parsedDate);
    String formattedDate = formatter.format(parsedDate);

    if (DateTime.now().difference(parsedDate).inDays == 0) {
      return formattedTime;
    } else {
      return formattedDate;
    }
  }
}
