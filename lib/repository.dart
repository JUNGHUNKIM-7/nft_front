import 'package:flutter_layout/providers.dart';

import 'base.dart';

class Repository {
  Repository._();
  factory Repository.getInstance() => Repository._();

  final setIntEvt = BaseController<CatchIntEvent?>(null);
  final coinsSelector = BaseController(0);
  final categoriesSelector = BaseController(0);
  final gridItemSelector = BaseController(0);
  final bottonNavSelector = BaseController(0);

  final setStringEvt = BaseController<CatchStringEvent?>(null);
  final searchValue = BaseController("");
}

class Interactor {
  String searchValue;
  int categoriesIdx;
  int coinsIdx;
  int gridItem;
  int bottomNav;

  Interactor._({
    required this.searchValue,
    required this.categoriesIdx,
    required this.coinsIdx,
    required this.gridItem,
    required this.bottomNav,
  });

  factory Interactor.getInstance() => Interactor._(
        searchValue: "",
        categoriesIdx: 0,
        coinsIdx: 0,
        gridItem: 0,
        bottomNav: 0,
      );

  set setSearchValue(String value) => searchValue = value;
  set setCategories(int index) => categoriesIdx = index;
  set setCoin(int index) => coinsIdx = index;
  set setGridItem(int index) => gridItem = index;
  set setBottomNav(int index) => bottomNav = index;
}
