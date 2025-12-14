🍔 McD Bot Queue System (Flutter)

🌍 Live Demo

You can view a running demo here:
👉 https://feedme.emirfikri.com

A Flutter-based prototype that simulates McDonald’s automated cooking bot order system.
The app demonstrates priority queuing (VIP vs Normal), concurrent bot processing, and real-time state updates using BLoC and Clean Architecture principles.

🚀 Features

Normal & VIP order queue

VIP priority handling (FIFO within VIP)

Dynamic bot management (+ / – bots)

Concurrent order processing (10s per order)

Pending / In-Progress / Completed flows

Bot status tracking (Idle / Busy)

Auto countdown timers

Fully in-memory (no persistence)

Unit & widget tests included

🏗 Architecture Overview

This project follows Clean Architecture with clear separation of concerns.

```
lib/
 ├─ domain/
 │   ├─ entities/
 │   │   ├─ order.dart
 │   │   └─ in_progress.dart
 │   └─ repositories/
 │       └─ order_repository.dart
 │
 ├─ data/
 │   ├─ models/
 │   │   └─ order_model.dart
 │   └─ repositories/
 │       └─ order_repository_impl.dart
 │
 ├─ presentation/
 │   ├─ bloc/
 │   │   ├─ order_bloc.dart
 │   │   ├─ order_event.dart
 │   │   └─ order_state.dart
 │   ├─ pages/
 │   │   └─ home_page.dart
 │   └─ widgets/
 │       ├─ pending_list.dart
 │       ├─ in_progress_list.dart
 │       ├─ complete_list.dart
 │       └─ bots_list.dart
 │
 └─ main.dart
```


🧠 Key Design Decisions

BLoC handles all business logic (orders, bots, timers)

Domain layer contains pure business entities

Data layer prepares models (extensible for Firestore/API)

Presentation layer contains UI + state binding only

Timers are fully controlled inside BLoC (testable)

📱 Running the App
Android / iOS (Device or Emulator)
flutter pub get
flutter run

🌐 Web
flutter run -d chrome

🧪 Running Tests

This project includes unit tests, widget tests, and bloc tests.

flutter test


Test structure:

```
test/
 ├─ widgets/
 │   ├─ bots_list_test.dart
 │   └─ widget_test.dart
 ├─ repository_test.dart
 └─ bloc_test.dart
```

🔄 Order Flow Logic

New order → Pending

VIP orders jump ahead of Normal orders

Available bot picks order → In Progress

Bot processes order (10 seconds)

Order moves to Completed

Bot becomes idle and picks next order

If a bot is removed mid-process:

The order is returned to Pending

Other bots may continue processing

🧩 Bot Management

Bots are dynamically created/destroyed

Each bot processes only one order at a time

Bot status is visible in the Bots tab

🧠 Tech Stack

Flutter (Material 3)

flutter_bloc

Equatable

Clean Architecture

Widget & Unit Testing

👨‍💻 Author
```
Emir Fikri
Software Engineer
Specialized in BLoC, Clean Architecture, CI/CD, and real-time systems.
```