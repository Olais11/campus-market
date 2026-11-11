# Campus Market: Team Guide

Read this fully before writing any code. It tells you exactly what to build, which files are yours, and how to avoid breaking the app. The app is a campus marketplace plus Lost & Found, built with Flutter and Firebase.

Repo: https://github.com/Olais11/campus-market
Firebase project: campus-market-ALCHE (you are added as an Editor)

---

## 1. The golden rules

1. **Never push to `main`.** Work on your own branch and open a pull request.
2. **Only edit files inside your own folders** (section 4). If you need a change elsewhere, ask the owner.
3. **Never edit** `lib/main.dart`, `lib/app_routes.dart`, `lib/routes.dart`, `pubspec.yaml`, `lib/firebase_options.dart`, `firestore.rules` or the `android/`, `web/`, `windows/` folders. Member 1 owns these.
4. **Never run `flutter create` again** and never run `flutter pub upgrade`. Never use `git push --force`.
5. **Need a new package?** Message Member 1. Do not add it yourself, because two people editing `pubspec.yaml` causes conflicts.
6. **Use the shared names.** Collection names, categories and statuses come from `lib/models/constants.dart`. Never type `'listings'` or `'lost'` by hand.
7. **Pull `main` into your branch every day** (section 3).
8. **Test before you open a PR.** `flutter run -d chrome` must start and your feature must work.

---

## 2. One-time setup

1. Accept the GitHub invitation (check your email) and the Firebase invitation.
2. Turn on Windows Developer Mode: run `start ms-settings:developers` and switch it On.
3. Clone and run:
```
git clone https://github.com/Olais11/campus-market.git
cd campus-market
flutter pub get
flutter run -d chrome
```
4. Register with your `@alustudent.com` email, log in and check you see the 4 tabs: Home, Lost & Found, Activity, Profile.
5. Tell Git who you are (once):
```
git config --global user.name "Your Name"
git config --global user.email "your-email@example.com"
```
6. Create your branch (use YOUR name from the table):
```
git checkout -b feature/home-marketplace
```
Branch names: Member 2 `feature/home-marketplace`, Member 3 `feature/lost-found-history`, Member 4 `feature/profile-navigation`, Member 1 `feature/accounts`.

---

## 3. Daily Git workflow (do this every time)

**Start of the day: get the latest main**
```
git checkout main
git pull
git checkout feature/your-branch
git merge main
```
If Git says there are conflicts, stop and ask Member 1. Do not delete other people's code to "make it work".

**Save your work often**
```
git add .
git commit -m "Short message about what you did"
git push -u origin feature/your-branch
```
(`-u origin ...` is only needed the first time. After that just `git push`.)

**Open a pull request**
1. On GitHub open the repo. A yellow banner "Compare & pull request" appears. Click it.
2. Fill in the template and attach screenshots.
3. Member 1 reviews and merges. Do not merge your own PR.

Before every commit run `git status` and check that the files listed are only inside your own folders.

---

## 4. Who owns what

| Member | Role | Folders and files you may edit |
|---|---|---|
| 1 Olais | Setup and accounts | `lib/screens/auth/`, `lib/services/auth_service.dart`, `lib/utils/`, `lib/main.dart`, `lib/routes.dart`, `lib/app_routes.dart`, `pubspec.yaml`, `firestore.rules` |
| 2 Chisom | Home and marketplace | `lib/screens/home/`, `lib/services/listing_service.dart` (create), `lib/models/listing.dart` |
| 3 Kevin | Lost & Found and activity | `lib/screens/lost_found/`, `lib/screens/history/`, `lib/services/lost_found_service.dart` (create), `lib/services/activity_service.dart`, `lib/models/lost_found_report.dart`, `lib/models/activity_entry.dart` |
| 4 Immaculata | Profile and navigation | `lib/screens/profile/`, `lib/screens/shared/`, `lib/widgets/`, `lib/services/profile_service.dart` (create) |

New files you create inside your own folders are fine. Add your screens to your own routes file: `home_routes.dart` (2), `lost_found_routes.dart` (3), `profile_routes.dart` (4). Never edit `app_routes.dart`.

---

## 5. Shared contracts (everyone follows these exactly)

### Routes
All route names are in `lib/routes.dart`. Detail and edit screens receive the document id as `arguments`:
```dart
Navigator.pushNamed(context, Routes.listingDetail, arguments: listing.id);
```
Read it in your route builder:
```dart
Routes.listingDetail: (context) => ListingDetailScreen(
    listingId: ModalRoute.of(context)!.settings.arguments as String),
```

