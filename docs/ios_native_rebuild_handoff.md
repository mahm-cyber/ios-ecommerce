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
| 8 | **Proposed, awaiting my confirmation:** endpoints are generic values that carry their response type, declared per feature area. | I first chose one enum with a case per endpoint. An enum case cannot carry its response type, so a wrong decode type still compiles, and the enum grows into one giant file like Flutter's `PolarisApi`. Static members keep the call site as readable as an enum case. |
| 9 | **Proposed, awaiting my confirmation:** the client receives token, language and device ID as injected "current value" dependencies; it never sees the session. | I first chose the client holding the session. That makes `Networking` import `Data` while `Data` imports `Networking`, a circular package dependency that does not build, and it is Flutter's API ↔ session cycle again. No performance difference. |
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

## 7. Current status

**Phase 0 is complete, committed and pushed. Phase 1 (networking) has started: the design is explained and the decisions are proposed; no Phase 1 code is written yet.**

The Xcode project is at `~/Desktop/ios-ecommerce/IOS-ECommerce/IOS-ECommerce.xcodeproj` (Xcode 26.6). Targets: app `IOS-ECommerce` (module `IOS_Ecommerce`) and unit tests `IOS EcommerceTests` (Swift Testing, hosted by the app). Remote: `https://github.com/mahm-cyber/ios-ecommerce` on `main`. This handoff file now lives in that repo at `docs/ios_native_rebuild_handoff.md`; the copy in the Flutter repo is older.

What exists and is verified (tests pass on an iOS 26.3.1 simulator with the Dev scheme; Prod builds):

- Configurations `Debug-Dev`, `Release-Dev`, `Debug-Prod`, `Release-Prod`; shared schemes `IOS-ECommerce-Dev` / `IOS-ECommerce-Prod`, both with the test target in their Test action.
- `Configuration/Base.xcconfig`, `Dev.xcconfig`, `Prod.xcconfig`, git-ignored `Secrets.xcconfig`; six settings reach the app through `Configuration/Info.plist`: `APP_ENVIRONMENT`, `API_BASE_URL`, `API_VERSION`, `API_ACCOUNT_ID`, `BRAND_SLUG`, `API_SECRET_KEY`.
- Deployment target is iOS 17.0, set once at the project level; neither target overrides it.
- `Configuration/AppConfiguration.swift`, `IOS-ECommerce/Composition/AppContainer.swift`, `IOS_ECommerceApp`, `ContentView` (initializer injection, decision 7).
- `IOS EcommerceTests/AppConfigurationTests.swift`: 11 test functions, 18 cases, all passing.

Who wrote what, so the next mentor knows what I have and have not practised:

- I wrote, with review: the Xcode configuration, xcconfigs, Info.plist, `AppContainer`, the `App` entry point, `ContentView`, and a first single-assert test.
- Given to me on request: the final `AppConfiguration`, the full test file, the `nonisolated` annotations and the deployment-target cleanup.
- So I have **not yet written on my own**: failure-path tests with `#expect(throws:)`, parameterized tests, or a throwing initializer with a validation helper. Phase 1 tests are mine to write unaided.

Phase 1 layout (packages are created in this phase):

```
Packages/
├── Core/                 errors shared by every layer; imports nothing
└── Networking/           depends on Core only
    ├── Sources/Networking/{Request, Response, Client}
    └── Tests/NetworkingTests/
```

Local packages default to no actor isolation, so the `nonisolated` annotations needed in the app target (`SWIFT_DEFAULT_ACTOR_ISOLATION = MainActor`) are not needed there.

Phase 1 flow: build `URLRequest` → send → map transport failure → check HTTP status (401 or 302-to-login = session expired, 422 = validation, 409 = conflict) → decode envelope → check body `errors` / `status` → decode `data`. The client only reports "session expired" as an error; who reacts is Phase 2.

Declined or deferred (do not re-raise unless it causes a problem): wrapping the sample in `#if DEBUG`; renaming `API_BASE_URL` (it holds `/host`, the plist adds `https:/`); moving `AppConfiguration.swift` out of the non-target `Configuration` folder. `@Environment` is deferred to the theme in Phase 3.

Still needed before Phase 1 can make a real request: the real Cuddluxe secret key in `Secrets.xcconfig` (currently a placeholder).

My next actions:

1. Confirm or challenge decisions 8 and 9.
2. Create the `Core` and `Networking` local packages under `Packages/`, add them to the project, link `Networking` to the app, make `Networking` depend on `Core`. Prove it with one `public` placeholder type used from the app; build both schemes; run the package tests.
3. Unit 1.1, request building (pure logic, no network yet): HTTP method type; the endpoint value (path, method, query items, optional body, response type); a small networking configuration value (base URL, API version, account ID, secret key; `Networking` must not import `AppConfiguration`); the request builder using `URLComponents`; one real endpoint, `Questions` (GET).
4. Tests for 1.1, written by me: URL shape with and without a trailing slash on the base URL; language change changes the path; GET carries `accountId` as a query item and keeps the endpoint's own items; fixed headers always present; `Authorization` present with a token and absent without; `device_token` present with a device ID and absent without; 30-second timeout; parameterized over `en`, `ar`, `de`.
5. Send for review: both `Package.swift` files, the endpoint and builder files, the test file and its results.

