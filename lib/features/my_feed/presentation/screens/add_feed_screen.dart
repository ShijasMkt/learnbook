import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:learnbook/core/utils/custom_sized_box.dart';
import 'package:learnbook/core/utils/responsive.dart';
import 'package:learnbook/features/home/data/models/category_model.dart';
import 'package:learnbook/features/home/data/providers/category_list_provider.dart';

class AddFeedScreen extends ConsumerWidget {
  const AddFeedScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final getCategoryList = ref.watch(categoryListProvider);
    return Scaffold(
      appBar: _appBar(context),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              DottedBorder(
                options: RectDottedBorderOptions(
                  dashPattern: [10, 5],
                  strokeWidth: 2,
                  color: Colors.white24,
                ),
                child: Container(
                  padding: EdgeInsets.all(10),
                  height: context.width(260),
                  width: double.infinity,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        CupertinoIcons.cloud_upload,
                        color: Colors.white,
                        size: 40,
                      ),
                      context.customSizedBoxHgt(context, 10),
                      Text(
                        "Select a video from Gallery",
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ),
              context.customSizedBoxHgt(context, 20),
              DottedBorder(
                options: RectDottedBorderOptions(
                  dashPattern: [10, 5],
                  strokeWidth: 2,
                  color: Colors.white24,
                ),
                child: Container(
                  padding: EdgeInsets.all(10),
                  height: context.width(130),
                  width: double.infinity,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(CupertinoIcons.photo, color: Colors.white, size: 40),
                      context.customSizedBoxWdt(context, 10),
                      Text(
                        "Add a Thumbnail",
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ),
              context.customSizedBoxHgt(context, 20),
              Text(
                "Add Description",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              context.customSizedBoxHgt(context, 10),
              TextField(
                maxLines: 4,
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  labelText: "Description",
                  labelStyle: const TextStyle(color: Colors.white70),
                  hintText: "Enter description...",
                  hintStyle: const TextStyle(color: Colors.white38),

                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 14,
                  ),

                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: Colors.white24),
                  ),

                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: Colors.white),
                  ),

                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: Colors.red),
                  ),

                  focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: Colors.red),
                  ),
                ),
              ),
              context.customSizedBoxHgt(context, 20),
              Divider(color: Colors.white24),
              Text(
                "Categories This project",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              context.customSizedBoxHgt(context, 20),
              getCategoryList.when(
                data: (data) {
                  final List<CategoryModel> categories = data.categories;
                  return SizedBox(
                    child: GridView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                        maxCrossAxisExtent: 200,
                        crossAxisSpacing: 8,
                        mainAxisSpacing: 8,
                        childAspectRatio: 3,
                      ),
                      itemCount: categories.length,
                      itemBuilder: (context, index) {
                        final CategoryModel category = categories[index];

                        return Container(
                          alignment: Alignment.center,
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            border: Border.all(color: Colors.white24),
                          ),
                          child: Text(
                            category.title,
                            textAlign: TextAlign.center,
                            style: const TextStyle(color: Colors.white),
                          ),
                        );
                      },
                    ),
                  );
                },
                error: (error, stackTrace) => Center(
                  child: Text(
                    error.toString(),
                    style: TextStyle(color: Colors.red),
                  ),
                ),
                loading: () => const Center(child: CircularProgressIndicator()),
              ),
            ],
          ),
        ),
      ),
    );
  }

  AppBar _appBar(BuildContext context) {
    return AppBar(
      backgroundColor: Color(0xff171717),
      leading: IconButton.outlined(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: Icon(CupertinoIcons.chevron_back, color: Colors.white),
      ),
      title: Text("Add Feeds", style: TextStyle(color: Colors.white)),
      actions: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          decoration: BoxDecoration(
            color: const Color(0xffC700000).withOpacity(0.3),
            border: Border.all(color: Colors.red.shade400),
            borderRadius: BorderRadius.circular(30),
          ),
          child: Text("Share Post", style: TextStyle(color: Colors.white)),
        ),
      ],
    );
  }
}
