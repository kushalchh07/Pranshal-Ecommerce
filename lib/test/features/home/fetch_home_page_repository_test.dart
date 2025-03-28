import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:get/get.dart';

import '../../../features/home/presentation/screens/homepage.dart';


@GenerateMocks([NavigatorObserver])
void main() {
  testWidgets('HomeScreen UI test', (WidgetTester tester) async {
    await tester.pumpWidget(
      GetMaterialApp(
        home: HomeScreen(),
      ),
    );

    // Verify the AppBar title
    expect(find.textContaining('Welcome,'), findsOneWidget);

    // Verify the presence of the upload file button
    expect(find.text('Upload File'), findsOneWidget);

    // Verify the presence of the capture button
    expect(find.text('Capture'), findsOneWidget);
  });

  testWidgets('Scroll test', (WidgetTester tester) async {
    await tester.pumpWidget(
      GetMaterialApp(
        home: Scaffold(
          body: SingleChildScrollView(
            child: Column(
              children: List.generate(
                20,
                (index) => ListTile(title: Text('Item $index')),
              ),
            ),
          ),
        ),
      ),
    );

    final lastItem = find.text('Item 19');

    // Verify initial state
    expect(lastItem, findsNothing);

    // Scroll down
    await tester.fling(find.byType(Scrollable), const Offset(0, -300), 1000);
    await tester.pumpAndSettle();

    // Verify last item is visible
    expect(lastItem, findsOneWidget);
  });
}
