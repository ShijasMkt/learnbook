import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:learnbook/core/utils/custom_sized_box.dart';
import 'package:learnbook/features/feed/data/models/feed_model.dart';
import 'package:learnbook/features/feed/presentation/widgets/feed_card.dart';
import 'package:learnbook/features/my_feed/data/providers/my_feed_data_provider.dart';

class MyFeedScreen extends ConsumerWidget {
  const MyFeedScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final getMyFeedData = ref.watch(myFeedDataProvider);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff171717),
        leading: IconButton.outlined(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(CupertinoIcons.chevron_back, color: Colors.white),
        ),
        title: Text("My Feed", style: TextStyle(color: Colors.white)),
      ),
      body: getMyFeedData.when(
        data: (data) {
          final List<FeedModel> results = data.results;
          return ListView.separated(
            shrinkWrap: true,
            itemBuilder: (context, index) {
              final FeedModel feedData = results[index];
              return FeedCard(feedData: feedData, myFeed: true);
            },
            separatorBuilder: (context, index) =>
                context.customSizedBoxHgt(context, 10),
            itemCount: results.length,
          );
        },
        error: (error, stackTrace) => Center(
          child: Text(error.toString(), style: TextStyle(color: Colors.red)),
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
      ),
    );
  }
}
