import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../controllers/multilingual_provider.dart';


class RegisterAllProviders {
  static get allProvidersList => [
    ChangeNotifierProvider(create: (_)=>TTSProvider()),
  ];
}
