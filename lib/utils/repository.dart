import '../base.dart';
import 'providers.dart';

class Repository {
  Repository._();
  factory Repository.getInstance() => Repository._();

  final setIntEvt = BaseController<CatchIntEvent?>(null);
  final coinsSelector = BaseController(0);
  final categoriesSelector = BaseController(0);
  final gridItemSelector = BaseController(0);
  final bottonNavSelector = BaseController(0);

  final setSetEvent = BaseController<CatchSetEvent?>(null);
  final favoriteSelector = BaseController(<int>{});
  final bookMarkSelector = BaseController(<int>{});

  final setStringEvt = BaseController<CatchStringEvent?>(null);
  final searchValue = BaseController("");
}

class Interactor {
  String searchValue;
  int categoriesIdx;
  int coinsIdx;
  int gridItem;
  int bottomNav;
  Set<int> favorites;
  Set<int> bookMarks;

  Interactor._({
    required this.searchValue,
    required this.categoriesIdx,
    required this.coinsIdx,
    required this.gridItem,
    required this.bottomNav,
    required this.favorites,
    required this.bookMarks,
  });

  factory Interactor.getInstance() => Interactor._(
        searchValue: "",
        categoriesIdx: 0,
        coinsIdx: 0,
        gridItem: 0,
        bottomNav: 0,
        favorites: <int>{},
        bookMarks: <int>{},
      );

  set setSearchValue(String value) => searchValue = value;
  set setCategories(int index) => categoriesIdx = index;
  set setCoin(int index) => coinsIdx = index;
  set setGridItem(int index) => gridItem = index;
  set setBottomNav(int index) => bottomNav = index;
  set setFavorite(int index) => favorites.add(index);
  set unsetFavorite(int index) => favorites.remove(index);
  set setBookMark(int index) => bookMarks.add(index);
  set unsetBookMark(int index) => bookMarks.remove(index);
}
