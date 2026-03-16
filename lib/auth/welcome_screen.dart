import 'package:flutter/material.dart';
import 'package:expense_tracker/auth/log_in.dart';
import 'package:expense_tracker/auth/sign_up.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Colors.indigo.shade50,
      appBar: AppBar(backgroundColor: Colors.indigo.shade50,
      centerTitle: true,
      title: const Text("Welcome!",style: TextStyle(fontSize: 35),),),
     body: Padding(
       padding: const EdgeInsets.symmetric(horizontal: 20),
       child: Column(
         children: [

           SizedBox(height: 215,width: 260,child:
         Image.asset('assets/images/welcome_icon.png',)),

         const Text("Track Your",style: TextStyle(fontSize: 28),),
             const Text("Expenses Easily",style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),),
             const SizedBox( height: 13,),
             const Text("Take control of your finances by",style: TextStyle(fontSize: 16,color: Colors.black54,fontWeight: FontWeight.w700),),
             const Text("tracking your expenses",style: TextStyle(fontSize: 16,color: Colors.black54,fontWeight: FontWeight.w700),),
             const Text("and incomes effortlessly.",style: TextStyle(fontSize: 16,color: Colors.black54,fontWeight: FontWeight.w700),),

             const SizedBox(height: 30,),

             SizedBox(height: 50,width: 350,child:
             ElevatedButton(style: ElevatedButton.styleFrom(backgroundColor: Colors.indigo,shape:
             RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context) => const SignUpScreen(),));}, child:
             const Text("Get Started",style: TextStyle(fontSize: 25,color: Colors.white,),))),

             const SizedBox(height: 18,),

             SizedBox(height: 50,width: 350,child:
             ElevatedButton(style: ElevatedButton.styleFrom(backgroundColor: Colors.white,shape:
             RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context) => const LoginScreen(),));}, child:
             const Text("Log in",style: TextStyle(fontSize: 25,),))),

           const SizedBox(height: 35,),

         const Divider(thickness: 1,height: 10,),
           
           Padding(
             padding: const EdgeInsets.only(left: 20,right: 20),
             child: Row(children: [const Text("Don't have an account?",style: TextStyle(fontSize: 20),),
             TextButton(onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context) => const SignUpScreen(),));}, child: const Text("Sign Up",style: TextStyle(fontSize: 20)))
             ],),
           ),

           const Divider(thickness: 1,height: 10,),

         ],),
     ),
    );
  }
}
