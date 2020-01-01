import 'package:flutter/material.dart';

class JiShu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("基数排序"),
      ),
      body: Page(),
    );
  }
}

class Page extends StatefulWidget {
  @override
  _PageState createState() => _PageState();
}

class _PageState extends State<Page> {
  List<String> date = [];
//创建10个基数列表  类型是字符串型
  List<String> _ = [];
  List<List<String>> tollist = List(10);
  void Sort(int size) {
    //初始化
    for (int i = 0; i < 10; i++) {
      tollist[i] = [];
    }
    for (int i = 0; i < date.length; i++) {
      int index = int.parse(date[i][size]);
      tollist[index].add(date[i]);
    }
    date = [];
    //将10个基数列表连起来
    for (int i = 0; i < 10; i++) {
      date.addAll(tollist[i]);
    }
    // print("第${(-size) + 3}次排序${date}");
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller.text = "278,109,063,930,589,184,505,269,008,083";
    date = _controller.text.split(",");
    Sort(2);

    Sort(1);

    Sort(0);
  }

  TextEditingController _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              child: TextField(
                decoration: InputDecoration(
                  labelText: "排序数组",
                  suffixIcon: IconButton(
                    icon: Icon(Icons.cancel),
                    onPressed: () {
                      setState(() {
                        date = [];
                        _controller.text = '';
                      });
                    },
                  ),
                ),
                controller: _controller,
              ),
            ),
            Container(
              child: RaisedButton(
                child: Text("重置"),
                onPressed: () {
                  setState(() {
                    date = [];
                    for (int i = 0; i < 10; i++) {
                      tollist[i] = [];
                    }
                  });
                },
              ),
            ),
            Container(
              child: RaisedButton(
                child: Text("排序"),
                onPressed: () {
                  setState(() {
                    date = _controller.text.split(",");
                    Sort(2);

                    Sort(1);

                    Sort(0);
                  });
                },
              ),
            ),
            Container(
              child: Text("结果为${date}"),
            )
          ],
        ),
      ),
    );
  }
}
