import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:starwars_app/src/infrastructure/data_sources/starwars_data_src.dart';
import 'package:starwars_app/src/data/model/model_people_detail.dart';

final provPeopleDetail = StateNotifierProvider.autoDispose<NotifierPeopleDetail, AsyncValue<ModelPeopleDetail>>((ref) 
    => NotifierPeopleDetail(ref));

class NotifierPeopleDetail extends StateNotifier<AsyncValue<ModelPeopleDetail>> {
  final AutoDisposeStateNotifierProviderRef _provider;
  late final StarWarsDataSource _dataSource;

  NotifierPeopleDetail(this._provider) : super(AsyncValue.data(ModelPeopleDetail())) {
    _dataSource = _provider.watch(starWarsDataSrcProvider);
  }

  Future<void> peopleDetail(String detailUrl) async {
    state = const AsyncLoading();
    final res = await AsyncValue.guard(() async => await _dataSource.peopleDetail(detailUrl));
    state = AsyncValue.data(res.asData!.value);
  }
}