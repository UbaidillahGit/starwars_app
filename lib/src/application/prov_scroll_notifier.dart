import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:starwars_app/src/application/prov_people.dart';

final scrollProvider = ChangeNotifierProvider<ScrollNotifier>((ref) => ScrollNotifier(ref));

/// Define a ScrollNotifier to handle [scrollController] and [scrollListener] for HomePage
/// [scrollListener] will listen for every scrolling and will trigger [paginationNext]
/// when scroll position is [offset]
class ScrollNotifier extends ChangeNotifier {
  ScrollController? scrollController;
  late WidgetRef widgetRef;

  ChangeNotifierProviderRef changeNotifierProviderRef;

  ScrollNotifier(this.changeNotifierProviderRef) {
    init(); ///_____ Call init on constructor
  }

  ///_____ Init ScrollController
  init() {
    scrollController = ScrollController(initialScrollOffset: 10)..addListener(scrollListener);
  }

  ///_____ Trigger pagination when scroll position is on max extent
  scrollListener() async {
    if (scrollController?.position.maxScrollExtent == scrollController?.offset) {
      changeNotifierProviderRef.read(peopleProvider.notifier).paginationNext();
    }
  }
}