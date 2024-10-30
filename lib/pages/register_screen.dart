import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:new_projects/custom_widgets/custom_appbar.dart';
import 'package:new_projects/custom_widgets/custom_button.dart';
import 'package:new_projects/custom_widgets/custom_first_text.dart';
import 'package:new_projects/custom_widgets/custom_form_field.dart';
import 'package:new_projects/custom_widgets/custom_row.dart';
import 'package:new_projects/pages/login_screen.dart';

import '../firebase_auth/firebase_auth.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final formKey=GlobalKey<FormState>();
  bool obscure=true;
  final emailController=TextEditingController();
  final passwordController=TextEditingController();
  final conformPasswordController=TextEditingController();
  final FirebaseAuthService auth =FirebaseAuthService();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    conformPasswordController.dispose();
    super.dispose();
  }

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
              CustomFirstText(title: 'Register Here', subTitle: 'Now go to Register screen and \n Register now'),
              SizedBox(height: 80,),
              CustomTextField(hintText: 'Enter Email',
                  labelText: 'Email',controller: emailController,),
              SizedBox(height: 12,),
              CustomTextField(hintText: 'Enter Password',controller: passwordController,
                labelText: 'Password',
              keyBoardType: TextInputType.number,
              obscureText: obscure,
              onTap: () {
                setState(() {
                  obscure=!obscure;
                });
              },
              suffixIcon:obscure==true?Icon(Icons.visibility_off):Icon(Icons.visibility),),
              SizedBox(height: 12,),
              CustomTextField(hintText: 'Enter Conform Password',
                labelText: 'Conform Password',
                controller: conformPasswordController,
                keyBoardType: TextInputType.number,
                obscureText: true,),
              SizedBox(height: 30,),

              CustomButton(title: 'Register Now',onTap: () {
                if (formKey.currentState!.validate()){
                  signUpIn();
                  FirebaseFirestore.instance.collection('Users').doc(emailController.text).set({
                    'Email':emailController.text,
                    'Password':passwordController.text
                  });
                }
                },),

              SizedBox(height: 20,),
              CustomRow(firstText: 'Already have an account',
                secondText: 'Login Now',onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen(),));
              },)
            ],
          ),
        ),
      ),
    );
  }
  void signUpIn() async {
   String email=emailController.text;
   String password=passwordController.text;
   String conformPassword=conformPasswordController.text;

    User ? user=await auth.signUpWithEmailAndPassword(email, password);

    if(user!=null){
     Fluttertoast.showToast(msg: 'Register Successfully',
        backgroundColor: Colors.indigo,textColor: Colors.white);
     Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen(),));
    }else{
     print('Wrong');
    }
  }
}
