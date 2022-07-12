import 'package:flutter/material.dart';
import 'package:new_soul/card_view.dart';
import 'package:swipeable_card_stack/swipeable_card_stack.dart';

class SwipeView extends StatefulWidget {
  SwipeView({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _SwipeViewState createState() => _SwipeViewState();
}

class _SwipeViewState extends State<SwipeView> {
  int counter = 4;

  @override
  Widget build(BuildContext context) {
    //create a CardController
    SwipeableCardSectionController _cardController =
        SwipeableCardSectionController();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff7986cb),
        leading: const IconButton(
          icon: Icon(Icons.menu, color: Color(0xffffe1ec)),
          tooltip: 'Navigation menu',
          onPressed: null,
        ),
        title: const Text('Yes or no questions'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SwipeableCardsSection(
            cardController: _cardController,
            context: context,
            //add the first 3 cards
            items: [
              CardView(
                text: "Do you like the mountains?",
                image: "assets/image_1.jpg",
              ),
              CardView(
                  text: "Do you like Donald Trump?",
                  image: "assets/image_2.jpg"),
              CardView(
                  text: "Do you like liquorice?", image: "assets/image_3.jpg"),
            ],
            onCardSwiped: (dir, index, widget) {
              //Add the next card
              if (counter <= 20) {
                _cardController.addItem(CardView(
                    text: "Do you like Card $counter???",
                    image: "assets/image_1.jpg"));
                counter++;
              }

              if (dir == Direction.left) {
                print('onDisliked ${(widget as CardView).text} $index');
              } else if (dir == Direction.right) {
                print('onLiked ${(widget as CardView).text} $index');
              } else if (dir == Direction.up) {
                print('onUp ${(widget as CardView).text} $index');
              }

              //else if (dir == Direction.down) {
              //  print('onDown ${(widget as CardView).text} $index');
              //}
            },
            enableSwipeUp: true,
            //enableSwipeDown: true,
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                FloatingActionButton(
                  backgroundColor: Color(0xffe57373),
                  child: Icon(Icons.thumb_down),
                  onPressed: () => _cardController.triggerSwipeLeft(),
                ),
                FloatingActionButton(
                  backgroundColor: Color(0xffffb74d),
                  child: Icon(Icons.block),
                  onPressed: () => _cardController.triggerSwipeUp(),
                ),
                FloatingActionButton(
                  backgroundColor: Color(0xff81c784),
                  child: Icon(Icons.thumb_up),
                  onPressed: () => _cardController.triggerSwipeRight(),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
