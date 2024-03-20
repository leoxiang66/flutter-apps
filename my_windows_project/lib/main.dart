import 'dart:convert';
import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:open_widgets/navigator/utils.dart';
import 'package:window_manager/window_manager.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:open_widgets/status/spinner.dart';
import 'package:file_selector/file_selector.dart';

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

  double calculateSolarGenerationWithModel(
      double temperature, // 气温℃
      double humidity, // 湿度%
      double atmosphericPressure, // 气压hPa
      double precipitation, // 降水量mm/h
      double meridionalWind, // 经向风m/s
      double zonalWind, // 纬向风m/s
      double surfaceWindSpeed, // 地面风速m/s
      double windDirection, // 风向°
      double surfaceHorizontalRadiation, // 地表水平辐射W/m^2
      double normalDirectRadiation, // 法向直接辐射W/m^2
      double scatteredRadiation // 散射辐射W/m^2
      ) {
    return temperature * 0.0037 +
        humidity * -0.0006 +
        atmosphericPressure * -0.0005 +
        precipitation * -0.0012 +
        meridionalWind * -0.0102 +
        zonalWind * 0.0005 +
        surfaceWindSpeed * -0.0069 +
        windDirection * 0.0001 +
        surfaceHorizontalRadiation * 0.0004 +
        normalDirectRadiation * -0.0001 +
        scatteredRadiation * 0.0001 +
        0.6608; // Intercept
  }

  double calculateWindGenerationWithModel(
      double temperature, // 气温℃
      double humidity, // 湿度%
      double atmosphericPressure, // 气压hPa
      double precipitation, // 降水量mm/h
      double meridionalWind, // 经向风m/s
      double zonalWind, // 纬向风m/s
      double surfaceWindSpeed, // 地面风速m/s
      double windDirection, // 风向°
      double surfaceHorizontalRadiation, // 地表水平辐射W/m^2
      double normalDirectRadiation, // 法向直接辐射W/m^2
      double scatteredRadiation // 散射辐射W/m^2
      ) {
    return temperature * -0.0265494436 +
        humidity * -0.0055894166 +
        atmosphericPressure * 0.001240531 +
        precipitation * -0.0726600105 +
        meridionalWind * 0.155803242 +
        zonalWind * 0.0221875947 +
        surfaceWindSpeed * 0.759732919 +
        windDirection * -0.000540551573 +
        surfaceHorizontalRadiation * -0.00143191532 +
        normalDirectRadiation * -0.00051611078 +
        scatteredRadiation * 0.000475089303 +
        -0.6102383793813357; // Intercept
  }

  double calculateGridLoad(double temperature) {
    return 500 + (temperature - 20) * 100;
  }

  String calculateLoadBalancingStrategyDisplay(
      double sunlightIntensity,
      double tiltAngle,
      double panelOrientation,
      double windSpeed,
      double temperature) {
    double solarGeneration = calculateSolarGeneration_display(
        sunlightIntensity, tiltAngle, panelOrientation);
    double windGeneration = calculateWindGeneration_display(windSpeed);
    double totalGeneration = solarGeneration + windGeneration;
    double predictedLoad = calculateGridLoad(temperature);

    if (totalGeneration < predictedLoad) {
      double deficit = predictedLoad - totalGeneration;
      return "需要增加发电或减少负荷 ${deficit.toStringAsFixed(2)} 单位来平衡电网。";
    } else {
      double surplus = totalGeneration - predictedLoad;
      return "发电量充足，超出负荷需求 ${surplus.toStringAsFixed(2)} 单位，可以考虑储能或减少发电。";
    }
  }

  String calculateLoadBalancingStrategyWithModel(
      double solarGeneration,
      double windGeneration,
      double predictedLoad,
) {
  
    double totalGeneration = solarGeneration + windGeneration;
    

    if (totalGeneration < predictedLoad) {
      double deficit = predictedLoad - totalGeneration;
      return "需要增加发电或减少负荷 ${deficit.toStringAsFixed(2)} 单位来平衡电网。";
    } else {
      double surplus = totalGeneration - predictedLoad;
      return "发电量充足，超出负荷需求 ${surplus.toStringAsFixed(2)} 单位，可以考虑储能或减少发电。";
    }
  }



  double calculateWindGeneration_display(double windSpeed) {
    return windSpeed * 1.2;
  }

  double calculateSolarGeneration_display(
      double sunlightIntensity, double tiltAngle, double panelOrientation) {
    return sunlightIntensity *
        1.5 *
        (tiltAngle / 45) *
        (panelOrientation / 180);
  }

  Widget _buildResult() {
    double solarGeneration = calculateSolarGeneration_display(
        double.parse(_sunlightIntensity),
        double.parse(_tiltAngle),
        double.parse(_panelOrientation));
    double windGeneration =
        calculateWindGeneration_display(double.parse(_windSpeed));
    double predictedLoad = calculateGridLoad(double.parse(_temperature));
    String strategy = calculateLoadBalancingStrategyDisplay(
        double.parse(_sunlightIntensity),
        double.parse(_tiltAngle),
        double.parse(_panelOrientation),
        double.parse(_windSpeed),
        double.parse(_temperature));

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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
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
                        SizedBox(
                          width: 20,
                        ),
                        ElevatedButton(
                          onPressed: () async {
                            FilePickerResult? result =
                                await FilePicker.platform.pickFiles(
                              type: FileType.custom,
                              allowedExtensions: [
                                'csv',
                              ],
                            );

                            if (result != null) {
                              // 如果用户选择了文件，这里可以获取文件路径
                              PlatformFile file = result.files.first;

                              go_to_internal_page(
                                  context,
                                  Scaffold(
                                    body: Container(
                                      child: Center(
                                        child: Spinner(
                                            work: processCsvFile(file),
                                            onFinished: (content) {
                                              return Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  ElevatedButton(
                                                      onPressed: () {
                                                        saveFileWithUserSelectedPath(
                                                            content);
                                                      },
                                                      child: Text("下载结果")),
                                                  SizedBox(
                                                    width: 20,
                                                  ),
                                                  ElevatedButton(
                                                      onPressed: () {
                                                        Navigator.pop(context);
                                                      },
                                                      child: Text("返回")),
                                                ],
                                              );
                                            }),
                                      ),
                                    ),
                                  ),
                                  pushonly: true);
                            } else {
                              // 用户没有选择任何文件
                              throw Exception('No file selected.'); // 抛出一个异常
                            }
                          },
                          child: const Text('上传文件批量处理'),
                        ),
                      ],
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

  Future<String> processCsvFile(PlatformFile file) async {
    try {
      // 将文件路径转换为File对象
      await Future.delayed(Duration(seconds: 2));

      var csvFile = File(file.path!);
      // 异步读取文件内容
      var lines = await csvFile.readAsLines();

      String result = lines[0];

      // 遍历除标题行外的每一行
      for (var line in lines.skip(1)) {
        // 如果第一行是列名，跳过第一行
        // 将每一行按逗号分割
        var values = line.split(',');

        try {
          String datetime = values[0];
          double temperature = tryParse(values[1]);
          double humidity = tryParse(values[2]);
          double atmosphericPressure = tryParse(values[3]);
          double precipitation = tryParse(values[4]);
          double meridionalWind = tryParse(values[5]);
          double zonalWind = tryParse(values[6]);
          double surfaceWindSpeed = tryParse(values[7]);
          double windDirection = tryParse(values[8]);
          double surfaceHorizontalRadiation = tryParse(values[9]);
          double normalDirectRadiation = tryParse(values[10]);
          double scatteredRadiation = tryParse(values[12]);

          double solar = calculateSolarGenerationWithModel(temperature,humidity,atmosphericPressure,precipitation,meridionalWind,zonalWind,surfaceWindSpeed,windDirection,surfaceHorizontalRadiation,normalDirectRadiation,scatteredRadiation);
          double wind = calculateWindGenerationWithModel(
              temperature,
              humidity,
              atmosphericPressure,
              precipitation,
              meridionalWind,
              zonalWind,
              surfaceWindSpeed,
              windDirection,
              surfaceHorizontalRadiation,
              normalDirectRadiation,
              scatteredRadiation);

          double fuhe = calculateGridLoad(temperature);
          String strategy =
              calculateLoadBalancingStrategyWithModel(solar,wind,fuhe);

          result +=
              '\n$datetime,$temperature,$humidity,$atmosphericPressure,$precipitation,$meridionalWind,$zonalWind,$surfaceWindSpeed,$windDirection,$surfaceHorizontalRadiation,$normalDirectRadiation,$scatteredRadiation,$solar,$wind,$fuhe,$strategy';
        } catch (e) {}
      }

      // 返回求和结果
      return result;
    } catch (e) {
      // 处理可能的异常
      return "Error processing file: $e";
    }
  }

  Future<String> sleepFiveSeconds() async {
    // 使用Future.delayed来暂停执行5秒
    await Future.delayed(Duration(seconds: 5));
    return "Finished";
  }

  Future<void> saveFileWithUserSelectedPath(String content) async {
    try {
      // 建议的文件名
      const String suggestedName = 'results.csv';
      // 弹出文件保存对话框
      final FileSaveLocation? result =
          await getSaveLocation(suggestedName: suggestedName);
      if (result == null) {
        // 用户取消了操作
        return;
      }

      // 将字符串内容转换为UTF-8编码的Uint8List
      final Uint8List fileData = Uint8List.fromList(utf8.encode(content));
      // 创建XFile对象，此处直接使用字符串内容，明确指定为"text/csv; charset=utf-8" MIME类型
      final XFile xFile = XFile.fromData(fileData,
          mimeType: 'text/csv; charset=utf-8', name: suggestedName);
      // 保存到用户选择的路径
      await xFile.saveTo(result.path);

      // 提示用户文件已保存或执行后续操作
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return Dialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: Container(
                height: 200,
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      TextField(
                        decoration: InputDecoration(
                            border: InputBorder.none, hintText: '成功'),
                      ),
                      SizedBox(
                        width: 320.0,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text("OK"),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF1BC0C5),
                            foregroundColor: Colors.white,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            );
          });
    } catch (e) {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return Dialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: Container(
                height: 200,
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SingleChildScrollView(
                        child: TextField(
                          decoration: InputDecoration(
                              border: InputBorder.none, hintText: e.toString()),
                        ),
                      ),
                      SizedBox(
                        width: 320.0,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text("OK"),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF1BC0C5),
                            foregroundColor: Colors.white,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            );
          });
    }
  }

  double tryParse(String source, {double defaultValue = 0.0}) {
    try {
      return double.parse(source);
    } catch (e) {
      return defaultValue;
    }
  }
}
