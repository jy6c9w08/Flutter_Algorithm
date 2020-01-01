import 'package:flutter/material.dart';

class WidgetListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("组件列表"),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Button(name: "中缀转后缀",),
              Button(name:"KMP算法"),
             Button(name: "基数排序",),
             Button(name: "矩阵",)
            ],
          ),
        )
    );
  }
}

class Button extends StatelessWidget {
  Button( {@required this.name});
  String name;

  @override
  Widget build(BuildContext context) {
    return RaisedButton(onPressed: () {
      Navigator.of(context).pushNamed(name);
    },

      child: Text(name),
    );

  }
}
