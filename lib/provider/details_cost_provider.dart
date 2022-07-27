import 'package:flutter/material.dart';
import 'package:meal_system_management/db_helper/main_database.dart';
import '../model/cost_details_model.dart';

class DetailsCostProvider extends ChangeNotifier {
  List<CostDetails> allCostMembers = [];

  Future<bool>allCostDetails(CostDetails costDetails) async {
    final rowId = await DBHelper.insertCostData(costDetails);
    if (rowId > 0) {
      costDetails.id = rowId;
      allCostMembers.add(costDetails);
      notifyListeners();
      return true;
    }
    return false;
  }

  getAllCost() async {
    allCostMembers = await DBHelper.getAllCostDetails();
    notifyListeners();
  }
  Future<int> updateCostDetails(int id, int bazarcost, int othercost) async {
    final rowId = await DBHelper.updateCost(id, bazarcost, othercost);

    if (rowId > 0) {
      //contactList[index].favourite = !contactList[index].favourite;
      allCostMembers[id-1].bazarcost = bazarcost;
      allCostMembers[id-1].othercost = othercost;
      notifyListeners();
      // return rowId;

    }
    return rowId;
    //notifyListeners();
  }
}
