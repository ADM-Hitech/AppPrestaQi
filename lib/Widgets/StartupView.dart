import 'package:flutter/material.dart';
import 'package:prestaQi/Models/StartupViewModel.dart';
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
              Container(
                child: Image(image: AssetImage('assets/images/ioio_entrada_loop.gif'), width: 250),
              )
            ],
          ),
        ),
      )
    );
  }
}