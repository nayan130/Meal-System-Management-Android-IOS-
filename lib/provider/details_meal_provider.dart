import 'package:flutter/material.dart';
import 'package:meal_system_management/model/member_meal_details_model.dart';

import '../db_helper/main_database.dart';

class DetailsMealProvider extends ChangeNotifier {
  List<MemberMealDetails> mealDetailsMember = [];

  Future<bool> addMealDetails(MemberMealDetails memberMealDetails) async {
    final rowId = await DBHelper.insertMealData(memberMealDetails);
    if (rowId > 0) {
      memberMealDetails.id = rowId;
      mealDetailsMember.add(memberMealDetails);
      notifyListeners();
      return true;
    }
    return false;
  }

  getAllDetailsMember() async {
    mealDetailsMember = await DBHelper.getAllMealMembers();
    notifyListeners();
  }
  Future<int> updateMealDetails(int id, int value) async {
    final rowId = await DBHelper.updateMeal(id, value);
    if (rowId > 0) {
      //contactList[index].favourite = !contactList[index].favourite;
      mealDetailsMember[id-1].meal = value;
      notifyListeners();
     // return rowId;

    }
    return rowId;
    //notifyListeners();
  }
  //  updateMealDetails(int id, int value) async {
  //   final rowId = await DBHelper.updateMeal(id, value);
  //   if (rowId > 0) {
  //     //contactList[index].favourite = !contactList[index].favourite;
  //     mealDetailsMember[id].meal = value;
  //     notifyListeners();
  //
  //   }}
    //return rowId;
    //notifyListeners();

}
