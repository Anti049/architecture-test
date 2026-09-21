# architecture-test

A Flutter **monorepo** that encapsulates multiple versions of the same application to
compare architecture packages side-by-side with identical functionality.

## What's being compared

| Axis | Options |
|---|---|
| Database | Isar (Community), Drift, sqflite |
| State management | Riverpod, Bloc |
| Immutable classes | Freezed, dart_mappable, None (plain) |
| Navigation | AutoRoute, GoRouter |

The full cartesian product is `3 x 2 x 3 x 2 = 36` apps, which is unmaintainable and
makes comparisons meaningless. Instead this repo uses a **one-variable-at-a-time (OVAT)**
matrix: a baseline app plus siblings that change exactly one axis, so each comparison
is a clean A/B test while still exercising **every** package listed above.

### App matrix

**Main workspace (latest stack):**

| App | DB | State | Immutable | Nav |
|---|---|---|---|---|
| `app_baseline` | Drift | Riverpod | Freezed | GoRouter |
| `app_sqflite` | sqflite | Riverpod | Freezed | GoRouter |
| `app_bloc` | Drift | Bloc | Freezed | GoRouter |
| `app_mappable` | Drift | Riverpod | dart_mappable | GoRouter |
| `app_no_immutable` | Drift | Riverpod | Plain | GoRouter |
| `app_autoroute` | Drift | Riverpod | Freezed | AutoRoute |

**Isar workspace (`./isar-workspace`, pinned older codegen stack):**

| App | DB | State | Immutable | Nav |
|---|---|---|---|---|
| `app_isar` | Isar | Riverpod | Plain | GoRouter |
| `app_isar_bloc_autoroute` | Isar | Bloc | dart_mappable | AutoRoute |
| `app_kitchensink` | Isar | Bloc | Plain | AutoRoute |

## Why two workspaces?

A single Dart pub workspace shares **one** resolution of every transitive dependency.
`isar_community_generator` 3.3.2 requires `analyzer ^6.9.0 (<7.0.0)`, while Freezed 3.x
and current `build_runner` (2.15.x) require `analyzer 12-14`. These ranges **do not
overlap**, so Isar cannot co-resolve with Freezed 3.x. The fix:

- **Main workspace** (`./pubspec.yaml`) - Drift, sqflite, Freezed, dart_mappable, all
  nav + state packages on the newest versions.
- **Isar workspace** (`./isar-workspace/pubspec.yaml`) - isolated, with
  `build_runner` pinned to `^2.4.13` and models restricted to **Plain** or
  **dart_mappable** (never Freezed).

Shared `packages/` are referenced from both workspaces via path dependencies.

## Architecture

Shared **contracts** and **UI** live in `packages/`; only the swappable parts (DB,
state, models, nav) sit behind abstract interfaces. Each app is a thin wiring layer.

```
core_domain      -> entities + repository/auth interfaces (pure Dart)
nav_contract     -> AppNavigator interface + route names
feature_*        -> screens/widgets (state-agnostic; receive AppNavigator + data)
model_*          -> DTOs (freezed | mappable | plain) mapping to core_domain
db_*             -> WorkRepository impls (drift | sqflite | isar)
nav_*            -> AppNavigator impls (gorouter | autoroute)
apps/app_*       -> compose one implementation per axis in main.dart
```

### Screens (each with its own AppBar)

- **Splash** - loads DB items + preferences, then routes to Login or Home.
- **Login / Register** - login with `nploetz049` / `thOrn-6231` (display name
  `NPloetz`) or continue anonymously.
- **Home** - 5-tab bottom navigation:
  - **Library** - list of works (tap -> Work Details, each with a FAB -> Reader) +
    a FAB -> Reader.
  - **Updates**, **History**.
  - **Browse** - top swipe tabs (Sources / Extensions / Search); AppBar title and
    actions change per sub-tab.
  - **More** - list items -> About, Help, Settings.

## Prerequisites (Windows 11)

```powershell
flutter --version            # >= 3.27 (Dart >= 3.6) for pub workspaces
dart pub global activate melos
code --install-extension Dart-Code.flutter
code --install-extension blaugold.melos-code
```

Add the pub cache bin to PATH if `melos` isn't found:
`C:\Users\<You>\AppData\Local\Pub\Cache\bin`

## Getting started

```powershell
git clone https://github.com/Anti049/architecture-test.git
cd architecture-test

# One-shot scaffold + bootstrap + codegen for BOTH workspaces:
powershell -ExecutionPolicy Bypass -File .\bootstrap.ps1
```

Or manually:

```powershell
# Main workspace
melos bootstrap
melos run gen          # freezed / mappable / drift codegen
melos run analyze

# Isar workspace (isolated)
cd isar-workspace
melos bootstrap
melos run gen          # isar codegen (build_runner 2.4.x)
cd ..
```

## Running an app

```powershell
cd apps\app_baseline
flutter run -d windows   # or -d chrome / an emulator
```

For Isar apps: `cd isar-workspace\apps\app_isar; flutter run -d windows`.

## Adding another permutation

1. Copy `apps\app_baseline` (or an Isar app for Isar permutations).
2. Swap the `db_*`, `model_*`, `nav_*`, and state (`flutter_riverpod` /
   `flutter_bloc`) dependencies in its `pubspec.yaml`.
3. Adjust `main.dart` wiring. Feature/UI code never changes.
4. Add the app to the correct workspace `pubspec.yaml`, then `melos bootstrap`.

## Windows gotchas

- Keep the repo at a short path (e.g. `C:\src\architecture-test`); enable long paths.
- Avoid OneDrive-synced folders for Flutter projects.
- Stop `flutter run`/watch before `melos run gen` to avoid `.dart_tool` file locks.
- In Windows PowerShell 5.1 chain commands with `;` (not `&&`).
- Never bump `build_runner` past 2.4.x inside `isar-workspace` - it breaks Isar codegen.
