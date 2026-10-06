# Proposal: load brand assets from the API

**Date:** 2026-10-05
**Status:** proposal, awaiting decisions (see the last section)
**Scope:** `polaris_max` monorepo, all four brand apps (onlyhandmade, cuddluxe, rubys, tervinox)

## Summary

Brand images (logos, placeholders, splash and section backgrounds) are bundled in each app today, so changing one needs a store release. This proposes serving them from the API instead, with the bundled copies kept only as an offline fallback.

Three things need a decision from you:

1. Whether to go ahead at all, given that an asset audit shows most of the size win is available from cleanup alone.
2. Whether the backend team can add an `app_assets` block to the initial-data response and guarantee unique filenames on upload.
3. Whether fonts and the add-to-cart sound are in scope (recommendation: no).

## What the audit found

A static audit of every bundled asset against the Dart code, flavor configs, pubspecs and launcher/splash tool configs. Native `android/res` and iOS `xcassets` were not audited.

### Runtime assets actually in use

| Asset | Per app | Loaded through |
|---|---|---|
| Coloured logo, white logo | yes | `coloredLogo`, `whiteLogo` in the flavor config |
| Product placeholder, article placeholder | yes | `noImageProduct`, `noImageArticle` in the flavor config |
| Splash background (1x, 2x, 3x) | all except rubys | `splashBg` in the flavor config |
| App bar background | onlyhandmade only | `ImageConstants.appBarBg` |
| Promotional messages background | rubys only | `ImageConstants.promotionalMessageBackground` |
| `add_to_cart.mp3` | yes | `SoundManager.play` |
| Cart bin Lottie animation | shared | `cart_delete_bin.dart` |
| Cairo, Kaisei Opti, PolarisMaxIcons fonts | shared | theme builder |

That is roughly eight runtime images per app. The call-site surface is small: about 30 references in total.

### Unused assets

Already removed from `packages/component_library` (uncommitted on `feature/cart-swipe-peek-hint`, analyzer clean, package tests pass, apps not yet built):

- all 51 SVGs in `assets/svgs/`, none of which were loaded anywhere
- `inter.ttf` (854 KB), declared but never used
- `animations/` and `sounds/`, both duplicates or dead
- the 22 `ImageConstants` entries and `LottieConstants` that pointed at them

Still in the repo and unused:

| File | Size |
|---|---|
| `apps/onlyhandmade/.../app_bar_pattern.svg` | 3.3 MB |
| `apps/rubys/.../categories_background.png` | 203 KB |
| `apps/rubys/.../section_background.png` | 204 KB |
| `apps/rubys/.../product_background.png` | 9 KB |
| `apps/tervinox/.../map.png` | 62 KB |
| `apps/onlyhandmade/.../icon_launcher.png` | 14 KB |

Two further size items:

- **Kaisei Opti (12.6 MB)** is used only by `theme1`, which only onlyhandmade runs. The other three apps bundle it for nothing because it lives in the shared `component_library`.
- **Launcher icon sources (about 330 KB across the apps)** are needed only by `flutter_launcher_icons` at build time, but ship in the app because each app's pubspec declares the whole brand folder.

### Broken references found along the way

- Cuddluxe's config points `noImageArticle` at `assets/cuddluxe/article_placeholder.png`, which does not exist. The article placeholder fails to load in that app.
- Cuddluxe's launcher icon config references a missing `icon_launcher.png`.
- Rubys' launcher icon configs point at `../../assets/rubys/`, which does not exist; the files are in `apps/rubys/assets/rubys/`.
- `ImageConstants` has five `*Level` constants pointing at a missing `assets/levels/` folder (the constants are unused).
- `ImageConstants.appBarBg` and `promotionalMessageBackground` hardcode the onlyhandmade and rubys folders inside shared code. Whether those widgets are gated to those brands was not checked.

## What "from the API" buys us

- **Rebranding without a release.** A logo, placeholder or splash change in the dashboard reaches users on their next launch.
- **Some app size**, but less than it first appears. After cleanup, the brand images that could move are between about 0.2 MB (rubys) and 5 MB (cuddluxe, tervinox), nearly all of it the 2x and 3x splash backgrounds.

