
part of 'product_bloc.dart';
@immutable
abstract class ProductState {}

class ProductInitial extends ProductState {}


class ProductLoading extends ProductState{}
class ProductUploaded extends ProductState{}
