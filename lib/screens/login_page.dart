import 'package:clone_mobile_app/components/social_button.dart';
import 'package:clone_mobile_app/screens/colors/login_color.dart';
import 'package:clone_mobile_app/screens/invite_page.dart';
import 'package:clone_mobile_app/screens/pin_page.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _isPasswordVisible = false;

  void _navigateToInvite() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const InvitePage()),
    );
  }

  void _navigateToPin() {
    Navigator.push(context, MaterialPageRoute(builder: (_) => const PinPage()));
  }

  void _onLogin() {
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      _showMessage("Please fill all fields");
      return;
    }

    const mockEmail = "intern@gofive.com";
    const mockPassword = "1234";

    if (email == mockEmail && password == mockPassword) {
      _navigateToPin();
    } else {
      _showMessage("Wrong Input");
    }
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              padding: const EdgeInsets.all(24),

              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),

                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,

                  children: [
                    Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,

                          children: [
                            IconButton(
                              onPressed: _navigateToInvite,
                              icon: Icon(Icons.arrow_back_ios),
                              color: LoginColor.primary,
                            ),

                            Row(
                              children: [
                                Image.asset(
                                  "assets/images/question.png",
                                  width: 30,
                                  height: 30,
                                ),

                                const SizedBox(width: 4),

                                Image.asset(
                                  "assets/images/language.jpg",
                                  width: 28,
                                  height: 28,
                                ),

                                const SizedBox(width: 4),

                                Icon(
                                  Icons.keyboard_arrow_down,
                                  color: Colors.blueGrey[300],
                                ),

                                const SizedBox(width: 4),
                              ],
                            ),
                          ],
                        ),

                        Image.asset(
                          "assets/images/logo.jpg",
                          height: 200,
                          fit: BoxFit.contain,
                        ),

                        TextField(
                          controller: _emailController,
                          keyboardType: TextInputType.emailAddress,

                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            hintText: "Email",
                            hintStyle: TextStyle(
                              fontSize: 14,
                              color: Colors.grey[400],
                            ),

                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(6),
                              borderSide: const BorderSide(
                                color: LoginColor.border,
                                width: 1.5,
                              ),
                            ),

                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(6),
                              borderSide: const BorderSide(
                                color: LoginColor.border,
                                width: 1.5,
                              ),
                            ),

                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(6),
                              borderSide: const BorderSide(
                                color: LoginColor.primary,
                                width: 2,
                              ),
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 16,
                            ),
                          ),
                        ),

                        const SizedBox(height: 20),

                        TextField(
                          controller: _passwordController,
                          obscureText: !_isPasswordVisible,

                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            hintText: "Password",
                            hintStyle: TextStyle(
                              fontSize: 14,
                              color: Colors.grey[400],
                            ),
                            suffixIcon: IconButton(
                              icon: Icon(
                                _isPasswordVisible
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                              ),
                              onPressed: () {
                                setState(() {
                                  _isPasswordVisible = !_isPasswordVisible;
                                });
                              },
                            ),

                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(6),
                              borderSide: const BorderSide(
                                color: LoginColor.border,
                                width: 1.5,
                              ),
                            ),

                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(6),
                              borderSide: const BorderSide(
                                color: LoginColor.border,
                                width: 1.5,
                              ),
                            ),

                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(6),
                              borderSide: const BorderSide(
                                color: LoginColor.primary,
                                width: 2,
                              ),
                            ),

                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 16,
                            ),
                          ),
                        ),

                        Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                            onPressed: () {},
                            child: const Text(
                              "Forgot password?",
                              style: TextStyle(color: LoginColor.primary),
                            ),
                          ),
                        ),

                        const SizedBox(height: 10),

                        SizedBox(
                          width: double.infinity,
                          height: 42,

                          child: ElevatedButton(
                            onPressed: () {
                              _onLogin();
                            },

                            style: ElevatedButton.styleFrom(
                              backgroundColor: LoginColor.primary,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              elevation: 0,
                            ),

                            child: Text(
                              "Sign in",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(height: 20),

                        Row(
                          children: [
                            Expanded(
                              child: Divider(
                                thickness: 2,
                                color: LoginColor.border,
                              ),
                            ),

                            Padding(
                              padding: const EdgeInsets.all(8.0),

                              child: Text(
                                "or continue with",
                                style: TextStyle(
                                  color: Colors.grey[600],
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),

                            Expanded(
                              child: Divider(
                                thickness: 2,
                                color: LoginColor.border,
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 6),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,

                          children: [
                            SocialButton(image: "assets/images/google.jpg"),

                            SizedBox(width: 14),

                            SocialButton(image: "assets/images/office.png"),
                            SizedBox(width: 14),

                            SocialButton(image: "assets/images/facebook.jpg"),
                            SizedBox(width: 14),

                            Container(
                              width: 50,
                              height: 50,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.white,
                                border: Border.all(
                                  color: Colors.grey[300]!,
                                  width: 1,
                                ),
                              ),
                              child: Center(
                                child: SizedBox(
                                  width: 40,
                                  height: 40,
                                  child: Image.asset(
                                    "assets/images/line.jpg",
                                    fit: BoxFit.contain,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 10),

                        TextButton(
                          onPressed: () {},
                          child: const Text(
                            "Sign in without email",
                            style: TextStyle(
                              color: Color(0xffF45B26),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),

                    Column(
                      children: [
                        Text(
                          "By continuing, you agree to our\nTerms & Conditions AND Privacy Policy",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 12,
                          ),
                        ),

                        const SizedBox(height: 60),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
