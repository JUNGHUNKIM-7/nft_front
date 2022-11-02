import '../base.dart';
import 'providers.dart';

class ControllerBase {
  ControllerBase._();
  factory ControllerBase.getInstance() => ControllerBase._();

  final setIntEvt = BaseController<CatchIntEvent?>(null);
  final coinsSelector = BaseController(0);
  final categoriesSelector = BaseController(0);
  final gridItemSelector = BaseController(0);
  final bottonNavSelector = BaseController(0);

  final setSetEvent = BaseController<CatchSetEvent?>(null);
  final favoriteSelector = BaseController(<int>{});
  final bookMarkSelector = BaseController(<int>{});
  final cartSelector = BaseController(<int>{});

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
  Set<int> cart;

  Interactor._({
    required this.searchValue,
    required this.categoriesIdx,
    required this.coinsIdx,
    required this.gridItem,
    required this.bottomNav,
    required this.favorites,
    required this.bookMarks,
    required this.cart,
  });

  factory Interactor.getInstance() => Interactor._(
        searchValue: "",
        categoriesIdx: 0,
        coinsIdx: 0,
        gridItem: 0,
        bottomNav: 0,
        favorites: <int>{},
        bookMarks: <int>{},
        cart: <int>{},
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
  set setCart(int index) => cart.add(index);
  set unsetCart(int index) => cart.remove(index);
}

class ServerRepository {
  ServerRepository._();
  factory ServerRepository.getInstance() => ServerRepository._();
}
