FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /src
COPY *.sln .
COPY src/LawConnect.API/*.csproj src/LawConnect.API/
COPY src/LawConnect.Application/*.csproj src/LawConnect.Application/
COPY src/LawConnect.Domain/*.csproj src/LawConnect.Domain/
COPY src/LawConnect.Infrastructure/*.csproj src/LawConnect.Infrastructure/
RUN dotnet restore
COPY . .
RUN dotnet publish src/LawConnect.API -c Release -o /app/publish

FROM mcr.microsoft.com/dotnet/aspnet:8.0
WORKDIR /app
COPY --from=build /app/publish .
EXPOSE 8080
ENTRYPOINT ["dotnet", "LawConnect.API.dll"]
