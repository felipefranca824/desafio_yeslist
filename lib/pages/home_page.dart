import 'package:desaafio_yeslist/controllers/home_page_controller.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  HomePageController _homePageController = HomePageController();

  TextEditingController _gallonController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _homePageController.addFieldController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Desafio'),
          centerTitle: true,
          actions: [
            IconButton(icon: Icon(Icons.refresh), onPressed: (){
              _gallonController.clear();
              _homePageController.clearFields();
            }),
          ],
        ),
        body: AnimatedBuilder(
            animation: _homePageController,
            builder: (context, child) {
              return Column(
                children: [
                  TextFormField(
                    autovalidate: true,
                    onChanged: (value) {
                      _homePageController.viewBotton(value);
                    },
                    validator: (text) {
                      return _homePageController.validate(text);
                    },
                    controller: _gallonController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        labelText: 'Volume do Galão', hintText: 'Ex.: 5'),
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: _homePageController.quantify,
                      itemBuilder: (context, index) {
                        return itemList(index);
                      },
                    ),
                  ),
                  Text(
                      'Resposta: ' + _homePageController.responseView+ ' Resto: ${_homePageController.rest.toStringAsFixed(2)}',
                      style: TextStyle(
                        fontSize: 20.0,
                      ),
                      ),
                  Padding(
                      padding: EdgeInsets.symmetric(horizontal: 30.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          RaisedButton(
                            onPressed: () {
                              _homePageController.addFieldController();
                            },
                            child: Text('Adicionar Garrafa'),
                          ),
                          RaisedButton(
                            onPressed: _homePageController.isBotton
                                ? () {
                                    _homePageController
                                        .submit(_gallonController.value.text);
                                  }
                                : null,
                            child: Text('Enviar'),
                          )
                        ],
                      )),
                ],
              );
            }));
  }

  Widget itemList(int index) {
    print(index);
    return Row(
      children: [
        Expanded(
            child: TextFormField(
          autovalidate: true,
          onChanged: (value) {
            _homePageController.viewBotton(value);
          },
          validator: (text) {
            return _homePageController.validate(text);
          },
          keyboardType: TextInputType.number,
          controller: _homePageController.listFieldControllers.elementAt(index),
          decoration: InputDecoration(
            labelText: 'Garrafa ${index + 1}',
          ),
        )),
        IconButton(icon: Icon(Icons.delete), onPressed: (){
          _homePageController.deleteController(index);
        })
      ],
    );
  }
}
