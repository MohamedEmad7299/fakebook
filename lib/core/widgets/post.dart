import 'package:fakebook/core/widgets/components.dart';
import 'package:flutter/material.dart';

import 'ExpandableText.dart';

class Post extends StatelessWidget {
  const Post({super.key});

  static const tags = [
    '#flutter',
    '#dart',
    '#programming',
    '#mobiledevelopment',
    '#appdevelopment',
    '#softwareengineering',
    '#coding',
    '#developer',
    '#tech',
    '#technology',
    '#opensource',
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Card(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        child: IntrinsicHeight( // Add this to help with height calculation
          child: Column(
            mainAxisSize: MainAxisSize.min, // Add this line
            children: [
              Padding(
                padding: const EdgeInsetsDirectional.only(
                    start: 16, end: 16, top: 16, bottom: 8),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 32,
                      backgroundImage: AssetImage(
                        'assets/images/user_avatar.jpg',
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded( // Add Expanded to prevent overflow
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min, // Add this
                        children: [
                          Row(
                            children: [
                              Flexible( // Wrap text in Flexible
                                child: Text(
                                  'Mohamed Emad',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 8),
                              Icon(
                                Icons.verified,
                                color: Colors.blue,
                                size: 16,
                              ),
                            ],
                          ),
                          Text(
                            '2 hours ago',
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.more_horiz),
                      onPressed: () {
                        // Handle more options
                      },
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Divider(height: 1), // Reduce divider height
              ),
              // ExpandableText(
              //   text: 'This is a sample post caption. It can be a brief description or a thought shared by the user.'
              // '\nThis is a sample post caption. It can be a brief description or a thought shared by the user.',
              //   maxLines: 2,
              // ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Expanded(
                      child: Wrap(
                        spacing: 4.0,
                        runSpacing: 4.0,
                        crossAxisAlignment: WrapCrossAlignment.start,
                        alignment: WrapAlignment.start,
                        runAlignment: WrapAlignment.start,
                        children: tags.map((tag) {
                          return Text(
                            tag,
                            style: TextStyle(
                              color: Colors.blue,
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Image.asset(
                    'assets/images/attachment_2.png',
                    fit: BoxFit.cover,
                    // Remove any height constraint here if you had one
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16 , vertical: 8.0),
                child: Row(
                  children: [
                    Icon(
                      Icons.favorite_border,
                      color: Colors.red,
                    ),
                    const SizedBox(width: 4),
                    Text('123', style: TextStyle(fontSize: 14)),
                    Spacer(),
                    Icon(
                      Icons.comment_outlined,
                      color: Colors.yellow,
                    ),
                    const SizedBox(width: 4),
                    Text('45  ' + 'Comments', style: TextStyle(fontSize: 14)),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Divider(height: 1), // Reduce divider height
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8.0),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 16,
                      backgroundImage: AssetImage(
                        'assets/images/user_avatar.jpg',
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: 'Write a comment...',
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    GestureDetector(
                      onTap: () {
                        toast(msg: "msg");
                      },
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            size: 20,
                            Icons.favorite_border,
                            color: Colors.red,
                          ),
                          SizedBox(width: 8),
                          Text(
                            'Like',
                            style: TextStyle(color: Colors.grey, fontSize: 14),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 16),
                    GestureDetector(
                      onTap: () {
                        toast(msg: "msg");
                      },
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            size: 20,
                            Icons.ios_share,
                            color: Colors.green,
                          ),
                          SizedBox(width: 8),
                          Text(
                            'Share',
                            style: TextStyle(color: Colors.grey, fontSize: 14),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
