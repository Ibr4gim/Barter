import 'package:BirJol/presentation/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class NewPasswordCode extends StatefulWidget {
  const NewPasswordCode({super.key});

  @override
  State<NewPasswordCode> createState() => _NewPasswordCodeState();
}

class _NewPasswordCodeState extends State<NewPasswordCode> {
  final TextEditingController _pinController = TextEditingController();
  int _resendSeconds = 60;
  bool _canResend = false;
  bool _isPinValid = false;

  @override
  void initState() {
    super.initState();
    _startResendTimer();
  }

  void _startResendTimer() {
    Future.delayed(const Duration(seconds: 1), () {
      if (mounted) {
        setState(() {
          if (_resendSeconds > 0) {
            _resendSeconds--;
            _startResendTimer();
          } else {
            _canResend = true;
          }
        });
      }
    });
  }

  void _resendCode() {
    if (_canResend) {
      setState(() {
        _resendSeconds = 60;
        _canResend = false;
        _pinController.clear();
      });
      _startResendTimer();
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Код отправлен заново')));
    }
  }

  void _verifyCode() {
    if (_pinController.text.length == 6) {
      Navigator.pushNamed(context, '/new_password');
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Введите действительный код')));
    }
  }

  @override
  void dispose() {
    _pinController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   leading: IconButton(
      //     icon: Icon(Icons.close, color: Colors.black, size: 28),
      //     onPressed: () => Navigator.pop(context),
      //   ),
      //   backgroundColor: Color(0xFF0A0A0A),
      //   elevation: 0,
      // ),
      backgroundColor: Color(0xFF0A0A0A),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(height: 130),
              Text(
                'New password',
                style: TextStyle(
                  color: Color(0xFF00D4AA),
                  fontSize: 32,
                  fontWeight: FontWeight.w700,
                  height: 1.5,
                ),
              ),
              Text(
                'Мы отправили тебе код на Email',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 20),
              PinCodeTextField(
                appContext: context,
                length: 6,
                controller: _pinController,
                keyboardType: TextInputType.number,
                textStyle: const TextStyle(
                  color: Colors.white,
                  fontSize: 28,
                  fontWeight: FontWeight.w500,
                ),
                pinTheme: PinTheme(
                  shape: PinCodeFieldShape.box,
                  borderRadius: BorderRadius.circular(9),
                  fieldHeight: 50,
                  fieldWidth: 50,
                  activeColor: Colors.blue,
                  inactiveColor: const Color.fromARGB(255, 44, 42, 42),
                  selectedColor: Colors.blue,
                  activeFillColor: const Color.fromARGB(255, 23, 234, 97),
                  inactiveFillColor: const Color.fromARGB(255, 66, 69, 67),
                  selectedFillColor: const Color.fromARGB(255, 255, 255, 255),
                ),
                cursorColor: Colors.white,
                enableActiveFill: true,
                onChanged: (value) {
                  setState(() {
                    _isPinValid = value.length == 6;
                  });
                },
              ),
              const SizedBox(height: 10),
              const Text(
                'Введи полученный код, чтобы подтвердить свою почту',
                style: TextStyle(
                  fontSize: 14,
                  color: Color.fromARGB(255, 100, 96, 96),
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  GestureDetector(
                    onTap: _resendCode,
                    child: Text(
                      'Отправить код заново',
                      style: TextStyle(
                        fontSize: 14,
                        color: _canResend ? Color(0xFF00D4AA) : Colors.grey,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Text(
                    _resendSeconds > 0 ? '$_resendSeconds сек' : '',
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              const Spacer(),
              CustomButton(
                text: 'Change password',
                textColor: Colors.white,
                onPressed: _isPinValid ? _verifyCode : null,
                // onPressed: () {
                //   Navigator.pushNamed(context, '/new_password');
                // },
                backgroundColor: Color(0xFF00D4AA),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
