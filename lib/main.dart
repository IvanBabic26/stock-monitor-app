import 'package:baraka_portfolio/app.dart';
import 'package:baraka_portfolio/core/injection_container.dart';
import 'package:flutter/material.dart';

void main() async {
  await initDependencies();
  runApp(const PortfolioApp());
}
