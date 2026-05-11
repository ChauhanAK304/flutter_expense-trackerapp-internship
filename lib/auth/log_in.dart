import 'package:expense_tracker/provider/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:expense_tracker/auth/forgot_password.dart';
import 'package:expense_tracker/auth/sign_up.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final formKey = GlobalKey<FormState>();
   bool isLoading = false;
   bool isPasswordVisible = true;

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AuthProvider1>(context);
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text(
            "Log In",
            style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.only(left: 15, right: 15, top: 10),
          child: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  SizedBox(
                      height: 200,
                      width: 240,
                      child: Image.asset(
                        "assets/images/forgot_icon.png",
                      )),
                  const SizedBox(
                    height: 16,
                  ),

                      // TextField For Email
                  TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Enter Your Email";
                      } else {
                        return null;
                      }
                    },
                    style: const TextStyle(
                        fontSize: 23, fontWeight: FontWeight.w500),
                    controller: provider.getEmailController,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.grey.shade400,
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(
                                color: Colors.white, width: 2)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(
                                color: Colors.indigo, width: 2)),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide:
                                const BorderSide(color: Colors.red, width: 2)),
                        prefixIcon: Icon(
                          Icons.email_sharp,
                          size: 35,
                          color: Colors.indigo.shade500,
                        ),
                        hintText: "Email Address",
                        hintStyle: const TextStyle(
                            fontSize: 23, color: Colors.black54)),
                  ),
                  const SizedBox(
                    height: 12,
                  ),

                   // Text Field For Password
                  TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Enter Your Password";
                      } else {
                        return null;
                      }
                    },
                    style: const TextStyle(
                        fontSize: 23, fontWeight: FontWeight.w500),
                    controller: provider.getPasswordController,
                    obscureText: provider.isPasswordVisible1,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.grey.shade400,
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(
                                color: Colors.white, width: 2)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(
                                color: Colors.indigo, width: 2)),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide:
                                const BorderSide(color: Colors.red, width: 2)),
                        prefixIcon: Icon(
                          Icons.lock,
                          size: 35,
                          color: Colors.indigo.shade500,
                        ),
                        hintText: "Password",
                        hintStyle: const TextStyle(
                            fontSize: 23, color: Colors.black54),
                        suffixIcon: IconButton(
                            onPressed: () {
                              provider.toggleVisibility();
                            },
                            icon: Icon(
                               provider.isPasswordVisible1
                                    ? Icons.visibility_off
                                    : Icons.remove_red_eye,
                                color: Colors.black45,
                                size: 35))),
                  ),
                  const SizedBox(
                    height: 6,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                          onPressed: () {
                            Get.to(() => ForgotPasswordScreen());
                          },
                          child: const Text(
                            "Forgot Password?",
                            style:
                                TextStyle(fontSize: 21, color: Colors.indigo),
                          )),
                    ],
                  ),
                  const SizedBox(
                    height: 8,
                  ),

                          // Login Button

                  SizedBox(
                      height: 50,
                      width: 380,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.indigo,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10))),
                          onPressed: () {
                            if (isLoading) return;
                            if (formKey.currentState!.validate()) {
                              setState(() => isLoading = true);

                              provider.logIn();

                            }
                          },
                          child: isLoading
                              ? const CircularProgressIndicator(
                                  color: Colors.white,
                                )
                              : const Text(
                                  "Log In",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 30),
                                ))),
                  const SizedBox(
                    height: 10,
                  ),

                         // Or

                  const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Or",
                        style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 5,
                  ),

                        // Google Sign In Button

                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.grey.shade400,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10))),
                      onPressed: isLoading ? null : () => provider.handleGoogleSignIn(),
                      child: isLoading
                          ? const SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator())
                          : Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  "assets/images/google-logo-icon.png",
                                  height: 22,
                                  width: 22,
                                ),
                                const SizedBox(
                                  width: 20,
                                ),
                                const Text(
                                  "Sign in with Google",
                                  style: TextStyle(
                                      fontSize: 18, color: Colors.black),
                                )
                              ],
                            )),

                             const SizedBox(height: 6,),

                             // Signup Screen Button

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Don't have an account?",
                        style: TextStyle(fontSize: 18),
                      ),
                      TextButton(
                          onPressed: () {
                            Get.to(() => const SignUpScreen());
                          },
                          child: const Text("Sign Up",
                              style: TextStyle(
                                  fontSize: 20, color: Colors.indigo)))
                    ],
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
