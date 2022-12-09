import 'package:flutter/material.dart';
import 'package:floor/floor.dart';
import 'package:rent_app/adclass.dart';
import 'user.dart';

@dao
abstract class AdDao{
  @Query('SELECT * FROM ads')
  Future<List<Ads>> findAllAds();

  @Query('SELECT * FROM ads WHERE title = :title')
  Stream<Ads?> findAdByTitle(String title);

  @Query('SELECT * FROM ads WHERE user_id = :id')
  Stream<Ads?> findAdByUserId(int id);

  @insert
  Future<void> insertAd(Ads ad);
}