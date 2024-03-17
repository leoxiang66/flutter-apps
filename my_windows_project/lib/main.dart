import 'package:flutter/material.dart';
import 'package:open_widgets/navigator/utils.dart';
import 'package:window_manager/window_manager.dart';
import 'package:open_widgets/navigator/web_navigator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Must add this line.
  await windowManager.ensureInitialized();

  WindowOptions windowOptions = WindowOptions(
    size: Size(800, 600),
    minimumSize: Size(600, 400),
    center: true,
    backgroundColor: Colors.transparent,
    skipTaskbar: false,
    title: "天气预测调峰",
    // titleBarStyle: TitleBarStyle.hidden,
    windowButtonVisibility: true,
  );
  windowManager.waitUntilReadyToShow(windowOptions, () async {
    await windowManager.show();
    await windowManager.focus();
  });

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: '天气预测调峰'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _formKey = GlobalKey<FormState>(); // 添加一个Form的key

  // 状态变量来存储用户输入
  String _sunlightIntensity = '';
  String _windSpeed = '';
  String _temperature = '';

  // 方法来更新状态变量
  void _updateSunlightIntensity(String value) {
    setState(() {
      _sunlightIntensity = value;
    });
  }

  void _updateWindSpeed(String value) {
    setState(() {
      _windSpeed = value;
    });
  }

  void _updateTemperature(String value) {
    setState(() {
      _temperature = value;
    });
  }

  Widget _buildResult() {
    return Text(_sunlightIntensity);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: SingleChildScrollView(
          child: Container(
            child: Center(
              child: Form(
                // 使用Form Widget来包裹输入框
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    TextFormField(
                      decoration: const InputDecoration(
                        labelText: '阳光强度',
                      ),
                      keyboardType: TextInputType.number,
                      onChanged: _updateSunlightIntensity, // 当输入改变时更新状态
                    ),
                    TextFormField(
                      decoration: const InputDecoration(
                        labelText: '风速',
                      ),
                      keyboardType: TextInputType.number,
                      onChanged: _updateWindSpeed, // 当输入改变时更新状态
                    ),
                    TextFormField(
                      decoration: const InputDecoration(
                        labelText: '温度',
                      ),
                      keyboardType: TextInputType.number,
                      onChanged: _updateTemperature, // 当输入改变时更新状态
                    ),
                    ElevatedButton(
                      onPressed: () {
                        // 在这里，您可以使用_formKey.currentState.validate()来校验输入的合法性（如果需要）
                        // 并使用上面的状态变量（_sunlightIntensity, _windSpeed, _temperature）进行后续处理
                        // 例如调用预测函数等

                        go_to_internal_page(context, _buildResult());
                      },
                      child: const Text('提交'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
