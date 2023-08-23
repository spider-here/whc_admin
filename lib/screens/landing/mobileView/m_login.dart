import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../database/authentication.dart';
import '../../../utils/constants.dart';

class MLogin extends StatelessWidget{

  final Authentication _auth = Authentication();
  final TextEditingController _emailC = TextEditingController();
  final TextEditingController _passC = TextEditingController();
  final RxBool loginButtonVisibility = true.obs;
  final RxBool progressVisibility = false.obs;

  MLogin({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kWhite,
      body: SingleChildScrollView(
        child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  height: MediaQuery.of(context).size.height/2,
                  margin: const EdgeInsets.all(25.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [const Text("Admin Login", style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold
                    ),),
                     TextField(
                       controller: _emailC,
                            decoration: const InputDecoration(
                                labelText: "Email",
                            ),
                       onSubmitted: (val){
                         if(val.isNotEmpty && _passC.text.isNotEmpty){
                           loginButtonVisibility.value = false;
                           progressVisibility.value = true;
                           _auth.signInWithEmailAndPassword(_emailC.text, _passC.text).whenComplete(()
                           {loginButtonVisibility.value = true;
                           progressVisibility.value = false;});
                         }
                       },
                          ),
                     TextField(
                       controller: _passC,
                            obscureText: true,
                            decoration: const InputDecoration(
                              labelText: "Password",
                            ),
                       onSubmitted: (val){
                         if(val.isNotEmpty && _emailC.text.isNotEmpty){
                           loginButtonVisibility.value = false;
                           progressVisibility.value = true;
                           _auth.signInWithEmailAndPassword(_emailC.text, _passC.text).whenComplete(()
                           {loginButtonVisibility.value = true;
                           progressVisibility.value = false;});
                         }
                       },
                          ),
                      Obx(
                        ()=> Visibility(
                          visible: loginButtonVisibility.value,
                          child: ElevatedButton(onPressed: (){
                            loginButtonVisibility.value = false;
                            progressVisibility.value = true;
                            _auth.signInWithEmailAndPassword(_emailC.text, _passC.text).whenComplete(()
                             {loginButtonVisibility.value = true;
                                progressVisibility.value = false;});
                          }, child: const Text("Login")),
                        ),
                      ),
                      Obx(() => Visibility(
                        visible: progressVisibility.value,
                          child: const CircularProgressIndicator())),
                    ]
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 300.0,
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('assets/images/logoFull.png',),
                          fit: BoxFit.fitWidth
                      )
                  ),),
              ],
            ),
      ),
    );
  }
  
}