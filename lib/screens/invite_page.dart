import 'package:clone_mobile_app/screens/colors/invite_color.dart';
import 'package:clone_mobile_app/screens/login_page.dart';
import 'package:flutter/material.dart';

class InvitePage extends StatefulWidget {
  const InvitePage({super.key});

  @override
  State<InvitePage> createState() => _InvitePageState();
}

class _InvitePageState extends State<InvitePage> {
  final TextEditingController codeController = TextEditingController();

  void navigateToLogin() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const LoginPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),

          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,

            children: [
              Align(
                alignment: Alignment.topRight,

                child: Row(
                  mainAxisSize: MainAxisSize.min,

                  children: [
                    Image.asset("assets/images/language.jpg", width: 30),

                    Icon(Icons.keyboard_arrow_down, color: Colors.grey[300]),
                  ],
                ),
              ),

              Image.asset(
                "assets/images/logo.jpg",
                width: 200,
                height: 200,
                fit: BoxFit.cover,
              ),

              const Text(
                "Please fill in the Invitation Code Provided by your \n administrator to access empeo within your company.",
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 36),

              TextField(
                controller: codeController,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  hintText: "Invitation Code",
                  hintStyle: TextStyle(fontSize: 14, color: Colors.grey[400]),

                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(6),
                    borderSide: const BorderSide(
                      color: InviteColors.border,
                      width: 1.5,
                    ),
                  ),

                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(6),
                    borderSide: const BorderSide(
                      color: InviteColors.border,
                      width: 1.5,
                    ),
                  ),

                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(6),
                    borderSide: const BorderSide(
                      color: InviteColors.primary,
                      width: 2,
                    ),
                  ),

                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 10,
                  ),
                ),
              ),

              const SizedBox(height: 24),

              SizedBox(
                width: double.infinity,
                height: 42,

                child: ElevatedButton(
                  onPressed: () {
                    navigateToLogin();
                  },

                  style: ElevatedButton.styleFrom(
                    backgroundColor: InviteColors.primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    elevation: 0,
                  ),

                  child: Text(
                    "Confirm",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 8),

              TextButton(
                onPressed: () {
                  navigateToLogin();
                },

                child: Text(
                  "Skip",
                  style: TextStyle(
                    fontSize: 14,
                    color: InviteColors.primary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
