import 'package:flutter/material.dart';
import 'package:optimization/basickMethod.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late int column;
  late int row;
  List<TableRow> rows = [];
  List<List<double>> matrix = [];
  List<List<TextEditingController>> controllers = [];
  TextEditingController _controllerColumn = TextEditingController();
  TextEditingController _controller = TextEditingController();
  TextEditingController _controllerRow = TextEditingController();
  bool isDataUnset = true;
  //List<List<double>> matrix = [[]];

  void createTableSecond(){
    for (int i = 0; i < row; i++) {
      List<Widget> cells = [];
      List<TextEditingController> rowControllers = []; // список контроллеров для строки
      for (int j = 0; j < column; j++) {
        TextEditingController controller = TextEditingController(); // создаем контроллер для TextField
        rowControllers.add(controller);
        cells.add(Container(
          padding: EdgeInsets.all(8.0),
          child: TextField(
            controller: controller, // передаем контроллер в TextField
          ),
        ));
      }
      controllers.add(rowControllers);
      rows.add(TableRow(children: cells));
    }
  }

  void setData(){

    for (int i = 0; i < row; i++) {
      List<double> rowList = [];
      for (int j = 0; j < column; j++) {
        double value = double.parse(controllers[i][j].text); // получаем текст из TextField и преобразуем его в число
        rowList.add(value);
      }
      matrix.add(rowList);
      print(matrix);
    }
  }

  void createtable(){
    for (int i = 0; i < row; i++) {
      List<Widget> cells = [];
      for (int j = 0; j < column; j++) {
        cells.add(Container(
          padding: EdgeInsets.all(8.0),
          child: TextField(
          ),
        ));
      }
      rows.add(TableRow(children: cells));
      print(cells);
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
              column = int.parse(_controllerColumn.text) + 1;
              row = int.parse(_controllerRow.text) + 1;
              createTableSecond();
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
          ),
          SizedBox(height: 30),
          GestureDetector(
            onTap: (){
              setData();
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => BasicMethod(matrix: matrix, row: row, column: column,)));
            },
              child: Text("Данные введены")),
      ],),
    );
  }
}
