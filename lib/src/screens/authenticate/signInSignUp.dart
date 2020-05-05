import 'package:bmslib/src/models/user.dart';
import 'package:bmslib/src/widgets/loading/loading.dart';
import 'package:flutter/material.dart';
import 'package:bmslib/src/services/auth.dart';

class LoginSignupPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _LoginSignupPageState();
}

class _LoginSignupPageState extends State<LoginSignupPage> {
  final _formKey = GlobalKey<FormState>();
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
      if (_isLoginForm) {
        // login the user
        user = await _auth.signIn(_email, _password);
        if (user != null) {
          print('Signed in: ${user.uid}');
        } else {
          setState(() {
            _isLoading = false;
            _errorMessage = "Could not sign in with those credentials :(";
            _formKey.currentState.reset();
          });
        }
      } else {
        // sign up the user
        UserData newUser = new UserData(
            libid: _libcard,
            name: _name,
            email: _email,
            phone: _phone,
            borrowed: 0,
            bag: []);
        user = await _auth.signUp(newUser, _password);
        if (user != null) {
          print('Signed up user: ${user.uid}');
        } else {
          setState(() {
            _isLoading = false;
            _errorMessage = "Could not sign up :(";
            _formKey.currentState.reset();
          });
        }
      }
    } else {
      // form validation failed
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _errorMessage = "";
    _isLoading = false;
    _isLoginForm = true;
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
          image: AssetImage("assets/images/background.jpg"),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Container(
          child: Stack(
            children: <Widget>[
              _showForm(),
              _showLoading(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _showLoading() {
    if (_isLoading) {
      //return Center(
      // child: CircularProgressIndicator(),
      //);
      return Loading();
    }
    return Container(
      height: 0.0,
      width: 0.0,
    );
  }

  Widget _showForm() {
    return Container(
      padding: EdgeInsets.all(16.0),
      child: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            Expanded(
              child: ListView(
                children: (_isLoginForm)
                    ? <Widget>[
                        showLogo(),
                        showText(),
                        showEmailInput(),
                        showPasswordInput(),
                        showErrorMessage(),
                        showPrimaryButton(),
                        showSecondaryButton(),
                      ]
                    : <Widget>[
                        showLogo(),
                        showText(),
                        showEmailInput(),
                        showLibNumInput(),
                        showNameInput(),
                        showPhoneInput(),
                        showPasswordInput(),
                        showErrorMessage(),
                        showPrimaryButton(),
                        showSecondaryButton(),
                      ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget showErrorMessage() {
    if (_errorMessage.length > 0 && _errorMessage != null) {
      return Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text(
          _errorMessage,
          style: TextStyle(
            fontSize: 18.0,
            color: Colors.red,
            height: 1.0,
            fontWeight: FontWeight.w600,
          ),
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
        padding: EdgeInsets.fromLTRB(0.0, 50.0, 0.0, 0.0),
        child: CircleAvatar(
          backgroundColor: Colors.transparent,
          radius: 28.0,
          child: Image.asset('assets/images/icon.png'),
        ),
      ),
    );
  }

  Widget showText() {
    return Padding(
      padding: EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 0.0),
      child: Center(
        child: Text(
          (_isLoginForm ? 'Sign In' : 'Sign Up'),
          style: TextStyle(
            color: Colors.grey[800],
            fontSize: 28.0,
          ),
        ),
      ),
    );
  }

  Widget showEmailInput() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 70.0, 0.0, 0.0),
      child: TextFormField(
        maxLines: 1,
        keyboardType: TextInputType.emailAddress,
        autofocus: false,
        style: TextStyle(
          color: Colors.grey[900],
        ),
        decoration: InputDecoration(
          hintText: 'Email',
          icon: Icon(
            Icons.mail,
            color: Colors.grey,
          ),
          hintStyle: TextStyle(
            color: Colors.grey[900],
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
        style: TextStyle(
          color: Colors.grey[900],
        ),
        decoration: InputDecoration(
          hintText: 'Password',
          icon: Icon(
            Icons.lock,
            color: Colors.grey,
          ),
          hintStyle: TextStyle(
            color: Colors.grey[900],
          ),
        ),
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
      padding: const EdgeInsets.fromLTRB(0.0, 15.0, 0.0, 0.0),
      child: TextFormField(
        maxLines: 1,
        autofocus: false,
        style: TextStyle(
          color: Colors.grey[900],
        ),
        decoration: InputDecoration(
          hintText: 'Library Card Number',
          icon: Icon(
            Icons.card_membership,
            color: Colors.grey,
          ),
          hintStyle: TextStyle(
            color: Colors.grey[900],
          ),
        ),
        validator: (value) {
          if (value.isEmpty)
            return 'Library Card can\'t be empty';
          else if (value.length != 8)
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
      padding: const EdgeInsets.fromLTRB(0.0, 15.0, 0.0, 0.0),
      child: TextFormField(
        maxLines: 1,
        autofocus: false,
        style: TextStyle(
          color: Colors.grey[900],
        ),
        decoration: InputDecoration(
          hintText: 'Name',
          icon: Icon(
            Icons.person,
            color: Colors.grey,
          ),
          hintStyle: TextStyle(
            color: Colors.grey[900],
          ),
        ),
        validator: (value) => value.isEmpty ? 'Name can\'t be empty' : null,
        onSaved: (value) => _name = value.trim(),
      ),
    );
  }

  Widget showPhoneInput() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 15.0, 0.0, 0.0),
      child: TextFormField(
        maxLines: 1,
        autofocus: false,
        style: TextStyle(
          color: Colors.grey[900],
        ),
        decoration: InputDecoration(
          hintText: 'Phone',
          icon: Icon(
            Icons.phone,
            color: Colors.grey,
          ),
          hintStyle: TextStyle(
            color: Colors.grey[900],
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
        style: TextStyle(
          fontSize: 18.0,
          fontWeight: FontWeight.w300,
          color: Colors.grey[800],
        ),
      ),
      onPressed: toggleFormMode,
    );
  }

  Widget showPrimaryButton() {
    return Padding(
      padding: EdgeInsets.fromLTRB(0.0, 35.0, 0.0, 0.0),
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
