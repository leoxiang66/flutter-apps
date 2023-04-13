import 'package:flutter/material.dart';
import 'package:open_widgets/chatbot/chat_page.dart';
import 'package:open_widgets/input/text_input.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await dotenv.load(fileName: ".env");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  Future<String> exampleAsyncFunction(String input) async {
    await Future.delayed(Duration(seconds: 5));
    return "Hello, $input!";
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final ValueNotifier<String> _inputNotifier = ValueNotifier('');

    var openTextInput = OpenTextInput(
      clearNotifier: _inputNotifier,
      placeholder: '2233444',
      // defaultValue: 'default',
      label: '',
      width: 200,
      onChanged: (text) {},
      onSubmitted: (text) {},
    );

    void test() {
      _inputNotifier.value = '';
    }

    return MaterialApp(
        title: 'ChatGPT Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.green,
          useMaterial3: true,
        ),
        home: Scaffold(
          body: Column(
            children: [
              openTextInput,
              ElevatedButton(
                  onPressed: () {
                    test();
                  },
                  child: Text("123"))
            ],
          ),
        )
        // OpenChatPage(
        // reply_func: exampleAsyncFunction,
        // ),
        );
  }
}
