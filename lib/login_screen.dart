import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rive/rive.dart';
import 'package:rive_bear_login/animation_enum.dart';
import 'package:rive_bear_login/login_controller.dart';
import 'package:rive_bear_login/theme/custom_textField.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  final String validEmail = "ahmad@gmail.com";
  final String validPassword = "12345";

  @override
  Widget build(BuildContext context) {
    Rx<RiveAssets> select = bottomNav.first.obs;
    LoginController loginController = Get.put(LoginController());
    StateMachineController? controller;
    StateMachineController? stateMachineController;

    return Scaffold(
      backgroundColor: const Color(0xFFD6E2EA),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1C3E66),
        title: const Text("Rive Animation"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              width: 300.0,
              height: 300.0,
              child: RiveAnimation.asset(
                "assets/images/bear.riv",
                fit: BoxFit.cover,
                stateMachines: const ["Login Machine"],
                onInit: (p0) {
                  controller = StateMachineController.fromArtboard(
                    p0,
                    "Login Machine",
                  );
                  if (controller == null) {
                    return;
                  } else {
                    p0.addController(controller!);
                    loginController.isChecking =
                        controller?.findInput(Enum.isChecking.name);
                    loginController.numLook =
                        controller?.findInput(Enum.numLook.name);
                    loginController.isHandsUp =
                        controller?.findInput(Enum.isHandsUp.name);
                    loginController.trigSuccess =
                        controller?.findInput(Enum.trigSuccess.name);
                    loginController.trigFail =
                        controller?.findInput(Enum.trigFail.name);
                  }
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  children: [
                    CustomTextField(
                      focusNode: loginController.emailFocusNode,
                      size: MediaQuery.of(context).size,
                      function: (value) {
                        loginController.email = value;
                        loginController.numLook
                            ?.change(value.length.toDouble() * 4);
                      },
                      hintText: "Email",
                      prefix: Icons.email,
                      type: TextInputType.emailAddress,
                      validator: (value) {},
                    ),
                    CustomTextField(
                      obscureText: true,
                      focusNode: loginController.passwordFocusNode,
                      size: MediaQuery.of(context).size,
                      function: (value) {
                        loginController.password = value;
                      },
                      hintText: "Password",
                      prefix: Icons.key,
                      suffix: IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.visibility,
                          color: Colors.grey,
                        ),
                      ),
                      type: TextInputType.emailAddress,
                      validator: (value) {},
                    ),
                    const SizedBox(
                      height: 32,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: 60,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF1C3E66),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                        onPressed: () async {
                          loginController.emailFocusNode.unfocus();
                          loginController.passwordFocusNode.unfocus();
                          await Future.delayed(
                            const Duration(milliseconds: 100),
                          );
                          if (loginController.email == validEmail &&
                              loginController.password == validPassword) {
                            loginController.trigSuccess?.change(true);
                          } else {
                            loginController.trigFail?.change(true);
                          }
                        },
                        child: const Text(
                          "Login",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 140.0,
            ),
/////////////////////////////////////////////////////////////////////////////////////////////////
            Container(
              padding: const EdgeInsets.all(
                12.0,
              ),
              margin: const EdgeInsets.symmetric(
                horizontal: 20.0,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(
                  24.0,
                ),
                color: const Color(0xFF11253d),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ...List.generate(
                    bottomNav.length,
                    (index) => InkWell(
                      onTap: () async {
                        select.value = bottomNav[index];
                        bottomNav[index].input?.change(true);
                        await Future.delayed(
                          const Duration(milliseconds: 1000),
                        );
                        bottomNav[index].input?.change(false);
                      },
                      child: Column(
                        children: [
                          Obx(
                            () => Container(
                              height: 3.0,
                              width: 20.0,
                              decoration: bottomNav[index] == select.value
                                  ? BoxDecoration(
                                      color: const Color(0xFF8e9fb3),
                                      borderRadius: BorderRadius.circular(
                                        20.0,
                                      ),
                                    )
                                  : null,
                            ),
                          ),
                          SizedBox(
                            height: 35.0,
                            width: 35.0,
                            child: Obx(
                              () => Opacity(
                                opacity:
                                    bottomNav[index] == select.value ? 1 : 0.5,
                                child: RiveAnimation.asset(
                                  "assets/images/icon.riv",
                                  artboard: bottomNav[index].artBoard,
                                  stateMachines: [
                                    bottomNav[index].stateMachineName
                                  ],
                                  onInit: (p0) {
                                    stateMachineController =
                                        StateMachineController.fromArtboard(
                                      p0,
                                      bottomNav[index].stateMachineName,
                                    );
                                    if (stateMachineController == null) {
                                      return;
                                    } else {
                                      p0.addController(stateMachineController!);
                                      bottomNav[index].input =
                                          stateMachineController
                                              ?.findSMI("active") as SMIBool;
                                    }
                                  },
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class RiveAssets {
  final String artBoard, stateMachineName, title;
  late SMIBool? input;

  RiveAssets({
    required this.title,
    required this.artBoard,
    required this.stateMachineName,
    this.input,
  });

  set setInput(SMIBool status) {
    input = status;
  }
}

List<RiveAssets> bottomNav = [
  RiveAssets(
      artBoard: "CHAT", stateMachineName: "CHAT_Interactivity", title: "CHAT"),
  RiveAssets(
      artBoard: "TIMER",
      stateMachineName: "TIMER_Interactivity",
      title: "TIMER"),
  RiveAssets(
      artBoard: "USER", stateMachineName: "USER_Interactivity", title: "USER"),
  RiveAssets(
      artBoard: "SEARCH",
      stateMachineName: "SEARCH_Interactivity",
      title: "SEARCH"),
  RiveAssets(
      artBoard: "BELL", stateMachineName: "BELL_Interactivity", title: "BELL"),
];
