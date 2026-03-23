---
description: "Use when asked to convert a Google Stitch screen ID, Stitch design, or Stitch screen export into Flutter UI code for this app. Covers screen implementation, file placement, widget decomposition, routing touchpoints, and repo-specific constraints."
---

# Google Stitch Screen To Flutter

Use these instructions when implementing a Flutter screen from a Google Stitch screen ID, screenshot, or screen export for this repository.

## Project Context

- This repository is a Flutter app with a feature-first structure under `lib/features/<feature>/...`.
- Most architecture folders already exist, but many files are placeholders or empty. Do not assume existing theme, router, DI, or shared widgets are production-ready unless you inspect them first.
- `pubspec.yaml` currently contains only Flutter SDK defaults and `cupertino_icons`. Prefer Flutter SDK widgets over adding new packages.
- `main.dart` is still the default Flutter counter app. Do not rewrite the app shell unless the user explicitly asks for integration.

## Primary Goal

Translate the Stitch design into maintainable Flutter code that matches the visual hierarchy and user flow while fitting this repo's structure.

## Required Inputs

Try to obtain these before implementation:

- Stitch screen ID or export details.
- Target feature name, for example `auth`, `products`, `profile`, or `dashboard`.
- Target screen name, for example `Login`, `ProductList`, or `OrderDetail`.
- Whether the task is UI-only or also needs navigation, state wiring, mock data, or backend integration.

If only a Stitch screen ID is provided and the actual design content is not accessible from the workspace, ask for one of the following before attempting a pixel-accurate implementation:

- A screenshot.
- A design export.
- A short section-by-section description of the screen.

If the user still wants a first pass without the design payload, generate a best-effort UI scaffold and clearly mark assumptions.

## File Placement Rules

- Put the main screen in `lib/features/<feature>/presentation/pages/<screen_name>_page.dart`.
- Put extracted reusable UI parts in `lib/features/<feature>/presentation/widgets/`.
- Keep Stitch-driven work in the presentation layer unless the user explicitly asks for data, domain, bloc, or repository code.
- If the feature folder does not exist, create only the minimal `presentation/pages` and `presentation/widgets` folders needed for the screen.
- Only update `lib/app/router/app_router.dart` when the user asks for navigation integration.

## Naming Rules

- Use PascalCase widget names.
- Name page widgets as `<ScreenName>Page`.
- Name extracted widgets by purpose, for example `ProductHeroSection`, `AddressSummaryCard`, or `CheckoutPriceRow`.
- Use snake_case file names that mirror the class name.

## Implementation Rules

- Build responsive layouts using `Scaffold`, `SafeArea`, `LayoutBuilder`, `SingleChildScrollView`, `ListView`, `GridView`, `Wrap`, `Expanded`, and `Flexible` as appropriate.
- Prefer composition over one massive build method. Extract sections once the page becomes difficult to read.
- Keep widgets `const` where practical.
- Use semantic Flutter layout primitives instead of absolute positioning unless the design truly requires stacking.
- Preserve the Stitch hierarchy and spacing rhythm, but do not chase pixel-perfect code with brittle fixed sizes.
- Avoid hard-coded magic numbers repeated across the file. Lift repeated spacing or sizing into local constants.
- Prefer `Theme.of(context)` and `ColorScheme` values first. If app theme files are still empty, keep screen-local styling small and avoid inventing a large theme system.
- Use `InkWell`, `GestureDetector`, `IconButton`, `TextButton`, `FilledButton`, and other Material controls instead of non-semantic tap targets.
- Provide overflow-safe text handling with `maxLines`, `overflow`, and flexible layout constraints where needed.
- Ensure the screen remains usable on narrow mobile widths.

## Interaction And Data Rules

- For UI-only tasks, keep callbacks local and leave clear TODO markers for business actions.
- Do not invent API clients, repositories, blocs, or models unless the user explicitly asks for them.
- Do not fabricate backend values. Use clearly named mock constants or constructor parameters instead.
- If the screen depends on dynamic content, prefer simple constructor inputs for the first pass.
- If state management is required, inspect the feature folder first and follow the existing pattern before introducing new state classes.

## Routing Rules

- When navigation is requested, add the smallest necessary change to the router.
- Do not redesign routing architecture as part of a Stitch screen task.
- If the router file is empty or placeholder-only, add only the route entries needed for the new screen and keep the structure simple.

## Visual Translation Rules

- Map Stitch sections into meaningful Flutter sections such as header, filter bar, hero card, product grid, summary card, CTA area, and footer actions.
- Replace unsupported design effects with stable Flutter equivalents.
- Use gradients, borders, chips, cards, and image placeholders when the design implies them.
- If assets are missing, use placeholders and note what asset path should be supplied later.
- Avoid generating decorative complexity that the repo cannot support.

## Accessibility Rules

- Maintain minimum practical tap target sizes.
- Use sufficient contrast with the chosen colors.
- Prefer readable text sizes and spacing.
- Add `Semantics` only when the screen has non-obvious interactive or status elements.

## What To Avoid

- Do not modify unrelated files.
- Do not add packages just to mirror a visual effect.
- Do not create empty clean-architecture layers for a screen-only request.
- Do not replace the default app bootstrap unless the user explicitly asks for full integration.
- Do not assume a completed design system exists in `lib/app/theme/`.

## Expected Output Pattern

When implementing a Stitch screen, aim to deliver:

- The page file.
- Any supporting presentation widgets required for readability.
- Minimal router updates only if requested.
- A short note describing assumptions, placeholders, and any missing design inputs.

## Suggested Workflow

1. Inspect the target feature folder and existing presentation files.
2. Confirm whether the task is UI-only or includes navigation and state.
3. Create the page in the correct feature path.
4. Extract repeated or visually distinct sections into widgets.
5. Keep data mocked through constructor inputs or local sample data unless told otherwise.
6. Validate the edited Dart files with analysis if code was generated.

## Example Mapping

- Stitch screen: product listing
- Target path: `lib/features/products/presentation/pages/product_list_page.dart`
- Supporting widgets: `product_filter_bar.dart`, `product_grid_item.dart`, `product_sort_sheet.dart`
- Optional router touchpoint: `lib/app/router/app_router.dart`

Use these instructions to keep Stitch-driven screen generation practical, minimal, and aligned with the current state of this repository.