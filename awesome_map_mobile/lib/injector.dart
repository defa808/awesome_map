import 'package:awesome_map_mobile/account/provder/accountProvider.dart';
import 'package:awesome_map_mobile/services/accountService.dart';
import 'package:awesome_map_mobile/services/authorizationService.dart';
import 'package:awesome_map_mobile/services/commentService.dart';
import 'package:awesome_map_mobile/services/eventService.dart';
import 'package:awesome_map_mobile/services/fileService.dart';
import 'package:awesome_map_mobile/services/problemService.dart';
import 'package:get_it/get_it.dart';

setupInjector(){
  GetIt.I.registerSingleton<ProblemService>(ProblemService());
  GetIt.I.registerSingleton<EventService>(EventService());
  GetIt.I.registerSingleton<FileService>(FileService());
  GetIt.I.registerSingleton<AuthorizationService>(AuthorizationService());
  GetIt.I.registerSingleton<CommentService>(CommentService());
  GetIt.I.registerSingleton<AccountProvider>(AccountProvider());
  GetIt.I.registerSingleton<AccountService>(AccountService());
}