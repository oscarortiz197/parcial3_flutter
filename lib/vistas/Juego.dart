import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class juego extends StatefulWidget {
  Map<String, dynamic> datos = {};
  juego({Key? key, required this.datos}) : super(key: key);

  @override
  State<juego> createState() => _juegoState();
}

class _juegoState extends State<juego> {
   
  bool _estado = false;
  List<dynamic> id = [];
  Map<String, dynamic> _Datosjuego = {};
  @override
  void initState() {
    id.add(widget.datos['id'].toString());
    _cargardata();
    super.initState();
  }

  _cargardata() async {
    var _url = Uri.https("www.freetogame.com", "/api/game", {'id': id});
    var _respuesta = await http.get(_url);
    if (_respuesta.statusCode == 200) {
      _Datosjuego = jsonDecode(_respuesta.body);
      
      print(_Datosjuego);
    }
    setState(() {
      _estado = true;
    });
  }
  
  
     

  @override
  Widget build(BuildContext context) {
    if (_estado) {
      return DefaultTabController(
          length: 2,
          child: Scaffold(
            appBar: AppBar(
              title: Text(widget.datos['title']),
            ),
            body: SafeArea(
              child: Column(
                children: [
                  
                  
                  const TabBar(
                    tabs: [
                      Tab(text: "Descripcion"),
                      Tab(
                        text: "Imagenes",
                      )
                    ],
                  ),
                  Expanded(
                    child: TabBarView(
                      children: [
                        descripcion(
                            texto: _Datosjuego['description'].toString(),img: _Datosjuego['thumbnail'].toString(),),
                        requerimientos(
                          imgs: _Datosjuego['screenshots'],
                        )
                      ],
                    ),
                  ),
                  Row(
                    //crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      IconButton(onPressed: (){}, icon: Icon(Icons.download)),
                      IconButton(onPressed: (){}, icon: Icon(Icons.link)),
                      IconButton(onPressed: (){}, icon: Icon(Icons.games))
                    ],
                  )
                ],
              ),
            ),
          )
          );
          
    } else {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

  }

}

class descripcion extends StatelessWidget {
  String texto;
  String img;
  descripcion({Key? key, required this.texto,required this.img}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
                    height: 150,
                    child: CachedNetworkImage(
                       imageUrl: this.img,
                    ),
          ),
          Container(
            margin: EdgeInsets.all(25),
            child: Text(this.texto),
          ),
          
        ],
      ),
    );
  }
}

class requerimientos extends StatelessWidget {
  List  imgs;

  requerimientos({Key? key, required this.imgs}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return ListView.builder(
      itemBuilder: (context, index) => 
          Container(
            margin: EdgeInsets.all(15),
                      height: 150,
                      child: CachedNetworkImage(
                        placeholder: (context, url) => const CircularProgressIndicator(),
                         imageUrl: this.imgs[index]['image'],
                         
                        // child: Text("hola"),
                      ),
            ),
            itemCount: imgs.length,
    );
  }
}
