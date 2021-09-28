import 'package:chat_app/blocs/threads_bloc.dart';
import 'package:chat_app/models/threads.dart';
import 'package:chat_app/repository/threads_repository.dart';
import 'package:chat_app/screens/home/components/threads_item_list.dart';
import 'package:chat_app/services/utils_service.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:intl/intl.dart';

class HomePage extends StatefulWidget {
  HomePage();

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ThreadsBloc _bloc = ThreadsBloc(ThreadsRepository());
  final _searchController = TextEditingController();

  @override
  void initState() {
    _bloc.getList('');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(MediaQuery.of(context).size.width, 40),
        child: StreamBuilder<AppBarState>(
          initialData: AppBarState.IDLE,
          stream: _bloc.appBarStream,
          builder: (context, snapshot) {
            switch (snapshot.data) {
              case AppBarState.SEARCH:
                return AppBar(
                  centerTitle: true,
                  backgroundColor: Colors.blueGrey[900],
                  leading: IconButton(
                      icon: Icon(Icons.arrow_back),
                      onPressed: () {
                        _searchController.clear();
                        _bloc.getList('');
                        _bloc.toggleAppBar(AppBarState.IDLE);
                      }),
                  title: TextField(
                    style: TextStyle(color: Colors.white),
                    onChanged: (value) => setState(() {
                      _bloc.getList(_searchController.text);
                    }),
                    controller: _searchController,
                    autofocus: true,
                    decoration: InputDecoration(
                      hintStyle: TextStyle(color: Colors.white),
                      hintText: 'Procurar..',
                    ),
                  ),
                  actions: [
                    Visibility(
                      visible: _searchController.text.length > 0,
                      child: IconButton(
                        icon: Icon(Icons.close),
                        onPressed: () {
                          _searchController.clear();
                          _bloc.getList(_searchController.text);
                          setState(() {});
                        },
                      ),
                    )
                  ],
                );
              case AppBarState.IDLE:
              default:
                return AppBar(
                  key: Key('appbar-idle'),
                  centerTitle: true,
                  backgroundColor: Colors.blueGrey[900],
                  title: Container(
                    width: 100,
                    child: Image.asset('assets/images/Logo.png'),
                  ),
                  actions: [
                    IconButton(
                      icon: Icon(Icons.search),
                      onPressed: () => _bloc.toggleAppBar(AppBarState.SEARCH),
                    )
                  ],
                );
            }
          },
        ),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 16.0),
        child: StreamBuilder<List<ThreadsModel>>(
          stream: _bloc.listStream,
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(child: CircularProgressIndicator());
            }
            List<ThreadsModel> threads = snapshot.data;

            if (threads.length == 0) {
              return Center(
                key: Key('zero-data-message'),
                child: Text('Nenhuma menssagem encotrada'),
              );
            }
            return ListView.separated(
                itemBuilder: (BuildContext context, int index) =>
                    ThreadItemList(threads: threads[index]),
                separatorBuilder: (BuildContext context, int index) =>
                    Divider(),
                itemCount: threads.length);
          },
        ),
      ),
    );
  }
}