If the goal is only app size, cleanup plus moving Kaisei Opti out of the three apps that do not use it gets most of the win with no backend work.

## What cannot move

- Launcher icons and the native splash: the OS needs them before Flutter starts.
- The flavor config JSON: it holds `apiUrl` and `accountId`, which are needed to call the API.
- One fallback logo, placeholder and splash background per app, for a first launch with no network.

## Proposed design

### Backend contract

Add an `app_assets` block to the existing initial-data response. Each entry is a logical key and a full URL:

```json
"app_assets": {
  "colored_logo": "https://.../uploads/28/branding/logo_8f3a1c.png",
  "white_logo": "https://.../uploads/28/branding/logo_white_2b7e90.png",
  "product_placeholder": "https://.../uploads/28/branding/product_ph_51d0aa.png",
  "article_placeholder": "https://.../uploads/28/branding/article_ph_c94e12.png",
  "splash_bg": "https://.../uploads/28/branding/splash_7a61f3.png",
  "app_bar_bg": null,
  "promotional_bg": null
}
```

A missing or null key means "use the bundled fallback". Files are uploaded per account in the dashboard.

### How the app knows an image changed

**The URL is the version.** The backend gives every upload a unique filename (content hash or upload timestamp) and never overwrites a file in place.

- The app caches each image on disk keyed by URL, which `cached_network_image` already does.
- Same URL as last time: use the cached file, no network request.
- Different URL: the image changed, so download the new file.

There is no separate change check. The app already re-fetches initial data on every launch and on app resume (`initialDataProvider`), so it sees a new URL within one resume of the dashboard change.

If the backend cannot guarantee unique filenames, the fallbacks are:

| Option | How it works | Drawback |
|---|---|---|
| Version field per asset (`updated_at` or a hash beside the URL) | App stores the last-seen version and re-downloads when it differs | App owns cache invalidation |
| HTTP `ETag` / `If-None-Match` | Server answers `304 Not Modified` when unchanged | One request per image per launch; needs correct server headers |

### App changes, by layer

| Layer | Change |
|---|---|
| `polaris_api` | Response model for `app_assets` |
| `domain_models` | Plain `AppAssets` entity |
| `key_value_storage` | Persist the last `AppAssets` so a cold start knows the URLs before the API answers |
| `initial_repo` | Map and expose it cache-first: stored value, then the fresh one |
| `component_library` | One resolver that takes a logical key and returns the remote image if a URL is known, otherwise the bundled fallback. `ColoredLogo`, `WhiteLogo`, the placeholders, the splash views and the two brand backgrounds switch to it |
| App startup | Pre-download changed images in the background after initial data loads |

### Behaviour users will see

- **First install, offline:** bundled fallbacks.
- **Normal launch:** cached remote images, shown immediately.
- **After a dashboard change:** the old image for the rest of that session at most. The splash updates on the following launch, because it is drawn before the new data arrives.

## Suggested order of work

1. Finish the cleanup: delete the remaining unused files, fix the broken references above, and move Kaisei Opti so only onlyhandmade bundles it. Independent of the API work.
2. Backend adds `app_assets` and unique filenames.
3. App reads `app_assets`, with the resolver and bundled fallbacks. Logos and placeholders first.
4. Splash background and the two brand backgrounds.
5. Once proven in production, remove the brand images that now come from the API, keeping the fallbacks.

## Risks

- **Splash on first launch** always shows the bundled image, so a rebrand is not fully release-free for new installs until the bundled fallback is also updated.
- **A bad upload** (wrong size, broken file) reaches all users of that brand without a release. The dashboard should validate dimensions and format.
- **Remote fonts** would cause a visible font swap on first load, which is why they are left out.

## Decisions needed

1. **Goal:** release-free rebranding, app size, or both? If only size, stop after step 1.
2. **Backend:** can the team add `app_assets` to initial data and guarantee unique filenames on upload? If not, which fallback above do they prefer?
3. **Fonts and sound:** leave bundled (recommended), or include them?
4. **Cleanup:** approve deleting the remaining unused files and moving Kaisei Opti to onlyhandmade only?
