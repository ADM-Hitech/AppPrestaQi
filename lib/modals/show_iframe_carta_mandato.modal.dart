import 'package:flutter/material.dart';
import 'package:prestaqi/models/advance.model.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ShowIframeCartaMandatoModal extends ModalRoute<void> {

  final String url;
  final AdvanceModel calculateAdvance;

  ShowIframeCartaMandatoModal({Key? key, required this.url, required this.calculateAdvance});

  @override
  Duration get transitionDuration => const Duration(milliseconds: 100);

  @override
  bool get opaque => false;

  @override
  bool get barrierDismissible => false;

  @override
  Color get barrierColor => Colors.black.withValues(alpha: 0.4);

  @override
  String? get barrierLabel => null;

  @override
  bool get maintainState => true;

  @override
  Widget buildPage(
      BuildContext context,
      Animation<double> animation,
      Animation<double> secondaryAnimation,
      ) {
    // This makes sure that text and other content follows the material style
    return Material(
      type: MaterialType.transparency,
      // make sure that the overlay content is not cut off
      child: SafeArea(
        child: _buildOverlayContent(context),
      ),
    );
  }

  Widget _buildOverlayContent(BuildContext context) {

    return IframeCartaMandato(url: url, calculateAdvance: calculateAdvance);
  }

  @override
  Widget buildTransitions(
      BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation, Widget child) {
    // You can add your own animations for the overlay content
    return FadeTransition(
      opacity: animation,
      child: ScaleTransition(
        scale: animation,
        child: child,
      ),
    );
  }
}

class IframeCartaMandato extends StatefulWidget {

  final String url;
  final AdvanceModel calculateAdvance;

  const IframeCartaMandato({super.key, required this.url, required this.calculateAdvance});
    
  @override
  IframeCartaMandatoState createState() => IframeCartaMandatoState();
}

class IframeCartaMandatoState extends State<IframeCartaMandato> {

  bool accept = false;
  bool decline = false;
  bool loading = true;
  late final WebViewController _controller;

  @override
  void initState() {
    super.initState();

    PlatformWebViewControllerCreationParams params = const PlatformWebViewControllerCreationParams();;

    final WebViewController controller =
        WebViewController.fromPlatformCreationParams(params);
    controller.setNavigationDelegate(NavigationDelegate(
      onPageFinished: (String url) {
        setState(() {
          loading = false;
        });
      }
    ));
    controller.loadRequest(Uri.parse(widget.url));

    _controller = controller;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          color: Colors.white,
        ),
        width: MediaQuery.of(context).size.width * .9,
        height: MediaQuery.of(context).size.height * .9,
        child: Column(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 10),
              height: (MediaQuery.of(context).size.height * .9),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    color: Colors.white,
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height - 300,
                    child: Opacity(
                      opacity: loading ? .2 : 1,
                      child: WebViewWidget(
                        controller: _controller,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  if (loading) ...[
                    const Center(
                      child: CircularProgressIndicator(),
                    )
                  ] else ...[
                    Row(
                      children: [
                        Checkbox(
                          checkColor: accept ? Colors.white : const Color.fromRGBO(0, 0, 102, 1),
                          activeColor: accept ? const Color.fromRGBO(50, 55, 158, 1) : Colors.white,
                          onChanged: (bool? value) {
                            setState(() {
                              accept = value ?? false;
                              decline = !(value ?? false);
                              Navigator.pop(context, true);
                            });
                          },
                          value: accept
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width - 151,
                          child: const Text('Si Acepto'),
                        )
                      ],
                    ),
                    Row(
                      children: [
                        Checkbox(
                          checkColor: decline ? Colors.white : const Color.fromRGBO(0, 0, 102, 1),
                          activeColor: decline ? const Color.fromRGBO(50, 55, 158, 1) : Colors.white,
                          onChanged: (bool? value) {
                            setState(() {
                              decline = value ?? false;
                              accept = !(value ?? false);
                              Navigator.pop(context, false);
                            });
                          },
                          value: decline
                        ),
                        const Text('No Acepto')
                      ],
                    )
                  ]
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
