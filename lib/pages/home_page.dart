import 'dart:math';

import 'package:app/pages/fragment_shader_pod.dart';
import 'package:app/shader_painter.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class HomePage extends HookConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final shaderValue = ref.watch(fragShaderPodProvider);

    ref.listen(fragShaderPodProvider, (_, next) {
      next.whenData((shader) {
        // 100個のランダムな点を生成してシェーダーに渡す
        final rnd = Random();
        final points = List.generate(100, (_) {
          final x = rnd.nextDouble() * 2 - 1;
          final y = rnd.nextDouble() * 2 - 1;
          return [x, y];
        }).expand((e) => e).toList();

        for (var i = 0; i < points.length; i++) {
          shader.setFloat(2 + i, points[i]);
        }
      });
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text('Title'),
      ),
      body: CustomPaint(
        painter: switch (shaderValue) {
          AsyncData(:final value) => ShaderPainter(
              shader: value,
            ),
          _ => null,
        },
        child: Center(
          child: Container(
            width: 100,
            height: 150,
            color: Colors.amber,
          ),
        ),
      ),
    );
  }
}
