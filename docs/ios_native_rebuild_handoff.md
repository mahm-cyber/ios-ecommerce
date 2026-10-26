# Polaris Max — Native iOS Rebuild: AI Handoff

Paste this whole file at the start of a new conversation with any AI assistant (Claude, Gemini, or other). It contains everything needed to continue without the earlier chats.

**To the AI reading this:** read sections 1 and 7 first. Section 1 is how you must behave; section 7 is where we are. At the end of each session, give me an updated version of sections 7 and 8 so I can paste them back into this file.

Last updated: 2026-10-06

---

## 1. Your role and rules

You are my senior iOS architect and mentor. I am an experienced Flutter developer rebuilding my production Flutter app natively in Swift and SwiftUI. The goal is for me to learn Swift, SwiftUI and architectural decision-making by writing the app myself. The goal is not for you to build it.

**You must not write the code for me.**

- No complete implementations, no whole files, no copy-paste-ready Swift.
- Small pseudocode or an interface sketch is fine when needed.
- A small syntax example only if I ask for one.
- Show exact corrected code only when I say: **"Show me the solution."**

**How to teach:**

- Explain what to build, where it lives, and which Swift or iOS concept it needs.
- Always explain why, not just what. Say "use X because...".
- For every technology you recommend, state: why we need it, what problem it solves, the Flutter equivalent, whether it is Apple-native or third-party, and its tradeoffs.
- When several designs are valid, do not pick immediately. Explain the options and tradeoffs, ask which I would choose, evaluate my answer, then recommend.
- Prefer Apple-native: SwiftUI, Observation (`@Observable`), async/await, URLSession, NavigationStack, Swift Testing, XCTest. No third-party library without a strong reason.
- Do not force Clean Architecture. Recommend the simplest structure that scales, and say when a layer is unnecessary.
- Avoid: over-engineering, excess protocols, massive view models, god objects, global singletons, business logic in views.
- Do not reproduce Riverpod or GoRouter in Swift. Teach the native way.

**When I send code for review:** find bugs, architectural problems and Swift best-practice issues; explain why each is a problem; give hints first; do not rewrite my code; ask me to fix it.

**Format for each new feature or unit of work:**

1. What we have in Flutter
2. What the equivalent concept is in iOS
3. Recommended architecture (with a folder tree)
4. Data flow (include state, error and navigation flow where relevant)
5. Concepts I need to learn
6. Implementation tasks (small, numbered, not implemented)
7. My task (exactly what to do next)
8. What to send you for review

Testing is part of every unit: give me scenarios to test, not the tests.

---

## 2. The existing Flutter system

Polaris Max is a white-label e-commerce app. One codebase serves four brands (`cuddluxe`, `onlyhandmade`, `rubys`, `tervinox`), each with a dev and prod flavor. It is a Melos monorepo of about 70 packages. Feature code is roughly 53k lines across 32 features. Languages: English, Arabic (RTL), German.

**Dependency direction:** brand app shell → `polaris_max/lib` (router and wiring) → features → repositories → `polaris_api` → `domain_models`.

| Concern | How Flutter does it |
|---|---|
| Presentation | 32 feature packages. Widgets plus Riverpod code-generated notifiers with an immutable state class. Some are large: `CartNotifier` is 733 lines and `CartState` has about 25 fields. |
| Domain | `domain_models`: about 70 hand-written immutable classes using `Equatable` and `copyWith`. No JSON logic. |
| Data | 17 repository packages. They map API response models (suffix `RM`) to domain models and hold in-memory state with broadcast streams (for example, one cart stream feeds every cart badge). |
| API | One `PolarisApi` class of 2,031 lines wrapping Dio, plus a `UrlBuilder`. |
| DI | Riverpod providers. |
| Navigation | GoRouter in a single 1,587-line file. Features never navigate; they receive callbacks wired in the router. Five-tab shell: Home, Categories, Reels, Cart, Menu. Auth redirect, deep links, and notification-tap routing with a separate cold-start path through the splash screen. |
| Local storage | Hive, used only for small preferences: language, first-run flag, device serial, in-flight checkout, cart hints. |
| Auth | Bearer token and customer JSON in the Keychain. Keychain is wiped on first launch because it survives an uninstall. |
| Config | Xcode schemes and xcconfigs exist per flavor but set only display name and asset prefix. Real config (API URL, API version, account ID, theme, flags) is a bundled JSON chosen by a separate `--dart-define`. Colours and design theme then arrive at runtime from the `/initial` endpoint. |
| Monitoring | Firebase Analytics, Crashlytics, Remote Config and Microsoft Clarity, each behind a service interface. |
| Notifications | Firebase Cloud Messaging plus local notifications. |
| Design system | `component_library` with four design themes. Cuddluxe uses `theme4`. Spacing and font-size constants, a price component that owns currency rendering, and stable test IDs on every tappable. |
| Tests | 68 test files, mostly in the API and monitoring packages. |

