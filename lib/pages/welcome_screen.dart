import 'package:flutter/material.dart';
import 'package:new_projects/custom_widgets/custom_first_text.dart';
import 'package:new_projects/pages/login_screen.dart';
import 'package:new_projects/pages/register_screen.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Image.asset('images/welcome.jpg',),
          CustomFirstText(title: 'Discover Your Dream Job Here',
              subTitle: 'Go to the market for your kind information\n kind information'),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen(),));
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical:12),
                      decoration: BoxDecoration(
                        color: Colors.indigo,
                        borderRadius: BorderRadius.circular(10)
                      ),
                      child: Center(child: Text('Login',style: TextStyle(
                        color: Colors.white,
                        fontSize: 25,
                        fontWeight: FontWeight.bold
                      ),)),
                    ),
                  ),
                ),
                SizedBox(width: 10,),
                Expanded(
                  child: InkWell(
                    onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => RegisterScreen(),));
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical:12),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10)
                      ),
                      child: Center(child: Text('Register',style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 25,
                        color: Colors.black
                      ),),),
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),

    );
  }
}





