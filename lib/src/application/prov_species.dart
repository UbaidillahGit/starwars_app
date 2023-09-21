import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:starwars_app/src/data/data_sources/starwars_data_src.dart';
import 'package:starwars_app/src/data/model/model_species.dart';

final provSpecies = StateNotifierProvider<NotifierSpeciesList, AsyncValue<ModelSpecies>>((ref) 
    => NotifierSpeciesList(ref));

class NotifierSpeciesList extends StateNotifier<AsyncValue<ModelSpecies>> {
  final StateNotifierProviderRef _provider;
  late final StarWarsDataSource _dataSource;

  ///____ Nullable variable used to define the results of all species and for next pagination
  List<Results>? results;
  bool isLoadingPagination = false;

  NotifierSpeciesList(this._provider) : super(AsyncValue.data(ModelSpecies())) {
    _dataSource = _provider.watch(starWarsDataSrcProvider);
  }

  Future<void> listSpecies() async {
    state = const AsyncLoading();
    final res = await AsyncValue.guard(() async => await _dataSource.speciesList());
    state = AsyncValue.data(res.asData!.value);
  }

  Future<void> paginationSpecies(String url) async {
    final String? nextUrl = state.value?.next;
    isLoadingPagination = true;
    log('paginationSpecies $nextUrl');
    if (nextUrl != null) {
      final res = await AsyncValue.guard(() async => await _dataSource.speciesPagination(nextUrl));

      if (state.value?.results != null) {
        for (var i = 0; i < res.value!.results!.length; i++) {
          state.value?.results!.add(res.value!.results![i]);
        }
      }
      state = AsyncValue.data(state.asData!.value);
      isLoadingPagination = false;
    }
  }
}
