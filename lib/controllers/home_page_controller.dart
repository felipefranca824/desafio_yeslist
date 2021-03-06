import 'package:flutter/widgets.dart';

class HomePageController extends ChangeNotifier {
  List<TextEditingController> _listFieldControllers =
      List<TextEditingController>();

  double _rest = 0;

  bool _isBotton = false;

  String _responseView = '';

  List<double> _response = List<double>();

  int _quantify = 0;

  double _gallon;

  List<double> _bottles = List<double>();

  bool get isBotton => this._isBotton;

  set isBotton(bool value) => this._isBotton = value;

  String get responseView =>
      this._responseView.isEmpty ? '0.0' : this._responseView;

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

  set quantify(int value) => this._quantify = value;

  addFieldController() {
    listFieldControllers.add(TextEditingController());
    addQuantify();
    notifyListeners();
  }

  addQuantify() {
    this._quantify++;
  }


  setBottles() {
    response.clear();
    bottles.clear();
    for (var controller in listFieldControllers) {
      bottles.add(double.parse(controller.value.text));
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

  verifyRestSmaller(List<double> largers, double copyGallon){
    for (int i = 0; i < largers.length; i++) {
      if((largers[i] - copyGallon) < (copyGallon - sumValuesResponse())){
        response.clear();
        response.add(largers[i]);
        rest = largers[i] - copyGallon;
      }

    }
  }

  sumValuesResponse(){
    double sum = 0;
    response.forEach((element){
      sum += element;
    });

    return sum;
  }

  calculateRest(double copyGallon){
    double sum = sumValuesResponse();

    if(copyGallon > sum){
      rest = copyGallon - sum;
    }
    else{
      rest = 0;
    }
    
  }

  verifyResponse() {
    List<double> notUtility = List<double>();
    int lastPosition = 0;
    double copyGallon = gallon;
    List<double> largers = List<double>();
    for (int i = 0; i < bottles.length; i++) {
      if(copyGallon < bottles[i]){
          largers.add(bottles[i]);
      }
      if (gallon - bottles[i] >= 0) {
        gallon = gallon - bottles[i];
        response.add(bottles[i]);
        if (gallon == 0) {
          rest = 0;
          return;
        }
        lastPosition = i;
      }
    }
    createListNotUtility(lastPosition, notUtility);

    for (var value in notUtility) {
      if (gallon - value < 0) {
        response.add(value);
        rest = value - gallon;
        break;
      }
    }
    print("Respostasss");
    response.forEach((element) {print(element);});
    calculateRest(copyGallon);
    verifyRestSmaller(largers, copyGallon);
  }

  deleteController(int index) {
    quantify--;
    listFieldControllers.removeAt(index);
    notifyListeners();
  }

  submit(valueGallon) {
    responseView = '';
    gallon = double.parse(valueGallon);
    setBottles();
    sortSmallToLarger();
    bottles.forEach((element) {print(element);});
    verifyResponse();
    response.forEach((element) {print('Resposta:$element');});
    createStringResponse();
    print(this._responseView);
    notifyListeners();
  }

  createStringResponse() {
    for (int i = 0; i < response.length; i++) {
      if (i == response.length - 1) {
        print('response: ${response[i]}');
        this._responseView = this._responseView + '${response[i]}';
      } else {
        print('response: ${response[i]}');
        this._responseView = this._responseView + '${response[i]}, ';
      }
    }
  }

  validate(String text) {
    Pattern pattern = r"^[+-]?[0-9]*\.?[0-9]*$";

    RegExp regex = RegExp(pattern);

    if (regex.hasMatch(text) && text.isNotEmpty) {
      return null;
    } else {
      return 'Digite um número válido, utilize . (ponto) para decimal';
    }
  }

  clearFields() {
    quantify = 0;
    listFieldControllers.clear();
    notifyListeners();
  }

  viewBotton(String text) {
    if (validate(text) == null) {
      if(quantify > 0){
        isBotton = true;
        notifyListeners();
      } else {
        isBotton = false;
        notifyListeners();
      }
      
    } else {
        isBotton = false;
        notifyListeners();
    }
  }
}
