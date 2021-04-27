import 'bloc_provider.dart';
import 'package:rxdart/rxdart.dart';

class ApplicationBloc implements BlocBase {
  BehaviorSubject<int> _appEvent = BehaviorSubject<int>();

  Sink<int> get _appEventSink => _appEvent.sink;

  Stream<int> get appEventStream => _appEvent.stream;

  @override
  void dispose() {
    _appEvent.close();
  }

  @override
  Future getData({data}) {
    return null;
  }

  @override
  Future onLoadMore({data}) {
    return null;
  }

  @override
  Future onRefresh({data}) {
    return null;
  }

  void sendAppEvent(int type) {
    _appEventSink.add(type);
  }
}
