# 🏗️ LawConnect GH Mobile Architecture

## 1. Flutter Architecture Pattern: Clean Architecture + Riverpod

### Why This Stack?
- **Clean Architecture**: Separation of concerns, testable, maintainable
- **Riverpod**: Modern state management, type-safe, excellent DevTools
- **go_router**: Declarative navigation, deep linking support
- **Dio**: Robust HTTP client with interceptors, caching, error handling
- **Hive**: Fast local storage for offline-first experience

### Architecture Layers:

```
┌─────────────────────────────────────────────────┐
│                   UI Layer                       │
│            Pages · Widgets · Dialogs             │
├─────────────────────────────────────────────────┤
│              Presentation Layer                  │
│         Riverpod Providers · ViewModels          │
├─────────────────────────────────────────────────┤
│               Domain Layer                       │
│       Entities · Use Cases · Repositories        │
├─────────────────────────────────────────────────┤
│               Data Layer                         │
│    API Client · Local Storage · Mappers          │
└─────────────────────────────────────────────────┘
```

## 2. Complete Screen Map

### 🔐 Authentication Flow
1. **Splash Screen** — App logo, loading animation
2. **Onboarding** — 3 slides explaining the app value
3. **Phone Auth** — Phone number input (Ghana +233 format)
4. **OTP Verification** — 6-digit OTP input with resend

### 🏠 Main App (Bottom Navigation)
1. **Home/Dashboard** — Quick actions, recent activity, featured lawyers
2. **Lawyers** — Browse/search lawyers with filters
3. **Consultations** — Active & history of consultations  
4. **Documents** — Legal document templates & generated docs
5. **Profile** — Settings, payment methods, help

### 📱 Feature Screens

#### Lawyer Discovery
- **Lawyers List** — Card-based list with filters
- **Search Lawyers** — Search by name, specialty, location
- **Lawyer Profile** — Full bio, ratings, availability, book button
- **Filters Sheet** — Specialty, location, price range, availability

#### Consultation Flow  
- **Book Consultation** — Choose type (instant/scheduled), duration, payment
- **Scheduling** — Date/time picker for scheduled consultations
- **Consultation Prep** — Pre-consultation questionnaire
- **Live Chat** — Real-time messaging with lawyer
- **Video/Voice Call** — In-app calling (future feature)
- **Consultation Complete** — Summary, rating, payment receipt

#### Documents
- **Document Templates** — Browse available legal documents
- **Request Document** — Form to request custom legal document
- **Generated Documents** — View/download completed documents
- **Document Viewer** — In-app PDF viewer

#### Payments & Money
- **Payment Methods** — Manage MoMo wallets (MTN, Vodafone, AirtelTigo)
- **Payment Flow** — Secure MoMo payment with confirmation
- **Payment History** — All transactions with receipts
- **Wallet Top-up** — Add money for consultations

#### Profile & Settings
- **Edit Profile** — Update personal information
- **Notification Settings** — Push notification preferences  
- **Privacy Settings** — Data usage, sharing preferences
- **Payment Settings** — Default payment method, billing
- **Help & Support** — FAQs, contact support, tutorials
- **Legal Knowledge** — Browse legal articles and guides

#### Notifications
- **Notification Center** — All app notifications
- **Push Notifications** — Consultation reminders, responses

## 3. Tech Stack Definition

### State Management
- **Riverpod** — AsyncNotifierProvider for API calls, StateProvider for UI state
- **Freezed** — Immutable data classes with unions
- **Riverpod Annotation** — Code generation for providers

### Navigation
- **go_router** — Declarative routing with guards
- **Deep linking** — Handle consultation links, lawyer profiles
- **Nested navigation** — Bottom nav + stack navigation

### HTTP & API
- **Dio** — HTTP client with interceptors
- **JWT Interceptor** — Automatic token refresh
- **Retry Interceptor** — Network resilience
- **Logging Interceptor** — Request/response debugging

