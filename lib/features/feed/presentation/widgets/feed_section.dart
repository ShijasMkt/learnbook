import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:learnbook/core/utils/custom_sized_box.dart';
import 'package:learnbook/features/feed/data/models/feed_model.dart';
import 'package:learnbook/features/home/data/providers/home_data_provider.dart';
import 'package:learnbook/features/feed/presentation/widgets/feed_card.dart';

class FeedSection extends ConsumerWidget {
  const FeedSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final getHomeData = ref.watch(homeDataProvider);

    return getHomeData.when(
      data: (data) {
        final List<FeedModel> results = data.results;
        return ListView.separated(
          shrinkWrap: true,
          itemBuilder: (context, index) {
            final FeedModel feedData = results[index];
            return FeedCard(feedData: feedData);
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
    );
  }
}
