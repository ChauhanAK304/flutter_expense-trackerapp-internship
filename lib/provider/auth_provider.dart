
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../auth/log_in.dart';
import '../screens/custom_bottomappbar.dart';

class AuthProvider1 with ChangeNotifier {

  BuildContext context;
  AuthProvider1(this.context);

  bool isLoading = false;
  bool _isPasswordVisible= true;
  bool get isPasswordVisible1 => _isPasswordVisible;

  final TextEditingController _nameController = TextEditingController();
   TextEditingController get getNameController => _nameController;
  final TextEditingController _emailController = TextEditingController();
   TextEditingController get getEmailController => _emailController;
  final TextEditingController _passwordController = TextEditingController();
   TextEditingController get getPasswordController => _passwordController;

  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseAuth _auth = FirebaseAuth.instance;








          // Google Sign-In Function

  Future<void> handleGoogleSignIn() async {
    isLoading = true; // Loading start krne k liye
    notifyListeners();

    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        isLoading = false;
        notifyListeners();
        return;
      }

      final GoogleSignInAuthentication googleAuth =
      await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Firebase login k liye
      UserCredential userCredential =
      await _auth.signInWithCredential(credential);

      if (userCredential.user != null) {

        // SUCCESS: Agle page par bhejne k liye
        Get.offAll(() => const CustomBottomAppBar());

      }
    } catch (e) {
      debugPrint("Google Sign-In Error: $e");
      Get.snackbar("Login Failed", e.toString(),
        titleText: const Text("Login Failed",style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold,color: Colors.black),),
        messageText:  Text(e.toString(),style: const TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.black),),
        snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red.shade100,
          colorText: Colors.black,
          duration: const Duration(seconds: 5),);
    } finally {
      isLoading = false; // Loading stop
      notifyListeners();
    }
  }

         // Login Function

  logIn() async {
    try {
      // 1. Sign in attempt karne k liye
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: getEmailController.text.trim(),
          password: getPasswordController.text.trim());

      getEmailController.clear();
      getPasswordController.clear();

      // 2. Success! Agle page par jane k liye
      Get.offAll(const CustomBottomAppBar());

    } on FirebaseAuthException catch (e) {
      // 3. Agar Firebase ki koi galti hai to (e.g. Wrong Password)
      debugPrint(e.code);
      debugPrint(e.message);
      Get.snackbar("Error", e.message ?? "Login Failed",
          titleText: const Text("Error",style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold,color: Colors.black),),
          messageText:  Text(e.message ??"Login Failed",style: const TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.black),),
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red.shade100,
          colorText: Colors.black,
          duration: const Duration(seconds: 5));
    } catch (e) {
      // 4. Koi aur generic error check krne k liye
      debugPrint(e as String?);
      Get.snackbar("Error", "Something went wrong",
          titleText: const Text("Error",style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold,color: Colors.black),),
          messageText:  const Text("Something Went Wrong",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.black),),
          backgroundColor: Colors.red.shade100,
          duration: const Duration(seconds: 5),
          colorText: Colors.black);
    } finally {
      // 5. Kuch bhi ho (Success ya Error), loading band karne k liye
      isLoading = false;
      notifyListeners();
    }
    debugPrint("Email: ${getEmailController.text}");
    debugPrint("Password: ${getPasswordController.text}");
    debugPrint("All good");

  }

  // SignUp Function

  Future<void> signUp() async{

    isLoading = true;
    notifyListeners();

    try {
      // 1. Sign in attempt karo
      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: getEmailController.text.trim(),
        password: getPasswordController.text.trim(),
      );
      await userCredential.user!.updateDisplayName(getNameController.text.trim());
      await FirebaseFirestore.instance.collection('users').doc(userCredential.user!.uid).set({
        'name': getNameController.text,
        'email': getEmailController.text,
        'uid': userCredential.user!.uid,
        'createdAt': DateTime.now(),
      });

      getPasswordController.clear();
      getNameController.clear();
      getEmailController.clear();

      // 2. Success! Agle page par jao
      Get.offAll(()=> const CustomBottomAppBar());
      Get.snackbar("Success", "Account Created Successfully",
          titleText: const Text("Success",style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold,color: Colors.black),),
          messageText: const Text("Account Created Successfully",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.black),),
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green.shade100,
          colorText: Colors.black,
          duration: const Duration(seconds: 5)

      );

    } on FirebaseAuthException catch (e){
      debugPrint(e.code);
      debugPrint(e.message);

      // 3. Agar Firebase ki koi galti hai (e.g. Wrong Password)
      Get.snackbar("Error", e.message ?? "Login failed",
          titleText: const Text("Error",style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold,color: Colors.black),),
          messageText: Text(e.message ??"Login Failed",style: const TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.black),),
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red.shade100,
          colorText: Colors.black,
          duration: const Duration(seconds: 10));
    }catch (e){
      // 4. Koi aur generic error
      Get.snackbar("Error", "Something went wrong",
          titleText: const Text("Success",style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold,color: Colors.black),),
          messageText: const Text("Account Created Successfully",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.black),),
          backgroundColor: Colors.red.shade100,
          colorText: Colors.black,
          duration: const Duration(seconds: 10));
    }finally{
      // 5. Kuch bhi ho (Success ya Error), loading band karo
      isLoading = false;
      notifyListeners();
    }
    debugPrint("Name: ${getNameController.text}");
    debugPrint("Email: ${getEmailController.text}");
    debugPrint("Password: ${getPasswordController.text}");

  }

  // Logout Function

  Future<void> logout() async{
    Get.defaultDialog(
      backgroundColor: Colors.red.shade100,
      radius: 20,
      title: "Logout",
      titleStyle: const TextStyle(fontSize: 25,fontWeight: FontWeight.bold,color: Colors.black),
      middleText: "Are you sure you want to logout?",
      middleTextStyle: const TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color: Colors.black),
      confirm: TextButton(onPressed: () async {

        // Home screen se bheji gayi ID ka use karke delete karne k liye
        await FirebaseAuth.instance.signOut();
        Get.back(); // Dialog band karne ke liye
        Get.offAll(()=> const LoginScreen());


        Get.snackbar("Success", "Expense Delete ",
            titleText: const Text("Success",style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold,color: Colors.black),),
            messageText: const Text("Logout Successfully",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.black),),
            snackPosition: SnackPosition.BOTTOM,
            duration: const Duration(seconds: 5),
            backgroundColor: Colors.green.shade100);

      }, child: const Text("Yes",style: TextStyle(
          fontSize: 25,
          fontWeight: FontWeight.bold,
          color: Colors.red),)),

      cancel: TextButton(onPressed: (){Get.back();},
          child: const Text("No",style: TextStyle(
              fontSize: 25,fontWeight: FontWeight.bold,
              color: Colors.black),)),

    );

    


  }

  // Forgot Function

  forgot() async{
    await FirebaseAuth.instance.sendPasswordResetEmail(email: getEmailController.text);
    Get.offAll(const LoginScreen());

    debugPrint("Email: ${getEmailController.text}");
    debugPrint("All good");
  }

  void toggleVisibility() {
    _isPasswordVisible = !_isPasswordVisible;
    notifyListeners();
  }

  void clearController (){
    _nameController;
    _passwordController;
    _emailController;
  }
}

