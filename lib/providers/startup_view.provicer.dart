import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

enum _ViewModelProviderType { withoutConsumer, withConsumer }

class StartupViewProvider<T extends ChangeNotifier> extends StatefulWidget {
  final Widget? staticChild;
  final Function(T model)? onModelReady;
  final Widget Function(BuildContext, T, Widget?) builder;
  final T viewModel;
  // ignore: library_private_types_in_public_api
  final _ViewModelProviderType providerType;

  // ignore: use_key_in_widget_constructors
  const StartupViewProvider.withoutConsumer({
    required this.viewModel,
    required this.builder,
    this.onModelReady
  }) : providerType = _ViewModelProviderType.withoutConsumer, staticChild = null;

  // ignore: use_key_in_widget_constructors
  const StartupViewProvider.withConsumer({
    required this.viewModel,
    required this.builder,
    this.staticChild,
    this.onModelReady
  }) : providerType = _ViewModelProviderType.withConsumer;

  @override
  // ignore: library_private_types_in_public_api
  _StartupViewProviderState<T> createState() => _StartupViewProviderState<T>();
}

class _StartupViewProviderState<T extends ChangeNotifier> extends State<StartupViewProvider<T>> {

  late T _model;

  @override
  void initState() {
    super.initState();

    _model = widget.viewModel;

    if (widget.onModelReady != null) {
      widget.onModelReady!(_model);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.providerType == _ViewModelProviderType.withoutConsumer) {
      return ChangeNotifierProvider(
        create: (context) => _model,
        child: widget.builder(context, _model, null),
      );
    }

    return ChangeNotifierProvider(
      create: (context) => _model,
      child: Consumer<T>(
        builder: widget.builder,
        child: widget.staticChild,
      ),
    );
  }
}