import 'package:bmslib/src/models/user.dart';
import 'package:bmslib/src/widgets/loading/loading.dart';
import 'package:flutter/material.dart';
import 'package:bmslib/src/services/auth.dart';

class LoginSignupPage extends StatefulWidget {
  // final AuthService auth;
  // final VoidCallback loginCallback;

  // LoginSignupPage({this.auth, this.loginCallback});

  @override
  State<StatefulWidget> createState() => new _LoginSignupPageState();
}

class _LoginSignupPageState extends State<LoginSignupPage> {
  final _formKey = new GlobalKey<FormState>();
  final AuthService _auth = AuthService();

  String _email;
  String _libcard;
  String _name;
  String _phone;
  String _password;
  String _errorMessage;

  bool _isLoginForm;
  bool _isLoading;

  // Check if form is valid before perform login or signup
  bool validateAndSave() {
    final form = _formKey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  // Perform login or signup
  void validateAndSubmit() async {
    setState(() {
      _errorMessage = "";
      _isLoading = true;
    });
    if (validateAndSave()) {
      User user;
      try {
        if (_isLoginForm) {
          user = await _auth.signIn(_email, _libcard, _password);
          print('Signed in: ${user.uid}');
        } else {
          UserData newUser = new UserData(
              libid: _libcard,
              name: _name,
              email: _email,
              phone: _phone,
              borrowed: 0,
              bag: []);
          user = await _auth.signUp(newUser, _password);
          print('Signed up user: ${user.uid}');
        }
        setState(() {
          _isLoading = false;
        });

        // if (userId.length > 0 && userId != null && _isLoginForm) {
        //   widget.loginCallback();
        // }
      } catch (e) {
        print('Error: $e');
        setState(() {
          _isLoading = false;
          _errorMessage = e.message;
          _formKey.currentState.reset();
        });
      }
    }
  }

  @override
  void initState() {
    _errorMessage = "";
    _isLoading = false;
    _isLoginForm = true;
    super.initState();
  }

  void resetForm() {
    _formKey.currentState.reset();
    _errorMessage = "";
  }

  void toggleFormMode() {
    resetForm();
    setState(() {
      _isLoginForm = !_isLoginForm;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("images/background.jpg"),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: Center(
            child: Text('Welcome to BMSLib'),
          ),
        ),
        body: Container(
          child: _isLoading ? Loading() : _showForm(),
        ),
      ),
    );
  }

  // Widget _showLoading() {
  //   if (_isLoading) {
  //     return Loading();
  //   }
  //   return Container(
  //     height: 0.0,
  //     width: 0.0,
  //   );
  // }

  Widget _showForm() {
    return Container(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            shrinkWrap: true,
            children: <Widget>[
              showLogo(),
              showEmailInput(),
              showLibNumInput(),
              !_isLoginForm ? showNameInput() : null,
              !_isLoginForm ? showPhoneInput() : null,
              showPasswordInput(),
              showPrimaryButton(),
              showSecondaryButton(),
              showErrorMessage(),
            ],
          ),
        ));
  }

  Widget showErrorMessage() {
    if (_errorMessage.length > 0 && _errorMessage != null) {
      return Text(
        _errorMessage,
        style: TextStyle(
          fontSize: 13.0,
          color: Colors.red,
          height: 1.0,
          fontWeight: FontWeight.w300,
        ),
      );
    } else {
      return Container(
        height: 0.0,
      );
    }
  }

  Widget showLogo() {
    return Hero(
      tag: 'hero',
      child: Padding(
        padding: EdgeInsets.fromLTRB(0.0, 70.0, 0.0, 0.0),
        child: CircleAvatar(
          backgroundColor: Colors.transparent,
          radius: 48.0,
          child: Image.asset('assets/images/icon.png'),
        ),
      ),
    );
  }

  Widget showEmailInput() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 100.0, 0.0, 0.0),
      child: TextFormField(
        maxLines: 1,
        keyboardType: TextInputType.emailAddress,
        autofocus: false,
        decoration: InputDecoration(
          hintText: 'Email',
          icon: Icon(
            Icons.mail,
            color: Colors.grey,
          ),
        ),
        validator: (value) {
          if (value.isEmpty)
            return 'Email can\'t be empty';
          else if (!value.endsWith('@bmsce.ac.in'))
            return 'Use your BMSCE email id !';
          else
            return null;
        },
        onSaved: (value) => _email = value.trim(),
      ),
    );
  }

  Widget showPasswordInput() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 15.0, 0.0, 0.0),
      child: TextFormField(
        maxLines: 1,
        obscureText: true,
        autofocus: false,
        decoration: InputDecoration(
            hintText: 'Password',
            icon: Icon(
              Icons.lock,
              color: Colors.grey,
            )),
        validator: (value) {
          if (value.isEmpty)
            return 'Password can\'t be empty';
          else if (value.length < 8)
            return 'Password must be at least 8 characters';
          else
            return null;
        },
        onSaved: (value) => _password = value.trim(),
      ),
    );
  }

  Widget showLibNumInput() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 100.0, 0.0, 0.0),
      child: TextFormField(
        maxLines: 1,
        autofocus: false,
        decoration: InputDecoration(
          hintText: 'Library Card Number',
          icon: Icon(
            Icons.card_membership,
            color: Colors.grey,
          ),
        ),
        validator: (value) {
          if (value.isEmpty)
            return 'Library Card can\'t be empty';
          else if (value.length > 8)
            return 'Invalid Card Number';
          else
            return null;
        },
        onSaved: (value) => _libcard = value.trim(),
      ),
    );
  }

  Widget showNameInput() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 100.0, 0.0, 0.0),
      child: TextFormField(
        maxLines: 1,
        autofocus: false,
        decoration: InputDecoration(
          hintText: 'Name',
          icon: Icon(
            Icons.person,
            color: Colors.grey,
          ),
        ),
        validator: (value) => value.isEmpty ? 'Name can\'t be empty' : null,
        onSaved: (value) => _name = value.trim(),
      ),
    );
  }

  Widget showPhoneInput() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 100.0, 0.0, 0.0),
      child: TextFormField(
        maxLines: 1,
        autofocus: false,
        decoration: InputDecoration(
          hintText: 'Phone',
          icon: Icon(
            Icons.phone,
            color: Colors.grey,
          ),
        ),
        validator: (value) {
          RegExp regex = new RegExp(r'^(?:[+0]9)?[0-9]{10}$');
          if (value.isEmpty)
            return 'Phone number can\'t be empty';
          else if (!regex.hasMatch(value))
            return 'Invalid Phone Number';
          else
            return null;
        },
        onSaved: (value) => _phone = value.trim(),
      ),
    );
  }

  Widget showSecondaryButton() {
    return FlatButton(
      child: Text(
          _isLoginForm ? 'Create an account' : 'Have an account? Sign in',
          style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w300)),
      onPressed: toggleFormMode,
    );
  }

  Widget showPrimaryButton() {
    return Padding(
      padding: EdgeInsets.fromLTRB(0.0, 45.0, 0.0, 0.0),
      child: SizedBox(
        height: 40.0,
        child: RaisedButton(
          elevation: 5.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
          ),
          color: Colors.blue,
          child: Text(
            _isLoginForm ? 'Login' : 'Create account',
            style: TextStyle(fontSize: 20.0, color: Colors.white),
          ),
          onPressed: validateAndSubmit,
        ),
      ),
    );
  }
}