---

## 8. Progress log

Add one line per session: date, what I built, what was reviewed, what was decided.

- 2026-10-06 — Analysed the Flutter system. Made decisions 1 to 4. Agreed target architecture and phase plan. Phase 0 tasks defined; no code written yet.
- 2026-10-06 — Created the Xcode project at `~/Desktop/ecommerce` with four configurations and two schemes. Added two xcconfigs. Hit an empty `PRODUCT_NAME` build error and a bundle ID vs display name mix-up; both still to fix.
- 2026-10-06 — Restarted in `~/Desktop/ios-ecommerce`. Tasks 1 to 5 built successfully and were reviewed. Remaining: deployment target, duplicate `PRODUCT_NAME`, xcconfigs leaking into the bundle, `.gitignore`.
- 2026-10-06 — Applied review fixes (deployment target 17, single `PRODUCT_NAME`, xcconfigs out of the bundle, `.gitignore`) and pushed to GitHub. Tasks 1 to 5 closed.
- 2026-10-06 — Chose option A for configuration (decision 5). Learned that `//` truncates URLs in xcconfigs and that custom Info.plist keys need a real Info.plist file. Task 6 defined.
- 2026-10-06 — Audited every Flutter config field for real use. Only `apiUrl`, `apiVersion`, `accountId`, `secretKey` and an environment value are launch configuration; the rest is dead, constant, already in the bundle, or belongs to the design system.
- 2026-10-06 — Agreed the six config variables. First pass at task 6a reviewed: Prod marked as Dev, URL escaped with backslashes, shared values duplicated, secret placeholder committed.
- 2026-10-06 — Second review of 6a/6b. Environment, duplication and secrets file fixed. Remaining: URL truncated by `//`, typo in the optional include, Info.plist not wired via `INFOPLIST_FILE` and missing five keys.
- 2026-10-06 — Third review. Decided failure strategy (decision 6: type throws, app entry point stops). Build broken by `INFOPLIST_FILE` pointing at a folder; URL still truncated; `AppConfiguration` not yet written.
- 2026-10-06 — 6a/6b working end to end in both schemes. First `AppConfiguration` reviewed: works on the happy path; needs throwing init from a dictionary, no silent environment fallback, empty-string and URL validation.
- 2026-10-06 — Second `AppConfiguration` review: structure now right (throws, dictionary in, raw-value enum, helper). Remaining: empty-string check, key name in errors, scheme/host check, error enum shape, naming, bundle entry; build broken by a stale call in `ContentView`.
- 2026-10-06 — Asked for and received the reference solution for `AppConfiguration` after two review rounds. To apply and commit.
- 2026-10-06 — Task 6 complete and verified in both schemes. Task 7 defined; dependency-access question (A/B/C) open.
- 2026-10-06 — Committed task 6. Chose option C for dependency access (decision 7). First pass at task 7 reviewed: error is printed instead of stopping the app; container empty and not stored.
- 2026-10-06 — Task 7 second review: container type done; entry point still prints instead of stopping and does not store the container.
- 2026-10-06 — Task 7 third review: entry point and container correct. Remaining: broken preview sample, display the values, single catch. Discussed `@Environment`: deferred to the theme in Phase 3.
- 2026-10-06 — Task 7.4 verified: launching with an empty secret stops the app and names `API_SECRET_KEY`. Remaining: show values on screen, tidy the sample and catches, commit.
- 2026-10-06 — Task 7 committed and pushed: container, entry point, launch failure and initializer injection all working. Two small `ContentView`/`catch` fixes left. Task 8 (tests) defined.
- 2026-10-06 — Added the unit test target and a first passing test. Diagnosed two issues: test target deployment target 26.5 vs 26.3.1 simulators, and default main-actor isolation forcing `await` on value types.
- 2026-10-06 — At my request the mentor made the remaining Phase 0 changes: unified deployment target (17.0 at project level), `nonisolated` on the config types, and the full `AppConfiguration` test suite (18 cases passing). Phase 0 complete pending commit.
- 2026-10-06 — Phase 0 committed and pushed. Handoff file copied into the iOS repo (`docs/`). Phase 1 started: re-read the Flutter API layer and added three contract details (URL shape, `accountId` as a GET query item, body `status` 401/422). Answered the three design questions (enum, client holds session, transport protocol); mentor agreed on the third and proposed decisions 8 and 9 instead of my first two. Unit 1.1 tasks and test scenarios defined; no code yet.
