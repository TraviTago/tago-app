import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tago_app/search/model/kakao_blog_search_model.dart';
import 'package:tago_app/search/repository/kakao_blog_search_repository.dart';

final kakaoBlogSearchProvider = StateNotifierProvider<
    KakaoBlogSearchStateNotifier, List<KakaoBlogSearchModel>>(
  (ref) {
    final repository = ref.watch(kakaoBlogSearchRepositoryProvider);

    final notifier = KakaoBlogSearchStateNotifier(repository: repository);
    return notifier;
  },
);

class KakaoBlogSearchStateNotifier
    extends StateNotifier<List<KakaoBlogSearchModel>> {
  final KakaoBlogSearchRepository repository;

  KakaoBlogSearchStateNotifier({
    required this.repository,
  }) : super([]) {
    paginate();
  }

  paginate() async {
    final resp = await repository.paginate();

    state = resp.documents;
  }
}
