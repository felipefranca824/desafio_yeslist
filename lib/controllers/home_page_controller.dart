import 'package:flutter/widgets.dart';

class HomePageController extends ChangeNotifier {
  
  List<TextEditingController> _listFieldControllers = List<TextEditingController>();

  int _quantify = 0;

  List<TextEditingController> get listFieldControllers => this._listFieldControllers;

  addFieldController(){
    listFieldControllers.add(TextEditingController());
    addQuantify();
    printControllers();
    notifyListeners();
  }

  get quantify => this._quantify;

  addQuantify(){
    this._quantify++;
  }

  printControllers(){
    print("Tamanho ${listFieldControllers.length}");
  }


}