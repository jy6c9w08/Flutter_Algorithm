import 'package:homework/Demo/KMP.dart';
import 'package:homework/Demo/Stack.dart';
import 'package:homework/Demo/JiShu.dart';
import 'package:homework/Demo/Matrix.dart';
import 'Widget_List.demo.dart';
//配置路由
final routes = {
  '/': (context) =>WidgetListPage(),
  '中缀转后缀':(context)=>Stack(),
  'KMP算法':(context)=>KMP(),
 '基数排序':(context)=>JiShu(),
 '矩阵':(context)=>Matrix(),
};

