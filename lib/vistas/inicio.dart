import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:parcial3/vistas/Juego.dart';

class inicio extends StatefulWidget {
  const inicio({Key? key}) : super(key: key);

  @override
  State<inicio> createState() => _inicioState();
}

class _inicioState extends State<inicio> {
  bool estado = false;
  List<dynamic> Datos = [];
  String Mensaje = "Cargando datos";
  @override
  void initState() {
    // TODO: implement initState
    _cargardata();
    super.initState();
  }

  _cargardata() async {
    var url = Uri.https('www.freetogame.com', '/api/games');
    var respuesta = await http.get(url);
    if (respuesta.statusCode == 200) {
      Datos = await jsonDecode(respuesta.body);
      estado = true;
      //print (Datos[2]);
    } else {
      Mensaje = "Error en la coneccion con el servidor ";
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    if (estado) {
      return Scaffold(
        appBar: AppBar(
          title: Text("Api game"),
          actions: [
            Align(
              alignment: Alignment.center,
              child: Icon(
                Icons.games_rounded,
              ),
            )
          ],
        ),
        body: Center(
          child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: (() {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => juego(
                                  datos: Datos[index],
                                )));
                  }),
                  child: Card(
                    child: Column(
                      children: [
                        Expanded(
                          flex: 3,
                          child: CachedNetworkImage(
                            imageUrl: Datos[index]['thumbnail'],
                            fit: BoxFit.fitHeight,
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Container(
                            decoration: const BoxDecoration(
                                borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(7),
                                    bottomRight: Radius.circular(7)),
                                color: Color.fromARGB(82, 0, 0, 0)),
                            child: Center(
                              child: Text(Datos[index]['title']),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                );
              },
              itemCount: Datos.length),
        ),
      );
    } else {
      return Scaffold(
        body: cargando(msj: Mensaje),
      );
    }
  }
}

class cargando extends StatelessWidget {
  String msj;
  cargando({required this.msj});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Container(
        height: 150,
        child: Column(
          children: [
            const CircularProgressIndicator(),
            const SizedBox(
              height: 25,
            ),
            Text(this.msj)
          ],
        ),
      ),
    );
  }
}
