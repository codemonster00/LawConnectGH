# 🇬🇭 LawConnect GH

**Affordable legal consultation for every Ghanaian** — A platform connecting citizens with verified lawyers for on-demand legal advice, document generation, and know-your-rights education.

## Tech Stack

- **Backend:** ASP.NET Core 8 Web API (Clean Architecture)
- **Database:** PostgreSQL 16
- **Auth:** JWT + OTP-based authentication
- **Real-time:** SignalR for chat
- **AI:** Consultation triage & document generation (pluggable)
- **Payments:** Mobile Money (MTN MoMo, Vodafone Cash) integration ready
- **CI/CD:** GitHub Actions → Railway/Docker

## Architecture

```
┌─────────────────────────────────────────────────┐
│                   API Layer                      │
│         Controllers · Hubs · Middleware          │
├─────────────────────────────────────────────────┤
│               Application Layer                  │
│      DTOs · Interfaces · Validators · UseCases   │
├─────────────────────────────────────────────────┤
│                Domain Layer                      │
│          Entities · Enums · Value Objects         │
├─────────────────────────────────────────────────┤
│             Infrastructure Layer                 │
│     EF Core · PostgreSQL · External Services     │
└─────────────────────────────────────────────────┘
```

## Project Structure

```
LawConnectGH/
├── src/
│   ├── LawConnect.API/            # Controllers, Program.cs, Middleware
│   ├── LawConnect.Application/    # DTOs, Interfaces, Validators
│   ├── LawConnect.Domain/         # Entities, Enums
│   └── LawConnect.Infrastructure/ # EF Core DbContext, Persistence
├── tests/
│   ├── LawConnect.UnitTests/
│   └── LawConnect.IntegrationTests/
├── .github/workflows/             # CI/CD pipelines
├── docker-compose.yml
├── Dockerfile
└── LawConnect.sln
```

## Getting Started

### Prerequisites

- [.NET 8 SDK](https://dotnet.microsoft.com/download/dotnet/8.0)
- [Docker & Docker Compose](https://docs.docker.com/get-docker/)
- [PostgreSQL 16](https://www.postgresql.org/) (or use Docker)

### Quick Start

```bash
# Clone the repository
git clone https://github.com/codemonster00/LawConnectGH.git
cd LawConnectGH

# Start with Docker (recommended)
docker-compose up -d

# Or run locally
dotnet restore
dotnet build
dotnet run --project src/LawConnect.API
```

The API will be available at `http://localhost:8080` with Swagger UI at `/swagger`.

## API Endpoints

| Method | Endpoint | Description |
|--------|----------|-------------|
| POST | `/api/v1/auth/register/client` | Register as a client |
| POST | `/api/v1/auth/register/lawyer` | Register as a lawyer |
| POST | `/api/v1/auth/request-otp` | Request OTP for login |
| POST | `/api/v1/auth/verify-otp` | Verify OTP & get JWT |
| GET | `/api/v1/lawyers` | Search lawyers |
| GET | `/api/v1/lawyers/{id}` | Get lawyer profile |
| POST | `/api/v1/consultations` | Create consultation |
| GET | `/api/v1/consultations` | List my consultations |
| GET | `/api/v1/documents/templates` | Browse templates |
| POST | `/api/v1/documents/generate` | Generate document |
| GET | `/api/v1/admin/lawyers/pending` | Admin: pending lawyers |
| PUT | `/api/v1/admin/lawyers/{id}/verify` | Admin: verify lawyer |

## CI/CD Pipeline

```
Push to develop → CI (build + test) → Deploy to Staging
Push to main    → CI (build + test) → Deploy to Production
Pull Request    → CI (build + test)
```

- **ci.yml** — Builds and tests on every push/PR with PostgreSQL service container
- **cd-staging.yml** — Auto-deploys to staging on `develop` branch
- **cd-production.yml** — Auto-deploys to production on `main` branch

## Contributing

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'feat: add amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## License

This project is licensed under the MIT License.

---

Built with ❤️ for Ghana 🇬🇭
