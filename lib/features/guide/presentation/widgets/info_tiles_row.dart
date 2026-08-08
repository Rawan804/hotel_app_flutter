import 'package:flutter/material.dart';
import '../../models/guide_models.dart';
import 'info_checklist.dart';
import 'info_tile.dart';

class InfoTilesRow extends StatefulWidget {
  final List<InfoSection> sections;
  const InfoTilesRow({super.key, required this.sections});

  @override
  State<InfoTilesRow> createState() => _InfoTilesRowState();
}

class _InfoTilesRowState extends State<InfoTilesRow> with SingleTickerProviderStateMixin {
  int? _openIndex;
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 500),
  );

  void _toggle(int index) {
    setState(() {
      if (_openIndex == index) {
        _openIndex = null;
        _controller.reverse();
      } else {
        _openIndex = index;
        _controller.forward(from: 0);
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.sections.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            for (int i = 0; i < widget.sections.length; i++) ...[
              if (i != 0) const SizedBox(width: 14),
              Expanded(
                child: InfoTile(
                  section: widget.sections[i],
                  isOpen: _openIndex == i,
                  onTap: () => _toggle(i),
                ),
              ),
            ],
          ],
        ),
        ClipRect(
          child: AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              return Align(
                alignment: Alignment.topCenter,
                heightFactor: Curves.easeOutCubic.transform(_controller.value),
                child: Opacity(opacity: _controller.value, child: child),
              );
            },
            child: _openIndex == null
                ? const SizedBox(width: double.infinity)
                : Padding(
                    padding: const EdgeInsets.only(top: 14),
                    child: InfoChecklist(
                      section: widget.sections[_openIndex!],
                      accent: widget.sections[_openIndex!].accent,
                      controller: _controller,
                    ),
                  ),
          ),
        ),
      ],
    );
  }
}
