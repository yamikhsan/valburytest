import 'package:flutter/material.dart';
import 'package:future_progress_dialog/future_progress_dialog.dart';
import 'package:valburytestapp/constants.dart';

class AuthentationView extends StatefulWidget {
  const AuthentationView({Key? key}) : super(key: key);

  @override
  _AuthentationViewState createState() => _AuthentationViewState();
}

class _AuthentationViewState extends State<AuthentationView> {

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }

  Future getFuture() {
    return Future(() async {
      await Future.delayed(Duration(seconds: 2));
      return Navigator.pushNamedAndRemoveUntil(context, NavigationViewRouter, (route) => false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      top: false,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text(
            'Register or Login',
            style: TextStyle(color: Colors.black),
          ),
          backgroundColor: Colors.white,
        ),
        body: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFormField(
                  validator: validatePhone,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  decoration: InputDecoration(
                    hintText: 'Phone',
                  ),
                  keyboardType: TextInputType.phone,
                ),
                TextFormField(
                  validator: validateEmail,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  decoration: InputDecoration(
                      hintText: 'Email'
                  ),
                  keyboardType: TextInputType.emailAddress,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(minimumSize: Size(double.infinity, 46)),
                    onPressed: onPressed,
                    child: const Text('Submit'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String? validatePhone(String? value){
    String pattern = r'^(?:[+0]9)?[0-9]{1,10}$';
    String message = 'Input max 10 char and number only';
    return validateForm(value, pattern, message);
  }

  String? validateEmail(String? value){
    String pattern = r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
    String message = 'Input with email format';
    return validateForm(value, pattern, message);
  }

  String? validateForm(String? value, String pattern, String message){
    RegExp regExp = new RegExp(pattern);
    if (value == null || value.isEmpty) {
      return 'Please enter some text';
    }else if(!regExp.hasMatch(value)){
      return message;
    }
    return null;
  }

  void onPressed(){
    if (_formKey.currentState!.validate()) {
      showDialog(context: context, builder: (context) {
        return WillPopScope(
            child: FutureProgressDialog(
                getFuture(),
                message: Text('Loading...')
            ),
            onWillPop: () async => false
        );
      });
    }
  }

}
