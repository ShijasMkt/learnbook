import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:learnbook/core/utils/custom_sized_box.dart';
import 'package:learnbook/core/utils/responsive.dart';
import 'package:learnbook/features/home/data/models/feed_model.dart';
import 'package:learnbook/features/home/data/models/user_model.dart';
import 'package:learnbook/features/home/presentation/widgets/feed_video.dart';

class FeedCard extends StatelessWidget {
  final FeedModel feedData;
  const FeedCard({super.key, required this.feedData});

  String formatDate(String dateString) {
    final date = DateTime.parse(dateString);
    return DateFormat('d MMMM yyyy').format(date);
  }

  @override
  Widget build(BuildContext context) {
    final UserModel feedUser = feedData.user;

    return Container(
      padding: EdgeInsets.all(10),
      color: Colors.black54,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              ClipOval(
                child: feedUser.image != null
                    ? Image.network(
                        feedUser.image!,
                        height: context.width(35),
                        width: context.width(35),
                      )
                    : SizedBox(
                        width: context.width(35),
                        height: context.width(35),
                        child: Icon(Icons.broken_image, color: Colors.white),
                      ),
              ),
              context.customSizedBoxWdt(context, 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(feedUser.name!, style: TextStyle(color: Colors.white)),
                  context.customSizedBoxHgt(context, 2),
                  Text(
                    formatDate(feedData.createdAt),
                    style: TextStyle(color: Colors.white, fontSize: 12),
                  ),
                ],
              ),
            ],
          ),
          context.customSizedBoxHgt(context, 10),
          FeedVideo(videoUrl: feedData.video, thumbnailUrl: feedData.image),
          context.customSizedBoxHgt(context, 20),
          Text(
            feedData.description,
            style: TextStyle(color: Colors.white, fontSize: 12),
          ),
          context.customSizedBoxHgt(context, 10),
        ],
      ),
    );
  }
}