**Feature list, largest first:** home, place_order, product_details, cart, maintenance_request, address, auth, reels, categories, order_details, points, form_settings, menu, articles, edit_profile, branch_selection, rate_order, maintenance_tracking, online_payment, product_reviews, orders, notifications, maintenance_orders, forgot_password, splash, change_contact, change_password, support, favorites, order_success, language, faq.

**Third-party SDKs that have no Apple-native replacement:** Firebase, Google Maps, Tabby, Tamara, Microsoft Clarity.

### Backend contract (must be preserved exactly)

- Base URL plus an API version segment, and a language segment that changes with the app language.
- Headers on every request: `Accept: application/json`, `X-Requested-With: XMLHttpRequest`, `Secretkey`, `User-Agent`, `device_token` (a persisted device UUID, not the push token), and `Authorization: Bearer <token>` when signed in.
- Responses are wrapped in an envelope with `data`, `message` and `errors`.
- **The backend can return HTTP 200 with an `errors` field in the body.** This must be treated as a failure.
- HTTP 401, or a 302 redirect to the login page, means the session expired: clear the token and customer, reset the session.
- HTTP 422 is a validation error carrying a server-localized message. HTTP 409 on the cart means a payment conflict.
- Timeouts are 30 seconds. Reads retry up to 3 times with increasing backoff (`400ms × attempt`, done in repositories, not in the client). **Mutations and payments never retry.**
- URL shape: `{apiUrl}/{language}/api/{apiVersion}/{endpoint}`, for example `…/ar/api/v006/Questions`. The language is read per request because it can change while the app runs.
- `accountId` is not a header: on a GET it is sent as a query parameter.
- Besides a non-null `errors` field, an HTTP 200 body can carry `status: 401` or `status: 422`. Both must be treated as the matching failure.

### Findings that shape the iOS design

1. **There is no real offline cache.** Project docs describe cache-first repositories, but the code only persists preferences. So SwiftData is probably unnecessary; decide in the persistence phase.
2. **The API layer and the user/session layer depend on each other**, with workarounds for the resulting cycle (session expiry needs the session; the session needs storage; the API needs the token). Solve this properly on iOS; do not port it.
3. **Secrets ship inside the app bundle**: Google Maps keys in `AppDelegate.swift` and a `secretKey` in the config JSON. xcconfig would not hide them either.
4. **Errors need a UI context to produce their message** (`getMessage(BuildContext)`). On iOS, errors should be plain typed values; localization happens at the presentation edge.

### Flutter config field audit (checked against all 8 flavor JSONs and every read in the code)

