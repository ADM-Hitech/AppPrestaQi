import 'package:flutter/material.dart';
import 'package:prestaQi/Models/StartupViewModel.dart';
import 'package:prestaQi/Utils/HexColor.dart';
import 'package:prestaQi/Widgets/ViewModelProvider.dart';

class StartupView extends StatelessWidget {

  const StartupView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelProvider<StartupViewModel>.withConsumer(
      viewModel: StartupViewModel(),
      onModelReady: (model) => model.handleStartUpLogin(),
      builder: (context, model, child) => Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              SizedBox(
                width: MediaQuery.of(context).size.width * .8,
                height: 150,
                child: Image.asset('assets/images/splash.png')
              ),
              Container(
                child: CircularProgressIndicator(
                  strokeWidth: 3,
                  valueColor: AlwaysStoppedAnimation(
                    HexColor.fromHex('#000066')
                  ),
                ),
              )
            ],
          ),
        ),
      )
    );
  }
}