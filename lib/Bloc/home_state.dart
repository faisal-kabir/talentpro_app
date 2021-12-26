part of 'home_bloc.dart';

@immutable
abstract class HomeState {}

class HomeInitial extends HomeState {}


class ProductLoading extends HomeState{}

class ProductGet extends HomeState{
  Products? products;
  ProductGet(this.products);
}