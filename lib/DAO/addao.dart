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

  @Query('SELECT * FROM ads WHERE owner_id = :id')
  Future<List<Ads?>> findAdByUserId(int id);

  @Query('SELECT * FROM ads WHERE id = :id')
  Stream<Ads?> findAdById(int id);

  @Query('UPDATE ads SET link = :link, location = :location,desc = :desc,title = :title,number_of_rooms = :number_of_rooms,price = :price,type = :type,phone_number =:phone_number WHERE id = :id')
  Future<void> updateAd(int id,String link,String desc,String title,int number_of_rooms,int price,String type,String location,int phone_number);

  @insert
  Future<void> insertAd(Ads ad);
}