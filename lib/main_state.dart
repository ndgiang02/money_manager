part of 'main_cubit.dart';

class MainState {
  final bool isLightTheme;
  final DrawerItem selected;

//<editor-fold desc="Data Methods">
  const MainState.init({
    this.selected = DrawerItem.Home,
    this.isLightTheme = false,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is MainState &&
          runtimeType == other.runtimeType &&
          isLightTheme == other.isLightTheme);

  @override
  int get hashCode => isLightTheme.hashCode;

  @override
  String toString() {
    return 'MainState{' + ' isLightTheme: $isLightTheme,' + '}';
  }

  MainState copyWith({
    bool? isLightTheme,
    DrawerItem? selected,
  }) {
    return MainState(
      isLightTheme: isLightTheme ?? this.isLightTheme,
      selected: selected ?? this.selected,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'isLightTheme': this.isLightTheme,
    };
  }

  factory MainState.fromMap(Map<String, dynamic> map) {
    return MainState(
      isLightTheme: map['isLightTheme'] as bool,
    );
  }

//</editor-fold>
}