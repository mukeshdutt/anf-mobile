# Design System Document: The Precision Atelier

This design system is a comprehensive framework for creating high-end, editorial-grade e-commerce agent dashboards. It moves beyond generic administrative interfaces to create an environment that feels like a bespoke digital concierge—balancing the rigorous clarity of financial data with the soft, tactile luxury of a premium retail brand.

---

## 1. Overview & Creative North Star

**Creative North Star: "The Digital Atelier"**
The design system is built on the concept of an "Atelier"—a space that is both a functional workshop and a high-end showroom. We reject the "boxed" nature of traditional dashboards. Instead, we embrace **Soft Minimalism**: a philosophy where UI elements do not sit *on* the screen, but are *woven into* it through tonal layering and intentional white space.

**Key Design Principles:**
* **Intentional Asymmetry:** Break the rigid 12-column grid. Use the `spacing-24` and `spacing-16` tokens to create "hero" focal points that sit slightly off-center, drawing the eye to critical KPIs.
* **Breathing Room as Luxury:** Space is not "empty"; it is a premium asset. Use generous padding to signal importance and reduce cognitive load.
* **Editorial Authority:** Typography is treated as a lead design element, not just a carrier of information.

---

## 2. Colors & Surface Philosophy

This palette utilizes a sophisticated interplay between the high-energy `primary` (#a10050) and the calming, professional `secondary` (#00677c).

### The "No-Line" Rule
**Explicit Instruction:** Designers are prohibited from using 1px solid borders for sectioning. Physical boundaries are replaced by:
1. **Background Shifts:** Placing a `surface-container-lowest` card on a `surface-container-low` background.
2. **Tonal Transitions:** Using the `surface-variant` to define header areas against the `surface` background.

### Surface Hierarchy & Nesting
Treat the UI as a series of physical layers—like stacked sheets of fine vellum.
* **Base Layer:** `surface` (#faf8ff) – The infinite canvas.
* **Section Layer:** `surface-container-low` (#f2f3ff) – Used for grouping related modules.
* **Content Layer:** `surface-container-lowest` (#ffffff) – Used for individual cards or interactive data points to create a "lifted" effect.
* **Floating Layer:** Glassmorphism using `surface` at 70% opacity with a `20px` backdrop-blur for navigation or modals.

### Signature Textures
Avoid flat blocks of color. For Primary CTAs or Hero Cards, apply a subtle linear gradient:
* **Start:** `primary` (#a10050)
* **End:** `primary_container` (#cd0268) at a 135-degree angle.

---

## 3. Typography: The Editorial Voice

We pair **Manrope** (Display/Headlines) for its geometric, modern authority with **Inter** (Body/Labels) for its world-class legibility in dense financial data.

* **The Power Scale:** Use `display-lg` (3.5rem) sparingly for total revenue or primary agent metrics. It creates a bold, "magazine" feel.
* **The Hierarchy of Trust:**
* **Headlines (`manrope`):** Bold and confident. Used for page titles and section headers to establish a clear narrative.
* **Body (`inter`):** Set at `body-md` (0.875rem) for most data points to maintain a "clean" density.
* **Labels (`inter`):** Use `label-md` in all-caps with a `0.05rem` letter-spacing for metadata to provide a technical, high-end financial aesthetic.

---

## 4. Elevation & Depth

We achieve hierarchy through **Tonal Layering** rather than structural shadows.

* **The Layering Principle:** Depth is simulated by stacking. A card (`surface-container-lowest`) placed on a workspace (`surface-container-low`) creates a natural, soft "pop" without a single drop shadow.
* **Ambient Shadows:** Where floating elements (Modals/Popovers) are required, use:
* `Box-shadow: 0 12px 40px rgba(21, 27, 44, 0.06);`
* The shadow color is a 6% opacity version of `on-surface`, ensuring the shadow feels like a natural part of the lighting environment.
* **The "Ghost Border" Fallback:** If accessibility requires a stroke, use `outline-variant` (#e2bdc5) at **15% opacity**. This provides a hint of a container without breaking the "No-Line" rule.

---

## 5. Components

### Buttons
* **Primary:** High-gloss. Gradient of `primary` to `primary-container`. `rounded-xl` (1.5rem) corners.
* **Secondary:** Ghost style. No background, `primary` text, and a `Ghost Border` that only appears on hover.
* **Tertiary:** `secondary-fixed-dim` background with `on-secondary-fixed` text. Low contrast for utility actions.

### Cards & Data Modules
* **Strict Rule:** No dividers. Use `spacing-6` (2rem) of vertical white space to separate content chunks.
* **Corners:** All cards must use `rounded-xl` (1.5rem) to maintain the "soft pastel" aesthetic.

### Input Fields
* **Style:** Minimalist underline or soft-tinted box (`surface-container-high`).
* **Focus State:** Transition to `primary` (#a10050) with a 2px "Glow" (a soft shadow in the primary color at 10% opacity).

### Specialized Agent Components
* **Trend Indicator:** Small sparklines using `secondary` for growth and `error` for decline, rendered with a 2px stroke width—no fill.
* **Status Orbs:** Pulsing `surface-tint` (#ba005e) for "Live" status, using a 4px blur to simulate a soft glow.

---

## 6. Do’s and Don’ts

### Do
* **Do** use asymmetrical layouts where one column is significantly wider (e.g., 65/35 split) to create visual interest.
* **Do** use `surface-bright` for the most critical interactive elements to guide the agent's eye.
* **Do** prioritize typography size over font-weight to show hierarchy.

### Don’t
* **Don't** use pure black (#000000) for text. Always use `on-surface` (#151b2c) to keep the contrast premium and soft.
* **Don't** use "Card-in-Card" layouts with borders. Use a background color shift instead.
* **Don't** use standard `0.5rem` spacing for major sections. Force yourself to use `spacing-8` (2.75rem) or `spacing-10` (3.5rem) to ensure the design feels "expensive."

---

## 7. Spacing & Logic

| Token | Value | Use Case |
| :--- | :--- | :--- |
| **spacing-1** | 0.35rem | Internal button padding (sides) |
| **spacing-3** | 1rem | Internal card padding |
| **spacing-6** | 2rem | Between related cards |
| **spacing-10** | 3.5rem | Between major page sections |
| **rounded-lg**| 1rem | Input fields and small chips |
| **rounded-xl**| 1.5rem| Main dashboard containers and primary buttons |