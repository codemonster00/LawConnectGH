# 🇬🇭 LawConnect GH Mobile App

**Beautiful, production-ready Flutter app for instant legal consultation in Ghana**

Connect Ghanaian citizens with verified lawyers through a premium mobile experience. Built with Flutter 3.x, Material Design 3, and modern architecture patterns.

## ✨ Features

### 🔐 Authentication
- **Phone-first auth** — No passwords, OTP-based login (Ghana +233 format)
- **Seamless onboarding** — 3-slide introduction with smooth animations
- **Secure storage** — JWT tokens with automatic refresh

### 👨‍⚖️ Lawyer Discovery
- **Smart search** — Filter by specialty, location, price, availability
- **Detailed profiles** — Bio, education, reviews, pricing, real-time availability
- **Verified badges** — Only certified Ghana Bar Association lawyers

### 💬 Instant Consultation
- **Real-time chat** — SignalR-powered messaging with typing indicators
- **Video/voice calls** — In-app calling for face-to-face consultations
- **Consultation timer** — Track session duration and billing
- **Rating system** — Rate lawyers after each consultation

### 📄 Legal Documents
- **Document templates** — Affidavits, contracts, wills, power of attorney
- **Custom generation** — AI-powered document creation by lawyers
- **Digital delivery** — Download and share completed documents

### 💰 Ghana-Focused Payments
- **Mobile Money** — MTN MoMo, Vodafone Cash, AirtelTigo integration
- **Transparent pricing** — No hidden fees, clear consultation rates
- **Secure transactions** — PCI-compliant payment processing

## 🏗️ Architecture

### Clean Architecture + Riverpod
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

### Key Technologies
- **State Management**: Riverpod with code generation
- **Navigation**: go_router with deep linking support
- **HTTP Client**: Dio with interceptors and retry logic
- **Real-time**: SignalR for live chat
- **Local Storage**: Hive + Secure Storage
- **UI**: Material Design 3 with custom Ghana-themed colors

## 🚀 Getting Started

### Prerequisites
- Flutter 3.27.1+ (stable channel)
- Dart 3.5.0+
- Android Studio / VS Code
- LawConnect GH backend running at `http://localhost:5055`

### Installation

```bash
# Clone the repository
git clone https://github.com/codemonster00/LawConnectGH.git
cd LawConnectGH/mobile

# Get dependencies
flutter pub get

# Generate code (Freezed, JSON serialization, Riverpod)
flutter packages pub run build_runner build

# Run the app
flutter run
```

### Running on Different Platforms

```bash
# Web (for development)
flutter run -d chrome

# Android
flutter run -d android

# iOS (macOS required)
flutter run -d ios
```

### Build for Production

```bash
# Android APK
flutter build apk --release

# Android App Bundle (for Play Store)
flutter build appbundle --release

# iOS (macOS required)
flutter build ios --release
```

## 🎨 Design System

