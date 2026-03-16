import 'package:expense_tracker/auth/wrapper_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:expense_tracker/auth/log_in.dart';
import 'package:get/get.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}


class _SignUpScreenState extends State<SignUpScreen> {

  final formKey = GlobalKey<FormState>();

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();


  signUp() async{

    await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text);
    Get.offAll(const WrapperScreen());
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Colors.indigo.shade50,
        appBar: AppBar(backgroundColor: Colors.indigo.shade50,
          centerTitle:true,
          title: const Text("Sign Up",style: TextStyle(fontSize: 35,fontWeight: FontWeight.bold),),),
        body: Padding(
          padding: const EdgeInsets.only(left: 20,right: 20,),
          child: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(children: [SizedBox(height: 200,width: 260,
                  child: Image.asset("assets/images/signup_icon.png",)),

                TextFormField(
                  validator: (value) {
                    if(value == null || value.isEmpty){
                      return "Enter your Name";
                    }else {return null;}
                  },
                  style:const TextStyle(fontSize: 23,fontWeight: FontWeight.w500),
                  controller:nameController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10),borderSide: const BorderSide(color: Colors.white,width: 2)),

                      focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10),borderSide: const BorderSide(color: Colors.indigo,width: 2)),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10),borderSide: const BorderSide(color: Colors.red,width: 2)),
                      prefixIcon: Icon(Icons.person, size: 35,color: Colors.indigo.shade500,),
                      hintText: "Full Name",hintStyle: const TextStyle(fontSize: 23,color: Colors.black54)),),

                const SizedBox(height: 10,),

                TextFormField(
                  validator: (value) {
                    if(value == null|| value.isEmpty){return "Enter your Email";}
                    else{return null;}
                  },
                  style:const TextStyle(fontSize: 23,fontWeight: FontWeight.w500),
                  controller:emailController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10),borderSide: const BorderSide(color: Colors.white,width: 2)),

                      focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10),borderSide: const BorderSide(color: Colors.indigo,width: 2)),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10),borderSide: const BorderSide(color: Colors.red,width: 2)),
                      prefixIcon: Icon(Icons.email_sharp, size: 35,color: Colors.indigo.shade500,),
                      hintText: "Email Address",hintStyle: const TextStyle(fontSize: 23,color: Colors.black54)),),

                const SizedBox(height: 10,),

                TextFormField(
                  validator: (value) {
                    if(value==null || value.isEmpty){return "Enter your Password";}
                    else{return null;}
                  },

                  style:const TextStyle(fontSize: 25,fontWeight: FontWeight.w500)
                  ,controller: passwordController,
                  obscureText:true,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10),borderSide: const BorderSide(color: Colors.white,width: 2)),

                      focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10),borderSide: const BorderSide(color: Colors.indigo,width: 2)),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10),borderSide: const BorderSide(color: Colors.red,width: 2)),
                      prefixIcon: Icon(Icons.lock, size: 35,color: Colors.indigo.shade500,),
                      hintText: "Password",
                      hintStyle: const TextStyle(fontSize: 23,color: Colors.black54),
                      suffixIcon: IconButton(onPressed: (){}, icon: const Icon(Icons.remove_red_eye,color: Colors.black45,size: 35))
                  ),),
                const SizedBox(height: 10,),

                TextFormField(
                  validator: (value) {
                    if(value==null || value.isEmpty){return "Enter Your Password";}
                    if (value != passwordController.text) {
                      return "Passwords do not match";
                    }
                    return null;

                  },
                  style:const TextStyle(fontSize: 25,fontWeight: FontWeight.w500),
                  obscureText:true,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10),borderSide: const BorderSide(color: Colors.white,width: 2)),

                      focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10),borderSide: const BorderSide(color: Colors.indigo,width: 2)),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10),borderSide: const BorderSide(color: Colors.red,width: 2)),
                      prefixIcon: Icon(Icons.lock, size: 35,color: Colors.indigo.shade500,),
                      hintText: "Confirm Password",
                      hintStyle: const TextStyle(fontSize: 23,color: Colors.black54),
                      suffixIcon: IconButton(onPressed: (){}, icon: const Icon(Icons.remove_red_eye,color: Colors.black45,size: 35))
                  ),),



                const SizedBox(height: 25,),

                SizedBox(height:50,width: 380,child: ElevatedButton(
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.indigo,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
                    onPressed: () {
                      if(formKey.currentState!.validate()){
                        signUp();}

                      debugPrint("Name: ${nameController.text}");
                      debugPrint("Email: ${emailController.text}");
                      debugPrint("Password: ${passwordController.text}");},
                    child: const Text("Sign Up",style: TextStyle(color: Colors.white,fontSize: 30),))),

                const SizedBox(height: 20,),

                const Divider(thickness: 1,height: 10,),
                Padding(
                  padding: const EdgeInsets.only(left: 20,right: 20),
                  child: Row(children: [const Text("Already have an account?",style: TextStyle(fontSize: 20),),
                    TextButton(onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context) => const LoginScreen(),));}, child: const Text("Log In",style: TextStyle(fontSize: 20)))
                  ],),
                ),

                const Divider(thickness: 1,height: 10,),
              ],),
            ),
          ),
        ));
  }
}
