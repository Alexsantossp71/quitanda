# Contributing to Quitanda Virtual

> Thank you for your interest in contributing! This guide covers everything you need to set up your development environment, understand the codebase conventions, and submit quality contributions.

## Table of Contents

- [Code of Conduct](#code-of-conduct)
- [Getting Started](#getting-started)
- [Development Setup](#development-setup)
- [Project Structure Overview](#project-structure-overview)
- [Development Workflow](#development-workflow)
- [Coding Conventions](#coding-conventions)
- [Adding a New Feature](#adding-a-new-feature)
- [Writing Tests](#writing-tests)
- [Commit Messages](#commit-messages)
- [Pull Request Process](#pull-request-process)
- [Demo Mode](#demo-mode)
- [Troubleshooting](#troubleshooting)

---

## Code of Conduct

Be respectful, constructive, and inclusive. We welcome contributors of all experience levels. If you're a beginner, don't hesitate to ask questions — we're here to help.

---

## Getting Started

### Prerequisites

- **Flutter SDK 3.27.4+** — [Install guide](https://docs.flutter.dev/get-started/install)
- **Dart 3.3+** (included with Flutter)
- **Git** — For version control
- **GitHub account** — For PRs and issues
- **VS Code** or **Android Studio** (recommended IDEs)

### Quick Start

```bash
# 1. Fork and clone the repository
git clone https://github.com/<your-username>/quitanda.git
cd quitanda

# 2. Install dependencies
flutter pub get

# 3. Run in demo mode (no backend needed)
flutter run -d chrome

# 4. Run tests
flutter test

# 5. Run static analysis
dart analyze
```

---

## Development Setup

### IDE Configuration

Install the **Flutter** and **Dart** extensions in your IDE. For VS Code:
- Flutter extension (Dart-Code)
- Error Lens (optional, highlights errors inline)

### Environment Variables

For real backend access (not demo mode), create a `.env` file or use `--dart-define`:

```bash
flutter run \
  --dart-define=PARSE_REST_API_KEY=your_key \
  --dart-define=PARSE_APP_ID=your_app_id
```

**Note**: Demo mode (`kDemoMode = true` in `lib/src/config/demo_mode.dart`) is the default and requires no API keys.

---

## Project Structure Overview

The project uses a **feature-based** folder structure under `lib/src/pages/`. Each feature contains:
- `binding/` — Dependency injection setup
- `controller/` — Business logic (GetX controllers)
- `repository/` — Data access layer
- `view/` — UI widgets

Shared code lives in:
- `config/` — App configuration (colors, demo mode, responsive layout)
- `constants/` — Static values (endpoints, storage keys)
- `models/` — Data models with JSON serialization
- `services/` — Cross-cutting utilities (HTTP, validation, formatting)

See [ARCHITECTURE.md](ARCHITECTURE.md) for detailed architecture documentation.

---

## Development Workflow

### Branch Naming

Use descriptive branch names following these conventions:

| Type | Format | Example |
|---|---|---|
| Feature | `feat/description` | `feat/checkout-flow` |
| Bug fix | `fix/description` | `fix/cart-total-calc` |
| Docs | `docs/description` | `docs/api-guide` |
| Refactor | `refactor/description` | `refactor/auth-service` |
| Test | `test/description` | `test/cart-repository` |
| Chore | `chore/description` | `chore/update-deps` |

### Workflow

```
main ───────────────────────────────────────────
  └── feat/your-feature ── commit ── commit ── PR ── merge
```

1. **Create a branch** from `main`:
   ```bash
   git checkout main
   git pull origin main
   git checkout -b feat/your-feature
   ```

2. **Make changes** following coding conventions.

3. **Commit** with clear messages (see [Commit Messages](#commit-messages)).

4. **Push** and open a Pull Request:
   ```bash
   git push -u origin feat/your-feature
   ```

---

## Coding Conventions

### Dart & Flutter

- Follow [Effective Dart](https://dart.dev/guides/language/effective-dart) guidelines.
- Use `flutter_lints` (already configured in `analysis_options.yaml`).
- Class names: `PascalCase` (`CartItemModel`, `NavigationController`).
- Files: `snake_case` (`cart_item_model.dart`, `navigation_controller.dart`).
- Constants: `lowerCamelCase` for local, `camelCase` for static (`kDemoMode`).
- Private members: prefix with `_` (`_httpManager`, `_currentIndex`).

### GetX Patterns

- Controllers: extend `GetxController`, use `.obs` for reactive state.
- Bindings: create a `Binding` class that calls `Get.lazyPut(() => Controller())`.
- Navigation: use `Get.toNamed(route)` or `Get.offAllNamed(route)`.
- Dependency resolution: `Get.find<T>()` for already-registered services.

### JSON Serialization

- Use `json_annotation` + `json_serializable`.
- Run `dart run build_runner build` after model changes.
- Commit the generated `.g.dart` files.

### Responsive Layout

- Use `ResponsiveLayout.isDesktop(context)` for breakpoint checks.
- Use `ResponsiveLayout.gridColumns(context)` for grid column counts.
- Wrap page content in `ResponsiveLayout.constrained(child: ...)`.

---

## Adding a New Feature

### Step-by-Step Example: Adding a "Favorites" Tab

1. **Define the route** in `lib/src/pages_routes/app_pages.dart`:
   ```dart
   GetPage(
     name: '/favorites',
     page: () => const FavoritesTab(),
     binding: FavoritesBinding(),
   )
   ```

2. **Create the feature module**:
   ```
   lib/src/pages/favorites/
   ├── binding/favorites_binding.dart
   ├── controller/favorites_controller.dart
   ├── repository/favorites_repository.dart
   └── view/favorites_tab.dart
   ```

3. **Create the repository** (with demo mode support):
   ```dart
   class FavoritesRepository {
     final _httpManager = HttpManager();
     final _demoRepo = DemoFavoritesRepository();

     Future<FavoritesResult> getFavorites({required String token}) async {
       if (kDemoMode) return _demoRepo.getFavorites(token: token);
       // ... real API call
     }
   }
   ```

4. **Create the controller**:
   ```dart
   class FavoritesController extends GetxController {
     final repository = FavoritesRepository();
     final favorites = <ItemModel>[].obs;

     @override
     void onInit() {
       super.onInit();
       loadFavorites();
     }

     Future<void> loadFavorites() async { /* ... */ }
   }
   ```

5. **Create the binding**:
   ```dart
   class FavoritesBinding implements Binding {
     @override
     void dependencies() {
       Get.lazyPut(() => FavoritesController());
     }
   }
   ```

6. **Add tests** in `test/unit/favorites_test.dart`.

7. **Update navigation** in `base_screen.dart` if needed.

---

## Writing Tests

### Test Structure

```
test/
├── widget_test.dart           # Smoke test (app starts without crash)
└── unit/
    ├── item_test.dart          # Model serialization tests
    ├── cart_item_test.dart     # Cart model tests
    ├── order_test.dart         # Order model tests
    ├── app_user_test.dart      # User model tests
    ├── validators_test.dart    # Form validation tests
    ├── category_model_test.dart # Category model tests
    └── endpoints_test.dart      # Endpoint URL verification
```

### Running Tests

```bash
# Run all tests
flutter test

# Run specific test file
flutter test test/unit/validators_test.dart

# Run with coverage
flutter test --coverage
```

### Test Guidelines

- **Model tests**: Verify `fromJson()`, `toJson()`, and round-trip serialization.
- **Validator tests**: Test valid inputs, empty/null inputs, and edge cases.
- **Controller tests**: Mock repositories, verify state changes.
- **Widget tests**: Use `flutter_test` toolkit; avoid network calls in tests.
- Each test file should cover the corresponding source file in `lib/src/`.

### Example Test

```dart
test('email validator returns null for valid email', () {
  expect(emailValidator('user@example.com'), isNull);
});

test('email validator returns error for empty input', () {
  expect(emailValidator(''), isNotNull);
  expect(emailValidator(null), isNotNull);
});
```

---

## Commit Messages

Follow the **Conventional Commits** format:

```
<type>(<scope>): <description>

[optional body]
```

| Type | Purpose |
|---|---|
| `feat` | New feature |
| `fix` | Bug fix |
| `docs` | Documentation only |
| `refactor` | Code refactoring (no behavior change) |
| `test` | Adding/updating tests |
| `chore` | Build, deps, config changes |
| `ci` | CI/CD changes |
| `style` | Formatting, linting |

**Examples**:
```
feat(cart): add quantity increment/decrement buttons
fix(auth): handle token expiration on API calls
docs: add ARCHITECTURE.md and CONTRIBUTING.md
test(orders): add unit tests for OrderModel serialization
```

---

## Pull Request Process

1. **Ensure CI passes**: Your PR should show all checks green (analyze + test).
2. **Update documentation**: If you changed architecture or added features, update `ARCHITECTURE.md`.
3. **Add tests**: New features and bug fixes should include tests.
4. **Keep PRs focused**: One PR per concern. If in doubt, split into smaller PRs.
5. **Respond to review**: Address feedback promptly and push updates to the same branch.

### PR Template

```markdown
## Summary
Brief description of changes.

## Changes
- [ ] List of changes

## Tests
- [ ] Test coverage added/updated

## Screenshots (if applicable)
```

---

## Demo Mode

The app defaults to **demo mode** (`kDemoMode = true`), which provides a fully functional offline experience without requiring API keys or a backend connection.

**To run with demo mode**:
```bash
flutter run -d chrome    # Just works, no keys needed
```

**To run with the real backend**:
1. Set `kDemoMode = false` in `lib/src/config/demo_mode.dart`.
2. Provide API keys via `--dart-define`:
   ```bash
   flutter run -d chrome \
     --dart-define=PARSE_REST_API_KEY=your_key \
     --dart-define=PARSE_APP_ID=your_app_id
   ```

---

## Troubleshooting

| Problem | Solution |
|---|---|
| `flutter pub get` fails | Ensure Flutter 3.27.4+ is installed. Check `pubspec.yaml` dependency versions. |
| Build fails on missing `.g.dart` | Run `dart run build_runner build --delete-conflicting-outputs`. |
| CI is red | Check that all new files have tests and `dart analyze` passes locally. |
| Images not loading in demo mode | Check internet connection (Unsplash images require network access). |
| Web deploy fails | Verify `PARSE_REST_API_KEY` and `PARSE_APP_ID` secrets are set in GitHub repo settings. |

---

## Questions?

Open an [issue](https://github.com/Alexsantossp71/quitanda/issues) with the `question` label. We'll do our best to help!

Happy coding!
