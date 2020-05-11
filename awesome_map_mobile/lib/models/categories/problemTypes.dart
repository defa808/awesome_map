import 'dart:convert';

import 'package:awesome_map_mobile/env/config.dart';
import 'package:awesome_map_mobile/models/base/category.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

import 'categories.dart';

class ProblemTypes extends Categories {
  ProblemTypes() : super("api/ProblemTypes");
}
