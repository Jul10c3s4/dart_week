import 'package:flutter/material.dart';
import 'package:vakinha_burguer_app/app/core/config/env/env.dart';
import 'package:vakinha_burguer_app/app/delivery_app.dart';
 
Future<void> main() async {
  await Env.instance.load();
  runApp(DeliveryApp());
}
