import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController wheightController = TextEditingController();
  TextEditingController heightController = TextEditingController();
  String _info = "Informe os seus dados";
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void resetFields() {
    wheightController.text = "";
    heightController.text = "";
    _info = "Informe os seus dados";
    _formKey = GlobalKey<FormState>();
  }

  void calculate() {
    setState(() {
      double weight = double.parse(wheightController.text);
      double height = double.parse(heightController.text) / 100;

      double imc = weight / (height * height);

      if (imc < 18.5) {
        _info =
            "Seu imc é (${imc.toStringAsPrecision(2)}) e vc esta com peso baixo!!!";
      } else if (imc > 18.5 && imc <= 24.9) {
        _info =
            "Seu imc é (${imc.toStringAsPrecision(2)}) e seu peso eh normal!!!";
      } else if (imc > 25.0 && imc <= 29.9) {
        _info = _info =
            "Seu imc é (${imc.toStringAsPrecision(2)}) e vc tem sobrepeso!!!";
      } else if (imc > 30.0 && imc <= 34.9) {
        _info = _info =
            "Seu imc é (${imc.toStringAsPrecision(2)}) e vc tem obesidade Grau 1!!";
      } else if (imc > 35.0 && imc <= 39.9) {
        _info = _info =
            "Seu imc é (${imc.toStringAsPrecision(4)}) e vc tem obesidade Grau 2!!!";
      } else if (imc > 40.0) {
        _info = _info =
            "Seu imc é (${imc.toStringAsPrecision(4)}) e vc tem Obesidade Mórbida!!!";
      } else {
        _info = "Ocorreu um erro ao calcular";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Calculadora de IMC"),
        centerTitle: true,
        backgroundColor: Colors.green[900],
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              setState(() {
                resetFields();
              });
            },
          )
        ],
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: EdgeInsets.all(30.0),
        child: Form(
                  key: _formKey,
                  child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Icon(
                Icons.person,
                color: Colors.green[900],
                size: 120,
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    labelText: "Peso (Kg)",
                    labelStyle:
                        TextStyle(color: Colors.green[900], fontSize: 25.0)),
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.green[900], fontSize: 25.0),
                controller: wheightController,
                validator: (value){
                  if(value.isEmpty){
                    return "Informe seu peso"; 
                  }
                  return null; 
                },
                
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    labelText: "Altura (Cm)",
                    labelStyle:
                        TextStyle(color: Colors.green[900], fontSize: 25.0)),
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.green[900], fontSize: 25.0),
                controller: heightController,
                validator: (value){
                  if(value.isEmpty){
                    return "Informe a sua altura"; 
                  }
                  return null;
                },
              ),
              SizedBox(
                height: 30,
              ),
              Container(
                height: 50,
                child: RaisedButton(
                  child: Text(
                    "Calcular",
                    style: TextStyle(color: Colors.white, fontSize: 25.0),
                  ),
                  color: Colors.green[900],
                  onPressed: () {
                    if(_formKey.currentState.validate()){
                        calculate();
                    }
                    
                  },
                ),
              ),
              SizedBox(
                height: 50,
              ),
              Text(
                _info,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.green[900],
                  fontSize: 30,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
