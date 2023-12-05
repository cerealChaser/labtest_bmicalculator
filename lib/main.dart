/*
* Written by MACAUREL NOEL MAK RAYMUND
* MATRIC NUM: B032110139
* */

import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:labtest_bmicalculator/user.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Text Input Example',
        home: MyHomePage()
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<User> users = [];
   TextEditingController _nameFieldController = TextEditingController();
   TextEditingController _heightFieldController = TextEditingController();
   TextEditingController _weightFieldController= TextEditingController();
   TextEditingController _bmiFieldController = TextEditingController();
   TextEditingController _bmiStatusController = TextEditingController();
  double _bmiValue=0;
  String _gender="";
  String _bmiStatus="";

  void _onSubmit() async{
    String name = _nameFieldController.text;
    double height = double.parse(_heightFieldController.text);
    double weight = double.parse(_weightFieldController.text);
    _bmiValue = weight/pow(height/100, 2);

    if (_gender == "male"){
      if (_bmiValue < 18.5){
        print ("Underweight");
        _bmiStatus = "Underweight";
      }
      if (_bmiValue >= 18.5 && _bmiValue <= 24.9){
        print ("Ideal");
        _bmiStatus = "Ideal";
      }
      if (_bmiValue >= 25.0 && _bmiValue <= 29.9){
        print ("Overweight");
        _bmiStatus = "Overweight";
      }
      if (_bmiValue > 30.0){
        print ("Obese");
        _bmiStatus = "Overweight";
      }
    }

    else if (_gender == "female"){
      if (_bmiValue < 16){
        print ("Underweight");
        _bmiStatus = "Underweight";
      }
      if (_bmiValue >= 16 && _bmiValue <= 22){
        print ("Ideal");
        _bmiStatus = "Ideal";
      }
      if (_bmiValue >= 22 && _bmiValue <= 27){
        print ("Overweight");
        _bmiStatus = "Overweight";
      }
      if (_bmiValue > 27){
        print ("Obese");
        _bmiStatus = "Overweight";
      }
    }

    print ('Text Field 1: $name');
    print ('Text Field 2: $height');
    print ('Text Field 3: $weight');
    print ('BMI VALUE: $_bmiValue' );

    _bmiStatusController.text = _bmiStatus;

    User user = User(name,weight, height, _gender, _bmiStatus);
    if (await user.save()){
      setState(() {
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async{
      List<User> result = await User.loadAll();
      int lastIndex = result.length - 1;
      _nameFieldController.text = result[lastIndex].name;
      _heightFieldController.text = result[lastIndex].height.toString();
      _weightFieldController.text = result[lastIndex].weight.toString();
      _bmiStatusController.text = result[lastIndex].bmi_status;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('BMI Calculator'),
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          children: <Widget> [
            TextField(
              controller: _nameFieldController,
              decoration: InputDecoration(labelText: 'Your Fullname'),
            ),
            TextField(
              controller: _heightFieldController,
              decoration: InputDecoration(labelText: 'height in cm; 170'),
            ),
            TextField(
              controller: _weightFieldController,
              decoration: InputDecoration(labelText: 'Weight in KG'),
            ),
            TextField(
              controller: _bmiFieldController,
              readOnly: true,
              decoration: InputDecoration(labelText: 'BMI Value', border: InputBorder.none),
            ),

            RadioListTile<String>(
              title: Text('Male'),
              value: 'male',
              groupValue: _gender,
              onChanged: (value){
                setState(() {
                  _gender = value!;
                });
              },
            ),
            RadioListTile<String>(
              title: Text('Female'),
              value: 'female',
              groupValue: _gender,
              onChanged: (value){
                setState(() {
                  _gender = value!;
                });
              },
            ),
            SizedBox(height: 20.00),
            ElevatedButton(
                onPressed: _onSubmit,
                child: Text('Calculate BMI and Save')
            ),
            Center(
              child: Column(
                children: <Widget>[
                  Text(
                    _bmiStatus,
                    style: TextStyle(fontSize: 16),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }


}