### Colors (Ghana Legal Theme)
- **Primary**: Deep navy blue (#1B365D) — Trust and professionalism
- **Accent**: Legal gold (#D4AF37) — Premium and authority  
- **Ghana Flag**: Red, Gold, Green accents for national identity
- **Mobile Money**: Brand colors for MTN, Vodafone, AirtelTigo

### Typography
- **Font**: Inter (clean, modern, professional)
- **Sizes**: Display → Headlines → Titles → Body → Labels
- **Weights**: Regular (400) → Medium (500) → SemiBold (600) → Bold (700)

### Components
- **Cards**: 16px radius, subtle shadows, elevated feel
- **Buttons**: 12px radius, prominent primary actions
- **Navigation**: Bottom nav with 5 tabs + floating action button
- **Animations**: Hero transitions, skeleton loading, micro-interactions

## 📱 Screens & Navigation

### Authentication Flow
1. **Splash Screen** — App logo with loading animation
2. **Onboarding** — 3 slides explaining app value proposition
3. **Phone Auth** — Ghana phone number input with country picker
4. **OTP Verification** — 6-digit PIN input with resend functionality

### Main App (Bottom Navigation)
1. **Home** — Dashboard, quick actions, featured lawyers
2. **Lawyers** — Browse/search with filters and sorting
3. **Consultations** — Active chats and consultation history
4. **Documents** — Templates and generated documents
5. **Profile** — Settings, payment methods, help

### Detail Screens
- **Lawyer Profile** — Full bio, ratings, pricing, booking
- **Consultation Chat** — Real-time messaging with timer
- **Document Templates** — Browse and request legal documents
- **Payment Flow** — Mobile Money integration

## 🌍 Ghana-Specific Features

### Localization Ready
- **Primary**: English (Ghana locale)
- **Future**: Twi, Ga, Hausa language support
- **Cultural**: Ghana flag colors, local legal terminology

### Mobile Money Integration
- **MTN MoMo** (60% market share) — *170# USSD integration
- **Vodafone Cash** (25% share) — *110# integration  
- **AirtelTigo** (15% share) — *185# integration

### Legal System
- **Ghana Bar Association** verification
- **Local specialties**: Land law, chieftaincy disputes
- **Regulatory compliance**: Ghana legal practice standards

## 📊 Performance Targets

- **App startup**: <2 seconds to home screen
- **API response**: <500ms average
- **Build size**: <25MB APK
- **Memory usage**: <150MB average
- **60fps animations** on ₵500-1500 Android devices

## 🔧 Development

### Code Generation
```bash
# Generate Riverpod providers, Freezed models, JSON serialization
flutter packages pub run build_runner build

# Watch mode for development
flutter packages pub run build_runner watch
```

### Testing
```bash
# Run all tests
flutter test

# Run with coverage
flutter test --coverage

# Widget tests
flutter test test/widgets/

# Integration tests  
flutter drive --target=test_driver/app.dart
```

### Code Quality
```bash
# Static analysis
flutter analyze

# Format code
dart format .

# Fix lint issues
dart fix --apply
```

## 📦 Dependencies

### Core
- `flutter_riverpod` — Type-safe state management
- `go_router` — Declarative routing with deep links
- `dio` — HTTP client with interceptors

### UI & Design
- `cached_network_image` — Image loading and caching
- `shimmer` — Skeleton loading animations
- `lottie` — Custom animations for onboarding

### Functionality  
- `hive` — Fast local storage
- `flutter_secure_storage` — Secure token storage
- `signalr_netcore` — Real-time chat communication
- `pin_code_fields` — OTP input interface

### Ghana-Specific
- `flutter_libphonenumber` — Ghana phone validation
- `country_picker` — Country selection with Ghana default
- `intl` — Currency formatting (Ghana Cedis)

## 💼 Business Model

### Revenue Streams
1. **Consultation Commissions** — 15% fee per consultation
2. **Document Generation** — ₵50-200 per legal document  
3. **Premium Subscriptions** — ₵30/month for power users
4. **Lawyer Listings** — Featured placement fees

### Pricing Strategy (Ghana Market)
- **15-min consultation**: ₵50-150 (lawyer sets price)
- **30-min consultation**: ₵80-250
- **Document generation**: ₵50-200 depending on complexity
- **Average transaction**: ₵120 consultation × 15% commission = ₵18 revenue

## 🚢 Deployment

### Environment Setup
```bash
# Development
export API_BASE_URL=http://localhost:5055/api/v1
export SIGNALR_URL=http://localhost:5055/chatHub

# Staging
export API_BASE_URL=https://staging-api.lawconnectgh.com/api/v1
export SIGNALR_URL=https://staging-api.lawconnectgh.com/chatHub

# Production
export API_BASE_URL=https://api.lawconnectgh.com/api/v1
export SIGNALR_URL=https://api.lawconnectgh.com/chatHub
```

### App Store Deployment
1. **Update version** in `pubspec.yaml` and platform configs
2. **Build release** with `flutter build appbundle --release`
3. **Upload to Play Console** with appropriate metadata
4. **Submit for review** with Ghana legal compliance notes

## 🧪 Testing Strategy

### Unit Tests
- Business logic in domain layer
- API client responses and error handling
- Formatters and validators
- Riverpod provider state changes

### Widget Tests
- Screen rendering and user interactions
- Form validation and input handling
- Navigation and routing
- Custom widget behavior

### Integration Tests
- Complete user journeys (auth → booking → chat)
- Payment flow end-to-end
- Real-time chat functionality
- Offline capabilities

## 📈 Success Metrics

### Technical KPIs
- **Crash-free rate**: >99.5%
- **App startup time**: <2 seconds
- **API success rate**: >99%
- **User retention**: >60% (30 days)

### Business KPIs  
- **Active consultations/day**: Target 50+ within 6 months
- **Average consultation value**: ₵120
- **Monthly revenue**: ₵27,000+ (50 consults/day × ₵120 × 15% × 30 days)
- **Lawyer onboarding**: 100+ verified lawyers in 12 months

## 🤝 Contributing

1. Fork the repository
2. Create feature branch (`git checkout -b feature/amazing-feature`)
3. Follow Flutter style guide and run `dart format`
4. Add tests for new functionality
5. Submit pull request with detailed description

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](../LICENSE) file.

## 🇬🇭 Built for Ghana

This app is specifically designed for the Ghanaian legal market:
- Ghana Bar Association compliance
- Mobile Money payment integration  
- Local legal specialties and terminology
- Cultural sensitivity in design and UX
- Optimized for popular Android devices in Ghana

---

**Made with ❤️ for Ghana's legal transformation** 🚀

### Contact
- **Backend API**: http://localhost:5055/swagger
- **Repository**: https://github.com/codemonster00/LawConnectGH
- **Documentation**: See `/ARCHITECTURE.md` for detailed technical specs