import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hotel_app/l10n/app_localizations.dart';

// ─────────────────────────────────────────────
//  Theme identifiers
// ─────────────────────────────────────────────
enum AppThemeType {
  royalBlue,
  dustyRose,
  darkEspresso,
  warmLinen,
  forestEmerald,
  babyBlue,
  babyPink,
  blackGold,
  midnightPurple,

}

// ─────────────────────────────────────────────
//  Palette tokens per theme
// ─────────────────────────────────────────────
class _Palette {
  final Color background;
  final Color surface;
  final Color appBar;
  final Color primary;
  final Color accent;
  final Color textPrimary;
  final Color textSecondary;
  final Color navSelected;
  final Color navUnselected;

  const _Palette({
    required this.background,
    required this.surface,
    required this.appBar,
    required this.primary,
    required this.accent,
    required this.textPrimary,
    required this.textSecondary,
    required this.navSelected,
    required this.navUnselected,
  });
}

const _palettes = <AppThemeType, _Palette>{
  // ── Royal Blue ──────────────────────────────
  AppThemeType.royalBlue: _Palette(
    background:    Color(0xFF0D1B2A), // كحلي عميق
    surface:       Color(0xFF162032),
    appBar:        Color(0xFF0A1628),
    primary:       Color(0xFF1E3A5F),
    accent:        Color(0xFFCBA135), // ذهبي ملكي
    textPrimary:   Color(0xFFE8F0F7),
    textSecondary: Color(0xFFA8C0D8),
    navSelected:   Color(0xFFCBA135),
    navUnselected: Color(0xFF4A6FA5),
  ),

  // ── Dusty Rose ──────────────────────────────
  AppThemeType.dustyRose: _Palette(
    background:    Color(0xFF2A1A20), // بيرغاندي غامق
    surface:       Color(0xFF3B2530),
    appBar:        Color(0xFF221520),
    primary:       Color(0xFF8B4A5E),
    accent:        Color(0xFFE8B4C0), // وردي باستيل
    textPrimary:   Color(0xFFF5E8EC),
    textSecondary: Color(0xFFD4A8B5),
    navSelected:   Color(0xFFE8B4C0),
    navUnselected: Color(0xFF9E6E7E),
  ),

  // ── Dark Espresso ────────────────────────────
  AppThemeType.darkEspresso: _Palette(
    background:    Color(0xFF2D1B12), // بني غامق جداً
    surface:       Color(0xFF4a342a),
    appBar:        Color(0xFF170D06),
    primary:       Color(0xFF2D1B12),
    accent:        Color(0xFFC49A6C), // برونزي دافئ
    textPrimary:   Color(0xFFF5E6D3),
    textSecondary: Color(0xFFD4B89A),
    navSelected:   Color(0xFFC49A6C),
    navUnselected: Color(0xFF8D6E63),
  ),

  // ── Warm Linen ──────────────────────────────
  AppThemeType.warmLinen: _Palette(
    background:    Color(0xFFF5EFE4), // كريم دافئ
    surface:       Color(0xFFD4AF7F),
    appBar:        Color(0xFF5C4A32), // بني خشبي
    primary:       Color(0xFFAA9070),
    accent:        Color(0xFFE7DFCB),
    textPrimary:   Color(0xFF2C1F0E),
    textSecondary: Color(0xFF6B4F36),
    navSelected:   Color(0xFFBF8C3A),
    navUnselected: Color(0xFFAA9070),
  ),

  // ── Forest Emerald ───────────────────────────
  AppThemeType.forestEmerald: _Palette(
    background:    Color(0xFF0A1F15), // أخضر غابة داكن
    surface:       Color(0xFF112B1C),
    appBar:        Color(0xFF081910),
    primary:       Color(0xFF1B4332),
    accent:        Color(0xFFB87333), // نحاسي
    textPrimary:   Color(0xFFE0F0E8),
    textSecondary: Color(0xFF9DC4A8),
    navSelected:   Color(0xFFB87333),
    navUnselected: Color(0xFF4A8C62),
  ),
  // ── Baby Blue ──────────────────────────────
  AppThemeType.babyBlue: _Palette(
    background:    Color(0xFFF5FAFF), // أزرق ثلجي فاتح
    surface:       Color(0xFF6FAEE8),
    appBar:        Color(0xFFB8DFFF),
    primary:       Color(0xFF9CCEF5),
    accent:        Color(0xFF6FAEE8), // أزرق بيبي
    textPrimary:   Color(0xFF081910),
    textSecondary: Color(0xFF5D7FA3),
    navSelected:   Color(0xFF6FAEE8),
    navUnselected: Color(0xFFA8C7E6),
  ),

// ── Baby Pink ──────────────────────────────
  AppThemeType.babyPink: _Palette(
    background:    Color(0xFFFFF7FA), // وردي ثلجي
    surface:       Color(0xFFD9AFC0),
    appBar:        Color(0xFFFCC8DA),
    primary:       Color(0xFFF7AFC8),
    accent:        Color(0xFFE88AB0), // وردي بيبي
    textPrimary:   Color(0xFF6B3551),
    textSecondary: Color(0xFF9A6880),
    navSelected:   Color(0xFFE88AB0),
    navUnselected: Color(0xFFD9AFC0),
  ),
  AppThemeType.blackGold: _Palette(
    background: Color(0xFF0B0B0B),
    surface: Color(0xFF171717),
    appBar: Color(0xFF101010),

    primary: Color(0xFF2A2A2A),
    accent: Color(0xFFD4AF37),

    textPrimary: Color(0xFFF8F8F8),
    textSecondary: Color(0xFFB5B5B5),

    navSelected: Color(0xFFD4AF37),
    navUnselected: Color(0xFF6E6E6E),
  ),
  AppThemeType.midnightPurple: _Palette(
    background: Color(0xFFF4EFFF),
    surface: Color(0xFF7D6996),
    appBar: Color(0xFF0F071A),

    primary: Color(0xFF7D6996),
    accent: Color(0xFFD4A5FF),

    textPrimary: Color(0xFF0F071A),
    textSecondary: Color(0xFFC8B4E3),

    navSelected: Color(0xFFD4A5FF),
    navUnselected: Color(0xFF7D6996),
  ),


};

