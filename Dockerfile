# ======================
# Build stage
# ======================
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /src

# Copiamos la solución y los proyectos
COPY ControlBingo.sln ./
COPY ControlBingo/ ./ControlBingo/

# Restauramos dependencias
RUN dotnet restore

# Publicamos la app en Release
RUN dotnet publish ControlBingo/ControlBingo.csproj -c Release -o /app/publish

# ======================
# Runtime stage
# ======================
FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS runtime
WORKDIR /app

# Copiamos los archivos publicados del build
COPY --from=build /app/publish .

# Puerto en el que escuchará la app
EXPOSE 80

# Comando para correr la app
ENTRYPOINT ["dotnet", "ControlBingo.dll"]