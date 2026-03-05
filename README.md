# 🇬🇭 LawConnect GH

[![Build Status](https://github.com/codemonster00/LawConnectGH/workflows/CI/badge.svg)](https://github.com/codemonster00/LawConnectGH/actions)
[![.NET Version](https://img.shields.io/badge/.NET-8.0-purple)](https://dotnet.microsoft.com/en-us/download/dotnet/8.0)
[![Flutter Version](https://img.shields.io/badge/Flutter-3.24+-blue)](https://flutter.dev/)
[![Next.js Version](https://img.shields.io/badge/Next.js-14-black)](https://nextjs.org/)
[![License](https://img.shields.io/badge/License-MIT-green.svg)](LICENSE)
[![PRs Welcome](https://img.shields.io/badge/PRs-welcome-brightgreen.svg)](CONTRIBUTING.md)

**Democratizing legal access for Ghana** — A comprehensive platform connecting citizens with verified lawyers for instant consultations, document generation, and legal education.

> 🏆 **Full-stack legal tech platform with real-time chat, AI triage, mobile money integration, and multi-platform support**

![LawConnect Preview](screenshots/lawconnect-preview.png)

---

## ✨ Key Features

🚀 **Instant Legal Consultations** - Connect with verified lawyers in real-time
📱 **Multi-Platform Support** - Web (React/Next.js), Mobile (Flutter), API-first
💬 **Real-time Chat** - SignalR-powered instant messaging between clients and lawyers
🔐 **Secure Authentication** - Phone + OTP verification with JWT tokens
💰 **Mobile Money Integration** - Support for MTN MoMo, Vodafone Cash, AirtelTigo
📄 **Smart Document Generation** - AI-powered legal document creation
🎯 **AI Consultation Triage** - Intelligent case routing and priority assessment
🔍 **Advanced Lawyer Search** - Filter by expertise, location, availability, and ratings
📊 **Admin Dashboard** - Comprehensive lawyer verification and platform management

## 📸 Screenshots

<table>
  <tr>
    <td width="50%">
      <h4>🏠 Client Dashboard</h4>
      <img src="screenshots/client-dashboard.png" alt="Client Dashboard" width="100%">
    </td>
    <td width="50%">
      <h4>💬 Real-time Chat</h4>
      <img src="screenshots/chat-interface.png" alt="Chat Interface" width="100%">
    </td>
  </tr>
  <tr>
    <td width="50%">
      <h4>📱 Mobile App</h4>
      <img src="screenshots/mobile-app.png" alt="Mobile App" width="100%">
    </td>
    <td width="50%">
      <h4>⚖️ Lawyer Portal</h4>
      <img src="screenshots/lawyer-portal.png" alt="Lawyer Portal" width="100%">
    </td>
  </tr>
</table>

## 🛠️ Technology Stack

### Backend (.NET 8 Clean Architecture)
- **Framework**: ASP.NET Core 8 Web API
- **Architecture**: Clean Architecture with CQRS pattern
- **Database**: PostgreSQL 16 with Entity Framework Core
- **Authentication**: JWT tokens + OTP-based phone verification
- **Real-time**: SignalR hubs for instant messaging
- **Testing**: xUnit, FluentAssertions, Moq
- **Documentation**: Swagger/OpenAPI 3.0

### Frontend (Next.js 14)
- **Framework**: Next.js 14 with React 18
- **Styling**: Tailwind CSS with responsive design
- **State Management**: Zustand + React Query
- **UI Components**: shadcn/ui + Headless UI
- **Forms**: React Hook Form + Zod validation
- **Real-time**: SignalR client integration

### Mobile (Flutter)
- **Framework**: Flutter 3.24+ (Dart)
- **State Management**: Riverpod 2.0
- **UI**: Material Design 3 with custom theming
- **HTTP**: Dio with interceptors
- **Storage**: Hive (local) + Secure Storage
- **Payments**: Flutter mobile money plugins

### DevOps & Infrastructure
- **Containerization**: Docker + Docker Compose
- **CI/CD**: GitHub Actions (3 workflows)
- **Deployment**: Railway/Azure Container Apps
- **Process Management**: systemd services
- **Monitoring**: Application Insights + Serilog

## 🏗️ Architecture Overview

```
┌─────────────────────────────────────────────────────────┐
│                    Presentation Layer                   │
│  Next.js Web App  │  Flutter Mobile  │  REST API        │
├─────────────────────────────────────────────────────────┤
│                   Application Layer                     │
│     Command Handlers  │  Query Handlers  │  SignalR     │
├─────────────────────────────────────────────────────────┤
│                     Domain Layer                        │
│  Entities │ Value Objects │ Domain Services │ Events     │
├─────────────────────────────────────────────────────────┤
│                 Infrastructure Layer                    │
│   EF Core │ PostgreSQL │ External APIs │ File Storage    │
└─────────────────────────────────────────────────────────┘
```

### Domain Entities (13 Core Entities)
- 👤 **User, Client, Lawyer** - Identity management
- ⚖️ **Consultation, Message** - Core consultation flow
- 📄 **Document, DocumentTemplate** - Document generation
- 💳 **Payment, Transaction** - Financial transactions
- 📊 **Review, Rating** - Quality assurance
- 🏢 **LegalArea, Specialization** - Lawyer expertise
- 🔧 **SystemSettings** - Platform configuration

### Key Enumerations (10 Enums)
```csharp
public enum ConsultationType { General, Emergency, Document, Advice }
public enum PaymentMethod { MtnMomo, VodafoneCash, AirtelTigo }
public enum LawyerStatus { Pending, Verified, Suspended, Active }
// ... and 7 more for comprehensive type safety
```

## 🚀 Quick Start

### Prerequisites
- [.NET 8 SDK](https://dotnet.microsoft.com/download/dotnet/8.0) 
- [Node.js 18+](https://nodejs.org/) 
- [Flutter SDK 3.24+](https://flutter.dev/docs/get-started/install)
- [PostgreSQL 16](https://www.postgresql.org/) (or use Docker)
- [Docker](https://docs.docker.com/get-docker/) (recommended)

### 1. Clone & Setup
```bash
# Clone repository
git clone https://github.com/codemonster00/LawConnectGH.git
cd LawConnectGH

# Setup environment variables
cp .env.example .env
# Edit .env with your configuration
```

### 2. Database Setup
```bash
# Using Docker (recommended)
docker-compose up -d postgres

# Or install PostgreSQL locally and create database
createdb lawconnect_dev
```

### 3. Backend (.NET API)
```bash
# Restore packages and run migrations
dotnet restore
dotnet ef database update --project src/LawConnect.API

# Run the API
dotnet run --project src/LawConnect.API
# API available at: https://localhost:7000
# Swagger UI: https://localhost:7000/swagger
```

### 4. Frontend (Next.js)
```bash
# Navigate to frontend
cd frontend

# Install dependencies and run
npm install
npm run dev
# Web app available at: http://localhost:3000
```

### 5. Mobile (Flutter)
```bash
# Navigate to mobile
cd mobile

# Get dependencies and run
flutter pub get
flutter run
# Choose your target device (iOS/Android emulator or physical device)
```

### 6. Complete Environment (Docker)
```bash
# Run everything with Docker Compose
docker-compose up -d

# Services will be available at:
# API: http://localhost:8080
# Web: http://localhost:3000
# Database: localhost:5432
```

## 📱 API Reference

### Core Endpoints

| Endpoint | Method | Description | Authentication |
|----------|--------|-------------|----------------|
| `/api/v1/auth/register/client` | POST | Register new client | None |
| `/api/v1/auth/register/lawyer` | POST | Register new lawyer | None |
| `/api/v1/auth/request-otp` | POST | Request OTP for login | None |
| `/api/v1/auth/verify-otp` | POST | Verify OTP & get JWT | None |
| `/api/v1/lawyers` | GET | Search and filter lawyers | Optional |
| `/api/v1/lawyers/{id}` | GET | Get lawyer profile details | Optional |
| `/api/v1/consultations` | POST | Create new consultation | Required |
| `/api/v1/consultations` | GET | List user's consultations | Required |
| `/api/v1/consultations/{id}/messages` | GET | Get chat messages | Required |
| `/api/v1/documents/templates` | GET | List document templates | Required |
| `/api/v1/documents/generate` | POST | Generate legal document | Required |
| `/api/v1/payments/initialize` | POST | Initialize MoMo payment | Required |
| `/api/v1/admin/lawyers/pending` | GET | List pending verifications | Admin |

### SignalR Hubs
- `/chathub` - Real-time consultation messaging
- `/notificationhub` - Live notifications and status updates

## 🧪 Testing

### Backend Tests
```bash
# Run all tests
dotnet test

# Run with coverage
dotnet test --collect:"XPlat Code Coverage"

# Integration tests (requires test database)
dotnet test tests/LawConnect.IntegrationTests/
```

### Frontend Tests
```bash
cd frontend

# Unit tests
npm run test

# E2E tests with Cypress
npm run test:e2e

# Component tests with Storybook
npm run storybook
```

### Mobile Tests
```bash
cd mobile

# Unit and widget tests
flutter test

# Integration tests
flutter drive --target=test_driver/app.dart
```

## 📊 CI/CD Pipeline

### GitHub Actions Workflows

1. **CI Pipeline** (`.github/workflows/ci.yml`)
   - ✅ Build .NET API and run tests
   - ✅ Build Next.js frontend
   - ✅ Flutter mobile app compilation
   - ✅ Code quality checks (SonarQube)
   - ✅ Security scanning

2. **Staging Deployment** (`.github/workflows/cd-staging.yml`)
   - 🚀 Auto-deploy to staging on `develop` branch
   - 📧 Slack notifications for deployments
   - 🧪 Automated smoke tests

3. **Production Deployment** (`.github/workflows/cd-production.yml`)
   - 🚀 Deploy to production on `main` branch
   - 📋 Manual approval for production releases
   - 📊 Health checks and rollback capabilities

### Quality Gates
- ✅ **Code Coverage**: Minimum 80% for backend
- ✅ **Security**: OWASP dependency scanning
- ✅ **Performance**: Lighthouse CI for frontend
- ✅ **API**: Contract testing with Pact

## 🤝 Contributing

We welcome contributions from the developer community! Please read our [Contributing Guide](CONTRIBUTING.md) for details.

### Development Workflow
1. 🍴 **Fork** the repository
2. 🌿 **Create** a feature branch (`git checkout -b feature/amazing-feature`)
3. ✅ **Test** your changes thoroughly
4. 💻 **Commit** using conventional commits (`feat:`, `fix:`, `docs:`)
5. 📤 **Push** to your branch (`git push origin feature/amazing-feature`)
6. 🔄 **Create** a Pull Request with detailed description

### Code Standards
- **C#**: Follow Microsoft coding conventions + EditorConfig
- **TypeScript**: ESLint + Prettier configuration
- **Dart**: Follow official Dart style guide
- **Git**: Conventional Commits for clear history

## 🚀 Deployment

### Production Checklist
- [ ] Environment variables configured
- [ ] SSL certificates installed
- [ ] Database migrations applied
- [ ] Mobile money API keys active
- [ ] Monitoring and logging enabled
- [ ] CDN configured for static assets

### Scalability Features
- 📊 **Horizontal scaling**: Stateless API design
- 🗄️ **Database**: Connection pooling + read replicas
- 📁 **File storage**: Azure Blob Storage integration
- ⚡ **Caching**: Redis for session management
- 📈 **Monitoring**: Application Insights + custom metrics

## 🔒 Security

- 🔐 **Authentication**: JWT with phone-based OTP verification
- 🛡️ **Authorization**: Role-based access control (RBAC)
- 🔒 **Data Protection**: GDPR-compliant data handling
- 📱 **Mobile Security**: Certificate pinning + secure storage
- 🌐 **API Security**: Rate limiting + request validation
- 🔍 **Monitoring**: Automated security scanning in CI/CD

## 📄 License

This project is licensed under the [MIT License](LICENSE) - see the LICENSE file for details.

## 🌍 Impact

**Democratizing Legal Access in Ghana**
- 📊 Target: 31M+ Ghanaians with limited legal access
- ⚖️ Mission: Affordable, accessible legal consultation
- 🎯 Goal: Bridge the justice gap through technology

---

<div align="center">

**Built with ❤️ for Ghana 🇬🇭**

[Live Demo](https://lawconnect-gh.vercel.app) • [API Docs](https://api.lawconnect-gh.com/swagger) • [Mobile App](https://play.google.com/store/apps/details?id=com.lawconnect.gh)

[![GitHub stars](https://img.shields.io/github/stars/codemonster00/LawConnectGH.svg?style=social&label=Star)](https://github.com/codemonster00/LawConnectGH)
[![Twitter Follow](https://img.shields.io/twitter/follow/lawconnectgh.svg?style=social&label=Follow)](https://twitter.com/lawconnectgh)

</div>