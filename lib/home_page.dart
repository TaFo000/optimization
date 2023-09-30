import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late int column;
  late int row;
  TextEditingController _controllerColumn = TextEditingController();
  TextEditingController _controllerRow = TextEditingController();
  bool isDataUnset = true;
  List<TableRow> rows = [];
  List<List<double>> matrix = [
    [1.0, -1.0, 1.0, 3.0],
    [2.0, -5.0, -1.0, 0.0],
    [-3.0, 6.0, 0.0, -3.0],
  ];


  void createtable(){
    for (int i = 0; i < row; i++) {
      List<Widget> cells = [];
      for (int j = 0; j < column; j++) {
        cells.add(Container(
          padding: EdgeInsets.all(8.0),
          child: TextField(),
        ));
      }
      rows.add(TableRow(children: cells));
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isDataUnset? Column(
        children: [
          Text("Число переменных"),
          SizedBox(height: 20,),
          TextField(
            controller: _controllerColumn,
          ),
          SizedBox(height: 30),
          Text("Число ограничений"),
          SizedBox(height: 20,),
          TextField(
            controller: _controllerRow,
          ),
          SizedBox(height: 30),
          GestureDetector(
            onTap: (){
              isDataUnset = !isDataUnset;
              column = int.parse(_controllerColumn.text);
              row = int.parse(_controllerRow.text);
              createtable();
              setState(() {

              });
            },
            child: Container(child: Text("Данные введены"),),)
        ],
      ) : Column(
        children: [
          Table(
            border: TableBorder.all(),
            children: rows,
          )
      ],),
    );
  }
}
