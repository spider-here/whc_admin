import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import '../../../database/authentication.dart';

class DLogin extends StatelessWidget{

 final Authentication _auth = Authentication();

 final TextEditingController _emailC = TextEditingController();
 final TextEditingController _passC = TextEditingController();
 final RxBool loginButtonVisibility = true.obs;
 final RxBool progressVisibility = false.obs;

  DLogin({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Card(
            elevation: 2.0,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)
            ),
              child: SizedBox(
                height: MediaQuery.of(context).size.height/1.5,
                width: MediaQuery.of(context).size.width/1.5,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width/4,
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('assets/images/logoFull.png',),
                            fit: BoxFit.fitWidth
                          )
                        ),),
                    const VerticalDivider(),
                    SizedBox(
                      // height: MediaQuery.of(context).size.height/2,
                      width: MediaQuery.of(context).size.width/3.0,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          const Text("Admin Login", style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold
                          ),),
                          SizedBox(
                            width: 300.0,
                              child: TextField(
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
                              )),
                          SizedBox(
                              width: 300.0,
                              child: TextField(
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
                              )),
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
                        ],
                      ),
                    )
                  ],
            ),
              ),
          ),
        ),
    );
  }

}