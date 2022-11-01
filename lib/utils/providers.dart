import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'repository.dart';
import './stream_combiner.dart';

enum CatchIntEvent {
  setCategoreis,
  setCoins,
  setGridItem,
  setBottomNav,
}

enum CatchStringEvent { setSearch }

enum CatchSetEvent {
  setFavorite,
  unsetFavorite,
  setBookMark,
  unsetBookMark,
}

final repositoryProvider = Provider<Repository>((ref) {
  return Repository.getInstance();
});

final combinerProvider = Provider<Combiner>((ref) {
  return Combiner.getInstance(ref.watch(repositoryProvider));
});

final interactorProvider = Provider<Interactor>((ref) {
  return Interactor.getInstance();
});

final catchStreamProvider = StreamProvider.autoDispose
    .family<String, CatchStringEvent>((ref, evt) async* {
  final Repository repository = ref.watch(repositoryProvider);
  final Interactor interactor = ref.watch(interactorProvider);

  ref.onDispose(() {
    repository.searchValue.dispose();
  });

  repository.setStringEvt.bSubject.listen((CatchStringEvent? evt) {
    switch (evt) {
      case CatchStringEvent.setSearch:
        repository.searchValue.setState = interactor.searchValue;
        break;
      default:
        break;
    }
  });

  switch (evt) {
    case CatchStringEvent.setSearch:
      yield* repository.searchValue.bStream;
      break;
    default:
      break;
  }
});

final catchIntFamilyProvider = StreamProvider.family<int, CatchIntEvent>(
  (ref, evt) async* {
    final Repository repository = ref.watch(repositoryProvider);
    final Interactor interactor = ref.watch(interactorProvider);

    repository.setIntEvt.bSubject.listen((CatchIntEvent? evt) {
      switch (evt) {
        case CatchIntEvent.setCategoreis:
          repository.categoriesSelector.setState = interactor.categoriesIdx;
          break;
        case CatchIntEvent.setCoins:
          repository.coinsSelector.setState = interactor.coinsIdx;
          break;
        case CatchIntEvent.setGridItem:
          repository.gridItemSelector.setState = interactor.gridItem;
          break;
        case CatchIntEvent.setBottomNav:
          repository.bottonNavSelector.setState = interactor.bottomNav;
          break;
        default:
          break;
      }
    });

    switch (evt) {
      case CatchIntEvent.setCategoreis:
        yield* repository.categoriesSelector.bStream;
        break;
      case CatchIntEvent.setCoins:
        yield* repository.coinsSelector.bStream;
        break;
      case CatchIntEvent.setGridItem:
        yield* repository.gridItemSelector.bStream;
        break;
      case CatchIntEvent.setBottomNav:
        yield* repository.bottonNavSelector.bStream;
        break;
      default:
        break;
    }
  },
);

final catchSetProvider =
    StreamProvider.family<Set<int>, CatchSetEvent>((ref, evt) async* {
  final Repository repository = ref.watch(repositoryProvider);
  final Interactor interactor = ref.watch(interactorProvider);

  repository.setSetEvent.bSubject.listen((CatchSetEvent? evt) {
    switch (evt) {
      case CatchSetEvent.setFavorite:
        repository.favoriteSelector.setState = interactor.favorites;
        break;
      case CatchSetEvent.unsetFavorite:
        repository.favoriteSelector.setState = interactor.favorites;
        break;
      case CatchSetEvent.setBookMark:
        repository.bookMarkSelector.setState = interactor.bookMarks;
        break;
      case CatchSetEvent.unsetBookMark:
        repository.bookMarkSelector.setState = interactor.bookMarks;
        break;
      default:
        break;
    }
  });

  switch (evt) {
    case CatchSetEvent.setFavorite:
      yield* repository.favoriteSelector.bStream;
      break;
    case CatchSetEvent.unsetFavorite:
      yield* repository.favoriteSelector.bStream;
      break;
    case CatchSetEvent.setBookMark:
      yield* repository.bookMarkSelector.bStream;
      break;
    case CatchSetEvent.unsetBookMark:
      yield* repository.bookMarkSelector.bStream;
      break;
    default:
      break;
  }
});
