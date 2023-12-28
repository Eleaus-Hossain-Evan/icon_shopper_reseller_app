import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/core.dart';
import '../../../features/home/domain/home_response.dart';
import '../../../features/home/domain/paginated_product_response.dart';
import '../infrastructure/home_repo.dart';

part 'home_provider.g.dart';

// @riverpod
// class HomeData extends _$HomeData {
//   @override
//   FutureOr<HomeResponse> build() async {
//     return HomeResponse.init();
//   }

//   void getData() async {
//     state = const AsyncLoading();

//     state = await AsyncValue.guard(() async {
//       final result = await HomeRepo().getHomeData();
//       return result.fold((l) {
//         showErrorToast(l.error.message);
//         return HomeResponse.init();
//       }, (r) => r);
//     });
//   }
// }

final homeDataProvider = FutureProvider<HomeResponse>((ref) async {
  final result = await HomeRepo().getHomeData();
  return result.fold((l) {
    showErrorToast(l.error.message);
    return HomeResponse.init();
  }, (r) => r);
}, name: 'homeDataProvider');

class HomeDataNotifier extends AsyncNotifier<HomeResponse> {
  @override
  FutureOr<HomeResponse> build() async {
    return HomeResponse.init();
  }

  void getData() async {
    state = const AsyncLoading();

    state = await AsyncValue.guard(() async {
      final result = await HomeRepo().getHomeData();
      return result.fold((l) {
        showErrorToast(l.error.message);
        return HomeResponse.init();
      }, (r) => r);
    });
  }
}

@riverpod
class SearchProduct extends _$SearchProduct {
  @override
  FutureOr<PaginatedProductResponse> build(
    String query, {
    int page = 1,
  }) async {
    final result = await HomeRepo().searchProduct(query, page: page);
    return result.fold((l) {
      showErrorToast(l.error.message);
      return PaginatedProductResponse.init();
    }, (r) => r);
  }
}
