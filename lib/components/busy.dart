import 'package:flutter/material.dart';

class BusyWidget extends StatelessWidget {
  final Widget child;
  final bool busy;
  BusyWidget({@required this.child, @required this.busy})
      : assert(busy != null && child != null);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          child,
          busy
              ? Stack(
                  children: [
                    ModalBarrier(
                        dismissible: false,
                        color: Colors.black.withOpacity(0.5)),
                    Center(
                      child: Text('Loading...',
                          style: TextStyle(
                              fontStyle: FontStyle.italic,
                              fontSize: 16,
                              color: Colors.white)),
                    )
                  ],
                )
              : Container()
        ],
      ),
    );
  }
}
