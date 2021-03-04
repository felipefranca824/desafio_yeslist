import 'package:flutter/widgets.dart';

class HomePageController extends ChangeNotifier {
  
  List<Widget> _listFields = List<Widget>();

  int _quantify = 0;

  List<Widget> get listFields => this._listFields;

  get quantify => this._quantify;

  addQuantify(){
    this._quantify++;
  }

  addlistFields(Widget item){
    listFields.add(item);
    addQuantify();
    print(listFields.length);
    print(quantify);
    notifyListeners();
  }
}