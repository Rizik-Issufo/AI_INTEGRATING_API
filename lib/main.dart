import 'package:flutter/material.dart';
import 'chat_service.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ROI AI',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'ROI Ai'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _controller = TextEditingController();
  String? _response;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(1.0 as int, 0.291 as int, 0.9201 as int, 0.192 as int),
        title: Text(widget.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              decoration: InputDecoration(hintText: 'Type your question here'),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () async {
                final service = ChatService();
                final response = await service.request(_controller.text);
                setState(() {
                  _response = response;
                });
              },
              child: Text('ENTER'),
            ),
            SizedBox(height: 16),
            if (_response != null) Text(_response!),
          ],
        ),
      ),
    );
  }
}
