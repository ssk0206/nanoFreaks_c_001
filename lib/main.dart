import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  // テキストフィールドを管理するコントローラを作成(入力内容の取得用)
  final textController = TextEditingController();

   // 入力データ格納用のリスト
  List<Map<String, dynamic>> items = [];

  //　追加ボタンが押されたときの処理（リストにIDと入力データを新規追加）
  void _addItem(String inputText) {
    setState(() {
      _counter++;
      items.add({ "id": _counter, "content": inputText});
    });
  }

  @override
  // widgetの破棄時にコントローラも破棄
  void dispose() {
    textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              '入力してください。',
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                controller: textController,
              ),
            ),
            Expanded(
              child:ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: items.length,
                itemBuilder: (BuildContext context, int index) {
                  final item = items[index];
                  // 新しいカードを作成して返す
                  return new Card(
                    child: ListTile(
                      title: Text(item["id"].toString() + " : " + item["content"]),
                    ),
                  );
                }),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        // ボタンが押された時の動作
        onPressed: () {
          //テキストフィールドの内容を取得し、アイテムリストに追加
          _addItem(textController.text);

          // テキストフィールドの内容をクリア
          textController.clear();
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
