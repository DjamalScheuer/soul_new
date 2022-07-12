
import 'package:flutter/material.dart';
import 'user.dart';
import 'user_preferences.dart';
import 'appbar_widget.dart';
import 'button_widget.dart';
import 'numbers_widget.dart';
import 'profile_widget.dart';
import 'edit_profile_page.dart';



class ProfileView extends StatefulWidget {
  @override
  _ProfileViewState createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  @override
  Widget build(BuildContext context) {
    final user = UserPreferences.myUser;

    return Scaffold(
      //appBar: buildAppBar(context),
      appBar: AppBar(
        backgroundColor: Color(0xff7986cb),
        leading: const IconButton(
          icon: Icon(Icons.person, color: Color(0xffffe1ec)),
          tooltip: 'Navigation menu',
          onPressed: null,
        ),
        title: const Text('My profile'),
        // actions: const [
        //   IconButton(
        //     icon: Icon(Icons.search),
        //     tooltip: 'Search',
        //     onPressed: null,
        //   ),
        // ],
      ),
//        body: Container(
//          decoration: BoxDecoration(
//            gradient: LinearGradient(
//              colors: [
//                Color(0xffffb74d),
//                Color(0xfff06292),
//                Color(0xff9575cd),
//              ],
//              stops: [
//                0.2,
//                0.7,
//                1,
//              ],
//              begin: Alignment.topRight,
//              end: Alignment.bottomLeft,
//            ),
//          ),
//        ),
      body: ListView(
        physics: BouncingScrollPhysics(),
        children: [
          ProfileWidget(
            imagePath: user.imagePath,
            onClicked: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => EditProfilePage()),
              );
            },
          ),
          const SizedBox(height: 24),
          buildName(user),
          const SizedBox(height: 24),
          Center(child: buildUpgradeButton()),
          const SizedBox(height: 24),
          NumbersWidget(),
          const SizedBox(height: 48),
          buildAbout(user),
        ],
      ),
    );
  }

  Widget buildName(User user) => Column(
    children: [
      Text(
        user.name,
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
      ),
      const SizedBox(height: 4),
      Text(
        user.email,
        style: TextStyle(color: Colors.grey),
      )
    ],
  );

  Widget buildUpgradeButton() => ButtonWidget(
    text: 'Upgrade To PRO',
    onClicked: () {},
  );

  Widget buildAbout(User user) => Container(
    padding: EdgeInsets.symmetric(horizontal: 48, vertical: 10),
    margin: EdgeInsets.symmetric(horizontal: 15),
    decoration: BoxDecoration(
      color: Color(0xffd1eaff),
      borderRadius: BorderRadius.circular(15),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'About me',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        Text(
          user.about,
          style: TextStyle(fontSize: 16, height: 1.4),
        ),
      ],
    ),
  );
}