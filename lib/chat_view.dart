import 'package:flutter/material.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';
//import 'package:stream_chat_localizations/stream_chat_localizations.dart';

class ChatView extends StatelessWidget {
  /// Example using Stream's Flutter package.
  ///
  /// If you'd prefer using minimal wrapper widgets for your app, please see
  /// our other package, `stream_chat_flutter_core`.
  const ChatView({
    super.key,
    required this.client,
    required this.channel,
  });

  /// Instance of Stream Client.
  ///
  /// Stream's [StreamChatClient] can be used to connect to our servers and
  /// set the default user for the application. Performing these actions
  /// trigger a websocket connection allowing for real-time updates.
  final StreamChatClient client;

  /// Instance of the Channel
  final Channel channel;

  @override
  Widget build(BuildContext context) => MaterialApp(
    theme: ThemeData.light(),
    //darkTheme: ThemeData.dark(),
    supportedLocales: const [
      Locale('en'),
      Locale('hi'),
      Locale('fr'),
      Locale('it'),
      Locale('es'),
    ],
    //localizationsDelegates: GlobalStreamChatLocalizations.delegates,
    builder: (context, widget) => StreamChat(
      client: client,
      child: widget,
    ),
    home: StreamChannel(
      channel: channel,
      child: const ChannelPage(),
    ),
  );
}

/// A list of messages sent
/// the current channel.
///
/// This is implemented using [StreamMessageListView],
/// a widget that provides query
/// functionalities fetching the messages from the api and showing them in a
/// listView.
class ChannelPage extends StatelessWidget {
  /// Creates the page that shows the list of messages
  const ChannelPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: const StreamChannelHeader(),
    body: Column(
      children: const <Widget>[
        Expanded(
          child: StreamMessageListView(),
        ),
        StreamMessageInput(attachmentLimit: 3),
      ],
    ),
  );
}