import 'dart:io';

import 'package:flutter/material.dart';
import 'package:meal_system_management/custom_widgets/rounded_widgets.dart';
import 'package:meal_system_management/pages/member_pages/login_pages.dart';
import 'package:meal_system_management/pages/meal_pages/meal_history_details.dart';
import 'package:provider/provider.dart';
import '../all_preference.dart';
import '../model/member_model.dart';
import '../provider/add_member_provider.dart';
import '../static_design.dart';
import 'cost_pages/cost_details_page.dart';
import 'meal_pages/meal_details_pages.dart';
import 'member_pages/add_members_pages.dart';

class HomePage extends StatefulWidget {
  static const String routeName = '/home';
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //when get at the first provider class object
  // late DetailsCostProvider provider;
  //
  // @override
  // void didChangeDependencies() {
  //   provider=Provider.of(context);
  //
  //   super.didChangeDependencies();
  // }
  late final MemberInfo? _person;
  @override
  void didChangeDependencies() {
    _person = ModalRoute.of(context)!.settings.arguments as MemberInfo;
    print('${_person!.id!}');
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }
  int _selectedIndex = 0;
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    if (_selectedIndex == 0) {
    } else if (_selectedIndex == 1) {
      Navigator.pushNamed(context, MealHistoryPage.routeName);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: ListTile(
          leading: _person!.image == null
              ? CircleAvatar(
            radius: 25.0,
            child: ClipRRect(
                borderRadius:
                BorderRadius.circular(25),
                child: Image.asset(
                    'images/login_place_holder.png')),
          )
              : CircleAvatar(
            radius: 25,
            backgroundImage:
            FileImage(File(_person!.image!)),
          ),
          title: _person?.name != null
              ? Text(_person!.name)
              : const Text('Person Name!'),
          subtitle: _person?.membertype != null
              ? Text(_person!.membertype!)
              : const Text('_personType.membertype!'),
        ),

        // actions: [
        //   PopupMenuButton(
        //       itemBuilder: (context) => [
        //         PopupMenuItem(
        //             onTap: () {
        //               setLoginStatus(false).then((value) =>
        //                   Navigator.pushReplacementNamed(
        //                       context, LoginManagerPage.routeName));
        //             },
        //             child: const Text('Logout'))
        //       ])
        // ],

        actions: [
          _person!.id==null
              ? TextButton(
                  onPressed: _login,
                  child: const Text(
                    'Login',
                    style: textColorWhite,
                  ))
              : TextButton(
                  onPressed: _logout,
                  child: const Text(
                    'Logout',
                    style: textColorWhite,
                  )),
          if(_person !.membertype=='Manager')TextButton(
              onPressed: _cost,
              child: const Text(
                'Cost',
                style: textColorWhite,
              ))
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 1.0,
        clipBehavior: Clip.antiAlias,
        child: Container(
          height: kBottomNavigationBarHeight,
          child: Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              border: Border(
                top: BorderSide(
                  color: Colors.grey,
                  width: 0.5,
                ),
              ),
            ),
             child: BottomNavigationBar(
                  currentIndex: _selectedIndex,
                  backgroundColor: Colors.deepPurpleAccent,
                  selectedItemColor: Colors.white,
                  onTap: _onItemTapped,
                  items: const [
                    BottomNavigationBarItem(
                        icon: Icon(Icons.home), label: 'Home'),
                    BottomNavigationBarItem(
                        icon: Icon(Icons.history), label: 'History')
                  ]
              ),

          ),
        ),
      ),
      body: Container(
        margin: EdgeInsets.only(left: 5, right: 5),
        height: double.maxFinite,
        width: double.maxFinite,
        child: SingleChildScrollView(
          child: Column(
            //mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListTile(
                // contentPadding:
                //     EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
                leading: Container(
                  padding: EdgeInsets.only(right: 12.0),
                  decoration:  new BoxDecoration(
                      border: new Border(
                          right:
                             new BorderSide(width: 1.0, color: Colors.green))),
                  child: const Icon(Icons.home, color: Colors.redAccent),
                ),
                title: Text(
                  "Mess Name",
                  style: TextStyle(
                      color: Colors.blueAccent, fontWeight: FontWeight.bold),
                ),
                trailing: Padding(
                  padding: const EdgeInsets.only(right: 70),
                  child: Text('Date of running month'),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  //borderRadius: EdgeInsets.only()
                ),
                width: double.maxFinite,
                height: MediaQuery.of(context).size.height * 0.25,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      ListTile(
                        // contentPadding:
                        //     EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
                        leading: Container(
                          padding: EdgeInsets.only(right: 12.0),
                          decoration: new BoxDecoration(
                              border: new Border(
                                  right: new BorderSide(
                                      width: 1.0, color: Colors.green))),
                          child: Icon(Icons.wallet, color: Colors.redAccent),
                        ),
                        title: Text(
                          "Mess Balance",
                          style: TextStyle(
                              color: Colors.blueAccent,
                              fontWeight: FontWeight.bold),
                        ),
                        trailing: Padding(
                          padding: const EdgeInsets.only(right: 70),
                          child: Text('112 Taka'),
                        ),
                      ),
                      ListTile(
                        // contentPadding:
                        //     EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
                        leading: Container(
                          padding: EdgeInsets.only(right: 12.0),
                          decoration: new BoxDecoration(
                              border: new Border(
                                  right: new BorderSide(
                                      width: 1.0, color: Colors.green))),
                          child: Icon(Icons.wallet_giftcard,
                              color: Colors.redAccent),
                        ),
                        title: Text(
                          "Total Deposit",
                          style: TextStyle(
                              color: Colors.blueAccent,
                              fontWeight: FontWeight.bold),
                        ),
                        trailing: Padding(
                          padding: const EdgeInsets.only(right: 70),
                          child: Text('112 Taka'),
                        ),
                      ),
                      ListTile(
                        // contentPadding:
                        //     EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
                        leading: Container(
                          padding: EdgeInsets.only(right: 12.0),
                          decoration: const BoxDecoration(
                              border:  Border(
                                  right:  BorderSide(
                                      width: 1.0, color: Colors.green))),
                          child: Icon(Icons.set_meal, color: Colors.redAccent),
                        ),
                        title: Text(
                          "Mess Meal Cost",
                          style: TextStyle(
                              color: Colors.blueAccent,
                              fontWeight: FontWeight.bold),
                        ),
                        trailing: Padding(
                          padding: const EdgeInsets.only(right: 70),
                          child: Text('112 Taka'),
                        ),
                      ),
                      ListTile(
                        // contentPadding:
                        //     EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
                        leading: Container(
                          padding: EdgeInsets.only(right: 12.0),
                          decoration: const BoxDecoration(
                              border: Border(
                                  right:  BorderSide(
                                      width: 1.0, color: Colors.green))),
                          child: Icon(Icons.equalizer, color: Colors.redAccent),
                        ),
                        title: Text(
                          "Mess Total Meal",
                          style: TextStyle(
                              color: Colors.blueAccent,
                              fontWeight: FontWeight.bold),
                        ),
                        trailing: Padding(
                          padding: const EdgeInsets.only(right: 70),
                          child: Text('112 Taka'),
                        ),
                      ),
                      ListTile(
                        // contentPadding:
                        //     EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
                        leading: Container(
                          padding: EdgeInsets.only(right: 12.0),
                          decoration: const BoxDecoration(
                              border: Border(
                                  right: BorderSide(
                                      width: 1.0, color: Colors.green))),
                          child:
                              Icon(Icons.rate_review, color: Colors.redAccent),
                        ),
                        title: Text(
                          "Mess Meal Rate",
                          style: TextStyle(
                              color: Colors.blueAccent,
                              fontWeight: FontWeight.bold),
                        ),
                        trailing: Padding(
                          padding: const EdgeInsets.only(right: 70),
                          child: Text('112 Taka'),
                        ),
                      ),
                      ListTile(
                        // contentPadding:
                        //     EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
                        leading: Container(
                          padding: EdgeInsets.only(right: 12.0),
                          decoration: new BoxDecoration(
                              border: new Border(
                                  right: new BorderSide(
                                      width: 1.0, color: Colors.green))),
                          child:
                              Icon(Icons.attach_money, color: Colors.redAccent),
                        ),
                        title: Text(
                          "Other Cost per head",
                          style: TextStyle(
                              color: Colors.blueAccent,
                              fontWeight: FontWeight.bold),
                        ),
                        trailing: Padding(
                          padding: const EdgeInsets.only(right: 70),
                          child: Text('112 Taka'),
                        ),
                      ),
                      ListTile(
                        // contentPadding:
                        //     EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
                        leading: Container(
                          padding: EdgeInsets.only(right: 12.0),
                          decoration: new BoxDecoration(
                              border: new Border(
                                  right: new BorderSide(
                                      width: 1.0, color: Colors.green))),
                          child: Icon(Icons.attach_money_outlined,
                              color: Colors.redAccent),
                        ),
                        title: Text(
                          "Total Other Cost",
                          style: TextStyle(
                              color: Colors.blueAccent,
                              fontWeight: FontWeight.bold),
                        ),
                        trailing: Padding(
                          padding: const EdgeInsets.only(right: 70),
                          child: Text('112 Taka'),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              SizedBox(
                height: 20,
              ),
              Card(
                elevation: 8,
                margin: EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 10.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
                child: Container(
                  padding: EdgeInsets.all(8),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Personal Information',
                        style: TextStyle(
                            color: Colors.blue,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          RoundedInfo(value: 56, valueName: 'My Meal'),
                          RoundedInfo(value: 56, valueName: 'My Deposit'),
                          RoundedInfo(value: 56, valueName: 'My Cost'),
                          RoundedInfo(value: 56, valueName: 'My Balance'),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Consumer<AddMemberProvider>(
                builder: (context, provider, _) => Container(
                  height: 300,
                  child: ListView.builder(
                      itemCount: provider.allMembers.length,
                      itemBuilder: (context, index) => ListTile(
                            title: Text(provider.allMembers[index].name),
                            subtitle: Column(
                              children: [
                                Row(
                                  children: [
                                    Text('Meal number = 10'),
                                    SizedBox(
                                      width: 20,
                                    ),
                                    Text('Deposite = 150')
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text('Total Cost = 10'),
                                    SizedBox(
                                      width: 20,
                                    ),
                                    Text('Balance = 150')
                                  ],
                                )
                              ],
                            ),
                            trailing: (_person!.membertype =='Manager') ?InkWell(
                              splashColor: Colors.red, // inkwell color
                              child: const SizedBox(
                                width: 40,
                                height: 40,
                                child: Icon(
                                  Icons.edit,
                                  color: Colors.purpleAccent,
                                  size: 25,
                                ),
                              ),
                              onTap: () {
                                Navigator.pushNamed(
                                    context, MemberMealDetailsPage.routeName,
                                    arguments: provider.allMembers[index].name);
                              },
                            ):Text(''),
                          )),
                ),
              )
            ],
          ),
        ),

      ),
      floatingActionButtonLocation:
      FloatingActionButtonLocation.miniCenterDocked,
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(3.0),
        child: FloatingActionButton(
          onPressed: () {
            String person = 'Member';
            Navigator.pushNamed(context, AddMemberPage.routeName, arguments: person);
          },
          child: Icon(Icons.add),
          tooltip: 'Add new Contact',
        ),
      ),
    );
  }

  void _login() {
    Navigator.pushNamed(context, LoginManagerPage.routeName);
  }

  void _cost() {
    Navigator.pushNamed(context, CostDetailsPage.routeName);
  }

  void _logout() {
    //Navigator.pushNamed(context, LoginManagerPage.routeName);
    setLoginStatus(false).then((value) =>
                          Navigator.pushReplacementNamed(
                              context, LoginManagerPage.routeName));
  }
}
