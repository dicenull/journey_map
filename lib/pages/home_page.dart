import 'package:app/pages/fragment_shader_pod.dart';
import 'package:app/shader_painter.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class HomePage extends HookConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final shaderValue = ref.watch(fragShaderPodProvider);

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
