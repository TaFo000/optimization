import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BasicMethod extends StatefulWidget {
   BasicMethod({
    super.key,
    required this.matrix,
   required this.row,
   required this.column});

  List<List<double>> matrix = [];
  int row;
  int column;


  @override
  State<BasicMethod> createState() => _BasicMethodState();
}



class _BasicMethodState extends State<BasicMethod> {
  late int row;
  late int column;
  late List<List<double>> matrix;
  double currentMainNum = 0;
  bool isChoosen = false;
   int _selectedRow = 1;
   int _selectedColumn = 1;
  late List<List<double>> pastMatrix;
  late List<List<double>> newMatrix = [];

  void removeColumn(List<List<double>> matrix, int columnIndex) {
    for (int i = 0; i < matrix.length; i++) {
      matrix[i].removeAt(columnIndex);
    }
    int row = matrix.length;
    int column = matrix[0].length;
    setState(() {
      widget.matrix = matrix;
      widget.row = row;
      widget.column = column;
    });
  }




  @override
  void initState() {
    matrix = widget.matrix;
    row = widget.row;
    column = widget.column;
    print(matrix);
    super.initState();
  }

  List<List<double>> createNewMatrix(List<List<double>> matrix, List<double> currentRow, int row, double currentMainNum, int column) {
    int m = matrix.length;
    int n = matrix[0].length;
    newMatrix = List.generate(m, (i) => List<double>.filled(n, 0));
    for (int i = 0; i < m; i++) {
      if (i == row) {
        for (int j = 0; j < n; j++) {
          newMatrix[i][j] = matrix[i][j] / currentMainNum;
          //print(newMatrix[i][j]);
        }
      } else {
        for (int j = 0; j < n; j++) {
          newMatrix[i][j] = matrix[i][j] - (matrix[i][column] * (currentRow[j]  / currentMainNum));
        }
      }
    }

    return newMatrix;
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(body:
      Column(children: [
        Table(
          border: TableBorder.all(),
          children: List.generate(row, (i) {
            return TableRow(
              children: List.generate(widget.column, (j) {
                if (j >= widget.matrix[i].length) {
                  return Container(); // пустой контейнер для дополнительных столбцов
                }
                return GestureDetector(
                  onTap: (){
                    currentMainNum = matrix[i][j];
                    print(currentMainNum);
                    setState(() {
                      _selectedRow = i;
                      _selectedColumn = j;
                    });
                  },
                  child: Container(
                    color: _selectedRow == i && _selectedColumn == j
                        ? Colors.blue
                        : Colors.white,
                    child: Text(widget.matrix[i][j].toString()),
                  ),
                );
              }),
            );
          }),
        ),
        SizedBox(height: 20),
        Row(children: [
          GestureDetector(
            onTap: (){
              setState(() {
                widget.matrix = pastMatrix;
              });
            },
            child: Text("Назад"),),
          SizedBox(width: 30),
          GestureDetector(
            onTap: (){
              pastMatrix = matrix;
             // print(matrix);
              createNewMatrix(matrix, matrix[_selectedRow], _selectedRow, currentMainNum, _selectedColumn);
              //print(newMatrix);
              matrix = newMatrix;
             // removeColumn(matrix, _selectedColumn);
             // print(_selectedColumn);
              //print(_selectedRow);
              print(newMatrix);
              setState(() {
                widget.matrix = matrix;
                widget.row = row;
                widget.column = column;
              });
            },
            child: Text("Вперед"),)
        ],)
      ],),);
  }
}
