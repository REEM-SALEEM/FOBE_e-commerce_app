
import 'package:finalproject/app/core/const.dart';
import 'package:finalproject/app/login/sign_in/provider/sign_in_prov.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/sign_up_prov.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: const Color.fromARGB(255, 245, 240, 240),
      body: SingleChildScrollView(
        child: Consumer<SignUp>(
          builder: (BuildContext context, value, Widget? child) {
            return Form(
              key: value.formkey,
              child: Column(
                children: [
                  iHeight70,
                  const Padding(
                    padding: EdgeInsets.fromLTRB(0, 0, 250, 10),
                    child: Text('Sign Up',
                        style: TextStyle(
                            fontWeight: FontWeight.w900, fontSize: 28)),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(18, 10, 18, 10),
                    child: TextFormField(
                      controller: value.fullname,
                      decoration: const InputDecoration(
                        hintText: "  Fullname",
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.black, width: 1.5),
                          borderRadius: BorderRadius.all(Radius.circular(40)),
                        ),
                        hintStyle: TextStyle(color: Colors.grey),
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(40))),
                      ),
                      validator: (valuee) => value.usernameValidation(valuee),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(18, 10, 18, 10),
                    child: TextFormField(
                      controller: value.email,
                      decoration: const InputDecoration(
                        hintText: "  Email",
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.black, width: 1.5),
                          borderRadius: BorderRadius.all(Radius.circular(40)),
                        ),
                        hintStyle: TextStyle(color: Colors.grey),
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(40))),
                      ),
                      validator: (valuee) => value.emailValidation(valuee),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(18, 10, 18, 10),
                    child: TextFormField(
                      controller: value.phone,
                      decoration: const InputDecoration(
                        hintText: "  Mobile Number",
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.black, width: 1.5),
                          borderRadius: BorderRadius.all(Radius.circular(40)),
                        ),
                        hintStyle: TextStyle(color: Colors.grey),
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(40))),
                      ),
                      validator: (valuee) => value.phoneValidation(valuee),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(18, 10, 18, 10),
                    child: Consumer<SignUp>(
                      builder: (BuildContext context, value, Widget? child) {
                        return TextFormField(
                          controller: value.password,
                          obscureText: value.isobscure,
                          decoration: const InputDecoration(
                            // suffixIcon: IconButton(
                            //     onPressed: () {
                            //       value.visibility();
                            //     },
                            //     icon: value.icon),
                            hintText: "  Password",
                            focusedBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: kBlackcolor, width: 1.5),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(40)),
                            ),
                            hintStyle: TextStyle(color: Colors.grey),
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(40))),
                          ),
                          validator: (valuee) =>
                              value.passwordValidation(valuee),
                        );
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(18, 10, 18, 25),
                    child: Consumer<SignIn>(
                      builder: (BuildContext context, value1, Widget? child) {
                        return TextFormField(
                          controller: value.confirmpassword,
                          obscureText: value1.isobscure,
                          decoration: const InputDecoration(
                            hintText: "  Confirm Password",
                            // suffixIcon: IconButton(
                            //     onPressed: () {
                            //       value1.visibility();
                            //     },
                            //     icon: value1.icon),
                            focusedBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: kBlackcolor, width: 1.5),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(40)),
                            ),
                            hintStyle: TextStyle(color: kActualGrey),
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(40))),
                          ),
                          validator: (valuee) =>
                              value.passwordValidation(valuee!),
                        );
                      },
                    ),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      foregroundColor: kWhitecolor,
                      backgroundColor: kBlackcolor,
                      disabledForegroundColor: kActualGrey,
                      elevation: 20,
                      minimumSize: const Size(350, 60),
                      shadowColor: Colors.blueGrey,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30)),
                    ),
                    onPressed: () {
                      Provider.of<SignUp>(context, listen: false)
                          .signupUser(context);
                    },
                    child: const Text('Sign up'),
                  ),
                  iHeight17,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Already have an account?"),
                      TextButton(
                          onPressed: () {
                            Provider.of<SignUp>(context, listen: false)
                                .clearTextfield();
                            Navigator.of(context).pop();
                          },
                          child: const Text('Sign up',
                              style:
                                  TextStyle(color: kBlackcolor, fontSize: 15)))
                    ],
                  )
                ],
              ),
            );
          },
        ),
      ),
    ));
  }
}
