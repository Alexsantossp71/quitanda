# Architecture — Quitanda Virtual

> A comprehensive guide to the codebase architecture, design decisions, and patterns used in the Quitanda Virtual (Greengrocery) Flutter application.

## Table of Contents

- [Overview](#overview)
- [Technology Stack](#technology-stack)
- [High-Level Architecture](#high-level-architecture)
- [Project Structure](#project-structure)
- [State Management — GetX](#state-management--getx)
- [Layer Architecture per Feature](#layer-architecture-per-feature)
- [Routing & Navigation](#routing--navigation)
- [Responsive Layout System](#responsive-layout-system)
- [Demo Mode (Offline)](#demo-mode-offline)
- [Models & Serialization](#models--serialization)
- [Network Layer](#network-layer)
- [Services & Utilities](#services--utilities)
- [Validation Layer](#validation-layer)
- [CI/CD Pipeline](#cicd-pipeline)
- [Design Decisions & Trade-offs](#design-decisions--trade-offs)

---

## Overview

Quitanda Virtual is a **Flutter e-commerce application** for fruit and grocery shopping. It follows a feature-based folder structure using the **GetX** framework for state management, dependency injection, and routing. The app connects to a **Back4App (Parse Server)** backend but can run entirely offline via a **demo mode** that provides local mock data.

The application supports **Android, iOS, and Web** platforms. A responsive layout system automatically adapts the UI between mobile (bottom navigation), tablet, and desktop (navigation rail + multi-column grids).

---

## Technology Stack

| Layer | Technology | Purpose |
|---|---|---|
| **Framework** | Flutter 3.27+ | Cross-platform UI (Android, iOS, Web) |
| **Language** | Dart 3.3+ | Application code |
| **State Management** | GetX 4.6.6 | Routing, DI, reactive state |
| **HTTP Client** | Dio 5.7.0 | Network requests |
| **Serialization** | json_serializable + json_annotation | JSON ↔ Model conversion |
| **Code Generation** | build_runner 2.4+ | `.g.dart` file generation |
| **Secure Storage** | flutter_secure_storage | Token persistence |
| **Backend** | Back4App (Parse Server) | REST API (bypassed in demo mode) |
| **CI/CD** | GitHub Actions | Lint, analyze, test, deploy web |
| **Hosting** | GitHub Pages | Web deployment |

---

## High-Level Architecture

```
┌──────────────────────────────────────────────────────┐
│                     Flutter App                       │
│                                                       │
│  ┌─────────┐  ┌──────────┐  ┌───────────────────┐   │
│  │  Views   │  │Controller│  │    Repository     │   │
│  │ (Pages) │──▶│ (GetX)   │──▶│  (Data Layer)     │   │
│  └─────────┘  └──────────┘  └──────┬────────────┘   │
│                                     │                 │
│                           ┌─────────┴─────────┐       │
│                           │                     │       │
│                    ┌──────▼──────┐    ┌───────▼──────┐│
│                    │ HttpManager  │    │ Demo Repo     ││
│                    │ (Dio/Back4App)│   │ (Mock Data)  ││
│                    └─────────────┘    └──────────────┘│
│                                                       │
└──────────────────────────────────────────────────────┘
```

**Key principle**: Each feature module follows the **MVVM-inspired** pattern: View → Controller → Repository → Data Source. The `kDemoMode` flag at compile time determines whether the repository layer routes to the real HTTP backend or to local demo data providers.

---

## Project Structure

```
lib/
├── main.dart                              # App entry point
├── src/
│   ├── config/                            # Global configuration
│   │   ├── custom_colors.dart             # Material color swatch
│   │   ├── demo_data.dart                # Mock data catalog
│   │   ├── demo_mode.dart                # kDemoMode toggle (const bool)
│   │   └── responsive_layout.dart        # Breakpoints & grid helpers
│   │
│   ├── constants/                         # Static constants
│   │   ├── endpoints.dart                # API endpoint URLs
│   │   └── storage_keys.dart             # Secure storage key names
│   │
│   ├── models/                            # Data models (JSON serializable)
│   │   ├── item_model.dart               # Product
│   │   ├── cart_item_model.dart          # Cart line item
│   │   ├── category_model.dart          # Product category
│   │   ├── order_model.dart              # Order
│   │   └── user_model.dart               # User account
│   │
│   ├── pages/                             # Feature modules
│   │   ├── auth/                         # Authentication (sign in/up)
│   │   │   ├── binding/
│   │   │   ├── controller/
│   │   │   ├── repositories/
│   │   │   ├── result/
│   │   │   └── view/
│   │   ├── base/                         # Shell with nav rail/bar
│   │   │   ├── binding/
│   │   │   ├── controller/
│   │   │   └── base_screen.dart
│   │   ├── cart/                         # Shopping cart + checkout
│   │   │   ├── binding/
│   │   │   ├── controller/
│   │   │   ├── repository/              # cart_repository + demo variant
│   │   │   ├── cart_result/
│   │   │   └── view/
│   │   ├── home/                         # Home catalog + search
│   │   │   ├── binding/
│   │   │   ├── controller/
│   │   │   ├── repository/              # home_repository + demo variant
│   │   │   ├── result/
│   │   │   └── view/
│   │   ├── orders/                       # Order history
│   │   │   ├── binding/
│   │   │   ├── controller/
│   │   │   ├── orders_result/
│   │   │   └── view/
│   │   ├── product/                      # Product detail screen
│   │   │   └── product_screen.dart
│   │   ├── profile/                      # User profile
│   │   │   └── profile_page.dart
│   │   └── splash/                       # Splash screen
│   │       └── splash_screen.dart
│   │
│   ├── pages_routes/                     # Centralized routing
│   │   └── app_pages.dart               # GetPage routes + PagesRoutes
│   │
│   └── services/                          # Cross-cutting services
│       ├── http_manager.dart            # Dio HTTP wrapper
│       ├── utils_services.dart          # Currency, date, toast, storage
│       └── validators.dart               # Form validators

test/
├── widget_test.dart                       # Smoke test: app starts
└── unit/
    ├── app_user_test.dart                # UserModel tests
    ├── cart_item_test.dart               # CartItemModel tests
    ├── item_test.dart                    # ItemModel tests
    ├── order_test.dart                   # OrderModel tests
    ├── validators_test.dart              # Form validation tests
    ├── category_model_test.dart          # CategoryModel tests
    └── endpoints_test.dart               # Endpoint URL tests
```

---

## State Management — GetX

The application uses **GetX** as a single solution for:

1. **Dependency Injection**: Controllers are registered via `Get.put()` at the binding level and resolved with `Get.find<T>()`.
2. **Reactive State**: Controllers use `.obs` (Rx types) for observable state changes. Views rebuild automatically via `Obx()` widgets.
3. **Routing**: `GetMaterialApp` replaces `MaterialApp`. All routes are defined centrally in `AppPages.pages` with lazy-loaded `GetPage` entries.
4. **Lifecycle**: Controllers extend `GetxController` with `onInit()` / `onClose()` lifecycle hooks.

### Bindings

Each feature module has a **Binding** class that registers controllers when the route is entered. The `BaseScreen` route bundles all tab bindings:

```dart
GetPage(
  name: PagesRoutes.baseRoute,
  page: () => const BaseScreen(),
  bindings: [
    NavigationBinding(),
    HomeBinding(),
    CartBinding(),
    OrdersBinding(),
  ],
)
```

---

## Layer Architecture per Feature

Each feature module follows this structure:

```
feature/
├── binding/         # Registers controller(s) on route entry
├── controller/      # Business logic, state management
├── repository/      # Data fetching (HTTP or demo)
├── result/          # Sealed-class-style result types
└── view/            # UI widgets + sub-widgets
```

### Data Flow

```
User Action → View → Controller method
    → Repository method → kDemoMode check
        → true  → DemoXxxRepository returns mock data
        → false → HttpManager.restRequest() → Back4App API
    → Repository returns Result<T> (success/error)
    → Controller updates state (.obs)
    → GetX/Obx rebuilds View
```

### Result Types

Custom result classes (`HomeResult<T>`, `CartResult<T>`, etc.) wrap API responses in a success/error union, keeping controllers clean from raw HTTP handling.

---

## Routing & Navigation

### Route Table

| Route Constant | Path | Page | Bindings |
|---|---|---|---|
| `splashRoute` | `/splash` | `SplashScreen` | — |
| `singInRoute` | `/signin` | `SingInScreen` | — |
| `singUpRoute` | `/signup` | `SingUpScreen` | — |
| `baseRoute` | `/` | `BaseScreen` | Navigation, Home, Cart, Orders |
| `homeRoute` | `/home` | `HomeTab` | — |
| `cartRoute` | `/cart` | `CartTab` | — |
| `ordersRoute` | `/orders` | `OrdersTab` | — |
| `profileRoute` | `/profile` | `ProfilePage` | — |
| `productRoute` | `/product` | `ProductScreen` | — |

Navigation between bottom tabs (Home, Cart, Orders, Profile) uses a `PageController` managed by `NavigationController`, not route changes. This preserves tab state and provides swipe-free tab switching.

---

## Responsive Layout System

The `ResponsiveLayout` utility class (`lib/src/config/responsive_layout.dart`) provides breakpoint-based decisions:

| Breakpoint | Width | Navigation | Grid Columns | Padding |
|---|---|---|---|---|
| Mobile | < 600px | BottomNavigationBar | 2 | 8px |
| Tablet | 600–899px | BottomNavigationBar | 2–3 | 24px |
| Desktop | >= 900px | NavigationRail | 3–4 | 48px |

```dart
// Grid columns: >=1200→4, >=900→3, else 2
ResponsiveLayout.gridColumns(context)

// Content constraint wrapper
ResponsiveLayout.constrained(child: myWidget, maxWidth: 1200)
```

The `BaseScreen` switches between `NavigationRail` (desktop) and `BottomNavigationBar` (mobile) based on `ResponsiveLayout.isDesktop(context)`.

---

## Demo Mode (Offline)

A compile-time constant `kDemoMode` (`lib/src/config/demo_mode.dart`) controls whether the app connects to the real backend or uses mock data:

```dart
const bool kDemoMode = true;  // Toggle to false for real API
```

When enabled, every repository checks `kDemoMode` and delegates to a corresponding `DemoXxxRepository` that returns local mock data with artificial delays for realistic UX:

| Real Repository | Demo Repository | Mock Data Source |
|---|---|---|
| `HomeRepository` | `DemoHomeRepository` | `demoCategories`, `demoProducts` |
| `CartRepository` | `DemoCartRepository` | Empty cart, `demoOrders` |
| `AuthRepository` | (built into controller) | `demoUser` |

Demo data is defined in `lib/src/config/demo_data.dart` with 12 products, 3 categories, and 2 sample orders. Products use real Unsplash images.

### Enabling Real Backend

1. Set `kDemoMode = false` in `lib/src/config/demo_mode.dart`.
2. Build with `--dart-define` flags:
   ```bash
   flutter build web \
     --dart-define=PARSE_REST_API_KEY=your_key \
     --dart-define=PARSE_APP_ID=your_app_id
   ```

---

## Models & Serialization

All models use `json_annotation` with `json_serializable` code generation:

```dart
@JsonSerializable()
class ItemModel {
  String id;
  @JsonKey(name: 'title')
  String itemName;
  @JsonKey(name: 'picture')
  String imgUrl;
  double price;
  String unit;
  String description;
  // ...
}
```

Key field mappings:
- `itemName` ↔ JSON `title`
- `imgUrl` ↔ JSON `picture`
- `createdDateTime` ↔ JSON `createdAt`
- `overdueDateTime` ↔ JSON `due`
- `copyAndPaste` ↔ JSON `copiaecola`
- `name` ↔ JSON `fullname`
- `item` ↔ JSON `product`

Generated `.g.dart` files are committed to the repository for zero-setup `flutter pub get`.

---

## Network Layer

### HttpManager

`HttpManager` (`lib/src/services/http_manager.dart`) wraps Dio with:

- **Parse Server headers**: `X-Parse-REST-API-Key` and `X-Parse-Application-Id` injected from `--dart-define` compile-time constants (defaults to empty string).
- **Demo mode bypass**: Returns empty map `{}` when `kDemoMode = true`.
- **Error handling**: `DioException` catches return `error.response?.data ?? {}`.

### Endpoints

All API endpoints are centralized in `lib/src/constants/endpoints.dart` under the `EndPoints` class. The base URL points to `https://parseapi.back4app.com/functions`.

---

## Services & Utilities

### UtilsServices

| Method | Purpose |
|---|---|
| `saveLocalData(key, data)` | Save string to secure storage |
| `getLocalData(key)` | Read string from secure storage |
| `removeLocalData(key)` | Delete from secure storage |
| `priceToCurrency(price)` | Format double as BRL (R$ X,XX) |
| `formatDateTime(dt)` | Format DateTime as dd/MM/yyyy HH:mm (pt_BR) |
| `decodeQrCodeImage(value)` | Decode base64 QR code image |
| `showToast(message, isError)` | Show toast notification |

### CustomColors

Defines the app's green color swatch (`MaterialColor(0xff8bc34a)`) and accent colors used across the app theme.

---

## Validation Layer

Form validation functions in `lib/src/services/validators.dart`:

| Validator | Rules |
|---|---|
| `emailValidator` | Required, valid email format (GetX `isEmail`) |
| `passwordValidator` | Required, minimum 7 characters |
| `nameValidator` | Required, must contain at least first + last name (space-separated) |
| `phoneValidator` | Required, valid phone number, minimum 14 characters |
| `cpfValidator` | Required, valid CPF format (GetX `isCpf`) |

All validators return `null` on success or a Portuguese error message string.

---

## CI/CD Pipeline

### GitHub Actions Workflows

**CI (`ci.yml`)** — Runs on every push and PR:
1. Checkout code
2. Setup Flutter 3.27.4
3. `flutter pub get`
4. `dart analyze` — Static analysis
5. `flutter test` — Unit & widget tests

**Web Deploy (`deploy-web.yml`)** — Runs on push to `main`:
1. Same Flutter setup
2. `flutter build web --dart-define=...`
3. Deploy to GitHub Pages via `peaceiris/actions-gh-pages`

### Secrets

Two repository secrets are used for the web build:
- `PARSE_REST_API_KEY`
- `PARSE_APP_ID`

---

## Design Decisions & Trade-offs

### Why GetX instead of BLoC/Riverpod?

GetX provides an all-in-one solution (routing, DI, state management) with minimal boilerplate, ideal for a solo-developed grocery app. The trade-off is less separation of concerns compared to BLoC, but the codebase remains maintainable at its current size.

### Why compile-time `kDemoMode` instead of runtime?

A `const bool` allows the Dart tree-shaker to eliminate all HTTP code paths in demo builds, producing a smaller and faster web bundle. It also prevents accidental API calls if the toggle is misconfigured at runtime.

### Why commit generated `.g.dart` files?

Committing generated files ensures `flutter pub get` works without requiring `build_runner` on first clone. This simplifies onboarding and CI setup.

### Why NavigationRail + BottomNavigationBar?

The desktop NavigationRail provides persistent sidebar navigation similar to native apps, while BottomNavigationBar provides mobile-native tab experience. The 900px breakpoint mirrors Material Design 3 adaptive guidelines.

---

*This document is auto-generated and should be updated when significant architectural changes are made.*
