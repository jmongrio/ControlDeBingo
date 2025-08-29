# Fase 1: Build
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /src

# Copiar los archivos del proyecto al contenedor
COPY . ./

# Restaurar dependencias y compilar el proyecto
RUN dotnet restore
RUN dotnet publish -c Release -o /app/publish

# Fase 2: Nginx Runtime
FROM nginx:alpine AS runtime
WORKDIR /usr/share/nginx/html

# Copiar los archivos de Blazor WebAssembly al servidor web
COPY --from=build /app/publish/wwwroot .

# Iniciar Nginx automáticamente
CMD ["nginx", "-g", "daemon off;"]
