import 'package:chat_app/models/threads.dart';
import 'package:chat_app/services/utils_service.dart';
import 'package:flutter/material.dart';

class ThreadItemList extends StatelessWidget {
  final ThreadsModel threads;

  const ThreadItemList({Key key, @required this.threads}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final utilsService = UtilsService();

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListTile(
        onTap: () =>
            Navigator.pushNamed(context, '/threadsDetail', arguments: threads),
        trailing: Text(utilsService.getDate(threads.lastMessage.createdDate)),
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(50.0),
          child: utilsService.imageFromBase64String(threads.image),
        ),
        title: Text(threads.name),
      ),
    );
  }
}
