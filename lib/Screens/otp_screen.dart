import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:japx/japx.dart';
import 'package:machine_test/Screens/Messages_Screen.dart';
import 'package:machine_test/utils/constants.dart';
import 'package:machine_test/widgets/custom_otp_field.dart';
import 'package:http/http.dart' as http;

class OTPVerifyScreen extends StatefulWidget {
  const OTPVerifyScreen({super.key, required this.mobile});
  final String mobile;

  @override
  State<OTPVerifyScreen> createState() => _OTPVerifyScreenState();
}

class _OTPVerifyScreenState extends State<OTPVerifyScreen> {
  verifyOtp({
    required BuildContext context,
    required String phone,
    required String otp,
  }) async {
    const String endpoint =
        "/auth/registration-otp-codes/actions/phone/verify-otp";

    final Map<String, dynamic> requestBody = {
      "data": {
        "type": "registration_otp_codes",
        "attributes": {
          "phone": phone,
          "otp": int.tryParse(otp),
          "device_meta": {
            "type": "web",
            "device-name": "HP Pavilion 14-EP0068TU",
            "device-os-version": "Linux x86_64",
            "browser": "Mozilla Firefox Snap for Ubuntu (64-bit)",
            "browser_version": "112.0.2",
            "user-agent":
                "Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/112.0",
            "screen_resolution": "1600x900",
            "language": "en-GB"
          }
        }
      }
    };

    try {
      final response = await http.post(
        Uri.parse('$baseUrl$endpoint'),
        headers: {
          'Content-Type': 'application/vnd.api+json',
          'Accept': 'application/vnd.api+json',
        },
        body: jsonEncode(requestBody),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final decodedJson = jsonDecode(response.body);
        final unwrapped = Japx.decode(decodedJson);

        final userId = unwrapped['data']?['id'];
        print("✅ User ID: $userId");

        if (userId != null) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const MessagesScreen(),
            ),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text(
                "Error No user found ",
                style: TextStyle(color: Colors.white),
              ),
              backgroundColor: Colors.red));
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(
              "${response.body}",
              style: const TextStyle(color: Colors.white),
            ),
            backgroundColor: Colors.red));
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
            "Error $e",
            style: const TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.red));
    }
  }

  final List<FocusNode> _focusNodes = List.generate(6, (index) => FocusNode());
  final List<TextEditingController> _controllers =
      List.generate(6, (index) => TextEditingController());

  @override
  void dispose() {
    for (var node in _focusNodes) {
      node.dispose();
    }
    for (var controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding:
            const EdgeInsets.only(top: 60, left: 24, right: 24, bottom: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Align(
              alignment: Alignment.centerLeft,
              child: Icon(Icons.arrow_back, size: 28),
            ),
            const SizedBox(height: 40),
            const Text(
              'Enter your verification\ncode',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 16),
            RichText(
              text: TextSpan(
                text: widget.mobile,
                style: const TextStyle(color: Colors.black87, fontSize: 16),
                children: const <TextSpan>[
                  TextSpan(
                    text: 'Edit',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(
                  6,
                  (index) => CustomOtpField(
                        controller: _controllers[index],
                        focusNode: _focusNodes[index],
                        onChanged: (value) {
                          if (value.isNotEmpty && index < 5) {
                            FocusScope.of(context)
                                .requestFocus(_focusNodes[index + 1]);
                          } else if (value.isEmpty && index > 0) {
                            FocusScope.of(context)
                                .requestFocus(_focusNodes[index - 1]);
                          }
                        },
                      )),
            ),
            const SizedBox(height: 20),
            const Text(
              "Didn't get anything? No worries, let's try again.",
              style: TextStyle(fontSize: 14, color: Colors.black54),
            ),
            const SizedBox(height: 5),
            const Text(
              'Resent',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  String otpCode =
                      _controllers.map((controller) => controller.text).join();
                  if (otpCode.length == 6) {
                    verifyOtp(
                      context: context,
                      phone: widget.mobile,
                      otp: otpCode,
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Please enter 6-digit OTP")),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  padding: EdgeInsets.zero,
                  elevation: 0,
                ).copyWith(
                  backgroundColor: MaterialStateProperty.resolveWith(
                    (states) => null,
                  ),
                ),
                child: Ink(
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xffff80a1), Color(0xffE6446E)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomCenter,
                    ),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: const Center(
                    child: Text(
                      'Next',
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
