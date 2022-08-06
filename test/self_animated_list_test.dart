import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:self_animated_list/self_animated_list.dart';

void main() {
  group('SelfAnimatedList tests', () {
    testWidgets(
      'IF SelfAnimatedList data set to 1,2,3 '
      'THEN it must contain text 1,2,3',
      (WidgetTester tester) async {
        final List<String> data = <String>['1', '2', '3'];

        await _pumpWidget(tester, data);

        expect(find.text('1'), findsOneWidget);
        expect(find.text('2'), findsOneWidget);
        expect(find.text('3'), findsOneWidget);
      },
    );
  });
}

Future<void> _pumpWidget(WidgetTester tester, List<String> data) async => tester.pumpWidget(
      MaterialApp(
        home: SelfAnimatedList<String>(
          data: data,
          itemBuilder: (ItemData<String> itemData) => Text(itemData.item),
        ),
      ),
    );
