import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:get_it/get_it.dart';
import 'package:meme/core/network/network_info.dart';
import 'package:meme/features/meme_view/data/datasources/meme_remote_data_source.dart';
import 'package:meme/features/meme_view/data/repositories/meme_repository_impl.dart';
import 'package:meme/features/meme_view/domain/repositories/meme_repository.dart';
import 'package:meme/features/meme_view/domain/usecases/down_vote.dart';
import 'package:meme/features/meme_view/domain/usecases/get_memes.dart';
import 'package:meme/features/meme_view/domain/usecases/up_vote.dart';
import 'package:http/http.dart' as http;

final sl = GetIt.instance;

Future<void> init() async {
  //! Features - Meme_View
  //Use cases
  sl.registerLazySingleton(() => GetMemes(sl()));
  sl.registerLazySingleton(() => UpVote(sl()));
  sl.registerLazySingleton(() => DownVote(sl()));

  //Repository
  sl.registerLazySingleton<MemeRepository>(() => MemeRepositoryImpl(
        remoteDataSource: sl(),
        networkInfo: sl(),
      ));

  //Data sources
  sl.registerLazySingleton<MemeRemoteDataSource>(
      () => MemeRemoteDataSourceImpl(sl()));

  //! Core
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

  //! External
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => DataConnectionChecker());
}
