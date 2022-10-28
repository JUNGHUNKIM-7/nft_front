import 'package:flutter_layout/repository.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

enum CatchIntEvent { setCategoreis, setCoins, setGridItem, setBottomNav }

enum CatchStringEvent { setSearch }

final repositoryProvider = Provider<Repository>((ref) {
  return Repository.getInstance();
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
