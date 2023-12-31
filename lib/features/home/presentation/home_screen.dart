import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../core/core.dart';
import '../../../features/home/presentation/widgets/home_slider.dart';
import '../application/home_provider.dart';
import 'widgets/home_category.dart';
import 'widgets/home_latest_product.dart';
import 'widgets/home_search.dart';

class HomeScreen extends HookConsumerWidget {
  static const route = '/home';

  const HomeScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //. -- Refresh Controller --
    final refreshController = useMemoized(
        () => RefreshController(initialLoadStatus: LoadStatus.canLoading));

    return Scaffold(
      appBar: KAppBar(
        title: Images.logoSmall.assetImage(height: kToolbarHeight - 36.h),
        actions: [
          IconButton(
            onPressed: () => showSearch(
              context: context,
              delegate: HomeSearch(ref),
            ),
            icon: const Icon(Icons.search),
          ),
        ],
      ),
      body: SmartRefresher(
        controller: refreshController,
        onRefresh: () => ref
            .refresh(homeDataProvider.future)
            .then((value) => refreshController.refreshCompleted()),
        child: SingleChildScrollView(
          padding: padding0,
          child: Column(
            children: [
              const HomeSlider(),
              gap36,
              const HomeCategoryWidget(),
              gap36,
              const HomeLatestProductWidget(),
              Images.home.assetImage(),
            ],
          ),
        ),
      ),
    );
  }
}