class ThemeMeta {
  final String labelKey;
  final String emoji;
  final Color previewColor;
  final Color previewAccent;

  const ThemeMeta({
    required this.labelKey,
    required this.emoji,
    required this.previewColor,
    required this.previewAccent,
  });


  String label(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    switch (labelKey) {
      case 'royalblue':      return t.royalblue;
      case 'dustyrose':      return t.dustyrose;
      case 'darkespresso':   return t.darkespresso;
      case 'warmlinen':      return t.warmlinen;
      case 'forestemerald':  return t.forestemerald;
      case 'babyblue':       return t.babyblue;
      case 'babypink':       return t.babypink;
      case 'blackgold':      return t.blackgold;
      case 'midnightpurple': return t.midnightpurple;
      default: return labelKey;
    }
  }
}

const themeMeta = <AppThemeType, ThemeMeta>{
  AppThemeType.royalBlue: ThemeMeta(
    labelKey: 'royalblue',
    emoji: '👑',
    previewColor: Color(0xFF1E3A5F),
    previewAccent: Color(0xFFCBA135),
  ),
  AppThemeType.dustyRose: ThemeMeta(
    labelKey: 'dustyrose',
    emoji: '🌸',
    previewColor: Color(0xFF8B4A5E),
    previewAccent: Color(0xFFE8B4C0),
  ),
  AppThemeType.darkEspresso: ThemeMeta(
    labelKey: 'darkespresso',
    emoji: '☕',
    previewColor: Color(0xFF4E2D1E),
    previewAccent: Color(0xFFC49A6C),
  ),
  AppThemeType.warmLinen: ThemeMeta(
    labelKey: 'warmlinen',
    emoji: '🌾',
    previewColor: Color(0xFF7A5C3E),
    previewAccent: Color(0xFFBF8C3A),
  ),
  AppThemeType.forestEmerald: ThemeMeta(
    labelKey: 'forestemerald',
    emoji: '🌿',
    previewColor: Color(0xFF1B4332),
    previewAccent: Color(0xFFB87333),
  ),
  AppThemeType.babyBlue: ThemeMeta(
    labelKey: 'babyblue',
    emoji: '🩵',
    previewColor: Color(0xFF9CCEF5),
    previewAccent: Color(0xFF6FAEE8),
  ),

  AppThemeType.babyPink: ThemeMeta(
    labelKey: 'babypink',
    emoji: '🩷',
    previewColor: Color(0xFFF7AFC8),
    previewAccent: Color(0xFFE88AB0),
  ),
  AppThemeType.blackGold: ThemeMeta(
    labelKey: 'blackgold',
    emoji: '🖤',
    previewColor: Color(0xFF171717),
    previewAccent: Color(0xFFD4AF37),
  ),

  AppThemeType.midnightPurple: ThemeMeta(
    labelKey: 'midnightpurple',
    emoji: '💜',
    previewColor: Color(0xFF35214F),
    previewAccent: Color(0xFFD4A5FF),
  ),};