### The 4 tabs (Member 4 owns the shell)
| Tab | Widget (do not rename) | Owner |
|---|---|---|
| Home | `HomeScreen` in `lib/screens/home/home_screen.dart` | 2 |
| Lost & Found | `LostFoundScreen` in `lib/screens/lost_found/lost_found_screen.dart` | 3 |
| Activity | `HistoryScreen` in `lib/screens/history/history_screen.dart` | 3 |
| Profile | `ProfileScreen` in `lib/screens/profile/profile_screen.dart` | 4 |

Keep the class names and a `const` constructor. Each file starts as a stub: replace its contents, do not delete the file.

### Firestore data (do not change field names)

**users/{uid}** (Member 1 creates it at sign-up, Member 4 edits it): `uid`, `name`, `email`, `phone`, `photoUrl`, `createdAt`

**listings/{id}** (Member 2): `sellerId`, `sellerName`, `title`, `description`, `category`, `condition`, `status` (`available` or `sold`), `price` (number), `createdAt`

**lostFound/{id}** (Member 3): `reporterId`, `reporterName`, `type` (`lost` or `found`), `title`, `description`, `category`, `location`, `contactNote`, `status` (`open`, `claimed` or `returned`), `claimedBy`, `createdAt`

**activity/{id}** (written through `ActivityService.log`): `userId`, `type`, `refId`, `title`, `createdAt`

Use the model classes in `lib/models/` (`Listing`, `LostFoundReport`, `ActivityEntry`). Use `Model.fromMap(doc.id, doc.data())` to read, `model.toMap()` to create. When **editing**, use `update({...})` with only the changed fields.

### Who is signed in
```dart
final user = AuthService.instance.currentUser; // user?.uid, user?.displayName, user?.email
```
Always check for `null`.

### History
Whenever a user does something that should appear in Activity, call:
```dart
await ActivityService.instance.log(
  type: ActivityTypes.listingPosted, refId: newId, title: 'Calculus textbook');
```
Member 2 logs `listingPosted` and `listingSold`. Member 3 logs `reportPosted` and `reportResolved`.

### Shared widgets
Use `LoadingView`, `EmptyView(message: ...)` and `ErrorView(message: ..., onRetry: ...)` from `lib/widgets/state_views.dart` in every screen that loads data.

### No Firestore index errors
If you filter with `where(...)`, do **not** also use `orderBy(...)` on a different field. Fetch with `where` and sort the list in Dart (see `ActivityService.myActivity()` for the pattern). If you do see "requires an index", click the link in the error, press Create index and wait 2 minutes.

### Images
Firebase Storage needs a paid plan, so **do not upload photos**. Show an icon for the category instead.

---

## 6. Look and feel (so the Figma and the app match)

- Material 3, seed color `#1B7F5C` (green), font Roboto (the Flutter default).
- Page padding 24, space between fields 16, buttons full width (`FilledButton`), text fields with `OutlineInputBorder`.
- Figma frames: **360 x 800** (Android). Name every frame `M2 - Listings`, `M3 - Report item`, etc. Use the same green and corner radius as the app.
- Every list screen needs 4 states: **loading, empty, error, success**.
- Show friendly messages. Never show raw error text like `FirebaseException ...`.

---

## 7. Exactly what each member builds

### Member 1: Setup and accounts (Olais) - DONE in repo
Welcome, register, login, reset password, validation, session handling and logout are already built. Remaining: review and merge PRs, publish `firestore.rules`, run the final tests, make the four Figma screens, keep `main` working.

