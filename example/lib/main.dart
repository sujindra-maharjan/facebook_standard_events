import 'package:flutter/material.dart';

import 'package:facebook_standard_events/facebook_standard_events.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  void initState() {
    super.initState();
   logEvents();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: RaisedButton(onPressed: ()async {
            var facebookLogin = FacebookLogin();
            var result = await facebookLogin.logIn(['email']);

            switch (result.status) {
              case FacebookLoginStatus.loggedIn:
                var token = result.accessToken.token;
                break;
              case FacebookLoginStatus.cancelledByUser:
                facebookLogin.logOut();
                throw ("LoginFailed");
              case FacebookLoginStatus.error:
                facebookLogin.logOut();
                throw ("LoginFailed");
            }
          }, child: Text('Login with Facebook'),),
        ),
      ),
    );
  }

  void logEvents() {
    ///custom log event
    FacebookStandardEvents().logEvent(name: 'test_custom_event_ios',parameters: {'id':23123,'test':'erwqads'},valueToSum: 10);

    /// purchase log event
    FacebookStandardEvents().logPurchaseEvent(10.0, 'USD', {'purchaseID':'ios asdasd qwek3j2j423'});

    ///view content log event
    FacebookStandardEvents().logViewContentEvent('Live stream channel ios','qweqw1231io2n3ioinon','Livestream',null,null);
    FacebookStandardEvents().logViewContentEvent('Live stream Recording ios','qweqw1231io2n3ioinon','Video',null,null);

    ///subscribe log event
    FacebookStandardEvents().logSubscribeEvent('qweqw1231asdwerwefio2n3ioinon','XXX',300);
  }
}
