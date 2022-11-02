import '../utils/repository.dart';

//repository,interactor <- combiner -> server
//repository -> client side

class Combiner {
  final ControllerBase _repository;
  final ServerRepository _serverReposity;

  Combiner._({
    required ControllerBase repository,
    required ServerRepository serverReposity,
  })  : _repository = repository,
        _serverReposity = serverReposity;

  factory Combiner.getInstance(
    ControllerBase repository,
    ServerRepository serverReposity,
  ) =>
      Combiner._(
        repository: repository,
        serverReposity: serverReposity,
      );
}
