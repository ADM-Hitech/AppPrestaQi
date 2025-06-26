import 'package:flutter/material.dart';
import 'package:prestaqi/pages/index_auth/content.dart';

class IndexAuthPage extends StatefulWidget {
  const IndexAuthPage({ super.key });

  @override
  IndexAuthState createState() => IndexAuthState();
}

class IndexAuthState extends State<IndexAuthPage> {

  double getFontSize() {
    double height = MediaQuery.of(context).size.height;

    if (height > 900) {
      return 55.0;
    } else if (height < 900 && height > 670) {
      return 45.0;
    } else if (height < 670){
      return 33.0;
    } else {
      return 50.0;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: indexAuthBody(state: this),
    );
  }
}