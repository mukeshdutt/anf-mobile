# ANF App — Project Structure

A Flutter e-commerce app built with **Clean Architecture** and **BLoC** state management.

---

## Top-Level Layout

```
anf-app/
├── lib/                  # All application source code
├── android/              # Android platform files
├── test/                 # Widget and unit tests
├── docs/                 # Project documentation
├── pubspec.yaml          # Dependencies & asset declarations
└── analysis_options.yaml # Lint rules
```

---

## `lib/` Structure

```
lib/
├── main.dart             # App entry point
├── app/                  # App-wide setup
├── core/                 # Shared infrastructure
├── features/             # Feature modules (Clean Architecture)
└── shared/               # Reusable UI utilities
```

---

## `app/` — App-Wide Configuration

```
app/
├── app.dart              # Root widget (MaterialApp / router bootstrap)
├── router/
│   ├── app_router.dart   # Route definitions (all named routes)
│   └── route_guards.dart # Auth / permission guards
└── theme/
    ├── app_colors.dart   # Global color palette
    ├── app_theme.dart    # ThemeData configuration
    └── app_typography.dart # Text styles & font config
```

---

## `core/` — Shared Infrastructure

```
core/
├── constants/
│   ├── api_constants.dart    # Base URLs, endpoint paths
│   ├── app_constants.dart    # App-wide magic values
│   └── storage_keys.dart     # Keys for local/secure storage
├── di/
│   └── injection.dart        # Dependency injection setup (GetIt / similar)
├── error/
│   ├── exceptions.dart       # Custom exception types
│   └── failures.dart         # Failure types (for Either / Result pattern)
├── network/
│   ├── api_client.dart       # HTTP client wrapper (Dio / http)
│   ├── network_info.dart     # Connectivity checks
│   └── interceptors/
│       ├── auth_interceptor.dart   # Attaches auth tokens to requests
│       └── retry_interceptor.dart  # Retries failed requests
├── storage/
│   ├── local_db.dart         # Local persistence (Hive / SQLite)
│   └── secure_storage.dart   # Encrypted storage (flutter_secure_storage)
└── utils/
    ├── currency_formatter.dart
    ├── date_formatter.dart
    └── validators.dart
```

---

## `shared/` — Reusable UI Utilities

```
shared/
├── extensions/
│   ├── context_extensions.dart   # BuildContext helpers (theme, nav, size)
│   └── string_extensions.dart    # String helpers
├── mixins/
│   └── pagination_mixin.dart     # Reusable pagination logic for lists
└── widgets/
    ├── app_button.dart           # Primary/secondary button variants
    ├── app_text_field.dart       # Branded text input
    ├── empty_state_widget.dart   # Empty list / no-data state
    ├── error_state_widget.dart   # Error + retry state
    ├── loading_overlay.dart      # Full-screen loading indicator
    └── status_chip.dart          # Order / commission status badge
```

---

## `features/` — Feature Modules

Each feature follows the **Clean Architecture** three-layer pattern:

```
features/<feature>/
├── data/
│   ├── datasources/    # Remote (API) and local (DB/cache) data sources
│   ├── models/         # JSON-serializable data models (extend entities)
│   └── repositories/   # Concrete repository implementations
├── domain/
│   ├── entities/       # Pure Dart business objects (no Flutter deps)
│   ├── repositories/   # Abstract repository contracts
│   └── usecases/       # Single-responsibility business logic units
└── presentation/
    ├── bloc/           # BLoC: events, states, and bloc class
    ├── pages/          # Full-screen route widgets
    └── widgets/        # Feature-scoped reusable widgets
```

---

### Feature: `agents/` — Agent / Referral System

> Handles agent profiles, commissions, referrals, and settlements.

