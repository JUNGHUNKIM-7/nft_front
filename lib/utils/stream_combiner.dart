import '../utils/repository.dart';

class Combiner {
  final Repository _repository;
  Combiner._({
    required Repository repository,
  }) : _repository = repository;

  factory Combiner.getInstance(Repository repository) =>
      Combiner._(repository: repository);
}
