import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:starwars_app/src/data/data_sources/starwars_data_src.dart';
import 'package:starwars_app/src/data/model/model_startship.dart';

final startshipProvider = StateNotifierProvider<StartshipNotifier, AsyncValue<Map<String, ModelStartship>>>((ref) {
  return StartshipNotifier(ref);
});

class StartshipNotifier extends StateNotifier<AsyncValue<Map<String, ModelStartship>>> {
  StartshipNotifier(this._notifierProviderRef) : super(const AsyncValue.data({})) {
    _dataSource = _notifierProviderRef.watch(starWarsDataSrcProvider);
  }
  final StateNotifierProviderRef _notifierProviderRef;
  late final StarWarsDataSource _dataSource;
  final starshipMap = <String, ModelStartship>{};

  Future<void> getStartship(String idx, String url) async {
    final res = await AsyncValue.guard(() async => await _dataSource.startship(url));
    final modelStartship = ModelStartship.fromJson(res.value);
    final stringModel = <String, ModelStartship>{idx : modelStartship};
    starshipMap.addEntries(stringModel.entries);
    state = AsyncValue.data(starshipMap);
    // log('getStartship $idx | ${state.value!.entries.first.value.toJson()}');
  }
}
