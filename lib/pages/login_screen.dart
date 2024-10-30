import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:new_projects/custom_widgets/custom_appbar.dart';
import 'package:new_projects/custom_widgets/custom_button.dart';
import 'package:new_projects/custom_widgets/custom_first_text.dart';
import 'package:new_projects/custom_widgets/custom_form_field.dart';
import 'package:new_projects/custom_widgets/custom_row.dart';
import 'package:new_projects/pages/bottom_navbar.dart';
import 'package:new_projects/pages/register_screen.dart';
import '../firebase_auth/firebase_auth.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final formKey=GlobalKey<FormState>();
  bool obscure=true;
  final emailController=TextEditingController();
  final passwordController=TextEditingController();
  final FirebaseAuthService auth =FirebaseAuthService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(leadingIcon: IconButton(onPressed: (){
        Navigator.pop(context);
      }, icon: Icon(Icons.arrow_back))),
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Column(
            children: [
              CustomFirstText(title: 'Login Here',
                  subTitle: 'Welcome to the our my\nLogin Screen'),
              SizedBox(height: 80,),
              CustomTextField(hintText: 'Enter Email', labelText:'Email',controller: emailController,),
              SizedBox(height: 10,),
              CustomTextField(hintText: 'Enter Password', labelText: 'Password',
              controller: passwordController,
              keyBoardType: TextInputType.number,obscureText: obscure,
                  onTap: () {
                    setState(() {
                      obscure=!obscure;
                    });
                  },
                  suffixIcon:obscure==true?Icon(Icons.visibility_off):Icon(Icons.visibility)),
              Padding(
                padding: const EdgeInsets.all(7),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Text('Forget Your Password',style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.indigo,
                    fontSize: 23
                  ),),
                ),
              ),
              SizedBox(height: 80,),
              CustomButton(title: 'Login',onTap: () {
                if(formKey.currentState!.validate()){
                 signIn();
                }

              },),
              SizedBox(height: 20,),
              CustomRow(firstText: 'Do not have Account?',
                secondText:'Register Now',onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => RegisterScreen(),));
              },)
            ],
          ),
        ),
      ),
    );
  }
  void signIn() async {
    String email=emailController.text;
    String password=passwordController.text;

    User ? user=await auth.signInWithEmailAndPassword(email, password);

    if(user!=null){
      Fluttertoast.showToast(msg: 'Login Successfully',
          backgroundColor: Colors.indigo,textColor: Colors.white);
      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => BottomNavbar(),),(route) => false,);
    }else{
      print('Some Happened ERROR');
    }
  }
}
