import 'package:flutter/material.dart';
import 'dart:convert';

class Stack extends StatefulWidget {
  @override
  _StackState createState() => _StackState();
}

class _StackState extends State<Stack> {
  @override
  Widget build(BuildContext context) {
    return 
     
       Scaffold(
        // resizeToAvoidBottomPadding: false,
        appBar: AppBar(
          title: Text("中缀转后缀"),
        ),
        body: MiddleChangeBehind(),
      );
    
  }
}


class MiddleChangeBehind extends StatefulWidget {
  @override
  _MiddleChangeBehindState createState() => _MiddleChangeBehindState();
}

class _MiddleChangeBehindState extends State<MiddleChangeBehind> {
  // String middle = "";
  List<String> list1 = []; //存放中缀表达式
  List<String> list2 = []; //存放运算符号
  List<String> list3 = []; //存放数字
  //将字符串转成list
  void stringToList() {
    for (int i = 0; i < _controller.text.length; i++) {
      list1.add(_controller.text[i]);
    }
    // debugPrint(list1);
  }

  void changeFun() {
    for (int i = 0; list1.length > 0;) {
      var num=ascii.encode(list1[i])[0];
      if (
      48<=num&&num<=57
      ) {
        list3.add(list1[i]);
        list1.remove(list1[i]);
        continue;
      }
      //判断是否为加减
      if (list1[i] == "+" || list1[i] == "-") {
        if (list2.contains("(")) {
          //判断是否包含右括号
          // debugPrint("object");
          for (int j = list2.length - 1; j >= 0; j--) {
            if (list2[j] == "(") {
              //遇到括号，添加符号 终止循环
              list2.add(list1[i]);
              list1.remove(list1[i]);
              //  print("object5${list2.toString()}");
              break;
            } else {
              list3.add(list2[j]);
              //  debugPrint("步骤");
              list2.removeLast();
              //  print("object6${list2.toString()}");
              continue;
            }
          }
        } else {
          if (list2.length == 0) {
            //list2为空直接添加
            list2.add(list1[i]);

            list1.remove(list1[i]);
            continue;
          } else {
            for (int j = list2.length - 1; j >= 0; j--) {
              list3.add(list2[j]);
              list2.removeLast();
              if (list2.length == 0) {
                break;
              }
            }
            list2.add(list1[i]);
            list1.remove(list1[i]);
            continue;
          }
        }
        continue;
      }
      if (list1[i] == "*" || list1[i] == "/") {
        if (list2.length != 0) {
          //判断上一位是不是"*"/"  若是则让上一位出栈
          if (list2[list2.length - 1] == "*" ||
              list2[list2.length - 1] == "/") {
            list3.add(list2[list2.length - 1]);
            list2.removeLast();
            list2.add(list1[i]);
            list1.remove(list1[i]);
            continue;
          } else {
            list2.add(list1[i]);
            list1.remove(list1[i]);
            continue;
          }
        } else {
          //如果list2为空直接添加
          list2.add(list1[i]);
          list1.remove(list1[i]);
          continue;
        }
      }
      if (list1[i] == "(") {
        list2.add(list1[i]);
        list1.remove(list1[i]);
      }
      if (list1[i] == ")") {
        list2.add(list1[i]);
        list1.remove(list1[i]);
        for (int j = list2.length - 1;; j--) {
          //将括号中的字符添加到list3
          if (list2[j] == "(") {
            // print("${list2.toString()}");
            // print("${list3.toString()}");

            list3.add(list2[j]);
            list2.removeLast();

            // print("object2");

            // print("列表一${list1.toString()}");
            break;
          }

          // if (list2[j] == "(")
          else {
            // print("${list2.toString()}");
            // print("${list3.toString()}");
            list3.add(list2[j]);
            list2.removeLast();
            // print("object1");
          }
        }
      }

      if (list1.length == 0) {
        break;
      }
      if (
      num<40||num>57
      )
      {
        setState(() {
          list3 = [];
          list3.add("存在非法字符");
        });
        break;
      }
    }
  }

  @override
  void initState() {
    super.initState();
    _controller.text = "1+2*3+(4*5+6)*7"; //初始化表格内容
    _controller.addListener(() {
      // debugPrint(_controller.text);
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
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
                padding: EdgeInsets.all(20),
                child: TextField(
                  decoration: InputDecoration(
                    labelText: "输入中缀表达式",
                    suffixIcon: IconButton(
                        icon: Icon(Icons.cancel),
                        onPressed: () {
                          // debugPrint(_controller.text);
                          setState(() {
                            _controller.text = '';

                            list3 = [];
                          });
                        }),
                  ),
                  controller: _controller,
                ),
              ),
              RaisedButton(
                child: Text("重置"),
                onPressed: () {
                  setState(() {
                    list1 = [];
                    list2 = [];
                    list3 = [];
                  });
                },
              ),
              RaisedButton(
                onPressed: () {
                  stringToList();
                  setState(() {
                    changeFun();
                    if (list2.length != 0) {
                      for (int i = list2.length - 1; i >= 0; i--) {
                        list3.add(list2[i]);
                        list2.removeLast();
                        if (list2.length == 0) {
                          break;
                        }
                      }
                    }
                    list3.removeWhere((value) => value == "("); //去除list3中的括号
                    list3.removeWhere((value) => value == ")");
                  });
                  // debugPrint("列表二${list2.toString()}");
                  // debugPrint("列表三${list3.toString()}");
                },
                child: Text("生成后缀表达式"),
              ),
              Container(
                padding: EdgeInsets.all(10),
                child: Text("输入的中缀表达式为${_controller.text}"),
              ),
              Container(
                padding: EdgeInsets.all(10),
                child: Text("输出的后缀表达式为${list3.toString()}"),
              ),
              SizedBox(
                height: 50,
              ),
              Container(
                child: Text(
                  "注意所有字符使用英文输入法，输入其他可能卡死应用",
                  style: TextStyle(color: Colors.red),
                ),
              )
            ],
          )),
    );
  }
}

