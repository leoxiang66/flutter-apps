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
  String _tiltAngle = ''; // 光伏板倾斜角度
  String _panelOrientation = ''; // 光伏板方位角

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

  void _updateTiltAngle(String value) {
    setState(() {
      _tiltAngle = value;
    });
  }

  void _updatePanelOrientation(String value) {
    setState(() {
      _panelOrientation = value;
    });
  }

  // 计算逻辑
  double calculateSolarGeneration() {
    double sunlightIntensity = double.tryParse(_sunlightIntensity) ?? 0.0;
    double tiltAngle = double.tryParse(_tiltAngle) ?? 0.0;
    double panelOrientation = double.tryParse(_panelOrientation) ?? 0.0;
    return sunlightIntensity *
        1.5 *
        (tiltAngle / 45) *
        (panelOrientation / 180);
  }

  double calculateWindGeneration() {
    double windSpeed = double.tryParse(_windSpeed) ?? 0.0;
    return windSpeed * 1.2;
  }

  double calculateGridLoad() {
    double temperature = double.tryParse(_temperature) ?? 0.0;
    return 500 + (temperature - 20) * 100;
  }

  String calculateLoadBalancingStrategy() {
    double solarGeneration = calculateSolarGeneration();
    double windGeneration = calculateWindGeneration();
    double totalGeneration = solarGeneration + windGeneration;
    double predictedLoad = calculateGridLoad();

    if (totalGeneration < predictedLoad) {
      double deficit = predictedLoad - totalGeneration;
      return "需要增加发电或减少负荷 ${deficit.toStringAsFixed(2)} 单位来平衡电网。";
    } else {
      double surplus = totalGeneration - predictedLoad;
      return "发电量充足，超出负荷需求 ${surplus.toStringAsFixed(2)} 单位，可以考虑储能或减少发电。";
    }
  }

  Widget _buildResult() {
    double solarGeneration = calculateSolarGeneration();
    double windGeneration = calculateWindGeneration();
    double predictedLoad = calculateGridLoad();
    String strategy = calculateLoadBalancingStrategy();

    return Scaffold(
        body: Container(
            child: Padding(
              padding: const EdgeInsets.all(100.0),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
            
                    Text("太阳能发电量: ${solarGeneration.toStringAsFixed(2)} 单位"),
                    Text("风能发电量: ${windGeneration.toStringAsFixed(2)} 单位"),
                    Text("预测负荷: ${predictedLoad.toStringAsFixed(2)} 单位"),
                    Text("调峰策略: $strategy"),
                    SizedBox(
                      height: 20,
                    ),
                    ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("返回"))
                  ],
                ),
            )));
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
                        labelText: '阳光强度（单位：W/m^2）',
                      ),
                      keyboardType: TextInputType.number,
                      onChanged: _updateSunlightIntensity, // 当输入改变时更新状态
                    ),
                    TextFormField(
                      decoration: const InputDecoration(
                        labelText: '风速（单位：m/s）',
                      ),
                      keyboardType: TextInputType.number,
                      onChanged: _updateWindSpeed, // 当输入改变时更新状态
                    ),
                    TextFormField(
                      decoration: const InputDecoration(
                        labelText: '温度（单位：°C）',
                      ),
                      keyboardType: TextInputType.number,
                      onChanged: _updateTemperature, // 当输入改变时更新状态
                    ),
                    TextFormField(
                      decoration: const InputDecoration(
                        labelText: '光伏板倾斜角度（单位：度）',
                      ),
                      keyboardType: TextInputType.number,
                      onChanged: _updateTiltAngle, // 当输入改变时更新状态
                    ),
                    TextFormField(
                      decoration: const InputDecoration(
                        labelText: '光伏板方位角（单位：度，正北为0）',
                      ),
                      keyboardType: TextInputType.number,
                      onChanged: _updatePanelOrientation, // 当输入改变时更新状态
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        // 在这里，您可以使用_formKey.currentState.validate()来校验输入的合法性（如果需要）
                        // 并使用上面的状态变量（_sunlightIntensity, _windSpeed, _temperature）进行后续处理
                        // 例如调用预测函数等

                        go_to_internal_page(context, _buildResult(),
                            pushonly: true);
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
