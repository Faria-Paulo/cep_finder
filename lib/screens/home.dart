import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String inputcep = '';
  String? resultadoLog;
  String? resultadoBai;
  String? resultadoCid;
  String? resultadoUf;
  String? resultadoCEP;
  bool _isVisible = false;

  _consultarCep() async {
    String url = "https://viacep.com.br/ws/$inputcep/json/";

    http.Response response;

    response = await http.get(Uri.parse(url));

    final Map<String, dynamic> retorno = json.decode(response.body);

    String cep = retorno["cep"];
    String logradouro = retorno["logradouro"];
    String cidade = retorno["localidade"];
    String bairro = retorno["bairro"];
    String uf = retorno["uf"];

    setState(() {
      resultadoCEP = cep;
      resultadoLog = logradouro;
      resultadoBai = bairro;
      resultadoCid = cidade;
      resultadoUf = uf;
      _isVisible = true;
    });
  }


   _abrirGoogleMaps() async {
    String url = "https://www.google.com/maps/search/$inputcep";
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      throw 'Could not launch Maps';
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        //Scaffold = barra superior dos apps
        appBar: AppBar(
          title: Text(
            "CEP FINDER",
              style: GoogleFonts.kanit(
                textStyle: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold ,
                  color: Colors.blue[900],
                ),)
          ),
          centerTitle: true,
          backgroundColor: Colors.yellowAccent,
          actions: <Widget>[
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.refresh),
            )
          ],
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(10.0, 0, 10.0, 0),
          child: Form(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Icon(
                  Icons.location_on,
                  size: 120.0,
                  color: Colors.blue[900],
                ),
                TextFormField(
                  onChanged: (text) {
                    inputcep = text;
                  },
                  textAlign: TextAlign.center,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      labelText: "DIGITE UM CEP",
                      labelStyle:  TextStyle(color: Colors.blue[900])),
                  style: GoogleFonts.kanit(
                    textStyle:TextStyle(
                    color: Colors.blue[900],
                    fontSize: 26.0,
                  )),
                ),
                    Padding(
                        padding: const EdgeInsets.only(top: 20.0, bottom: 20.0),
                        child: SizedBox(
                          height: 50.0,
                          child: ElevatedButton(
                            onPressed: _consultarCep,
                            child: Text('PESQUISAR' ,
                            style: GoogleFonts.kanit(
                              textStyle: TextStyle(
                                fontSize: 25,
                                color: Colors.blue[900],
                              ),
                            )),
                          ),
                        ),
                    ),
                Visibility(
                  visible: _isVisible,
                  child:
                  Text(
                      "CEP: $resultadoCEP",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.kanit(
                        textStyle: TextStyle(
                          fontSize: 25,
                          color: Colors.blue[900],
                        ),)
                  ),
                ),
                Visibility(
                  visible: _isVisible,
                  child:
                  Text(
                    "LOGRADOURO: $resultadoLog",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.kanit(
                      textStyle: TextStyle(
                        fontSize: 25,
                        color: Colors.blue[900],
                        ),)
                  ),
                ),
                Visibility(
                  visible: _isVisible,
                  child:
                  Text(
                    "BAIRRO: $resultadoBai",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.kanit(
                        textStyle: TextStyle(
                          fontSize: 25,
                          color: Colors.blue[900],
                        ),)
                  ),
                ),
                Visibility(
                  visible: _isVisible,
                  child:
                  Text(
                    "CIDADE: $resultadoCid",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.kanit(
                        textStyle: TextStyle(
                          fontSize: 25,
                          color: Colors.blue[900],
                        ),)
                  ),
                ),
                Visibility(
                  visible: _isVisible,
                  child:
                  Text(
                    "UF: $resultadoUf",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.kanit(
                        textStyle: TextStyle(
                          fontSize: 25,
                          color: Colors.blue[900],
                        ),)
                  ),
                ),


                  //dificuldades para funcionar no mobile, via  chrome funciona

                /*Visibility(
                  visible: _isVisible,
                  child:
                  Padding(
                      padding: const EdgeInsets.only(top: 20.0, bottom: 20.0),
                      child: SizedBox(
                        height: 50.0,
                        child: ElevatedButton(
                          onPressed: _abrirGoogleMaps,
                          child: Text('VER NO GOOGLE MAPS' ,
                              style: GoogleFonts.kanit(
                                textStyle: TextStyle(
                                  fontSize: 25,
                                  color: Colors.blue[900],
                                ),
                              )),
                        ),
                      )),
                ),*/
              ],
            ),
          ),
        ));
  }
}