### Local Storage
- **Hive** — Fast key-value storage
- **Secure Storage** — JWT tokens, sensitive data  
- **SQLite** — Offline consultation history
- **Cached Network Image** — Image caching

### Real-time Communication
- **SignalR** — ASP.NET Core SignalR client
- **WebSocket fallback** — For older devices
- **Auto-reconnect** — Robust connection handling

### Payments
- **Mobile Money APIs** — MTN MoMo, Vodafone Cash, AirtelTigo  
- **WebView** — For payment gateway integration
- **Deep links** — Return from payment apps

### UI & Animations
- **Material 3** — Latest Material Design
- **Custom Animations** — Hero transitions, page transitions
- **Skeleton Loaders** — Instead of spinners
- **Lottie** — Custom animations for onboarding

### Backend Integration
- **API Base URL**: `http://localhost:5055/api/v1/`
- **Auth**: JWT Bearer tokens
- **Real-time**: SignalR at `/chatHub`

## 4. Monetization Strategy

### Revenue Streams
1. **Consultation Fees** — 15-20% commission on each consultation
2. **Document Generation** — Flat fees for legal documents (₵50-200)
3. **Premium Subscriptions** — Monthly plans for frequent users
4. **Lawyer Listing** — Featured placement fees for lawyers

### Payment Model (Ghana-focused)
- **Mobile Money** — Primary payment method (90% of users)
  - MTN MoMo — 60% market share
  - Vodafone Cash — 25% market share  
  - AirtelTigo Money — 15% market share
- **Bank Transfer** — Secondary option
- **Cash** — For offline document pickup

### Pricing Strategy
- **15-min consultation**: ₵50-150 (lawyer sets price)
- **30-min consultation**: ₵80-250  
- **Document generation**: ₵50-200 depending on complexity
- **App commission**: 15% per transaction
- **Premium subscription**: ₵30/month (unlimited chat, priority booking)

### Financial Projections
- **Target**: 1000 users in 6 months
- **Conservative**: 20 consultations/day × ₵100 avg × 15% = ₵300/day revenue
- **Aggressive**: 100 consultations/day × ₵120 avg × 15% = ₵1,800/day revenue

## 5. Technical Architecture Details

### Folder Structure
```
mobile/
├── lib/
│   ├── main.dart                    # App entry point
│   ├── app/
│   │   ├── app.dart                # App widget with providers
│   │   ├── router.dart             # go_router configuration  
│   │   ├── theme.dart              # Material 3 theme
│   │   └── constants.dart          # App-wide constants
│   ├── core/
│   │   ├── constants/
│   │   │   ├── api_endpoints.dart  # API URLs
│   │   │   ├── app_colors.dart     # Brand colors
│   │   │   ├── app_strings.dart    # Text constants
│   │   │   └── storage_keys.dart   # Local storage keys
│   │   ├── utils/
│   │   │   ├── formatters.dart     # Phone, currency formatters
│   │   │   ├── validators.dart     # Form validation
│   │   │   ├── date_utils.dart     # Date/time helpers
│   │   │   └── extensions.dart     # Dart extensions
│   │   ├── network/
│   │   │   ├── dio_client.dart     # HTTP client setup
│   │   │   ├── api_interceptors.dart # JWT, retry, logging
│   │   │   └── network_info.dart   # Connectivity checking
│   │   └── errors/
│   │       ├── exceptions.dart     # App exceptions  
│   │       ├── failures.dart       # Domain failures
│   │       └── error_handler.dart  # Global error handling
│   ├── features/
│   │   ├── auth/
│   │   │   ├── data/              # API client, local storage
│   │   │   ├── domain/            # Entities, use cases
│   │   │   ├── presentation/      # Screens, providers
│   │   │   └── widgets/           # Auth-specific widgets
│   │   ├── lawyers/               # Lawyer discovery & profiles
│   │   ├── consultation/          # Booking & chat
│   │   ├── documents/             # Document generation
│   │   ├── payments/              # MoMo integration
│   │   ├── profile/               # User profile & settings
│   │   └── notifications/         # Push notifications
│   └── shared/
│       ├── widgets/               # Reusable UI components
│       ├── models/                # Shared data models
│       ├── providers/             # Global providers
│       └── services/              # Platform services
├── assets/
│   ├── images/                    # App icons, illustrations
│   ├── icons/                     # Custom legal icons
│   ├── fonts/                     # Custom typography
│   └── animations/                # Lottie animations
├── android/                       # Android configuration
├── ios/                           # iOS configuration
├── web/                           # Web configuration
├── pubspec.yaml                   # Dependencies
└── README.md                      # Setup instructions
```

