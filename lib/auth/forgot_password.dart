import 'package:expense_tracker/provider/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:expense_tracker/auth/sign_up.dart';
import 'package:provider/provider.dart';

class ForgotPasswordScreen extends StatelessWidget {
   ForgotPasswordScreen({super.key});

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {

    final provider = Provider.of<AuthProvider1>(context, listen: false);

    return Scaffold(
        appBar: AppBar(
          centerTitle:true,title: const Text("Forgot Password",style: TextStyle(fontSize: 28,fontWeight: FontWeight.bold,),),),
        body: Padding(
          padding: const EdgeInsets.only(left: 20,right: 20,top: 10),
          child: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(children: [SizedBox(height: 200,width: 260,
                  child: Image.asset("assets/images/login_icon.png",)),

                const Text("Forgot Password?",style: TextStyle(fontSize: 35,fontWeight: FontWeight.bold,color: Colors.green),),
                const SizedBox(height: 6,),
                const Text("Enter your email address to",style: TextStyle(fontSize: 20,color: Colors.orange),),
                const Text("receive a password reset link.",style: TextStyle(fontSize: 20,color: Colors.orange)),
                 const SizedBox(height: 30,),

                TextFormField(
                  validator: (value) {
                    if(value == null || value.isEmpty){
                      return "Enter Your Email";}
                    else{return null;}
                  },
                  style:const TextStyle(fontSize: 23,fontWeight: FontWeight.w500),
                  controller: provider.getEmailController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.grey.shade400,
                      enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12),borderSide: const BorderSide(color: Colors.white,width: 2)),

                      focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12),borderSide: const BorderSide(color: Colors.indigo,width: 2)),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12),borderSide: const BorderSide(color: Colors.red,width: 2)),
                      prefixIcon: Icon(Icons.email_sharp, size: 35,color: Colors.indigo.shade500,),
                      hintText: "Email Address",hintStyle: const TextStyle(fontSize: 23,color: Colors.black54)),),

                const SizedBox(height: 16,),

                SizedBox(height:60,width: 380,child:
                ElevatedButton(
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.indigo,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
                    onPressed: () {
                      if(formKey.currentState!.validate()) {
                        provider.forgot();}
                      },
                    child: const Text("Send Reset Link",style: TextStyle(color: Colors.white,fontSize: 25),))),

                const SizedBox(height: 20,),

                const Divider(thickness: 1,),
                Padding(
                  padding: const EdgeInsets.only(left: 20,right: 20),
                  child: Row(children: [const Text("Don't have an account?",style: TextStyle(fontSize: 20),),
                    TextButton(onPressed: (){Navigator.push(context,
                        MaterialPageRoute(builder: (context) => const SignUpScreen(),));}, child:
                    const Text("Sign Up",style: TextStyle(fontSize: 21,color: Colors.indigo,fontWeight: FontWeight.bold)))
                  ],),
                ),

                const Divider(thickness: 1,),
              ],),
            ),
          ),
        ));
  }
}