| Field | Varies by | Read where | Verdict for iOS |
|---|---|---|---|
| `apiUrl` | environment | API client | Launch config |
| `apiVersion` | brand (not environment) | API client | Launch config |
| `accountId` | brand | API header supplier, image URLs | Launch config |
| `secretKey` | brand | API header; Cuddluxe's JSON value is a `TODO` placeholder, the real one comes from a build-time `SECRET_KEY` define | Launch config, injected at build time, not committed |
| `flavor` | both | Picks Firebase options; `contains('prod')` check in monitoring | Replace with a typed environment value |
| `slug` | brand | Analytics, plus about eight `if brand == ...` checks inside features | Keep for analytics only; do not port the brand checks |
| `fcmTopic` | environment | Push registration | Add in phase 10 |
| `countryName`, `tabbyCurrency` | nothing (same everywhere) | Tamara and Tabby badges | Constants; revisit in phase 8 |
| `appName`, `version` | brand | App title, menu version label | Already in the bundle (display name, marketing version) |
| `mainColor`, `splashBg`, `designTheme` | brand | Splash only, before `/initial` has loaded | Design system / asset catalog. The real theme comes from `/initial` |
| `coloredLogo`, `whiteLogo`, `noImageProduct`, `noImageArticle` | brand | Image widgets | Asset catalog names, not config |
| `featureFlag`, `countryCode`, `tamaraIsSandbox` | — | Never read | Drop |
| `categoryCardOptions` | nothing (identical in all 8) | Only `bgColor` matters to theme4; the six size fields are never read | Drop; one theme token |
| `maintenanceApiUrl`, `categoryId` | — | Absent for Cuddluxe | Not needed |

### Do not copy into Swift

- A package per feature and per repository.
- The single giant API class and the single giant router file.
- Riverpod mechanics (`ref.watch`, `invalidate`, mounted guards, microtask deferrals).
- The two-flag flavor selection that can silently run one brand with another's config.

---

## 3. Decisions made

| # | Decision | Reasoning |
|---|---|---|
| 1 | Build for **Cuddluxe only** (theme4) now; other brands later. | Smaller scope while learning. Condition: nothing outside the app target and its config may know the brand. Screens read colours and tokens from an injected theme, never literals. |
| 2 | **A few local Swift packages**, with one `Features` package containing one target per feature. | Compiler-enforced boundaries without maintaining 32 packages. |
| 3 | **Minimum iOS 17.** | Required for the Observation framework. Open risk: the Flutter app supports iOS 15, so shipping under the same bundle ID drops iOS 15 and 16 users. To confirm with the product owner before launch. |
| 4 | Four build configurations (Debug and Release, for Dev and Prod), two schemes. No Profile configuration. | Profile is a Flutter concept. |
| 6 | `AppConfiguration`'s initializer **throws** a descriptive error; the app entry point catches it and calls `fatalError`. | I proposed `fatalError`. It is the right outcome but the wrong place: a type that crashes internally cannot be unit-tested for missing keys. Throwing keeps the logic testable and lets one call site decide to stop. |
| 7 | **Dependencies are handed to each screen explicitly** (option C): the container stays in the app layer and passes each screen only what it needs through its initializer. | A screen's dependencies are visible in its declaration, a test passes a fake with no setup, and feature modules never need to see `AppContainer`. A global hides dependencies; the whole container in the environment is a service locator. The SwiftUI environment stays reserved for cross-cutting UI values such as the theme. |
| 5 | Config reaches Swift via **xcconfig → Info.plist → `Bundle` → typed struct** (option A). | One selector (the scheme), so brand and environment cannot disagree; no values in Swift source. Limits: strings only, so no nested data, and values are readable in the shipped bundle, so it is not a place for real secrets. Custom keys need a real Info.plist file, because `INFOPLIST_KEY_` settings only cover keys Apple defines. |
| 8 | Endpoints are **generic values** that carry their response type, declared per feature area. | I first chose one enum with a case per endpoint. An enum case cannot carry its response type, so a wrong decode type still compiles, and the enum grows into one giant file like Flutter's `PolarisApi`. Static members keep the call site as readable as an enum case. |
| 9 | The client **receives token, language and device ID as injected "current value" dependencies**; it never sees the session. | I first chose the client holding the session. That makes `Networking` import `Data` while `Data` imports `Networking`, a circular package dependency that does not build, and it is Flutter's API ↔ session cycle again. No performance difference. |
| 10 | The test seam is a **one-function transport protocol** ("send a `URLRequest`, return data and response"); `URLSession` is the real implementation. | Simplest seam; lets request building, validation and decoding be tested. A fake at the repository level comes in Phase 2. |

