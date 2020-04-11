import 'package:rxdart/rxdart.dart';

class BaseBloc<T> {
  final _controller = BehaviorSubject<T>();

  ValueStream<T> get stream => _controller.stream;

  void add(T obj){
    if(! _controller.isClosed){
      _controller.add(obj);
    }
  }

  void addError(obj){
    if(! _controller.isClosed){
      _controller.addError(obj);
    }
  }

  void dispose(){
    _controller.close();
  }
}