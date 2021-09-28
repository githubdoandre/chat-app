import 'dart:async';

import 'package:chat_app/blocs/threads_bloc.dart';
import 'package:chat_app/models/threads.dart';
import 'package:chat_app/repository/threads_repository.dart';
import 'package:chat_app/services/utils_service.dart';
import 'package:flutter/material.dart';

class ThreadsPage extends StatefulWidget {
  final ThreadsModel threads;

  ThreadsPage({this.threads});

  @override
  _ThreadsPageState createState() => _ThreadsPageState();
}

class _ThreadsPageState extends State<ThreadsPage> {
  final _utilsService = UtilsService();
  final _msgController = TextEditingController();
  final _scrollcontroller = ScrollController();

  @override
  Widget build(BuildContext context) {
   Timer(
      Duration(milliseconds: 100),
      () =>
          _scrollcontroller.jumpTo(_scrollcontroller.position.maxScrollExtent));

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey[900],
        title: Container(
          height: 40,
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(50.0),
                child:
                    _utilsService.imageFromBase64String(widget.threads.image),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 14.0),
                child: Text(widget.threads.name),
              )
            ],
          ),
        ),
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(
              bottom: 60.0,
            ),
            child: ListView.builder(
              controller: _scrollcontroller,
              itemCount: widget.threads.messages.length,
              itemBuilder: (BuildContext buildContext, int index) {
                return Container(
                  padding:
                      EdgeInsets.only(left: 14, right: 14, top: 10, bottom: 10),
                  child: Align(
                    alignment: (widget.threads.messages[index].to == 'me'
                        ? Alignment.topRight
                        : Alignment.topLeft),
                    child: Column(
                      crossAxisAlignment:
                          widget.threads.messages[index].to == 'me'
                              ? CrossAxisAlignment.end
                              : CrossAxisAlignment.start,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(
                                    widget.threads.messages[index].to == 'me'
                                        ? 15
                                        : 0),
                                topRight: Radius.circular(
                                    widget.threads.messages[index].to == 'me'
                                        ? 0
                                        : 15),
                                bottomLeft: Radius.circular(15),
                                bottomRight: Radius.circular(15)),
                            color: ((widget.threads.messages[index].to == 'me')
                                ? Colors.blue[800]
                                : Colors.grey[200]),
                          ),
                          padding: EdgeInsets.all(16),
                          child: Text(
                            widget.threads.messages[index].content,
                            style: TextStyle(
                              fontSize: 15,
                              color: (widget.threads.messages[index].to == 'me')
                                  ? Colors.white
                                  : Colors.black,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Text(
                            _utilsService.getDate(
                                widget.threads.messages[index].createdDate),
                            style: TextStyle(color: Colors.grey),
                          ),
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: Container(
              padding: EdgeInsets.only(left: 10, bottom: 10, top: 10),
              height: 60,
              width: double.infinity,
              color: Colors.white,
              child: Row(
                children: <Widget>[
                  SizedBox(
                    width: 12,
                  ),
                  Expanded(
                    child: TextField(
                      controller: _msgController,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.only(
                          bottom: 5.0,
                          left: 5.0,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.grey,
                            width: 0.0,
                          ),
                        ),
                        hintText: "Digite sua mensagem",
                        hintStyle: TextStyle(color: Colors.black54),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.grey,
                            width: 0.0,
                          ),
                        ),
                      ),
                    ),
                  ),
                  FloatingActionButton(
                    onPressed: () {
                      addMessage();
                    },
                    elevation: 0,
                    child: Image.asset("assets/images/SendButton.png"),
                  ),
                  SizedBox(
                    width: 12,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void addMessage() {
    Message newMsg = Message(
        content: _msgController.text,
        createdDate: DateTime.now().toString(),
        from: 'me',
        to: widget.threads.identity,
        status: 'Received');
    widget.threads.messages.add(newMsg);
    _msgController.clear();
    setState(() {});
    Timer(
      Duration(milliseconds: 500),
      () =>
          _scrollcontroller.jumpTo(_scrollcontroller.position.maxScrollExtent),
    );
  }
}
