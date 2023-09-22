import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:starwars_app/src/presentation/utils/reusable_widget/custom_text.dart';
import 'package:starwars_app/src/application/prov_people_detail.dart';
import 'package:starwars_app/src/application/prov_startship.dart';
import 'package:starwars_app/src/presentation/detail/components/info_field.dart';
import 'package:starwars_app/src/presentation/home/components/home_refresh_loading.dart';

class StartshipsExpansion extends ConsumerWidget {
  const StartshipsExpansion({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final watch = ref.watch(provPeopleDetail);
    final watchStarship = ref.watch(startshipProvider);
    return ExpansionTile(
      tilePadding: EdgeInsets.zero,
      iconColor: Colors.blue,
      collapsedIconColor: Colors.blue,
      title: CustomText().starjediWhite(txt: 'Starships'),
      subtitle: CustomText().starjediWhite(txt: watch.value?.starships!.isNotEmpty == true ? '${watch.value?.starships?.length.toString()}' : '-'),
      children: (() {
        if (watch.value?.starships != null) {
          return List.generate(
            watch.value?.starships?.length ?? 0,
            (index) {
              ///______ Identify unique Startship data with 'id' that extracted from Url String 
              final getIdFromUrlString = watch.value?.starships?[index].replaceAll(RegExp(r'[^0-9]'), '');

              return ExpansionTile(
                title: CustomText().starjediWhite(txt: 'id - $getIdFromUrlString'),
                backgroundColor: Colors.transparent,
                collapsedIconColor: Colors.blue,
                childrenPadding: const EdgeInsets.only(left: 20),
                tilePadding: const EdgeInsets.only(left: 20),
                expandedCrossAxisAlignment: CrossAxisAlignment.start,
                iconColor: Colors.blue,
                onExpansionChanged: (value) {
                  ///_____ Only request when current Startship data does not defined yet on [starshipMap] Map data
                  if (value == true && watchStarship.value?[getIdFromUrlString] == null) {
                    ref.read(startshipProvider.notifier).getStartship(getIdFromUrlString!, watch.value!.starships![index]);
                  }
                },
                children: [
                  if (watchStarship.value?[getIdFromUrlString] != null) ...[
                    Column(
                      children: [
                        DetailInfoField(
                          title: 'Model',
                          value: watchStarship.value?[getIdFromUrlString]?.model ?? '-',
                        ),
                        const SizedBox(height: 10),
                        DetailInfoField(
                          title: 'Class',
                          value: watchStarship.value?[getIdFromUrlString]?.starshipClass ?? '-',
                        ),
                        const SizedBox(height: 10),
                        DetailInfoField(
                          title: 'Hyperdrive Rating',
                          value: watchStarship.value?[getIdFromUrlString]?.hyperdriveRating ?? '-',
                        ),
                        const SizedBox(height: 10),
                        DetailInfoField(
                          title: 'Cost in credits',
                          value: watchStarship.value?[getIdFromUrlString]?.costInCredits ?? '-',
                        ),
                        const SizedBox(height: 10),
                        DetailInfoField(
                          title: 'Manufacturer',
                          value: watchStarship.value?[getIdFromUrlString]?.manufacturer ?? '-',
                        )
                      ],
                    )
                  ] else if (watchStarship.value?[getIdFromUrlString] == null) ...[
                    const HomePageRefreshLoading()
                  ]
                ],
              );
            },
          );
        }
        return <Widget>[];
      }()),
    );
  }
}