### Member 2: Home and marketplace (Chisom)
Create in `lib/screens/home/` and `lib/services/listing_service.dart`:
1. **`home_screen.dart`** (replace the stub): greeting with the user's name, buttons "Browse listings" and "Sell an item", category chips, and the 5 newest available listings.
2. **`listings_screen.dart`**: all available listings, search box (filter in Dart), category filter, tap opens detail.
3. **`listing_detail_screen.dart`** (takes `listingId`): all fields, seller name, price. The seller sees "Edit" and "Mark as sold". Others see "Contact seller" (show the seller's email from `users/{sellerId}`).
4. **`post_listing_screen.dart`**: form for title, description, price, category, condition with validation. The same screen edits an existing listing when given an id.
5. **`listing_service.dart`**: `Stream<List<Listing>> availableListings()`, `Future<Listing?> getListing(id)`, `createListing(...)`, `updateListing(id, fields)`, `markSold(id)`.
6. Register your routes in `home_routes.dart`.
7. Log activity: `listingPosted` after create, `listingSold` after mark sold.

**Done when:** you can post a listing, see it on Home and in Browse, open it, edit it, mark it sold (it disappears from Browse), and every screen has loading, empty, error and success states. Matching Figma screens are done.

### Member 3: Lost & Found and history (Kevin)
Create in `lib/screens/lost_found/`, `lib/screens/history/` and `lib/services/lost_found_service.dart`:
1. **`lost_found_screen.dart`** (replace the stub): two tabs, "Lost" and "Found", showing only `open` reports, with a "Report item" button.
2. **`report_item_screen.dart`**: form for type (lost or found), title, description, category, location, contact note. The same screen edits an existing report.
3. **`lost_found_detail_screen.dart`** (takes `reportId`): all fields. The reporter sees Edit, Delete and "Mark as returned". Others see "This is mine / I found it", which sets `status: claimed` and `claimedBy: <uid>`.
4. **`lost_found_service.dart`**: `Stream<List<LostFoundReport>> openReports(String type)`, `getReport(id)`, `createReport(...)`, `updateReport(id, fields)`, `deleteReport(id)`, `claimReport(id)`, `markReturned(id)`.
5. **`history_screen.dart`** (replace the stub): list from `ActivityService.instance.myActivity()` with an icon per type, title, and date. Empty state: "Nothing here yet".
6. Register your routes in `lost_found_routes.dart`.
7. Log activity: `reportPosted` after create, `reportResolved` after mark returned.

**Done when:** create, view, edit and delete all work, claiming works from a second account, History shows the events from both Member 2's and your features, and the empty, error and failed-request cases show friendly messages. Matching Figma screens are done.

### Member 4: Profile, settings and navigation (Immaculata)
Create in `lib/screens/profile/`, `lib/screens/shared/`, `lib/widgets/` and `lib/services/profile_service.dart`:
1. **`profile_screen.dart`** (replace the stub): shows name, email, phone from `users/{uid}`, an "Edit profile" button, a "Settings" button and a working **Log out** button.
2. **`edit_profile_screen.dart`**: edit name and phone with validation, save with `update` to `users/{uid}`, show a success message. Also update `displayName` with `AuthService.instance.currentUser?.updateDisplayName(...)`.
3. **`settings_screen.dart`**: "Send password reset email" (use `AuthService.instance.sendPasswordReset(email)`), "About" (app name and version) and Log out.
4. **`profile_service.dart`**: `Stream<Map<String, dynamic>?> myProfile()` and `updateProfile(...)`.
5. Register your routes in `profile_routes.dart`.
6. Maintain `main_shell.dart` and `lib/widgets/state_views.dart` (you may restyle them, but keep the class names).
7. **Integration:** at the end, merge everyone's branches in order (section 8), check routes and back buttons, and build the combined Figma prototype. You coordinate integration, you do not fix other people's code.

**Done when:** profile shows live data, edits save and appear immediately, navigation between all 4 tabs works, back buttons behave, and the combined Figma prototype has more than 10 clickable screens.

---

## 8. Timeline and integration

| Date | What |
|---|---|
| Nov 11 to 12 | Everyone: setup, branch, start screens, start interviews. Figma screens started. |
| Nov 12 night | First PR from each member (even if unfinished, as long as the app runs). |
| Nov 13 | Features working. Members 2, 3 and 4 send final PRs. Member 1 reviews and merges in this order: **2, then 3, then 4**. |
| Nov 14 | Member 4 integration: run the full app, check every route, finish the combined Figma prototype. Fix bugs only in your own files. |
| Nov 15 | Final review, screenshots, tracker, submit the PDF before 11:30pm. |

**Before the final merge each member must test on a clean copy:** `git clone` into a new folder, `flutter pub get`, `flutter run -d chrome`, then register a new account and use every screen.

---

## 9. Common problems

| Problem | Fix |
|---|---|
| "Building with plugins requires symlink support" | Turn on Developer Mode: `start ms-settings:developers` |
| Red errors after pulling | `flutter pub get`, then stop and rerun the app |
| "Permission denied" from Firestore | Member 1 must publish `firestore.rules`. Make sure you are signed in. |
| "The query requires an index" | Click the link in the error and press Create index (or see section 5) |
| Merge conflict | Stop. Do not delete anything. Message Member 1 with a screenshot. |
| I edited a file that is not mine | Run `git checkout -- path/to/file` to undo it before committing |
| Can't find the `lib` folder | You are in the wrong folder. `cd campus-market` first. |

---

## 10. Contribution tracker evidence

For the tracker, every member saves: a screenshot of their merged pull request, screenshots of each working screen, and the Figma frame names for their screens. Interviews: scripts, consent forms and empathy maps go in the shared Drive folder (3 interviews each).
