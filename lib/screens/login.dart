import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:whc_admin/utils/constants.dart';
import '../custom_widgets/general/app_text_field.dart';
import '../custom_widgets/general/progress_bar.dart';
import '../database/authentication.dart';

class Login extends StatelessWidget{
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    final RxBool loginButtonVisibility = true.obs;
    final RxBool progressVisibility = false.obs;
    final TextEditingController emailC = TextEditingController();
    final TextEditingController passC = TextEditingController();
    return Scaffold(
      backgroundColor: kCanvasColor,
      body: LayoutBuilder(builder: (BuildContext context, BoxConstraints constraints) {
        if (constraints.maxWidth <= constraints.maxHeight ||
            constraints.maxWidth <= 600.0) {
          return SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 300.0,
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('assets/images/logoFull.png',),
                          fit: BoxFit.fitWidth,
                      )
                  ),),
                Obx(() =>
                    Visibility(
                        visible: progressVisibility.value,
                        child: ProgressBar(width: constraints.maxWidth,))),
                Container(
                  height: MediaQuery.of(context).size.height/2,
                  margin: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: LoginFields(emailC: emailC, passC: passC, loginButtonVisibility: loginButtonVisibility, progressVisibility: progressVisibility)
                ),

              ],
            ),
          );
        }
        else{
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Obx(() =>
                    Visibility(
                        visible: progressVisibility.value,
                        child: ProgressBar(width: MediaQuery.of(context).size.width / 1.5,))),
                Card(
                  elevation: 2.0,
                  color: kWhite,
                  surfaceTintColor: kWhite,
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.zero
                  ),
                  child: SizedBox(
                    height: MediaQuery
                        .of(context)
                        .size
                        .height / 1.5,
                    width: MediaQuery
                        .of(context)
                        .size
                        .width / 1.5,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          width: MediaQuery
                              .of(context)
                              .size
                              .width / 3.8,
                          decoration: const BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage(
                                    'assets/images/logoFull.png',),
                                  fit: BoxFit.fitWidth
                              )
                          ),),
                        const VerticalDivider(width: 0.0,
                          color: kBlack,
                          thickness: 0.5,),
                        Container(
                          // height: MediaQuery.of(context).size.height/2,
                          width: MediaQuery
                              .of(context)
                              .size
                              .width / 3.0,
                          padding: const EdgeInsets.only(left: 40.0),
                          child: LoginFields(emailC: emailC, passC: passC, loginButtonVisibility: loginButtonVisibility, progressVisibility: progressVisibility)
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        }
      }
      ),
    );
  }

}

class LoginFields extends StatelessWidget{
  final Authentication _auth = Authentication();
  final TextEditingController emailC;
  final TextEditingController passC;
  RxBool loginButtonVisibility;
  RxBool progressVisibility;
  LoginFields({super.key, required this.emailC, required this.passC, required this.loginButtonVisibility, required this.progressVisibility});
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Spacer(flex: 2,),
        const Text("Admin Login", style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold
        ),),
        const Padding(padding: EdgeInsets.only(top: 30.0)),
        AppTextField(controller: emailC,
          label: 'Email',
          icon: Icons.alternate_email,
          onSubmit: (val) {
            if (val.isNotEmpty &&
                passC.text.isNotEmpty) {
              loginButtonVisibility.value = false;
              progressVisibility.value = true;
              _auth.signInWithEmailAndPassword(
                  emailC.text, passC.text)
                  .whenComplete(() {
                loginButtonVisibility.value = true;
                progressVisibility.value = false;
              });
            }
          },),
        const Padding(padding: EdgeInsets.only(top: 20.0)),
        AppTextField(controller: passC,
          label: 'Password',
          icon: Icons.password,
          obscure: true,
          onSubmit: (val) {
            if (val.isNotEmpty &&
                emailC.text.isNotEmpty) {
              loginButtonVisibility.value = false;
              progressVisibility.value = true;
              _auth.signInWithEmailAndPassword(
                  emailC.text, passC.text)
                  .whenComplete(() {
                loginButtonVisibility.value = true;
                progressVisibility.value = false;
              });
            }
          },),
        const Spacer(flex: 1,),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Obx(
                  () =>
                  Visibility(
                    visible: loginButtonVisibility.value,
                    child: ElevatedButton(onPressed: () {
                      loginButtonVisibility.value = false;
                      progressVisibility.value = true;
                      _auth.signInWithEmailAndPassword(
                          emailC.text, passC.text)
                          .whenComplete(() {
                        loginButtonVisibility.value =
                        true;
                        progressVisibility.value = false;
                      });
                    }, child: const Text("Login")),
                  ),
            ),
          ],
        ),
        const Spacer(flex: 1,),
      ],
    );
  }
  
}