import 'dart:ui';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'fragment_shader_pod.g.dart';

@riverpod
Future<FragmentShader> fragShaderPod(Ref ref) async {
  final frag = await FragmentProgram.fromAsset('assets/shaders/shadow.frag');

  return frag.fragmentShader();
}
