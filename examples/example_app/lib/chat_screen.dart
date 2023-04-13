import 'package:flutter/material.dart';
import 'dart:math';
import 'chatmessage.dart';

class OpenChatPage extends StatefulWidget {
  const OpenChatPage({super.key});

  @override
  State<OpenChatPage> createState() => _OpenChatPageState();
}

class _OpenChatPageState extends State<OpenChatPage> {
  final TextEditingController _controller = TextEditingController();
  final List<ChatMessage> _messages = [];
  final FocusNode _focusNode = FocusNode(); // 添加FocusNode实例
  final ScrollController _scrollController = ScrollController();

  bool _isImageSearch = false;

  String dummyResponse() {
    const characters =
        'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
    final random = Random();
    final length = random.nextInt(500) + 1; // 随机长度，1到50之间
    return String.fromCharCodes(Iterable.generate(length,
        (_) => characters.codeUnitAt(random.nextInt(characters.length))));
  }

  void _sendMessage() async {
    if (_controller.text.isEmpty) return;
    ChatMessage message = ChatMessage(
      text: _controller.text,
      sender: "user",
      isImage: false,
    );

    setState(() {
      _messages.add(message);
      scroll_bottom();
    });

    _controller.clear();

    if (_isImageSearch) {
      // final request = GenerateImage(message.text, 1, size: "256x256");
      // final response = await chatGPT!.generateImage(request);
      final response = dummyResponse();
      // Vx.log(response!.data!.last!.url!);
      // insertNewData(response.data!.last!.url!, isImage: true);
      insertNewData(response, isImage: true);
    } else {
      // final request =
      //     CompleteText(prompt: message.text, model: kTranslateModelV3);

      // final response = await chatGPT!.onCompleteText(request: request);
      final response = dummyResponse();
      // Vx.log(response!.choices[0].text);
      // insertNewData(response.choices[0].text, isImage: false);
      insertNewData(response, isImage: false);
    }
  }

  void insertNewData(String response, {bool isImage = false}) async {
    int typingDelay = 5; // 每个字符的延迟时间，单位为毫秒

    StringBuffer stringBuffer = StringBuffer();
    for (int i = 0; i < response.length; i++) {
      stringBuffer.write(response[i]);
      await Future.delayed(Duration(milliseconds: typingDelay)); // 等待延迟时间

      ChatMessage botMessage = ChatMessage(
        text: stringBuffer.toString(),
        sender: "bot",
        isImage: isImage,
      );

      setState(() {
        if (_messages.isNotEmpty &&
            _messages.last.sender == "bot" &&
            !_messages.last.isImage) {
          _messages.removeLast(); // 移除上一个botMessage
        }
        _messages.add(botMessage); // 添加新的botMessage
        scroll_bottom();
      });
    }
  }

  void scroll_bottom() {
    _scrollController.jumpTo(
      _scrollController.position.maxScrollExtent, // 立即滚动到底部
    );
  }

  Widget _buildTextComposer() {
    return Row(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8), // 设置四周的padding值
            child: TextField(
              controller: _controller,
              focusNode: _focusNode, // 将TextField与_focusNode关联
              onSubmitted: (value) {
                _sendMessage();
                // auto-focus
                _focusNode.requestFocus(); // 自动将焦点聚焦到TextField
              },
              decoration: const InputDecoration.collapsed(
                  hintText: "Question/description"),
            ),
          ),
        ),
        ButtonBar(
          children: [
            IconButton(
              icon: const Icon(Icons.send),
              onPressed: () {
                _isImageSearch = false;
                _sendMessage();
                // auto-focus
                _focusNode.requestFocus(); // 自动将焦点聚焦到TextField
              },
            ),
            // Padding(
            //   padding: EdgeInsets.all(8.0), // 设置四周的padding值
            //   child: TextButton(
            //     onPressed: () {
            //       _isImageSearch = true;
            //       _sendMessage();
            //     },
            //     child: const Text("Generate Image"),
            //   ),
            // ),
          ],
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("ChatGPT Demo"),
          centerTitle: true, // 将标题居中
          backgroundColor:
              const Color.fromARGB(100, 212, 250, 226), // 设置背景颜色为白色
          foregroundColor: Colors.black, // 设置前景色为黑色，以确保标题在白色背景上可见
        ),
        backgroundColor: Colors.white, // 设置背景颜色为白色，或者您想要的其他颜色
        body: SafeArea(
          child: Column(
            children: [
              Flexible(
                  child: ListView.builder(
                controller: _scrollController, // 添加ScrollController
                reverse: false,
                // padding: const EdgeInsets.all(10),
                itemCount: _messages.length,
                itemBuilder: (context, index) {
                  return _messages[index];
                },
              )),
              const Divider(
                height: 1.0,
              ),
              Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                ),
                child: _buildTextComposer(),
              )
            ],
          ),
        ));
  }
}
