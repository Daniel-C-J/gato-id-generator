// coverage:ignore-file
import 'dart:async';
import 'dart:typed_data';
import 'package:gato_id_generator/src/data/model/gato_id_content.dart';
import 'package:gato_id_generator/src/data/model/gato_id_stat.dart';

abstract class GenerateIdRepo {
  GatoId generate();

  FutureOr<List<Map<String, dynamic>>> getAllGeneratedImages({required String uid});

  Future<void> saveGenerated(String uuid, Uint8List value, {required String uid});

  Future<void> delete({required String uid, required String uuid});

  FutureOr<GatoIdStat> getLatestStats({required String uid});

  Future<void> incrementAndSaveStats({required String uid});
}
