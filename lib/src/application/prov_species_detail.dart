import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:starwars_app/src/data/data_sources/starwars_data_src.dart';
import 'package:starwars_app/src/data/model/model_species_detail.dart';

final provSpeciesDetail = StateNotifierProvider.autoDispose<NotifierSpeciesDetail, AsyncValue<ModelSpeciesDetail>>((ref) 
    => NotifierSpeciesDetail(ref));

class NotifierSpeciesDetail extends StateNotifier<AsyncValue<ModelSpeciesDetail>> {
  final AutoDisposeStateNotifierProviderRef _provider;
  late final StarWarsDataSource _dataSource;

  NotifierSpeciesDetail(this._provider) : super(AsyncValue.data(ModelSpeciesDetail())) {
    _dataSource = _provider.watch(starWarsDataSrcProvider);
  }

  Future<void> speciesDetail(String detailUrl) async {
    state = const AsyncLoading();
    final res = await AsyncValue.guard(() async => await _dataSource.speciesDetail(detailUrl));
    state = AsyncValue.data(res.asData!.value);
  }

}