import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final TextEditingController _emailController = TextEditingController();
  String userEmail = '';
  void resetEmail() {
    setState(() {
      userEmail = '';
      _emailController.clear();
    });
  }

  final _authentication = FirebaseAuth.instance;

  Future<void> resetPassword() async {
    try {
      if (userEmail.isNotEmpty) {
        await _authentication.sendPasswordResetEmail(email: userEmail);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              '비밀번호 재설정 이메일이 발송되었습니다. \n이메일이 없을 경우 스팸메일함을 확인해 주세요.',
              textAlign: TextAlign.center,
              //style: TextStyle(fontSize: 20),
            ),
          ),
        );
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              '계정이 존재하지 않습니다. \n올바른 이메일을 입력해 주세요.',
              textAlign: TextAlign.center,
            ),
          ),
        );
      } else if (e.code == 'invalid-email') {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              '올바르지 않은 이메일 형식입니다. \n올바른 이메일을 입력해 주세요.',
              textAlign: TextAlign.center,
            ),
          ),
        );
      }
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('비밀번호 찾기'),
        centerTitle: true,
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Container(
          padding: EdgeInsets.only(
            top: MediaQuery.of(context).size.height / 6,
            right: MediaQuery.of(context).size.width / 14,
            left: MediaQuery.of(context).size.width / 14,
          ),
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/images/gradient.jpg'),
                  fit: BoxFit.fill)),
          child: Column(
            children: [
              TextFormField(
                controller: _emailController,
                cursorColor: Colors.grey,
                onSaved: (value) {
                  userEmail = value!;
                },
                onChanged: (value) {
                  userEmail = value;
                },
                decoration: InputDecoration(
                    hintText: '이메일을 입력해 주세요.',
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    prefixIcon: const Icon(
                      Icons.email,
                      color: Colors.black,
                    ),
                    suffixIcon: IconButton(
                      color: Colors.black,
                      onPressed: () {
                        setState(() {
                          resetEmail();
                        });
                      },
                      icon: const Icon(Icons.clear),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    )),
                textAlign: TextAlign.justify,
              ),
              const SizedBox(
                height: 15,
              ),
              ElevatedButton(
                onPressed: () async {
                  FocusScope.of(context).unfocus();

                  await resetPassword();
                },
                child: const Text('비밀번호 찾기'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
