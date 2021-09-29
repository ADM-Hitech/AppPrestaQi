import 'package:advance_pdf_viewer/advance_pdf_viewer.dart';
import 'package:flutter/material.dart';
import 'package:prestaQi/Screens/MyAdvances/my_advances.dart';
import 'package:prestaQi/Utils/HexColor.dart';

class MyAdvancesContent extends StatelessWidget {

  final MyAdvancesState state;

  MyAdvancesContent({Key key, @required this.state});

  @override
  Widget build(BuildContext context) {
    return new Container(
      height: this.state.screen.height,
      width: this.state.screen.width,
      child: Stack(
        children: [
          Positioned(
            top: 0,
            child: Container(
              height: 290,
              width: this.state.screen.width,
              decoration: BoxDecoration(
                color: HexColor.fromHex('#1292ff'),
                image: DecorationImage(
                  image: AssetImage('assets/images/background_header.png'),
                  fit: BoxFit.none,
                  alignment: Alignment.bottomCenter
                )
              ),
            ),
          ),
          Positioned(
            top: 95.0,
            child: Container(
              width: this.state.screen.width,
              height: this.state.screen.height - 90,
              padding: EdgeInsets.all(25),
              decoration: BoxDecoration(
                color: HexColor.fromHex('#eff4ff'),
                borderRadius: BorderRadius.only(topRight: Radius.circular(70)),
                boxShadow: [
                  BoxShadow(
                    color: Color.fromRGBO(0, 0, 102, .4),
                    spreadRadius: 5,
                    blurRadius: 50,
                    offset: Offset(0, 3)
                  )
                ]
              ),
              child: (this.state.loading) ? 
                Center(
                  child: CircularProgressIndicator(),
                ) :  
                ListView.builder(
                  padding: EdgeInsets.only(top: 15, left: 0, right: 0, bottom: 0),
                  physics: BouncingScrollPhysics(),
                  itemCount: 1,
                  itemBuilder: (cntx, i) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: (this.state.screen.width * .75) + 25,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(child: FittedBox(
                                fit: BoxFit.contain,
                                child: Text(
                                  'Mis adelantos',
                                  style: TextStyle(
                                    color: Color.fromRGBO(0, 0, 102, 1),
                                    fontWeight: FontWeight.bold
                                  ),
                                ),
                              )),
                              Container(
                                margin: EdgeInsets.only(left: 25),
                                child: IconButton(
                                  iconSize: 37,
                                  color: Theme.of(context).primaryColor,
                                  alignment: Alignment.bottomCenter,
                                  icon: Icon(Icons.download_rounded),
                                  onPressed: this.state.downloading ? null : this.state.downloadPDF
                                ),
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 25,
                        ),
                        if (this.state.downloading)
                          Container(
                            child: LinearProgressIndicator(
                              value: this.state.progress
                            ),
                          )
                        ,
                        Container(
                          height: this.state.screen.height - 250,
                          child: PDFViewer(
                            document: this.state.doc,

                          ),
                        )
                      ],
                    );
                  },
                ),
            ),
          )
        ],
      ),
    );
  }
}