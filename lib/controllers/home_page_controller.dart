import 'package:flutter/widgets.dart';

class HomePageController extends ChangeNotifier {
  List<TextEditingController> _listFieldControllers =
      List<TextEditingController>();

  double _rest = 0;

  String _responseView = '';

  List<double> _response = List<double>();

  int _quantify = 0;

  double _gallon;

  List<double> _bottles = List<double>();

  String get reponseView => this._responseView;

  set responseView(String value) {
    this._responseView = value;
    notifyListeners();
  }

  double get rest => this._rest;

  set rest(double rest) => this._rest = rest;

  List<double> get response => this._response;

  double get gallon => this._gallon;

  set gallon(double value) => this._gallon = value;

  List<double> get bottles => this._bottles;

  List<TextEditingController> get listFieldControllers =>
      this._listFieldControllers;

  get quantify => this._quantify;

  addFieldController() {
    listFieldControllers.add(TextEditingController());
    addQuantify();
    printControllers();
    notifyListeners();
  }

  addQuantify() {
    this._quantify++;
  }

  printControllers() {
    print("Tamanho ${listFieldControllers.length}");
  }

  setBottles() {
    bottles.clear();
    for (var controller in listFieldControllers) {
      bottles.add(double.parse(controller.value.text));
    }
    printBottles();
  }

  printBottles() {
    for (var x in bottles) {
      print("Garrafa $x");
    }
  }

  sortSmallToLarger() {
    bottles.sort((a, b) {
      if (a < b)
        return 1;
      else if (b == a)
        return 0;
      else
        return -1;
    });
  }

  createListNotUtility(int lastPosition, List<double> notUtility) {
    for (int i = bottles.length - 1; i > lastPosition; i--) {
      notUtility.add(bottles[i]);
    }
  }

  verifyResponse() {
    List<double> notUtility = List<double>();
    int lastPosition = 0;
    for (int i = 0; i < bottles.length; i++) {
      if (gallon - bottles[i] >= 0) {
        gallon = gallon - bottles[i];
        response.add(bottles[i]);
        if (i == bottles.length || gallon == 0) {
          rest = 0;
          return;
        }
        lastPosition = i;
      }
    }
    createListNotUtility(lastPosition, notUtility);
    print('Tamanho not utility: ${response.length}');

    for (var value in notUtility) {
      if (gallon - value < 0) {
        print("Ta entrando");
        response.add(value);
        rest = value - gallon;
        break;
      }
    }
  }

  submit(valueGallon) {
    responseView = '';
    gallon = double.parse(valueGallon);
    setBottles();
    sortSmallToLarger();
    verifyResponse();
    print("Resposta: ");
    for (var item in response) {
      print(item);
    }
    print("Resto: $rest");
    print('Tamanho response: ${response.length}');
    createStringResponse();
    notifyListeners();
  }

  createStringResponse() {
    for (int i = 0; i < response.length; i++) {
      if (i == response.length - 1) {
        this._responseView += '${response[i]}';
      } else {
        this._responseView += '${response[i]}, ';
      }
    }
  }
}
