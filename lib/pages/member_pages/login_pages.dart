import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../db_helper/main_database.dart';
import '../../model/member_model.dart';
import '../guest_home_page.dart';
import '../home_page.dart';
import 'add_members_pages.dart';

class LoginManagerPage extends StatefulWidget {
  static const String routeName = '/login';
  const LoginManagerPage({Key? key}) : super(key: key);

  @override
  State<LoginManagerPage> createState() => _LoginManagerPageState();
}

class _LoginManagerPageState extends State<LoginManagerPage> {
  late bool _passwordVisible = false;
  String _radioSelected = '';
  final _userPasswordController = TextEditingController();
  final _userPhoneController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  final Future<SharedPreferences> _pref = SharedPreferences.getInstance();
  Future setStatusPoint(MemberInfo memberInfo) async {
    final SharedPreferences sp = await _pref;
    sp.setString('id', memberInfo.id.toString());
    sp.setString('password', memberInfo.password);
    sp.setString('phone', memberInfo.phone);
    sp.setString('membertype', memberInfo.membertype!);
    sp.setString('name', memberInfo.name);
  }

  @override
  void dispose() {
    _userPasswordController.dispose();
    _userPhoneController.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('Meal Management'),
      ),
      body: Stack(
        children: [
          Image.asset(
            'images/bg_login6.jpg',
            height: double.maxFinite,
            width: double.maxFinite,
            fit: BoxFit.cover,
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: SingleChildScrollView(
                child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      CircleAvatar(
                        radius: 60.0,
                        child: ClipRRect(
                          child: Image.asset('images/login_place_holder.png'),
                          borderRadius: BorderRadius.circular(60.0),
                        ),
                      ),
                      // Image.asset(
                      //   'images/login_place_holder.png',
                      //   height: 100,
                      //   width: 100,
                      //   fit: BoxFit.cover,
                      // ),
                      SizedBox(height: 12.0),
                      Text(
                        _radioSelected + ' Login',
                        style: const TextStyle(
                          color: Colors.redAccent,
                          fontSize: 30,
                          //fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 12.0),
                      TextFormField(
                        controller: _userPhoneController,
                        keyboardType: TextInputType.number,
                        autofocus: false,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          icon: Icon(Icons.phone),
                          labelText: 'Mobile Number',
                          hintText: 'Enter your Mobile Number',
                          contentPadding:
                              EdgeInsets.fromLTRB(20.0, 12.0, 20.0, 12.0),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter mobile Number ';
                          }
                          if (value.length != 11) {
                            return 'Please enter your valid 11 digit mobile Number ';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 12.0),
                      TextFormField(
                        keyboardType: TextInputType.text,
                        controller: _userPasswordController,
                        obscureText: !_passwordVisible,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter your Password ';
                          }
                          if (value.length <= 5) {
                            return 'Please enter at least six digit password  ';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          border: const OutlineInputBorder(),
                          icon: const Icon(Icons.lock),
                          contentPadding:
                              const EdgeInsets.fromLTRB(20.0, 12.0, 20.0, 12.0),
                          labelText: 'Password',
                          hintText: 'Enter your password',
                          // Here is key idea
                          suffixIcon: IconButton(
                            icon: Icon(
                              _passwordVisible
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: Theme.of(context).primaryColorDark,
                            ),
                            onPressed: () {
                              setState(() {
                                _passwordVisible = !_passwordVisible;
                              });
                            },
                          ),
                        ),
                      ),
                      const SizedBox(height: 24.0),
                      InkWell(
                        onTap: _loginMembers,
                        child: Container(
                          height: 50,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Color(0xffff3333),
                          ),
                          child: const Center(
                            child: Text(
                              'Log In',
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white,
                                  fontSize: 18),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Radio(
                            value: 'Manager',
                            groupValue: _radioSelected,
                            activeColor: Colors.blue,
                            onChanged: (value) {
                              setState(() {
                                _radioSelected = value as String;
                              });
                            },
                          ),
                          Text('Manager'),
                          SizedBox(
                            height: 10,
                          ),
                          Radio(
                            value: 'Member',
                            groupValue: _radioSelected,
                            activeColor: Colors.pink,
                            onChanged: (value) {
                              setState(() {
                                _radioSelected = value as String;
                              });
                            },
                          ),
                          Text('Member'),
                        ],
                      ),

                      const SizedBox(
                        height: 25,
                      ),
                      TextButton(
                          onPressed: () {
                            // Navigator.pushNamed(
                            //     context, MemberMealDetailsPage.routeName);
                          },
                          child: const Text(
                            'Forgot Your Password?',
                            style: TextStyle(
                                color: Colors.blueAccent, fontSize: 18),
                          )),
                      const SizedBox(
                        height: 25,
                      ),
                      TextButton(
                        onPressed: () {
                          if (_radioSelected == '') {
                            setState(() {
                              showDialog<String>(
                                context: context,
                                builder: (BuildContext context) => AlertDialog(
                                  title: const Text('Select Any'),
                                  content:
                                      const Text('Select Manager or Member'),
                                  actions: <Widget>[
                                    TextButton(
                                      onPressed: () =>
                                          Navigator.pop(context, 'OK'),
                                      child: const Text('OK'),
                                    ),
                                  ],
                                ),
                              );
                            });
                          } else {
                            Navigator.pushNamed(
                                context, AddMemberPage.routeName,
                                arguments: _radioSelected);
                          }
                        },
                        child: const Text(
                          "New User? Create Account",
                          style: TextStyle(
                            color: Colors.blueAccent,
                            fontSize: 19,
                          ),
                        ),
                      ),
                      TextButton(
                          onPressed: () {
                            Navigator.pushNamed(context, GuestHomePage.routeName);
                          },
                          child: const Text(
                            'Guest Mode',
                            style: TextStyle(
                                color: Colors.blueAccent, fontSize: 18),
                          )),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _loginMembers() async {
    if (formKey.currentState!.validate()) {

    await DBHelper.getLoginMembers(_userPhoneController.text, _userPasswordController.text)
        .then((memberData) {
      print('Login Successfully!');
      // print('Mobile:${neederNumber}');
      // print('Password:${neederPassword}');
      if (memberData != null) {
        setStatusPoint(memberData).whenComplete(() {
          print('Login Successfully!');
          Navigator.pushNamed(context, HomePage.routeName,arguments: memberData);

          // Navigator.pushAndRemoveUntil(context,
          //     MaterialPageRoute(builder: (_) => HomePage()), (route) => false);
        });
      } else {
        print("Not Found!");
      }
    }).catchError((error) {
      print(error);
      print("Number or Password Incorrect!");
    });

    }

  }
}
