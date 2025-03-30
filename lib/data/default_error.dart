class DefaultError implements Exception {
  const DefaultError({
    this.data,
    this.stackTrace,
  });

  final Object? data;
  final Object? stackTrace;

  @override
  String toString() => 'DefaultError:\ndata=$data';
}
