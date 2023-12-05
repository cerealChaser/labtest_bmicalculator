/*
* Written by MACAUREL NOEL MAK RAYMUND
* MATRIC NUM: B032110139
* */
import 'package:labtest_bmicalculator/sqlite_db.dart';

class User{
  static const String SQLiteTable = "bmi";
  String name;
  double weight;
  double height;
  String gender;
  String bmi_status;

  User(this.name, this.weight, this.height, this.gender, this.bmi_status);

  User.fromJson(Map<String, dynamic> json):
        name = json['username'] as String,
        weight=(json['weight'] as num).toDouble(),
        height=(json['height'] as num).toDouble(),
        gender= json['gender'] as String,
        bmi_status = json['bmi_status'] as String;

  Map<String, dynamic> toJson() => {
    "username": name, "weight": weight.toString(), "height": height.toString(), "gender":
    gender, "bmi_status": bmi_status
  };

  Future<bool> save() async {
    if(await SQLiteDB().insert(SQLiteTable, toJson())!=0){
      return true;
    }
    else {
      return false;
    }
  }

  static Future<List<User>> loadAll() async{
    List<Map<String, dynamic>> result = await SQLiteDB().queryAll(SQLiteTable);
    List<User> users=[];

    for (var item in result){
      users.add(User.fromJson(item));
    }
    return users;
  }
}