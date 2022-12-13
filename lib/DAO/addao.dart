import 'package:flutter/material.dart';
import 'package:floor/floor.dart';
import 'package:rent_app/Classes/adclass.dart';
import '../Classes/user.dart';

@dao
abstract class AdDao{
  @Query('SELECT * FROM ads')
  Future<List<Ads>> findAllAds();

  @Query('SELECT * FROM ads WHERE title = :title')
  Future<List<Ads>> findAdByTitle(String title);

  @Query('SELECT * FROM ads WHERE user_id = :id')
  Future<List<Ads?>> findAdByUserId(int id);

  @insert
  Future<void> insertAd(Ads ad);
}