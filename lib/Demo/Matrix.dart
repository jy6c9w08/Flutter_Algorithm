import 'package:flutter/material.dart';

class Matrix extends StatelessWidget {
  const Matrix({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("矩阵"),
      ),
      body: Page(),
    );
  }
}

class Page extends StatefulWidget {
  Page({Key key}) : super(key: key);

  @override
  _PageState createState() => _PageState();
}

class _PageState extends State<Page> {
  static List<Ele> M = [
    Ele(1, 2, 12),
    Ele(1, 3, 9),
    Ele(3, 1, -3),
    Ele(3, 6, 14),
    Ele(4, 3, 24),
    Ele(5, 2, 18),
    Ele(6, 1, 15),
    Ele(6, 4, 17),
  ];
  static List<Ele> M1 = [
    Ele(1, 1, 3),
    Ele(1, 4, 5),
    Ele(2, 2, -1),
    Ele(3, 1, 2),
  ]; //第一个元素是行，第二个是列
  static List<Ele> M2 = [
    Ele(1, 2, 2),
    Ele(2, 1, 1),
    Ele(3, 1, -2),
    Ele(3, 2, 4),
  ];
  List<Ele> R = List(M.length);
  List<Ele> T = [];
  static int row = 6;
  static int colum = 7;
  List<int> cpot = List(colum);
  List<int> rpos = List(4);
  List<int> temp = [];
  List<int> temp2 = [];
  void testrpos() {
    for (int i = 0; i < 4; i++) {
      rpos[i] = 0;
    }

    for (int i = 0; i < M2.length; i++) {
      rpos[M2[i].row]++;
    }

    for (int i = 2; i < 4; i++) {
      rpos[i] = rpos[i] + rpos[i - 1];
    }
    print(rpos);
    temp2.addAll(rpos);
  }

  void testcopt() {
    for (int i = 0; i < colum; i++) {
      cpot[i] = 0;
    }

    for (int i = 0; i < M.length; i++) {
      cpot[M[i].column]++;
    }
    // print(cpot);
    for (int i = 2; i < colum; i++) {
      cpot[i] = cpot[i] + cpot[i - 1];
    }
    temp.addAll(cpot);
  }

  void trans() {
    int temp;
    for (int i = 0; i < R.length; i++) {
      //  print(cpot);
      temp = M[i].row;
      M[i].row = M[i].column;
      M[i].column = temp;
      R[cpot[M[i].row - 1]] = M[i];

      cpot[M[i].row - 1]++;
    }
  }

  void multiply() {
    for (int i = 0; i < M1.length; i++) {
      Ele temp = Ele(0, 0, 0);
      if (rpos[M1[i].column - 1] + 1 > M2.length) {
        continue;
      }
      temp.row = M1[i].row;
      temp.column = M2[rpos[M1[i].column - 1]].column;
      temp.info = M1[i].info * M2[rpos[M1[i].column - 1]].info;
      // rpos[M1[i].column - 1]++;
      T.add(temp);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    testcopt();
    print(cpot);
    trans();
    testrpos();
    multiply();
  }

  List<Widget> printf(List<Ele> list) {
    List<Widget> p = [];
    for (int i = 0; i < list.length; i++) {
      p.add(Text(
          "${list[i].row.toString()}  ${list[i].column.toString()}    ${list[i].info.toString()}"));
    }
    return p;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
      height: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          ListTile(
            title: Text("M的cpot"),
            subtitle: Text(temp.toString()),
          ),
          ListTile(
            title: Text("M2的ropt"),
            subtitle: Text(temp2.toString()),
          ),
          ListTile(
            title: Text("矩阵M"),
            subtitle: Column(
              children: printf(M),
            ),
          ),
          ListTile(
            title: Text("M1的转置矩阵R"),
            subtitle: Column(children: printf(R)),
          ),
          ListTile(
            title: Text("相乘矩阵M1"),
            subtitle: Column(children: printf(M1)),
          ),
          ListTile(
            title: Text("相乘矩阵M2"),
            subtitle: Column(children: printf(M2)),
          ),
          ListTile(
            title: Text("M1M2相乘矩阵T"),
            subtitle: Column(children: printf(T)),
          ),
        ],
      ),
    ),
    );
  }
}

class Ele {
  int column; //行
  int row; //列
  int info; //数值
  Ele(this.row, this.column, this.info);
}
