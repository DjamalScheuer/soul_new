
import 'package:flutter/material.dart';
import 'app_colors.dart';
import 'package:flutter/cupertino.dart';
import 'profile_view.dart';
import 'contact_view.dart';
import 'swipe_view.dart';
import 'chat_view.dart';

import 'package:stream_chat_flutter/stream_chat_flutter.dart';
//import 'package:stream_chat_localizations/stream_chat_localizations.dart';


void main() async{

  WidgetsFlutterBinding.ensureInitialized();

  /// Create a new instance of [StreamChatClient] passing the apikey obtained
  /// from your project dashboard.
  final client = StreamChatClient(
    's2dxdhpxd94g',
    logLevel: Level.INFO,
  );

  /// Set the current user and connect the websocket. In a production
  /// scenario, this should be done using a backend to generate a user token
  /// using our server SDK.
  ///
  /// Please see the following for more information:
  /// https://getstream.io/chat/docs/ios_user_setup_and_tokens/
  await client.connectUser(
    User(id: 'super-band-9'),
    '''eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoic3VwZXItYmFuZC05In0.0L6lGoeLwkz0aZRUcpZKsvaXtNEDHBcezVTZ0oPq40A''',
  );

  final channel = client.channel('messaging', id: 'godevs');

  await channel.watch();

  //runApp(MyApp());

  runApp(
    MyApp(
      client: client,
      channel: channel,
    ),
  );

}


class MyApp extends StatelessWidget {

  const MyApp({
    super.key,
    required this.client,
    required this.channel,
  });

  final StreamChatClient client;
  final Channel channel;


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.pink,
      ),
      //home: MyHomePage(title: 'Soul'),
      home: DefaultTabController(
        length: 4,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Color(0xffe04c7e),
            leading: const IconButton(
              icon: Icon(Icons.settings,color: Color(0xffffe1ec)),
              tooltip: 'Navigation menu',
              onPressed: null,
            ),
            title: const Text('Soul'),
          ),
          bottomNavigationBar: menu(),
          body: TabBarView(
            physics: NeverScrollableScrollPhysics(),
            children: [
              SwipeView(title: 'Soul'),
              ProfileView(),
              ContactView(client: client, channel: channel),
              ChatView(client: client, channel: channel),//ContactView(),
            ],
          ),
        ),
      ),
    );
  }

  Widget menu() {
    return Container(
      color: Color(0xffe04c7e),
      child: TabBar(
        tabs: [
          Tab(text: 'Swipe', icon: Icon(Icons.help)),
          Tab(text: 'Profile', icon: Icon(Icons.person)),
          Tab(text: 'Settings', icon: Icon(Icons.format_list_bulleted)),
          Tab(text: 'Chat', icon: Icon(Icons.chat)),
        ],
      ),
    );
  }
}



