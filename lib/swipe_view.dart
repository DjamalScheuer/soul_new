import 'swipe/bottom_buttons_row.dart';
import 'swipe/card_overlay.dart';
import 'swipe/example_card.dart';
import 'swipe/general_drawer.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:swipable_stack/swipable_stack.dart';


const _images = [
  'assets/image_5.jpg',
  'assets/image_3.jpg',
  'assets/image_4.jpg',
];

class SwipeView extends StatefulWidget {
  const SwipeView({super.key});

  @override
  _SwipeViewState createState() => _SwipeViewState();
}

class _SwipeViewState extends State<SwipeView> {
  late final SwipableStackController _controller;

  void _listenController() => setState(() {});

  @override
  void initState() {
    super.initState();
    _controller = SwipableStackController()..addListener(_listenController);
  }

  @override
  void dispose() {
    super.dispose();
    _controller
      ..removeListener(_listenController)
      ..dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('BasicExample'),
      ),
      drawer: const GeneralDrawer(),
      body: SafeArea(
        top: false,
        child: Stack(
          children: [
            Positioned.fill(
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: SwipableStack(
                  detectableSwipeDirections: const {
                    SwipeDirection.right,
                    SwipeDirection.left,
                  },
                  controller: _controller,
                  stackClipBehaviour: Clip.none,
                  onSwipeCompleted: (index, direction) {
                    if (kDebugMode) {
                      print('$index, $direction');
                    }
                  },
                  horizontalSwipeThreshold: 0.8,
                  verticalSwipeThreshold: 0.8,
                  builder: (context, properties) {
                    final itemIndex = properties.index % _images.length;

                    return Stack(
                      children: [
                        ExampleCard(
                          name: 'Sample No.${itemIndex + 1}',
                          assetPath: _images[itemIndex],
                        ),
                        // more custom overlay possible than with overlayBuilder
                        if (properties.stackIndex == 0 &&
                            properties.direction != null)
                          CardOverlay(
                            swipeProgress: properties.swipeProgress,
                            direction: properties.direction!,
                          )
                      ],
                    );
                  },
                ),
              ),
            ),
            BottomButtonsRow(
              onSwipe: (direction) {
                _controller.next(swipeDirection: direction);
              },
              onRewindTap: _controller.rewind,
              canRewind: _controller.canRewind,
            ),
          ],
        ),
      ),
    );
  }
}