// ─────────────────────────────────────────────
//  Theme builder
// ─────────────────────────────────────────────
class AppThemes {
  AppThemes._();

  static ThemeData build(AppThemeType type,{bool isArabic = false,}) {
    final bodyFont = isArabic
        ? GoogleFonts.alexandria()
        : GoogleFonts.poppins();

    final titleFont = isArabic
        ? GoogleFonts.cairo()
        : GoogleFonts.inter();

    final displayFont = isArabic
        ? GoogleFonts.almarai()
        : GoogleFonts.playfairDisplay();
    final p = _palettes[type]!;
    final isLight = type == AppThemeType.warmLinen;
    return ThemeData(
      useMaterial3: true,
      brightness: isLight ? Brightness.light : Brightness.dark,
      scaffoldBackgroundColor: p.background,

      colorScheme: ColorScheme(
        brightness: isLight ? Brightness.light : Brightness.dark,
        primary:           p.accent,
        onPrimary:         p.background,
        secondary:         p.primary,
        onSecondary:       p.textPrimary,
        surface:           p.surface,
        onSurface:         p.textPrimary,
        error:             const Color(0xFFCF6679),
        onError:           Colors.white,
      ),

      appBarTheme: AppBarTheme(
        backgroundColor: p.appBar,
        foregroundColor: p.textPrimary,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: GoogleFonts.playfairDisplay(
          fontSize: 20,
          fontWeight: FontWeight.w700,
          color: p.accent,
          letterSpacing: 0.5,
        ),
      ),

      cardTheme: CardThemeData(
        color: p.surface,
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: p.appBar,
        selectedItemColor: p.navSelected,
        unselectedItemColor: p.navUnselected,
        type: BottomNavigationBarType.fixed,
        elevation: 0,
      ),

      switchTheme: SwitchThemeData(
        thumbColor: WidgetStateProperty.resolveWith((states) =>
        states.contains(WidgetState.selected) ? p.accent : p.navUnselected),
        trackColor: WidgetStateProperty.resolveWith((states) =>
        states.contains(WidgetState.selected)
            ? p.accent.withOpacity(0.4)
            : p.surface),
      ),

      dividerTheme: DividerThemeData(
        color: p.primary.withOpacity(0.5),
        thickness: 1,
      ),

      textTheme: TextTheme(
        displayLarge: displayFont.copyWith(
          fontSize: 36,
          fontWeight: FontWeight.w700,
          color: p.textPrimary,
          letterSpacing: -0.5,
        ),

        displayMedium: displayFont.copyWith(
          fontSize: 26,
          fontWeight: FontWeight.w700,
          color: p.textPrimary,
        ),

        displaySmall: displayFont.copyWith(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: p.textPrimary,
        ),

        titleLarge: titleFont.copyWith(
          fontSize: 18,
          fontWeight: FontWeight.w500,
          color: p.textPrimary,
          letterSpacing: 0.15,
        ),

        titleMedium: titleFont.copyWith(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: p.textPrimary,
        ),

        bodyLarge: bodyFont.copyWith(
          fontSize: 16,
          fontWeight: FontWeight.w400,
          color: p.textPrimary,
          height: 1.6,
        ),

        bodyMedium: bodyFont.copyWith(
          fontSize: 14,
          color: p.textPrimary,
          height: 1.5,
        ),

        labelLarge: titleFont.copyWith(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: p.accent,
          letterSpacing: 0.8,
        ),
      ),

      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: p.accent,
          foregroundColor: p.background,
          elevation: 0,
          padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          textStyle: GoogleFonts.inter(
            fontSize: 15,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.5,
          ),
        ),
      ),

      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: p.surface,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: p.primary, width: 1),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: p.primary.withOpacity(0.5), width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: p.accent, width: 1.5),
        ),
        labelStyle: GoogleFonts.inter(color: p.textSecondary, fontSize: 14),
        hintStyle: GoogleFonts.inter(color: p.navUnselected, fontSize: 14),
      ),

    );

  }
  // أضف هاد

}