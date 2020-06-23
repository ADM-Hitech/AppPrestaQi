import 'package:flutter/material.dart';
import 'package:prestaQi/Screens/Login/login.dart';
import 'package:prestaQi/Utils/HexColor.dart';

class LoginContent extends StatelessWidget {
  
  final LoginState state;

  LoginContent({Key key, @required this.state});

  @override
  Widget build(BuildContext context) {
    
    return new Container(
      height: this.state.screen.height,
      width: this.state.screen.width,
      decoration: BoxDecoration(
        gradient: new LinearGradient(
          colors: [
            
          ]
        )
      ),
    );
  }
} 