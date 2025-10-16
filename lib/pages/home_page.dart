import 'package:app/pages/fragment_shader_pod.dart';
import 'package:app/shader_painter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class HomePage extends HookConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final shaderValue = ref.watch(fragShaderPodProvider);
    final mousePositions = useState<List<Offset>>([]);
    final index = useState(0);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Title'),
      ),
      body: MouseRegion(
        onHover: (event) {
          // ウィンドウのサイズを取得
          final size = MediaQuery.of(context).size;

          // マウス座標を取得
          final x = event.position.dx;
          final y = event.position.dy;

          // 中央を0として、-1.0~1.0の範囲に正規化
          final normalizedX = (x - size.width / 2) / (size.width / 2);
          final normalizedY = (y - size.height / 2) / (size.height / 2);

          final point = Offset(normalizedX, normalizedY);
          if (mousePositions.value.length < 100) {
            mousePositions.value.add(point);
          } else {
            mousePositions.value[index.value] = point;
            index.value = (index.value + 1) % 100;
          }
        },
        child: CustomPaint(
          foregroundPainter: switch (shaderValue) {
            AsyncData(:final value) => ShaderPainter(
                shader: value,
                points: mousePositions.value,
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
      ),
    );
  }
}