Bundle IDs in the Flutter app: dev `com.namaait.cuddluxedev`, prod `io.onemobile.cuddluxe`.

---

## 4. Target architecture

```
PolarisMax (Xcode project)
├── App/                 app target: entry point, composition, navigation, config
└── Packages/
    ├── Core             domain models, errors — imports nothing
    ├── Networking       HTTP client, endpoints, response models
    ├── Data             repositories, Keychain, UserDefaults
    ├── DesignSystem     tokens, components
    └── Features         one target per feature
```

Dependencies point one way: Features → Data → Networking → Core. Only `App` sees everything, so navigation and dependency wiring live there. Features must not import each other. Packages are created in the phase that first needs them, not up front.

---

## 5. Phase plan

| Phase | Scope |
|---|---|
| 0 | Project, configuration, entry point, dependency container |
| 1 | Networking |
| 2 | Session and `/initial` bootstrap, splash |
| 3 | Minimum design system (theme4 tokens, text, price, button) |
| 4 | First vertical slice: FAQ, then Categories |
| 5 | Auth and OTP |
| 6 | Tab shell, navigation, deep links |
| 7 | Home, product listing, product details, favourites |
| 8 | Cart, place order, Tabby and Tamara |
| 9 | Orders, addresses, profile, points |
| 10 | Push, analytics, Crashlytics, Clarity |
| 11 | Production hardening |

---

## 6. Phase 0 plan (current phase)

Target layout inside the app target:

```
App/
├── PolarisMaxApp        @main entry
├── Composition/         dependency container
├── Configuration/       typed configuration + xcconfig files
└── Resources/           Info.plist, assets
```

Intended config flow: scheme → build configuration → xcconfig → build settings → Info.plist substitution → `Bundle` → a typed configuration value read once → container → SwiftUI environment. A missing or malformed value must fail loudly at launch, never fall back to another brand.

Tasks:

1. Create the Xcode project (SwiftUI, iOS 17, Swift Testing).
2. Replace default configurations with Debug-Dev, Release-Dev, Debug-Prod, Release-Prod.
3. Create two shared schemes mapped to those configurations.
4. Create xcconfig files with a shared base and assign them.
5. Give Dev and Prod different bundle IDs and display names.
6. Design the typed configuration and how it gets its values.
7. Create the empty container and inject it at the root.
8. Test the configuration parsing.

Concepts to learn for this phase: target vs build configuration vs scheme; xcconfig syntax and the `https://` truncation gotcha; Info.plist `$(NAME)` substitution; `App`, `Scene`, `WindowGroup`; struct vs class; when failing at launch is correct (`fatalError` vs throwing vs optional).

---

### 7. Current status

**Phase 0, Phase 1, Phase 2, and Phase 3 (Minimum Design System) are complete and verified. Ready for Phase 4 (First vertical slice: FAQ, then Categories).**

Remote: `https://github.com/mahm-cyber/ios-ecommerce` on `main`.

What exists and is verified:
- **Phase 0:** Configurations, schemes, xcconfigs, Info.plist substitution, `AppConfiguration`, `AppContainer`, Swift Testing suite (18 cases passing).
- **Phase 1 (Networking):** `Core` (errors), `Networking` (`HTTPMethod`, `RequestBuilder`, `Endpoint<T>`, `APIResponse<T>`, `ServerErrorPayload`, `HTTPTransport`, `TestTransport`, `NetworkClient` with session supplier closures and status check). All tests passing.
- **Phase 2 (Session & Bootstrap):**
  - Unit 2.1: `AppPreferenceStorage` (UserDefaults) & `SystemKeychainStorage` (Security framework).
  - Unit 2.2: `AppContainer` storage wiring, first-run Keychain wipe, and supplier closures.
  - Unit 2.3: `SessionRepository` and `AppSessionRepository` with Keychain sync and cold-start restore.
  - Unit 2.4: Domain models (`StoreStatus`, `CurrencyConfig`, `ThemeConfig`, `BootstrapData`) and `AppBootstrapRepository`.
  - Unit 2.5: `UserAgent` formatter matching Flutter, `NetworkError: LocalizedError`, and `AppRootView` bootstrap state routing (`SplashView`, `MaintenanceView`, `ContentView`, retry action).
