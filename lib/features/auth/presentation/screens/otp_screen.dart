import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:ug/config/responsive.dart';
import 'package:ug/core/logger.dart';
import 'package:ug/features/auth/presentation/widgets/otp_verify_button.dart';
import 'package:ug/shared/widgets/responsive_builder.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({super.key});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  PinTheme _getPinTheme(BuildContext context) {
    final isDesktop = Responsive.isDesktop(context);
    
    return PinTheme(
      width: isDesktop ? 72 : 56,
      height: isDesktop ? 72 : 56,
      textStyle: TextStyle(
        fontSize: isDesktop ? 24 : 20,
        color: const Color.fromRGBO(30, 60, 80, 1),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(19),
        border: Border.all(color: const Color.fromRGBO(13, 51, 77, 1.0)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = _getPinTheme(context);
    
    return Scaffold(
      body: ResponsiveBuilder(
        mobile: _buildMobileLayout(context, defaultPinTheme),
        tablet: _buildTabletLayout(context, defaultPinTheme),
        desktop: _buildDesktopLayout(context, defaultPinTheme),
      ),
    );
  }

  Widget _buildMobileLayout(BuildContext context, PinTheme defaultPinTheme) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: _buildMainContent(context, defaultPinTheme),
    );
  }

  Widget _buildTabletLayout(BuildContext context, PinTheme defaultPinTheme) {
    return Center(
      child: SizedBox(
        width: Responsive.width(context) * 0.7,
        child: _buildMainContent(context, defaultPinTheme),
      ),
    );
  }

  Widget _buildDesktopLayout(BuildContext context, PinTheme defaultPinTheme) {
    return Center(
      child: SizedBox(
        width: Responsive.width(context) * 0.4,
        child: _buildMainContent(context, defaultPinTheme),
      ),
    );
  }

  Widget _buildMainContent(BuildContext context, PinTheme defaultPinTheme) {
    final focusedPinTheme = defaultPinTheme.copyDecorationWith(
      border: Border.all(color: const Color.fromRGBO(13, 51, 77, 1.0)),
      borderRadius: BorderRadius.circular(8),
    );

    final submittedPinTheme = defaultPinTheme.copyWith(
      decoration: defaultPinTheme.decoration!.copyWith(
        color: const Color(0xffFECD01),
      ),
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Enter your OTP Here",
          style: TextStyle(
            fontSize: Responsive.sp(context, 60),
            fontWeight: FontWeight.w900,
          ),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: Responsive.sp(context, 25)),
        Text(
          "You've tried to register +911234567890 \nrecently. Wait before requesting an sms or a call.\nwith your code. Wrong number?",
          style: TextStyle(
            fontSize: Responsive.sp(context, 30),
            fontWeight: FontWeight.w600,
            letterSpacing: 0.5,
          ),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: Responsive.sp(context, 30)),
        Pinput(
          length: 6,
          defaultPinTheme: defaultPinTheme,
          focusedPinTheme: focusedPinTheme,
          submittedPinTheme: submittedPinTheme,
          onCompleted: (pin) {
            logger.i('Entered Pin: $pin');
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
        ),
        SizedBox(height: Responsive.sp(context, 20)),
        Center(
          child: TextButton(
            onPressed: () {
              // Resend code logic
            },
            style: TextButton.styleFrom(
              foregroundColor: CupertinoColors.black,
            ),
            child: const Text('Didn\'t receive code?'),
          ),
        ),
        SizedBox(height: Responsive.sp(context, 40)),
        OTPVerifyButton(
          onPressed: () {
            // Navigation logic
          },
          buttonText: "Verify Now",
        ),
      ],
    );
  }
} 