// ignore: file_names
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:machine_test/Screens/otp_screen.dart';
import 'package:http/http.dart' as http;
import 'package:machine_test/utils/constants.dart';

class PhoneNumberScreen extends StatefulWidget {
  const PhoneNumberScreen({super.key});

  @override
  State<PhoneNumberScreen> createState() => _PhoneNumberScreenState();
}

class _PhoneNumberScreenState extends State<PhoneNumberScreen> {
  String selectedCode = '+91';
  final List<String> countryCodes = ['+91', '+1', '+44', '+61'];

  getOtp(String number) async {
    var headers = {'Content-Type': 'application/json'};
    var request = http.Request(
        'POST',
        Uri.parse(
            '$baseUrl/auth/registration-otp-codes/actions/phone/send-otp'));
    request.body = json.encode({
      "data": {
        "type": "registration_otp_codes",
        "attributes": {"phone": number}
      }
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => OTPVerifyScreen(
              mobile: number,
            ),
          ));
    } else {
      print(response.reasonPhrase);
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
            "Enter valid Mobile",
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.red));
    }
  }

  TextEditingController phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.arrow_back),
              ),
              const SizedBox(height: 20),
              const Center(
                child: Text(
                  'Enter your phone\nnumber',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 40),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                decoration: BoxDecoration(
                  border: Border.all(color: const Color(0xFFD5CFD0)),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.phone_android),
                    const SizedBox(width: 10),
                    DropdownButton<String>(
                      value: selectedCode,
                      underline: const SizedBox(),
                      items: countryCodes.map((code) {
                        return DropdownMenuItem(
                          value: code,
                          child: Text(code),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          selectedCode = value!;
                        });
                      },
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: TextField(
                        controller: phoneController,
                        keyboardType: TextInputType.phone,
                        decoration: const InputDecoration(
                          hintText: '8080808080',
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              const Padding(
                padding: EdgeInsets.only(left: 5),
                child: Text(
                  'Fliq will send you a text with a verification code.',
                  style: TextStyle(fontSize: 13, color: Color(0xff583E45)),
                ),
              ),
              const Spacer(),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    String number = phoneController.text.trim();
                    if (number.isEmpty || number.length < 8) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Please enter a valid phone number"),
                          backgroundColor: Colors.red,
                        ),
                      );
                      return;
                    }

                    String fullPhone = selectedCode + number;
                    getOtp(fullPhone);
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
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}
