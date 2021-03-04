import 'package:desaafio_yeslist/controllers/home_page_controller.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key, this.title}) : super(key: key);

  final String title;

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
        ),
        body: AnimatedBuilder(
            animation: _homePageController,
            builder: (context, child) {
              return Column(
                children: [
                  TextFormField(
                    controller: _gallonController,
                    decoration: InputDecoration(
                      hintText: 'Volume do Galão',
                    ),
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
                    'Resposta: ${_homePageController.response} Resto: ${_homePageController.rest}'
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
                            onPressed: () {
                              _homePageController.submit(_gallonController.value.text);
                            },
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
              controller: _homePageController.listFieldControllers.elementAt(index),
          decoration: InputDecoration(
            hintText: 'Garrafa ${index + 1}',
          ),
        )),
      ],
    );
  }
}
