import 'package:flutter/material.dart';
import 'carepage.dart'; // Ensure CausesPage is imported

class VerificationCodePage extends StatefulWidget {
  const VerificationCodePage({super.key});

  @override
  _VerificationCodePageState createState() => _VerificationCodePageState();
}

class _VerificationCodePageState extends State<VerificationCodePage> {
  final String _phoneNumber = '+1 (206) 555-0126';

  // Create separate controllers for each input box
  final List<TextEditingController> _controllers =
      List.generate(6, (index) => TextEditingController());
  final List<FocusNode> _focusNodes = List.generate(6, (index) => FocusNode());

  @override
  void dispose() {
    // Dispose controllers and focus nodes to avoid memory leaks
    for (var controller in _controllers) {
      controller.dispose();
    }
    for (var focusNode in _focusNodes) {
      focusNode.dispose();
    }
    super.dispose();
  }

  void _verifyCode() {
    // Combine the values of all text controllers
    String verificationCode =
        _controllers.map((controller) => controller.text).join();
    if (verificationCode.length == 6) {
      // Print the verification code for testing purposes
      print('Verification code entered: $verificationCode');

      // Navigate to the CausesPage after successful verification
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const CausesPage()),
      );
    } else {
      print('Incomplete code');
    }
  }

  void _onChanged(int index, String value) {
    if (value.isNotEmpty && index < 5) {
      FocusScope.of(context).nextFocus(); // Move to the next field
    }
  }

  void _onBackspace(int index, String value) {
    if (value.isEmpty && index > 0) {
      FocusScope.of(context).previousFocus(); // Move to the previous field
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Enter Verification Code'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'We sent a verification code to:',
              style: TextStyle(fontSize: 16),
            ),
            Text(
              _phoneNumber,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(6, (index) {
                return SizedBox(
                  width: 40,
                  child: TextField(
                    controller: _controllers[index],
                    focusNode: _focusNodes[index],
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                    maxLength: 1,
                    decoration: const InputDecoration(
                      counterText: "", // Hide the counter
                      border: OutlineInputBorder(),
                    ),
                    onChanged: (value) => _onChanged(index, value),
                    onEditingComplete: () {
                      _onBackspace(index, _controllers[index].text);
                    },
                  ),
                );
              }),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: () {
                    // Placeholder for resend code logic
                    print('Resend code');
                  },
                  child: const Text('Resend code'),
                ),
                ElevatedButton(
                  onPressed: _verifyCode,
                  child: const Text('Verify'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