- **Phase 3 (Unit 3.1 - Design System Foundation & Theme Tokens):**
  - Created `Packages/DesignSystem` local Swift package with Swift 6 mode, iOS 17+, dependent on `Core`.
  - Linked `Packages/DesignSystem` to `IOS-ECommerce` target in `IOS-ECommerce.xcodeproj`.
  - Implemented `Color(hex:)` and `Color(hex:fallback:)` in `Color+Hex.swift` supporting 6-digit (`#RRGGBB`), 8-digit (`#RRGGBBAA`), uppercase, lowercase, and malformed handling.
  - Implemented semantic `AppTheme` struct (`primary`, `background`, `surface`, `textPrimary`, `textSecondary`, `border`, `error`, `success`), `AppTheme.default`, and dynamic `init(themeConfig:)` mapping brand primary colors.
  - Implemented `AppThemeEnvironment.swift` with `AppThemeKey: EnvironmentKey`, `EnvironmentValues.appTheme`, and `View.appTheme(_:)` modifier.
  - Wired `AppRootView` to inject the ambient `currentTheme` derived from `BootstrapData.theme` down the view tree.
  - Swift Testing test suites: `ColorHexTests` (7 scenarios) and `AppThemeTests` (4 scenarios) passing cleanly (11 tests in 0.003s). Full app target builds cleanly.

Who wrote what, so the next mentor knows what I have and have not practised:
- Phase 0: I wrote config, schemes, container, app entry, single-assert test. Given on request: final `AppConfiguration`, test cases, nonisolated cleanup.
- Phase 1: I wrote `RequestBuilder`, `Endpoint`, `/initial` DTOs, `APIResponse`, `NetworkClient`, and the test suites (`HTTPMethodTests`, `RequestBuilderTests`, `NetworkClientTests`).
- Phase 2 (Unit 2.1): I wrote `PreferenceStorage`, `AppPreferenceStorage`, `KeychainError`, `SystemKeychainStorage`, and string helpers. Given on request: `TestPreferenceStorage`, `TestKeychainStorage`, and test suites.
- Phase 2 (Unit 2.2): I wrote `AppContainer` storage wiring, first-run wipe, and closure suppliers. Given on request: `AppContainerTests.swift`.
- Phase 2 (Unit 2.3): I wrote `SessionState`, `SessionRepository`, and `AppSessionRepository`. Given on request: `SessionRepositoryTests.swift` and `@unchecked Sendable` conformance.
- Phase 2 (Unit 2.4): I wrote `StoreStatus`, `CurrencyConfig`, `ThemeConfig`, `BootstrapData`, `BootstrapState`, `BootstrapRepository`, and `AppBootstrapRepository`. Given on request: `BootstrapRepositoryTests.swift`, `TestTransport.swift`, and `Networking` DTO public accessors.
- Phase 2 (Unit 2.5): I wrote `SplashView`, `MaintenanceView`, and `AppRootView`. Given on request: `UserAgent.swift`, `UserAgentTests.swift`, `NetworkError: LocalizedError`, and retry integration.
- Phase 3 (Unit 3.1): I set up `Packages/DesignSystem`, linked it in Xcode, drafted `AppTheme.swift` and `AppThemeEnvironment.swift`. Given on request: `ColorHexTests.swift`, `Color+Hex.swift`, `AppTheme` completion, `AppThemeTests.swift`, and `AppRootView` environment wiring.
- Phase 3 (Unit 3.2): I drafted `AppTypography.swift`, added `typography` property to `AppTheme`, and created `AppTypographyTests.swift`. Given on request: `AppTypography.swift` completion and `AppTypographyTests.swift` test suite.
- Phase 3 (Unit 3.3): I implemented `AppButton.swift` (primary, secondary, ghost, loading, disabled) and wrote `AppButtonTests.swift` covering configuration, action execution, and variants. Given on request: `@MainActor` testing isolation guidance and `@MainActor @Sendable` action typing.
- Phase 3 (Unit 3.4): I implemented `CurrencyEnvironment.swift`, `PriceView.swift` with currency formatting, dynamic vector SAR icon support with `Bundle.module`, and strike-through discounts. Given on request: `PriceViewTests.swift` and SPM resource bundle configuration.
- Phase 4 (Unit 4.1): I created `FAQItem` domain model in `Core`, `QuestionsResponseDTO` / `QuestionItemDTO` and `Endpoint.questions` in `Networking`, and `FAQEndpointTests.swift` (2 tests passing).
- Phase 4 (Unit 4.2): I wrote `String+HTML.swift`, `FAQRepository` protocol, and `AppFAQRepository` with DTO to domain mapping in `Data`. Wired `faqRepository` into `AppContainer`. Given on request: `FAQRepositoryTests.swift` (3 tests passing).
- Phase 4 (Unit 4.3): Set up `Packages/Features` package with `FAQFeature` target linked to app target. Implemented `FAQState`, `FAQViewModel` with Swift 6 `@Observable` and `@MainActor`, `FAQItemRow` accordion component with animated chevron and theme tokens, and `FAQView` handling loading, empty, error, and loaded states with pull-to-refresh. Added `FAQViewModelTests` (5 test scenarios). Wired into `AppRootView` and `ContentView`. All 79 package tests passing and app target building cleanly.
- Phase 4 (Unit 4.4 - Data Layer): Defined `CategoryItem` domain model in `Core`, updated `Categories` DTO in `Networking`, added `categories: [CategoryItem]` to `BootstrapData` and implemented recursive DTO-to-domain mapping in `AppBootstrapRepository`. Implemented `CategoriesRepository` protocol and `AppCategoriesRepository` (in-memory cached reader with auto-load). Added `CategoriesRepositoryTests` suite (4 tests passing, 28 total tests in Data passing).

