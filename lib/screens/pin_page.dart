import 'package:clone_mobile_app/screens/bottom_nav_page.dart';
import 'package:clone_mobile_app/screens/colors/pin_color.dart';
import 'package:flutter/material.dart';

class PinPage extends StatefulWidget {
  const PinPage({super.key});

  @override
  State<PinPage> createState() => _PinPageState();
}

class _PinPageState extends State<PinPage> {
  String _pin = "";
  static const String _correctPin = "123456";
  static const int _maxPinLength = 6;
  bool _isError = false;

  void _onPinComplete() {
    Future.delayed(const Duration(milliseconds: 300), () {
      if (_pin == _correctPin) {
        _navigateToHome();
      } else {
        _onPinError();
      }
    });
  }

  void _onPinError() {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text("Incorrect PIN")));

    setState(() {
      _isError = true;
      _pin = "";
    });

    Future.delayed(const Duration(milliseconds: 500), () {
      if (mounted) {
        setState(() {
          _isError = false;
        });
      }
    });
  }

  void _navigateToHome() {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (_) => const BottomNavPage()),
      (route) => false,
    );
  }

  void _onNumPress(String num) {
    if (_pin.length >= _maxPinLength) return;

    setState(() {
      _pin += num;
      _isError = false;
    });

    if (_pin.length == _maxPinLength) {
      _onPinComplete();
    }
  }

  void _onBackspace() {
    if (_pin.isNotEmpty) {
      setState(() {
        _pin = _pin.substring(0, _pin.length - 1);
        _isError = false;
      });
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
                        color: PinColor.primary,
                      ),

                      const SizedBox(height: 30),

                      const Text(
                        'Enter the 6 digit pin code.',
                        style: TextStyle(fontWeight: FontWeight.w500),
                      ),

                      const SizedBox(height: 16),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,

                        children: List.generate(_maxPinLength, (index) {
                          return Container(
                            margin: const EdgeInsets.symmetric(horizontal: 6),
                            width: 12,
                            height: 12,

                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: _isError
                                  ? Colors.red
                                  : index < _pin.length
                                  ? PinColor.primary
                                  : Colors.transparent,
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
