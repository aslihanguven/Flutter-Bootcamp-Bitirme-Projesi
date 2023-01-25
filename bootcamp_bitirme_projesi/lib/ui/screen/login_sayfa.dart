import 'package:bootcamp_bitirme_projesi/colors.dart';
import 'package:bootcamp_bitirme_projesi/ui/screen/signup_screen.dart';
import 'package:bootcamp_bitirme_projesi/ui/screen/yemekler_anasayfa.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../data/entity/widgets.dart';

class LoginSayfa extends StatefulWidget {
  const LoginSayfa({Key? key}) : super(key: key);

  @override
  State<LoginSayfa> createState() => _LoginSayfaState();
}

class _LoginSayfaState extends State<LoginSayfa> {
  TextEditingController _emailTextController = TextEditingController();
  TextEditingController _sifreTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(gradient: LinearGradient(colors: [
          Color(0xFFFF9966),
          Color(0xFFFF5e62),

        ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.fromLTRB(20, MediaQuery.of(context).size.height * 0.1, 20, 0),
            child: Column(
              children:<Widget> [
                SizedBox(
                  height: 100,
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 50),
                  child: Text("YUMMY !", style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold, color: Colors.white, fontFamily: "Solitreo"),),
                ),
                kullanilabilirTextField("E-Mail Adresinizi Giriniz", Icons.person_outline, false, _emailTextController ),
                SizedBox(
                  height: 30,
                ),
                kullanilabilirTextField("Şifrenizi Giriniz", Icons.lock_outline_rounded, true, _sifreTextController),
                SizedBox(height: 20,),
                forgetPassword(context),
                firebaseUIButton(context, "GİRİŞ YAP", (){
                  FirebaseAuth.instance
                      .signInWithEmailAndPassword(
                      email: _emailTextController.text,
                      password: _sifreTextController.text)
                      .then((value) {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => YemeklerAnasayfa()));
                  }).onError((error, stackTrace) {
                    print("Error ${error.toString()}");
                  });
                }),
                signUpOption()
              ],
            ),
          ),
        ),
      ),
    );
  }
  Row signUpOption() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(" Hesabın Yok Mu ?",
            style: TextStyle(color: Colors.white70)),
        GestureDetector(
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => SignUpScreen()));
          },
          child: const Text(
            " Hesap Oluştur ",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        )
      ],
    );
  }
}
Widget forgetPassword(BuildContext context) {
  return Container(
    width: MediaQuery.of(context).size.width,
    height: 35,
    alignment: Alignment.bottomRight,
    child: TextButton(
      child: const Text(
        "Şifremi Unuttum",
        style: TextStyle(color: Colors.white70),
        textAlign: TextAlign.right,
      ),
      onPressed: () => Navigator.push(
          context, MaterialPageRoute(builder: (context) => LoginSayfa())),
    ),
  );
}



