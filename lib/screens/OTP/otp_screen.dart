import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:ug/components/OTP/otp_verify_button.dart';
import 'package:ug/screens/Profile/profile_screen.dart';
import 'package:logger/logger.dart';
import 'package:firebase_auth/firebase_auth.dart';

class OtpScreen extends StatefulWidget {
  final String verificationId;
  const OtpScreen({super.key, required this.verificationId});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final logger = Logger();
  final TextEditingController otpController = TextEditingController();
  bool isLoading = false;

  Future<void> verifyOTP() async {
    if (otpController.text.length != 6) {
      // Show error message
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a valid 6-digit OTP')),
      );
      return;
    }

    setState(() {
      isLoading = true;
    });

    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: widget.verificationId,
        smsCode: otpController.text,
      );

      await FirebaseAuth.instance.signInWithCredential(credential);

      // Navigate to profile screen on success
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const ProfileScreen(),
        ),
      );
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.message ?? 'An error occurred')),
      );
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // Get the screen width and height using MediaQuery
    double screenWidth = MediaQuery.of(context).size.width;
    final defaultPinTheme = PinTheme(
      width: 56,
      height: 56,
      textStyle: TextStyle(fontSize: 20, color: Color.fromRGBO(30, 60, 80, 1)),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(19),
        border: Border.all(color: Color.fromRGBO(13, 51, 77, 1.0)),
      ),
    );

    final focusedPinTheme = defaultPinTheme.copyDecorationWith(
      border: Border.all(color: Color.fromRGBO(13, 51, 77, 1.0)),
      borderRadius: BorderRadius.circular(8),
    );

    final submittedPinTheme = defaultPinTheme.copyWith(
      decoration: defaultPinTheme.decoration!.copyWith(
        color: Color(0xffFECD01),
      ),
    );

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                "Enter your OTP Here",
                style: TextStyle(
                  fontSize: screenWidth * 0.06,
                  fontWeight: FontWeight.w900,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 25),

              Text(
                "You've tried to register +911234567890 \n recently. Wait before requesting an sms or a call.\n with your code. Wrong number?",
                style: TextStyle(
                  fontSize: screenWidth * 0.03,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.5,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 30),
              // Code Input using Pinput
              Pinput(
                length: 6,
                defaultPinTheme: defaultPinTheme,
                focusedPinTheme: focusedPinTheme,
                submittedPinTheme: submittedPinTheme,
                controller: otpController,
                onCompleted: (pin) {
                  verifyOTP();
                },
                onChanged: (value) {
                  // You can handle changes here if needed
                },
                cursor: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      width: 1,
                      height: 16,
                      color: Colors.black,
                    ),
                  ],
                ),
                pinAnimationType: PinAnimationType.fade,
                errorTextStyle: TextStyle(
                  color: Colors.red,
                  fontSize: 12,
                ),
                autofocus: true,
                enableSuggestions: true,
              ),

              SizedBox(height: 20),
              Center(
                child: TextButton(
                  onPressed: () {
                    // Resend code logic here
                  },
                  style: TextButton.styleFrom(
                    foregroundColor: CupertinoColors.black, // Text color
                  ),
                  child: Text('Didn\'t receive code ?'),
                ),
              ),
              SizedBox(height: 40),
              OTPVerifyButton(
                onPressed: isLoading ? () {} : () => verifyOTP(),
                buttonText: isLoading ? "Verifying..." : "Verify Now",
              )
            ],
          ),
        ),
      ),
    );
  }
}
