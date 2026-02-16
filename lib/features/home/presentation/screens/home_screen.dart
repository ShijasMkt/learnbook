import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:learnbook/core/utils/custom_sized_box.dart';
import 'package:learnbook/core/utils/responsive.dart';
import 'package:learnbook/features/home/data/models/category_model.dart';
import 'package:learnbook/features/home/data/providers/category_list_provider.dart';
import 'package:learnbook/features/home/presentation/widgets/feed_section.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final getCategoryList = ref.watch(categoryListProvider);

    return Scaffold(
      appBar: _appBar(context),
      body: getCategoryList.when(
        data: (data) {
          final List<CategoryModel> categories = data.categories;
          return Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                context.customSizedBoxHgt(context, 10),
                _categoryRow(context, categories),
                context.customSizedBoxHgt(context, 20),
                Expanded(child: FeedSection()),
              ],
            ),
          );
        },
        error: (error, stackTrace) => Center(
          child: Text(error.toString(), style: TextStyle(color: Colors.red)),
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
      ),
      floatingActionButton: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: Colors.red,
        ),
        child: Icon(Icons.add, size: 40, color: Colors.white),
      ),
    );
  }

  AppBar _appBar(BuildContext context) {
    return AppBar(
      backgroundColor: Color(0xff171717),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Hello Maria",
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          context.customSizedBoxHgt(context, 5),
          Text(
            "Welcome back to section",
            style: TextStyle(color: Colors.white, fontSize: 12),
          ),
        ],
      ),
      actions: [
        ClipOval(
          child: Image.asset(
            "assets/images/Logo.png",
            width: context.width(45),
            height: context.width(45),
          ),
        ),
      ],
      actionsPadding: EdgeInsets.only(right: 10),
    );
  }

  SizedBox _categoryRow(BuildContext context, List<CategoryModel> categories) {
    return SizedBox(
      height: context.width(40),
      child: ListView.separated(
        reverse: true,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          final CategoryModel category = categories[index];
          return Container(
            padding: EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              border: Border.all(color: Colors.white24),
            ),
            child: Center(
              child: Text(
                category.title,
                style: TextStyle(color: Colors.white),
              ),
            ),
          );
        },
        separatorBuilder: (context, index) =>
            context.customSizedBoxWdt(context, 5),
        itemCount: categories.length,
        scrollDirection: Axis.horizontal,
      ),
    );
  }
}
