import 'package:flutter/material.dart';
import 'package:prestaqi/models/startup_view.model.dart';
import 'package:prestaqi/providers/startup_view.provicer.dart';

class StatupView extends StatelessWidget {
  const StatupView({ super.key });

  @override
  Widget build(BuildContext context) {
    return StartupViewProvider<StartupViewModel>.withConsumer(
      viewModel: StartupViewModel(),
      onModelReady: (StartupViewModel model) => model.handleStartUp(context),
      builder: (context, model, child) => Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircularProgressIndicator(
                strokeWidth: 3,
                valueColor: AlwaysStoppedAnimation(
                  Theme.of(context).primaryColor
                ),
              )
            ]
          ),
        ),
      )
    );
  }
}