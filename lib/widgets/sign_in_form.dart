import 'package:flutter/material.dart';
import 'package:insta_clone_coding/constants/common_size.dart';
import 'package:insta_clone_coding/home_page.dart';
import 'package:insta_clone_coding/model/fiirebase_auth_state.dart';
import 'package:insta_clone_coding/widgets/sign_up_form.dart';
import 'package:provider/provider.dart';

class SignInForm extends StatefulWidget {
  @override
  _SignInFormState createState() => _SignInFormState();
}

class _SignInFormState extends State<SignInForm> {
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
              Align(
                alignment: Alignment.centerRight,
                child: FlatButton(
                  onPressed: () {},
                  child: Text(
                    'Forgotten Password?',
                    style: TextStyle(color: Colors.red),
                  ),
                ),
              ),
              SizedBox(
                height: common_s_gap,
              ),
              FlatButton(
                onPressed: () {
                  if (_formKey.currentState.validate()) {
                    print('validation Success!');
                    Provider.of<FirebaseAuthState>(context, listen: false)
                        .login(context,
                            email: _emailController.text,
                            password: _passwordController.text);
                    // Navigator.pushReplacement(context,
                    //     MaterialPageRoute(builder: (context) => HomePage()));
                  }
                },
                child: Text(
                  'Sign In',
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
                  onPressed: () {
                    Provider.of<FirebaseAuthState>(context, listen: false)
                        .loginWithFacebook(context);
                  },
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