```
agents/
├── data/
│   ├── datasources/
│   │   └── referral_remote_ds.dart
│   ├── models/
│   │   ├── agent_model.dart
│   │   ├── commission_model.dart
│   │   ├── referral_attribution_model.dart
│   │   └── settlement_model.dart
│   └── repositories/
│       └── referral_repo_impl.dart
├── domain/
│   ├── entities/
│   │   ├── agent_entity.dart
│   │   ├── commission_entity.dart
│   │   └── settlement_entity.dart
│   ├── repositories/
│   │   └── referral_repository.dart
│   └── usecases/
│       ├── get_agent_profile_usecase.dart
│       ├── get_commissions_usecase.dart
│       ├── get_referral_history_usecase.dart
│       ├── get_settlements_usecase.dart
│       └── share_agent_id_usecase.dart
└── presentation/
    ├── bloc/
    │   ├── agent_bloc.dart
    │   ├── commission_bloc.dart
    │   └── settlement_bloc.dart
    ├── pages/
    │   ├── agent_dashboard.dart
    │   ├── commission_details.dart
    │   ├── commission_wallet.dart
    │   ├── redeem_commission.dart
    │   └── redemption_history.dart
    └── widgets/
        ├── agent_id_card.dart
        ├── commission_tile.dart
        └── settlement_status_badge.dart
```

---

### Feature: `auth/` — Authentication

> OTP / phone login, token management, session persistence.

```
auth/
├── data/
│   ├── datasources/
│   │   ├── auth_local_ds.dart
│   │   └── auth_remote_ds.dart
│   ├── models/
│   │   ├── auth_token.dart
│   │   └── login_request.dart
│   └── repositories/
│       └── auth_repo_impl.dart
├── domain/
│   ├── entities/
│   │   └── user_entity.dart
│   ├── repositories/
│   │   └── auth_repository.dart
│   └── usecases/
│       ├── login_usecase.dart
│       └── logout_usecase.dart
└── presentation/
    ├── bloc/
    │   ├── auth_bloc.dart
    │   └── auth_state.dart
    ├── pages/
    │   ├── login_page.dart
    │   └── register_page.dart
    └── widgets/
        └── auth_form.dart
```

---

### Feature: `dashboard/` — Home / Dashboard

> Main landing screen with product highlights, categories, and agent earnings summary.

```
dashboard/
├── dashboard_colors.dart        # Dashboard-specific color overrides
├── data/                        # (placeholder)
├── domain/                      # (placeholder)
└── presentation/
    ├── bloc/                    # (placeholder)
    ├── pages/
    │   └── dashboard_page.dart
    └── widgets/
        ├── budget_grid.dart
        ├── category_list.dart
        ├── commission_chart.dart
        ├── dashboard_bottom_nav.dart
        ├── dashboard_header.dart
        ├── dashboard_search_bar.dart
        ├── earnings_summary_card.dart
        ├── featured_products_grid.dart
        ├── hero_carousel.dart
        ├── price_range_list.dart
        ├── recent_referrals_list.dart
        └── recently_viewed_list.dart
```

---

### Feature: `products/` — Product Catalog

```
products/
├── data/         # (placeholder)
├── domain/       # (placeholder)
└── presentation/
    ├── pages/
    │   ├── product_list_page.dart
    │   ├── product_detail_page.dart
    │   ├── product_search_page.dart
    │   └── search_by_sku.dart
    └── widgets/  # (placeholder)
```

---

### Feature: `cart/` — Shopping Cart

```
cart/
├── data/         # (placeholder)
├── domain/       # (placeholder)
└── presentation/
    ├── bloc/     # (placeholder)
    ├── pages/
    │   └── cart_page.dart
    └── widgets/  # (placeholder)
```

---

### Feature: `checkout/` — Checkout & Payment

```
checkout/
├── data/         # (placeholder)
├── domain/       # (placeholder)
└── presentation/
    ├── pages/
    │   ├── checkout_page.dart
    │   └── payment_page.dart
    └── widgets/
        └── agent_id_input_field.dart  # Agent referral code entry at checkout
```

---

