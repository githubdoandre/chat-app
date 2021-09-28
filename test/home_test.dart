// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:chat_app/models/threads.dart';
import 'package:chat_app/repository/threads_repository.dart';
import 'package:chat_app/screens/home/components/threads_item_list.dart';
import 'package:chat_app/screens/home/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:chat_app/main.dart';
import 'package:mockito/mockito.dart';

class ThreadsRepositoryMock extends Mock implements ThreadsRepository {}

void main() {
  testWidgets('Deveria exibir a lista de conversas',
      (WidgetTester tester) async {
    final mockRepository = ThreadsRepositoryMock();

    when(mockRepository.getList(any)).thenAnswer(
      (_) async => [
        ThreadsModel(
          identity: 'jimhalpert@blip.ai',
          name: 'Jim Halpert',
        ),
      ],
    );

    await tester.pumpWidget(
      MaterialApp(
        home: Material(
          child: HomePage(),
        ),
      ),
    );

    await tester.pump();

    expect(find.byType(ThreadItemList), findsNWidgets(1));
  });
}
