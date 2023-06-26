import 'package:flutter/material.dart';

const String baseUrl = "http://www.comicvine.com/api";
const Color green = Color(0xff617f67);
const Color white = Color(0xfff4f4f4);
const int pageSize = 12;

const Map<String, dynamic> errorToMessage = {
  "internetError": "Can't access the api, check your internet connection",
};
