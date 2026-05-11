import 'package:expense_tracker/provider/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:expense_tracker/auth/log_in.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}


class _SignUpScreenState extends State<SignUpScreen> {

  final formKey = GlobalKey<FormState>();


  bool isPasswordVisible = true;
  bool isPasswordVisible2 = true;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AuthProvider1>(context);
    return Scaffold(
        appBar: AppBar(
          centerTitle:true,
          title: const Text("Sign Up",style: TextStyle(fontSize: 35,fontWeight: FontWeight.bold),),),
        body: Padding(
          padding: const EdgeInsets.only(left: 15,right: 15,),
          child: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(children: [SizedBox(height: 190,width: 250,
                  child: Image.asset("assets/images/signup_icon.png",)),

                TextFormField(
                  validator: (value) {
                    if(value == null || value.isEmpty){
                      return "Enter your Name";
                    }else {return null;}
                  },
                  style:const TextStyle(fontSize: 23,fontWeight: FontWeight.w500),
                  controller: provider.getNameController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.grey.shade400,
                      enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12),borderSide: const BorderSide(color: Colors.white,width: 2)),

                      focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12),borderSide: const BorderSide(color: Colors.indigo,width: 2)),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12),borderSide: const BorderSide(color: Colors.red,width: 2)),
                      prefixIcon: Icon(Icons.person, size: 35,color: Colors.indigo.shade500,),
                      hintText: "Full Name",hintStyle: const TextStyle(fontSize: 23,color: Colors.black54)),),

                const SizedBox(height: 10,),

                TextFormField(
                  validator: (value) {
                    if(value == null|| value.isEmpty){return "Enter your Email";}
                    else{return null;}
                  },
                  style:const TextStyle(fontSize: 23,fontWeight: FontWeight.w500),
                  controller:provider.getEmailController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.grey.shade400,
                      enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12),borderSide: const BorderSide(color: Colors.white,width: 2)),

                      focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12),borderSide: const BorderSide(color: Colors.indigo,width: 2)),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12),borderSide: const BorderSide(color: Colors.red,width: 2)),
                      prefixIcon: Icon(Icons.email_sharp, size: 35,color: Colors.indigo.shade500,),
                      hintText: "Email Address",hintStyle: const TextStyle(fontSize: 23,color: Colors.black54)),),

                const SizedBox(height: 10,),

                TextFormField(
                  validator: (value) {
                    if(value==null || value.isEmpty){return "Enter your Password";}
                    else{return null;}
                  },

                  style:const TextStyle(fontSize: 25,fontWeight: FontWeight.w500)
                  ,controller: provider.getPasswordController,
                  obscureText: provider.isPasswordVisible1,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.grey.shade400,
                      enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12),borderSide: const BorderSide(color: Colors.white,width: 2)),

                      focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12),borderSide: const BorderSide(color: Colors.indigo,width: 2)),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12),borderSide: const BorderSide(color: Colors.red,width: 2)),
                      prefixIcon: Icon(Icons.lock, size: 35,color: Colors.indigo.shade500,),
                      hintText: "Password",
                      hintStyle: const TextStyle(fontSize: 23,color: Colors.black54),
                      suffixIcon: IconButton(onPressed: (){
                        provider.toggleVisibility();
                      }, icon:  Icon(
                          provider.isPasswordVisible1?Icons.visibility_off:Icons.remove_red_eye,color: Colors.black45,size: 35))
                  ),),
                const SizedBox(height: 10,),

                TextFormField(
                  validator: (value) {
                    if(value==null || value.isEmpty){return "Enter Your Password";}
                    if (value != provider.getPasswordController.text) {
                      return "Passwords do not match";
                    }
                    return null;

                  },
                  style:const TextStyle(fontSize: 25,fontWeight: FontWeight.w500),
                  obscureText: provider.isPasswordVisible1,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.grey.shade400,
                      enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12),borderSide: const BorderSide(color: Colors.white,width: 2)),

                      focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12),borderSide: const BorderSide(color: Colors.indigo,width: 2)),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12),borderSide: const BorderSide(color: Colors.red,width: 2)),
                      prefixIcon: Icon(Icons.lock, size: 35,color: Colors.indigo.shade500,),
                      hintText: "Confirm Password",
                      hintStyle: const TextStyle(fontSize: 23,color: Colors.black54),
                      suffixIcon: IconButton(onPressed: (){
                        provider.toggleVisibility();
                      }, icon:  Icon(
                          provider.isPasswordVisible1?Icons.visibility_off:Icons.visibility,color: Colors.black45,size: 35))
                  ),),



                const SizedBox(height: 25,),

                SizedBox(height:50,width: 380,child: ElevatedButton(
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.indigo,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
                    onPressed: () {
                      if(isLoading) return;
                      if(formKey.currentState!.validate()) {
                        provider.signUp();


                      }
                      },
                    child:  isLoading? const CircularProgressIndicator(color: Colors.white,):const Text("Sign Up",style: TextStyle(color: Colors.white,fontSize: 30),))),

                const SizedBox(
                  height: 12,
                ),


                Row(mainAxisAlignment:MainAxisAlignment.center,children: [
                  const Text("Already have an account?",style: TextStyle(fontSize: 20),),
                  TextButton(onPressed: (){Get.offAll(() => const LoginScreen());}, child: const Text("Log In",style: TextStyle(fontSize: 20,color: Colors.indigo)))
                ],),

              ],),
            ),
          ),
        ));
  }
}
