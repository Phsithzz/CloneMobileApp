import 'package:clone_mobile_app/screens/bottom_nav_page.dart';
import 'package:flutter/material.dart';

class PinPage extends StatefulWidget {
  const PinPage({super.key});

  @override
  State<PinPage> createState() => _PinPageState();
}

class _PinPageState extends State<PinPage> {
  String pin = "";

  void _onNumPress(String num) {
    if (pin.length < 6) {
      setState(() => pin += num);
      if (pin.length == 6) {
        Future.delayed(const Duration(milliseconds: 300), () {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (_) => const BottomNavPage()),
            (route) => false,
          );
        });
      }
    }
  }

  void _onBackspace() {
    if (pin.isNotEmpty) {
      setState(() => pin = pin.substring(0, pin.length - 1));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              flex: 3,
              child: Stack(
                children: [
                  Positioned.fill(
                    child: Opacity(
                      opacity: 0.7,
                      child: Image.asset(
                        'assets/images/background.jpg',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Column(
                    children: [
                      const SizedBox(height: 40),
                      const Text(
                        'Create your PIN',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 2),
                      const Text(
                        'To allow secure access to app and payslip information',
                        style: TextStyle(color: Colors.black, fontSize: 12),
                      ),
                      const SizedBox(height: 30),
                      const Icon(
                        Icons.lock_outline,
                        size: 50,
                        color: Color(0xFFF25A29),
                      ),
                      const SizedBox(height: 30),
                      const Text(
                        'Enter the 6 digit pin code.',
                        style: TextStyle(fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(6, (index) {
                          return Container(
                            margin: const EdgeInsets.symmetric(horizontal: 6),
                            width: 12,
                            height: 12,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: index < pin.length
                                  ? const Color(0xFFF25A29)
                                  : Colors.transparent,
                              border: Border.all(
                                color: index < pin.length
                                    ? const Color(0xFFF25A29)
                                    : Colors.grey,
                              ),
                            ),
                          );
                        }),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            // Numpad Mockup
            Expanded(
              flex: 2,
              child: Container(
                color: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 0),
                child: GridView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    childAspectRatio: 1.5,
                  ),
                  itemCount: 12,
                  itemBuilder: (context, index) {
                    if (index == 9) return const SizedBox.shrink();
                    if (index == 11) {
                      return IconButton(
                        onPressed: _onBackspace,
                        icon: const Icon(Icons.backspace_outlined),
                      );
                    }
                    final number = index == 10 ? '0' : '${index + 1}';
                    return InkWell(
                      onTap: () => _onNumPress(number),
                      child: Center(
                        child: Text(
                          number,
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