### Feature: `orders/` — Order Management

```
orders/
├── data/         # (placeholder)
├── domain/       # (placeholder)
└── presentation/
    ├── pages/
    │   ├── order_list_page.dart
    │   └── order_detail_page.dart
    └── widgets/  # (placeholder)
```

---

### Feature: `profile/` — User Profile & Addresses

```
profile/
├── data/
│   ├── datasources/
│   ├── models/
│   └── repositories/
├── domain/
│   ├── entities/
│   ├── repositories/
│   └── usecases/
└── presentation/
    ├── bloc/
    │   ├── profile_bloc.dart
    │   ├── address_bloc.dart
    │   ├── address_event.dart
    │   └── address_state.dart
    ├── pages/
    │   ├── profile_page.dart
    │   ├── edit_account_details.dart
    │   ├── change_password.dart
    │   ├── my_address_page.dart
    │   ├── add_address_page.dart
    │   └── edit_address_page.dart
    └── widgets/
        ├── address_card_widget.dart
        └── address_form_widget.dart
```

---

### Feature: `wishlist/` — Wishlist

```
wishlist/
├── data/
│   ├── datasources/
│   │   ├── wishlist_local_datasource.dart
│   │   └── wishlist_remote_datasource.dart
│   ├── models/
│   │   └── wishlist_model.dart
│   └── repositories/
│       └── wishlist_repository_impl.dart
├── domain/
│   ├── entities/
│   │   └── wishlist_entity.dart
│   ├── repositories/
│   │   └── wishlist_repository.dart
│   └── usecases/
│       ├── add_to_wishlist_usecase.dart
│       ├── get_wishlist_usecase.dart
│       └── remove_from_wishlist_usecase.dart
└── presentation/
    ├── bloc/
    │   ├── wishlist_bloc.dart
    │   ├── wishlist_event.dart
    │   └── wishlist_state.dart
    ├── pages/
    │   └── wishlist_page.dart
    └── widgets/
        └── wishlist_item_widget.dart
```

---

### Feature: `splash/` — Splash / Launch Screen

```
splash/
├── bloc/
│   ├── splash_bloc.dart
│   ├── splash_event.dart
│   └── splash_state.dart
├── pages/
│   └── splash_page.dart
└── widgets/  # (placeholder)
```

> Note: `splash/` does not follow the data/domain sub-layer split as it contains no backend logic.

---

## Architecture Summary

| Concern            | Approach                                      |
|--------------------|-----------------------------------------------|
| Architecture       | Clean Architecture (Data / Domain / Presentation) |
| State management   | BLoC (`flutter_bloc`)                         |
| Dependency injection | `core/di/injection.dart` (GetIt pattern)    |
| Routing            | Centralized named routes + guards             |
| Networking         | API client with auth & retry interceptors     |
| Storage            | Local DB + secure storage                     |
| Error handling     | Exceptions + Failures (Either/Result pattern) |
| Theming            | Centralized `app_theme.dart`; per-feature overrides allowed |

---

## Naming Conventions

| Artifact          | Convention                        | Example                          |
|-------------------|-----------------------------------|----------------------------------|
| Page widget       | `<Name>Page`                      | `ProductDetailPage`              |
| BLoC class        | `<Name>Bloc`                      | `WishlistBloc`                   |
| Entity            | `<Name>Entity`                    | `AgentEntity`                    |
| Model             | `<Name>Model`                     | `CommissionModel`                |
| Use case          | `<Verb><Name>Usecase`             | `GetCommissionsUsecase`          |
| Repository (abs)  | `<Name>Repository`                | `WishlistRepository`             |
| Repository (impl) | `<Name>RepositoryImpl`            | `WishlistRepositoryImpl`         |
| Data source       | `<Name>RemoteDs` / `<Name>LocalDs`| `AuthRemoteDs`, `AuthLocalDs`    |
| File name         | `snake_case.dart`                 | `commission_tile.dart`           |
