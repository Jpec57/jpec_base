part of 'extension.dart';

extension FutureExtension on Future {
  Widget toBuild<T>(
      {@required Widget Function(T data) onSuccess,
        @required Widget loadingWidget,
        @required Widget notFoundWidget,
        @required Widget onError,
        dynamic data}) {
    return FutureBuilder<T>(
      future: this,
      initialData: data,
      builder: (BuildContext context, AsyncSnapshot<T> snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
          case ConnectionState.active:
            return loadingWidget ?? CircularProgressIndicator();
          case ConnectionState.done:
            if (snapshot.hasData) return onSuccess(snapshot.data);
            return onError ?? Text('An error occurred.');
          default:
            return notFoundWidget ?? Text('Not Found.');
        }
      },
    );
  }
}