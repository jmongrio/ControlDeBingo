# ======================
# Base runtime
# ======================
FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS base
WORKDIR /app
EXPOSE 80
EXPOSE 443

# ======================
# Build stage
# ======================
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /src

# Copiar solución y proyecto
COPY ControlBingo.sln ./
COPY ControlBingo/ ./ControlBingo/

# Restaurar dependencias
RUN dotnet restore

# Publicar app
RUN dotnet publish ControlBingo/ControlBingo.csproj -c Release -o /app/publish

# ======================
# Final stage
# ======================
FROM base AS final
WORKDIR /app
COPY --from=build /app/publish .
ENV ASPNETCORE_URLS=https://+:80
ENTRYPOINT ["dotnet", "ControlBingo.dll"]
