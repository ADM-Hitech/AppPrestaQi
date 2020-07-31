import 'package:flutter/material.dart';
import 'package:webview_flutter/platform_interface.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ShowIframeModal extends ModalRoute<void> {

  final String url;
  final String textAccepted;
  final String textCancel;

  ShowIframeModal({Key key, this.url, this.textAccepted, this.textCancel });

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

    return ShowIframe(url: this.url, textAccepted: this.textAccepted, textCancel: this.textCancel);
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

class ShowIframe extends StatefulWidget {

  final String url;
  final String textAccepted;
  final String textCancel;

  ShowIframe({this.url, this.textAccepted, this.textCancel});
    
  @override
  ShowIframeState createState() => ShowIframeState();
}

class ShowIframeState extends State<ShowIframe> {

  bool accept = false;
  bool decline = false;

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
                      color: Colors.grey,
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height - 300,
                      child: WebView(
                        onPageStarted: (String val) {
                          print(val);
                        },
                        onPageFinished: (String val) {
                          print(val);
                        },
                        onWebResourceError: (WebResourceError err) {
                          print(err);
                        },
                        initialUrl: this.widget.url,

                      ),
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    if (this.widget.textAccepted == null) ...[
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
                              child: Text(this.widget.textAccepted),
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
                              child: Text(this.widget.textCancel),
                            )
                          ],
                        ),
                      )
                    ] else ...[
                      Center(
                        child: Container(
                          child: GestureDetector(
                            onTap: () {
                              Navigator.pop(context, true);
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(vertical: 15),
                              decoration: BoxDecoration(
                                color: Color.fromRGBO(0, 0, 102, 1),
                                borderRadius: BorderRadius.circular(40)
                              ),
                              child: Center(
                                child: Text(
                                  'SALIR', 
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: 'Montserrat',
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18
                                  )
                                ),
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
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
