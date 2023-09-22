import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:starwars_app/src/presentation/utils/reusable_widget/custom_text.dart';
import 'package:starwars_app/src/application/prov_homeworld.dart';
import 'package:starwars_app/src/application/prov_people_detail.dart';
import 'package:starwars_app/src/presentation/detail/components/info_field.dart';
import 'package:starwars_app/src/presentation/home/components/home_refresh_loading.dart';

class HomeworldExpansion extends ConsumerWidget {
  const HomeworldExpansion({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final watchPeopleDetail = ref.watch(provPeopleDetail);
    final watchHomeworld = ref.watch(homeworldProvider);

    final getIdFromUrlString = watchPeopleDetail.value?.homeworld?.replaceAll(RegExp(r'[^0-9]'), '');

    return ExpansionTile(
      tilePadding: EdgeInsets.zero,
      iconColor: Colors.blue,
      collapsedIconColor: Colors.blue,
      title: CustomText().starjediWhite(txt: 'homeworld'),
      childrenPadding: const EdgeInsets.only(left: 20),
      onExpansionChanged: (value) {
        if (value == true && watchHomeworld.value?[getIdFromUrlString] == null) {
          ref.read(homeworldProvider.notifier).getHomeworld(getIdFromUrlString!, watchPeopleDetail.value?.homeworld ?? '');
        }
      },
      children: [
        if (watchHomeworld.value?[getIdFromUrlString] != null) ...[
          DetailInfoField(
            title: 'Name',
            value: watchHomeworld.value?[getIdFromUrlString]?.name ?? '-',
          ),
          const SizedBox(height: 10),
          DetailInfoField(
            title: 'Population',
            value: watchHomeworld.value?[getIdFromUrlString]?.population ?? '-',
          ),
          const SizedBox(height: 10),
          DetailInfoField(
            title: 'Climate',
            value: watchHomeworld.value?[getIdFromUrlString]?.climate ?? '-',
          )
        ] else ...[
          const HomePageRefreshLoading()
        ]
      ],
    );
  }
}
