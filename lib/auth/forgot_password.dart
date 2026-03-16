import 'package:expense_tracker/auth/log_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:expense_tracker/auth/sign_up.dart';
import 'package:get/get.dart';

class ForgotPasswordScreen extends StatelessWidget {
   ForgotPasswordScreen({super.key});

  final formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();

  forgot() async{
   await FirebaseAuth.instance.sendPasswordResetEmail(email: emailController.text);
   Get.offAll(const LoginScreen());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Colors.indigo.shade50,
        appBar: AppBar(backgroundColor: Colors.indigo.shade50,
          centerTitle:true,title: const Text("Forgot Password",style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),),),
        body: Padding(
          padding: const EdgeInsets.only(left: 20,right: 20,top: 20),
          child: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(children: [SizedBox(height: 200,width: 260,
                  child: Image.asset("assets/images/login_icon.png",)),

                const Text("Forgot Password?",style: TextStyle(fontSize: 35,fontWeight: FontWeight.bold),),
                const SizedBox(height: 13,),
                const Text("Enter your email address to",style: TextStyle(fontSize: 22),),
                const Text("receive a password reset link.",style: TextStyle(fontSize: 22)),
                 const SizedBox(height: 25,),

                TextFormField(
                  validator: (value) {
                    if(value == null || value.isEmpty){
                      return "Enter Your Email";}
                    else{return null;}
                  },
                  style:const TextStyle(fontSize: 23,fontWeight: FontWeight.w500),controller:emailController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10),borderSide: const BorderSide(color: Colors.white,width: 2)),

                      focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10),borderSide: const BorderSide(color: Colors.indigo,width: 2)),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10),borderSide: const BorderSide(color: Colors.red,width: 2)),
                      prefixIcon: Icon(Icons.email_sharp, size: 35,color: Colors.yellow[700],),
                      hintText: "Email Address",hintStyle: const TextStyle(fontSize: 23,color: Colors.black54)),),

                const SizedBox(height: 20,),

                SizedBox(height:50,width: 380,child:
                ElevatedButton(
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.indigo,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
                    onPressed: () {
                      if(formKey.currentState!.validate()) {
                        forgot();}
                      debugPrint("Email: ${emailController.text}");

                      debugPrint("All good");},
                    child: const Text("Send Reset Link",style: TextStyle(color: Colors.white,fontSize: 25),))),

                const SizedBox(height: 20,),

                const Divider(thickness: 1,),
                Padding(
                  padding: const EdgeInsets.only(left: 20,right: 20),
                  child: Row(children: [const Text("Don't have an account?",style: TextStyle(fontSize: 20),),
                    TextButton(onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context) => const SignUpScreen(),));}, child: const Text("Sign Up",style: TextStyle(fontSize: 20)))
                  ],),
                ),

                const Divider(thickness: 1,),
              ],),
            ),
          ),
        ));
  }
}
