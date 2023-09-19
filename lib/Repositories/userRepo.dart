import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';

final auth = FirebaseAuth.instance;
final fireStore = FirebaseFirestore.instance;

CollectionReference userCollection =
    fireStore.collection("users");
Map<String, dynamic> userData = {};
User? currentUser = auth.currentUser;


signUp(
    {required String email,
    required String password,
    required String username}) async {
  try {

    UserCredential userCredential = await auth.createUserWithEmailAndPassword(
        email: email, password: password);
    String? userUID = userCredential.user?.uid;
    await userCollection
        .doc(userUID)
        .set({"username": username, "password": password, "email": email});

    return true;
  } catch (e) {
    print(e);
    String error = e.toString();
    if (error
        .contains("The email address is already in use by another account")) {
      await Fluttertoast.showToast(
          msg: "The email address is already in use by another account",
          timeInSecForIosWeb: 3,
          fontSize: 20);
    }
    if (error.contains("The email address is badly formatted")) {
      await Fluttertoast.showToast(
          msg: "The email address is in bad format", fontSize: 20);
    }
    if (error.contains("Password should be at least 6 characters")) {
      await Fluttertoast.showToast(
          msg: "Password should be at least 6 characters",
          fontSize: 20,
          timeInSecForIosWeb: 3);
    }
    
    return false;

  }
}

login({required String email, required String password}) async {
  try {
    var user =
        await auth.signInWithEmailAndPassword(email: email, password: password);
    return true;
    //
  } catch (e) {
    print(e);
    String error = e.toString();
    if (error.contains(
        "There is no user record corresponding to this identifier. The user may have been deleted.")) {
      await Fluttertoast.showToast(msg: "Incorrect email");
    }

    if (error.contains(
        "The password is invalid or the user does not have a password.")) {
      await Fluttertoast.showToast(msg: "Incorrect password");
    }
    return false;
  }
}

void signOut() {
  auth.signOut();
}




bool? gotData;

fetchUserData() async {
  if (currentUser != null){
    String? userUid = currentUser?.uid;
    final snapshot = await fireStore.collection("users").doc(userUid).get();
    if (snapshot.exists) {
      userData = snapshot.data()!;
      gotData=true;
      return userData;
    }
  }
}


 updateUserData(String? username ,String? email)async{
   if (currentUser != null){
     String userUid = currentUser!.uid;
     await fireStore.collection("users").doc(userUid).update({
       "username":username,"email":email
     }).whenComplete(() =>  Fluttertoast.showToast(msg: "Your profile has been updated"));   }

 }

