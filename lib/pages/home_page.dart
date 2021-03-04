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

  @override
  void initState() {
    super.initState();
    _homePageController.addlistFields(itemList());
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
                    decoration: InputDecoration(
                      hintText: 'Volume do Galão',
                    ),
                  ),
                  Expanded(
                    child: ListView(
                      //shrinkWrap: true,
                      children: _homePageController.listFields,
                    ),
                  ),
                  Padding(
                      padding: EdgeInsets.symmetric(horizontal: 30.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          RaisedButton(
                            onPressed: () {
                              _homePageController.addlistFields(itemList());
                            },
                            child: Text('Adicionar Garrafa'),
                          ),
                          RaisedButton(
                            onPressed: () {},
                            child: Text('Enviar'),
                          )
                        ],
                      )),
                ],
              );
            }));
  }

  Widget itemList() {
    return Row(
      children: [
        Expanded(
            child: TextFormField(
          decoration: InputDecoration(
            hintText: 'Garrafa ${_homePageController.quantify + 1}',
          ),
        )),
      ],
    );
  }
}
