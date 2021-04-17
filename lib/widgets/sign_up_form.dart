import 'package:flutter/material.dart';
import 'package:insta_clone_coding/constants/common_size.dart';
import 'package:insta_clone_coding/home_page.dart';
import 'package:insta_clone_coding/model/fiirebase_auth_state.dart';
import 'package:provider/provider.dart';

class SignUpForm extends StatefulWidget {
  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _confirmPwdController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPwdController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Padding(
        padding: const EdgeInsets.all(common_gap),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              SizedBox(
                height: common_l_gap,
              ),
              Image.asset('assets/images/insta_text_logo.png'),
              TextFormField(
                controller: _emailController,
                cursorColor: Colors.black54,
                decoration: textInputDecor('Email'),
                validator: (text) {
                  if (text.isNotEmpty && text.contains("@")) {
                    return null;
                  } else {
                    return '정확한 이메일 주소를 입력해주세욥!';
                  }
                },
              ),
              SizedBox(height: common_xs_gap),
              TextFormField(
                controller: _passwordController,
                cursorColor: Colors.black54,
                decoration: textInputDecor('Password'),
                obscureText: true,
                validator: (text) {
                  if (text.isNotEmpty && text.length > 5) {
                    return null;
                  } else {
                    return '제대로 된 비밀번호를 입력해주세욥!';
                  }
                },
              ),
              SizedBox(height: common_xs_gap),
              TextFormField(
                controller: _confirmPwdController,
                cursorColor: Colors.black54,
                obscureText: true,
                decoration: textInputDecor('Confirm Password'),
                validator: (text) {
                  if (text.isNotEmpty && _passwordController.text == text) {
                    return null;
                  } else {
                    return '입력한 값이 비밀번호와 일치하지 않네요! 다시 확인해주세욥';
                  }
                },
              ),
              SizedBox(
                height: common_s_gap,
              ),
              FlatButton(
                onPressed: () {
                  if (_formKey.currentState.validate()) {
                    print('validation Success!');
                    Provider.of<FirebaseAuthState>(context,listen: false).registerUser(context,email: _emailController.text, password: _passwordController.text);
                    // Navigator.pushReplacement(context,
                    //     MaterialPageRoute(builder: (context) => HomePage()));
                  }
                },
                child: Text(
                  'Join',
                  style: TextStyle(color: Colors.white),
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6),
                ),
                color: Colors.blue,
              ),
              SizedBox(
                height: common_s_gap,
              ),
              orDivider(),
              FlatButton.icon(
                  onPressed: () {},
                  textColor: Colors.blue,
                  icon: ImageIcon(AssetImage('assets/images/facebook.png')),
                  label: Text('Login with Facebook'))
            ],
          ),
        ),
      ),
    );
  }
}

Stack orDivider() {
  return Stack(
    alignment: Alignment.center,
    children: [
      Positioned(
        right: 0,
        left: 0,
        height: 1,
        child: Container(
          color: Colors.grey[300],
          height: 1,
        ),
      ),
      Container(
        color: Colors.grey[50],
        height: 3,
        width: 60,
      ),
      Text(
        'OR',
        style: TextStyle(color: Colors.grey[600], fontWeight: FontWeight.bold),
      )
    ],
  );
}

InputDecoration textInputDecor(String hintText) {
  return InputDecoration(
      hintText: hintText,
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.grey[300]),
        borderRadius: BorderRadius.circular(common_gap),
      ),
      errorBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.redAccent),
        borderRadius: BorderRadius.circular(common_gap),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.grey[300]),
        borderRadius: BorderRadius.circular(common_gap),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.redAccent),
        borderRadius: BorderRadius.circular(common_gap),
      ),
      fillColor: Colors.grey[100],
      filled: true);
}
