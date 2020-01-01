import 'package:flutter/material.dart';

class KMP extends StatefulWidget {
  @override
  _KMPState createState() => _KMPState();
}

class _KMPState extends State<KMP> {
  @override
  Widget build(BuildContext context) {
    return 
       Scaffold(
        appBar: AppBar(
          title: Text("KMP算法"),
        ),
        body: Home_Demo(),
      );
   
  }
}

class Home_Demo extends StatefulWidget {
  @override
  _Home_DemoState createState() => _Home_DemoState();
}

class _Home_DemoState extends State<Home_Demo> {
  static List mather = []; //母串
  static List son = []; //字串
  int size;
 List next=[] ;

  void stringToList() {
    mather.add("");
    son.add("");
    for (int i = 0; i < _controller1.text.length; i++) {
      mather.add(_controller1.text[i]);
    }
    for (int i = 0; i < _controller2.text.length; i++) {
      son.add(_controller2.text[i]);
    }
    // debugPrint(list1);
  } //next数组

  void getNext() {
    next[0] = '';
    //i从第一个开始，没有零
    int j = 0;
    next[1] = 0; //next的第一个为0
    for (int i = 1; ;) {
      // print(i);
      if (i == son.length-1 ) {
        break;
      }
      if (j == 0 || son[i] == son[j]) {
        i++;
        j++;
        next[i] = j;
      } else {
        j = next[j];
      }
    }
  }

  void KMP() {
    int j = 1;
    int i = 1;
    //从头开始判断
    for (; i < mather.length && j < son.length;) {
      // print(mather[i]);
      // print(son[j]);
      if (j == 0 || mather[i] == son[j]) {
        i++;
        j++;
      } else {
        j = next[j];
      }
    }
    size = i;
    // print("i的值${i - (next.length - 1)}");
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller1.text = "acabaabaabcacaabc";
    _controller2.text = "abaabcac";
    stringToList();
    next.addAll(son);
    getNext();
    KMP();
  }

  TextEditingController _controller1 = TextEditingController();
  TextEditingController _controller2 = TextEditingController();

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
                    labelText: "主串",
                    suffixIcon: IconButton(
                      icon: Icon(Icons.cancel),
                      onPressed: () {
                        setState(() {
                          _controller1.text = '';
                          mather = [];
                        });
                      },
                    )),
                controller: _controller1,
              ),
            ),
            Container(
              child: TextField(
                decoration: InputDecoration(
                    labelText: "子串",
                    suffixIcon: IconButton(
                      icon: Icon(Icons.cancel),
                      onPressed: () {
                        setState(() {
                          _controller2.text = '';
                          son = [];
                        });
                      },
                    )),
                controller: _controller2,
              ),
            ),
            RaisedButton(
              child: Text("重置"),
              onPressed: () {
                setState(() {
                  mather = [];
                  son = [];
                  next=[];
                });
              },
            ),
            RaisedButton(
              onPressed: () {
                // mather.add(null);
                // son.add(null);//占位
                stringToList();
                setState(() {
                  next.addAll(son);
                  getNext();
                  KMP();
                });
              },
              child: Text("搜索字串位置"),
            ),
            Container(
              padding: EdgeInsets.all(10),
              child: Text("next数组为${next.toString()}"),
            ),
            Container(
              padding: EdgeInsets.all(10),
              child: Text("位置${size- (next.length - 1) }"),
            ),
          ],
        ),
      ),
    );
  }
}