### Key Dependencies
```yaml
dependencies:
  # Core Flutter
  flutter_riverpod: ^2.6.1
  riverpod_annotation: ^2.3.6
  go_router: ^15.0.0
  
  # Network & API
  dio: ^5.7.0
  json_annotation: ^4.9.0
  
  # Local Storage
  hive: ^2.2.3
  hive_flutter: ^1.1.0
  flutter_secure_storage: ^9.2.2
  
  # Real-time
  signalr_netcore: ^1.4.2
  web_socket_channel: ^3.0.1
  
  # UI & Design
  flutter_svg: ^2.0.12
  cached_network_image: ^3.4.1
  shimmer: ^3.0.0
  lottie: ^3.2.0
  
  # Phone & Location
  flutter_libphonenumber: ^2.3.3
  geolocator: ^13.0.1
  
  # Utils
  intl: ^0.20.0
  url_launcher: ^6.3.1
  image_picker: ^1.1.2
  permission_handler: ^11.3.1
  
dev_dependencies:
  # Code Generation
  riverpod_generator: ^2.4.3
  json_serializable: ^6.8.0
  build_runner: ^2.4.13
  freezed: ^2.5.7
  
  # Testing
  flutter_test:
  mockito: ^5.4.4
```

## 6. Ghana-Specific Considerations

### User Experience
- **Phone-first auth** — No passwords, OTP only
- **Offline-friendly** — Cache lawyers, consultations
- **Low-data mode** — Compressed images, text-first
- **Local languages** — English + Twi support ready

### Mobile Money Integration
- **MTN MoMo** — USSD *170# integration
- **Vodafone Cash** — *110# integration  
- **AirtelTigo** — *185# integration
- **Backup**: Bank transfer, cash payment

### Cultural Design
- **Colors**: Deep blue (trust) + gold (prosperity)
- **Icons**: Legal scales, Ghana flag colors
- **Typography**: Professional but approachable
- **Imagery**: Diverse Ghanaian lawyers and clients

## 7. Performance Targets

### App Performance
- **App startup**: <2 seconds to home screen
- **API calls**: <500ms average response time
- **Image loading**: Progressive with shimmer
- **Animations**: 60fps on mid-range devices (₵500-1500 phones)

### Technical Metrics
- **Build size**: <25MB APK
- **Memory usage**: <150MB on average device
- **Battery impact**: <5% per hour of active use
- **Offline capability**: 24-48 hours without connection

## 8. Next Steps

1. ✅ **Architecture defined**
2. 🔄 **Create Flutter project structure** 
3. 🔄 **Implement core foundation (routing, theme, API)**
4. 🔄 **Build authentication flow**
5. 🔄 **Implement lawyer discovery**
6. 🔄 **Build consultation booking**
7. 🔄 **Add real-time chat**
8. 🔄 **Integrate MoMo payments**
9. 🔄 **Polish UI/UX**
10. 🔄 **Testing & optimization**

This is a **revenue-focused product**. Every screen, animation, and interaction should feel premium and trustworthy. Ghanaian users deserve world-class legal tech! 🇬🇭✨