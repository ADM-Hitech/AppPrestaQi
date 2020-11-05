import 'package:flutter/material.dart';
import 'package:prestaQi/Models/Advance.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ShowIframeCartaMandatoModal extends ModalRoute<void> {

  final String url;
  final Advance calculateAdvance;

  ShowIframeCartaMandatoModal({Key key, this.url, this.calculateAdvance});

  @override
  Duration get transitionDuration => Duration(milliseconds: 100);

  @override
  bool get opaque => false;

  @override
  bool get barrierDismissible => false;

  @override
  Color get barrierColor => Colors.black.withOpacity(0.4);

  @override
  String get barrierLabel => null;

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

    return IframeCartaMandato(url: this.url, calculateAdvance: this.calculateAdvance);
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
  final Advance calculateAdvance;

  IframeCartaMandato({this.url, this.calculateAdvance});
    
  @override
  IframeCartaMandatoState createState() => IframeCartaMandatoState();
}

class IframeCartaMandatoState extends State<IframeCartaMandato> {

  bool accept = false;
  bool decline = false;
  bool loading = true;

  @override
  void initState() {
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            color: Colors.white,
          ),
          width: MediaQuery.of(context).size.width * .9,
          height: MediaQuery.of(context).size.height * .9,
          child: Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.symmetric(vertical: 40, horizontal: 10),
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
                        opacity: this.loading ? .2 : 1,
                        child: WebView(
                          initialUrl: this.widget.url,
                          debuggingEnabled: true,
                          onPageFinished: (String value) {
                            setState(() {
                              this.loading = false;
                            });
                          }
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    if (this.loading) ...[
                      Container(
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      )
                    ] else ...[
                      Container(
                        child: Row(
                          children: [
                            Container(
                              child: Checkbox(
                                checkColor: this.accept ? Colors.white : Color.fromRGBO(0, 0, 102, 1),
                                activeColor: this.accept ? Color.fromRGBO(50, 55, 158, 1) : Colors.white,
                                onChanged: (bool value) {
                                  setState(() {
                                    this.accept = value;
                                    this.decline = !value;
                                    Navigator.pop(context, true);
                                  });
                                },
                                value: this.accept
                              )
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width - 151,
                              child: Text('Si Acepto'),
                            )
                          ],
                        ),
                      ),
                      Container(
                        child: Row(
                          children: [
                            Container(
                              child: Checkbox(
                                checkColor: this.decline ? Colors.white : Color.fromRGBO(0, 0, 102, 1),
                                activeColor: this.decline ? Color.fromRGBO(50, 55, 158, 1) : Colors.white,
                                onChanged: (bool value) {
                                  setState(() {
                                    this.decline = value;
                                    this.accept = !value;
                                    Navigator.pop(context, false);
                                  });
                                },
                                value: this.decline
                              ),
                            ),
                            Container(
                              child: Text('No Acepto'),
                            )
                          ],
                        ),
                      )
                    ]
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