My next actions (Phase 4):
1. Unit 4.4 (Presentation Layer): Wire `categoriesRepository` into `AppContainer`, create `CategoriesFeature` target in `Packages/Features/Package.swift`, implement `CategoriesViewModel` and `CategoriesView`.

---

## 8. Progress log

Add one line per session: date, what I built, what was reviewed, what was decided.

- 2026-10-06 — Analysed the Flutter system. Made decisions 1 to 4. Agreed target architecture and phase plan. Phase 0 tasks defined; no code written yet.
- 2026-10-06 — Phase 0 completed, verified, and committed.
- 2026-10-11 — Accepted decisions 8 and 9.
- 2026-10-12 — Created `Core` and `Networking` packages with Swift 6 and iOS 17.
- 2026-10-14 — Drafted `RequestBuilder`. Received live `/initial` payload. Designed generic `APIResponse<T>` envelope.
- 2026-10-15 — Completed Unit 1.1: `RequestBuilder`, `InitialData` DTOs, and full `RequestBuilderTests` suite passing. Implemented Unit 1.2: `HTTPTransport`, `TestTransport`, and `NetworkClient`. Inverted HTTP 401 guard fixed. Ready for `NetworkClientTests`.
- 2026-10-16 — Phase 1 complete (`NetworkClientTests` passing). Created `Packages/Data` local package, linked to Xcode project.
- 2026-10-17 — Unit 2.1 complete: Implemented `AppPreferenceStorage` (UserDefaults) and `SystemKeychainStorage` (Security framework). Added in-memory fakes and Swift Testing suites (`AppPreferenceStorageTests`, `KeychainStorageTests`). Verified clean build.
- 2026-10-18 — Unit 2.2 complete: Wired `PreferenceStorage` and `KeychainStorage` into `AppContainer` with first-run wipe and live supplier closures. Added `AppContainerTests` suite.
- 2026-10-18 — Unit 2.3 complete: Implemented `SessionState`, `SessionRepository`, and `AppSessionRepository` with Keychain sync and cold-start restore. Added `SessionRepositoryTests` suite (all 4 tests passing).
- 2026-10-19 — Unit 2.4 complete: Implemented `AppBootstrapRepository` with defensive DTO -> Domain mapping logic. Created `BootstrapRepositoryTests` with 6 test scenarios passing (14 total tests in Data passing in 0.014s). Ready for Unit 2.5 (Splash routing).
- 2026-10-20 — Implemented dynamic Flutter-compatible `UserAgent` formatter (`UserAgent.swift` & `UserAgentTests.swift`), integrated into `RequestBuilder` and `AppContainer`. Conformed `NetworkError` to `LocalizedError`. Built Unit 2.5 (`SplashView`, `MaintenanceView`, and `AppRootView` with retry action). All unit tests passing.
- 2026-10-20 — Unit 3.1 complete: Created `Packages/DesignSystem` local package. Implemented `Color(hex:)`, semantic `AppTheme` tokens, and SwiftUI environment injection (`@Environment(\.appTheme)`). Added 11 tests across `ColorHexTests` and `AppThemeTests` (all passing). Wired `AppRootView` with live theme.
- 2026-10-21 — Unit 3.2 complete: Implemented `AppTypography` with Apple-native Dynamic Type scaling and monospaced price digits. Integrated `typography` into `AppTheme`. Added 4 test scenarios in `AppTypographyTests` (15 total tests passing in DesignSystem in 0.003s). App target built cleanly.
- 2026-10-21 — Unit 3.3 complete: Implemented `AppButton` (primary, secondary, ghost, loading, and disabled states). Learned Swift 6 `@MainActor` test isolation and `@MainActor @Sendable` closures. Added 4 test scenarios in `AppButtonTests` (19 total tests passing in DesignSystem in 0.002s). Ready for Unit 3.4 (`PriceView`).
- 2026-10-21 — Unit 3.4 & Phase 3 complete: Configured SPM resources and `Bundle.module` in `DesignSystem`. Built `PriceView`, `CurrencyLabel` with dynamic template SVG symbol and text fallback, and strikethrough discount pricing. Added 4 tests in `PriceViewTests` (23 total tests passing in DesignSystem in 0.005s). Phase 3 Minimum Design System is complete. Ready for Phase 4 (First Vertical Slice: FAQ & Categories).
- 2026-10-22 — Unit 4.1 & Unit 4.2 complete: Built `FAQItem` domain entity in `Core`, `QuestionsResponseDTO` & `Endpoint.questions` in `Networking` (2 tests passing). Implemented `String.strippingHTML()` and `AppFAQRepository` with DTO to domain mapping in `Data`. Wired `faqRepository` into `AppContainer`. Added `FAQRepositoryTests` (3 tests passing). App target built cleanly. Ready for Unit 4.3 (Features & `FAQView`).
- 2026-10-22 — Unit 4.3 complete: Created `Packages/Features` package with `FAQFeature` target linked to app target. Built `FAQState`, `FAQViewModel` with `@Observable` & `@MainActor`, `FAQItemRow` accordion with smooth animation, and `FAQView` with loading, empty, and error retry states. Added `FAQViewModelTests` (5 test scenarios). Wired into `AppRootView` and `ContentView`. All 79 package tests passing and app target building cleanly. Ready for Unit 4.4 (Categories slice).
- 2026-10-26 — Unit 4.4 (Data Layer): Defined `CategoryItem` in `Core`, exposed public properties on `Categories` DTO in `Networking`, added categories to `BootstrapData`, implemented recursive mapping in `AppBootstrapRepository`, built `AppCategoriesRepository` with in-memory caching from bootstrap, and added `CategoriesRepositoryTests` (4 tests passing, 28 total tests in Data passing). Ready for `CategoriesFeature` in `Features` package.

