
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:starwars_app/src/infrastructure/data_sources/starwars_data_src.dart';
import 'package:starwars_app/src/data/model/model_people.dart';

final searchProvider = StateNotifierProvider<HomeSearchNotifier, AsyncValue<ModelPeople>?>((ref) {
  return HomeSearchNotifier(ref);
});

class HomeSearchNotifier extends StateNotifier<AsyncValue<ModelPeople>?> {
  HomeSearchNotifier(this._notifierProviderRef): super(null) {
    _dataSource = _notifierProviderRef.watch(starWarsDataSrcProvider);
  }
  
  final StateNotifierProviderRef _notifierProviderRef;
  late final StarWarsDataSource _dataSource;

  Future<void> search({required String keyword}) async {
    if (keyword.isNotEmpty) {
      state = const AsyncLoading(); ///_____ Set state on loading when keyword is valid
      final res = await AsyncValue.guard(() async => await _dataSource.searchPeople(keyword));
      state = AsyncData(res.asData!.value);
    } else {
      ///_____ Set state on null when there's no keyword provided
      ///_____ so the search result would be back to null
      state = null;
    }
  }
}