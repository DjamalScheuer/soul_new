
import 'package:flutter/material.dart';
import 'package:group_list_view/group_list_view.dart';
import 'package:new_soul/chat_view.dart';
import 'app_colors.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';


Map<String, List> _elements = {
  'Group A': ['Klay Lewis', 'Ehsan Woodard', 'River Bains'],
  'Group B': ['Toyah Downs', 'Tyla Kane'],
  'Group C': ['Marcus Romero', 'Farrah Parkes', 'Fay Lawson', 'Asif Mckay'],
  'Group D': ['Casey Zuniga', 'Ayisha Burn', 'Josie Hayden', 'Kenan Walls', 'Mario Powers'],
  'Group Q': ['Toyah Downs', 'Tyla Kane', 'Toyah Downs'],
};


class ContactView extends StatefulWidget {
  const ContactView({
    super.key,
    required this.client,
    required this.channel,
  });

  final StreamChatClient client;
  final Channel channel;

  @override
  _ContactViewState createState() => _ContactViewState();
}

class _ContactViewState extends State<ContactView> {

  @override
  Widget build(BuildContext context) {
    return GroupListView(
      sectionsCount: _elements.keys.toList().length,
      countOfItemInSection: (int section) {
        return _elements.values.toList()[section].length;
      },
      itemBuilder: _itemBuilder,
      groupHeaderBuilder: (BuildContext context, int section) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
          child: Text(
            _elements.keys.toList()[section],
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
          ),
        );
      },
      separatorBuilder: (context, index) => SizedBox(height: 10),
      sectionSeparatorBuilder: (context, section) => SizedBox(height: 10),
    );
  }

  Widget _itemBuilder(BuildContext context, IndexPath index) {
    String user = _elements.values.toList()[index.section][index.index];
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Card(
        elevation: 8,
        child: ListTile(
          contentPadding:
          const EdgeInsets.symmetric(horizontal: 18, vertical: 10.0),
          leading: CircleAvatar(
            child: Text(
              _getInitials(user),
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
            backgroundColor: _getAvatarColor(user),
          ),
          title: Text(
            _elements.values.toList()[index.section][index.index],
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
          ),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ChatView(client: widget.client, channel: widget.channel)),
            );
          },
          trailing: Icon(Icons.arrow_forward_ios),
        ),
      ),
    );
  }

  String _getInitials(String user) {
    var buffer = StringBuffer();
    var split = user.split(" ");
    for (var s in split) buffer.write(s[0]);

    return buffer.toString().substring(0, split.length);
  }

  Color _getAvatarColor(String user) {
    return AppColors
        .avatarColors[user.hashCode % AppColors.avatarColors.length];
  }
}
