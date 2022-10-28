import 'package:rxdart/rxdart.dart';

abstract class Base<T> {
  T _state;
  Base({required T state}) : _state = state;
  get state => _state;
  set setState(T value) => _state = value;
  void dispose();
}

class BaseController<T> extends Base<T> {
  late final BehaviorSubject<T> _behaviorSubject;
  late final ReplaySubject<T> _replaySubject;
  final int? maxSize;

  BaseController(T state, {this.maxSize}) : super(state: state) {
    _behaviorSubject = BehaviorSubject<T>.seeded(_state);
    if (maxSize != null) {
      _replaySubject = ReplaySubject<T>(maxSize: maxSize);
    } else {
      _replaySubject = ReplaySubject<T>();
    }
  }

  @override
  set setState(T value) {
    super.setState = value;
    _behaviorSubject.add(_state);
    _replaySubject.add(_state);
  }

  BehaviorSubject<T> get bSubject => _behaviorSubject;
  Stream<T> get bStream => _behaviorSubject.stream;

  ReplaySubject<T> get rSubject => _replaySubject;
  Stream<T> get rStream => _replaySubject.stream;

  @override
  void dispose() {
    _behaviorSubject.close();
    _replaySubject.close();
  }
}
