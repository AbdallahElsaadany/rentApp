import 'package:flutter/material.dart';
import 'package:floor/floor.dart';
import 'package:rent_app/Classes/adclass.dart';
import '../Classes/favoriteads.dart';
import '../Classes/user.dart';

@dao
abstract class FavoriteDao{
  @Query('SELECT * FROM favorites')
  Future<List<Favorite>> findAllAds();

  @Query('SELECT * FROM favorites WHERE Ad_id = :id')
  Future<List<Favorite?>> findAdByAdId(int id);

  @Query('SELECT * FROM favorites WHERE customer_id = :id')
  Future<List<Favorite?>> findAdByUserId(int id);

  @Query('SELECT * FROM favorites WHERE id = :id')
  Stream<Favorite?> findAdById(int id);

  @Query('SELECT ads.id,ads.owner_id,price,ads.number_of_rooms,ads.phone_number,ads.link,ads.desc,ads.title,ads.type,ads.location FROM ads, favorites WHERE favorites.customer_id  = :id and ads.id = favorites.ad_id')
  Future<List<Ads?>> findFavAdByUserID(int id);

  @delete
  Future<void> deleteFavAd(Favorite ad);

  @insert
  Future<void> insertAd(Favorite ad);
}