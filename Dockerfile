# Fase 1: Build
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /src

# Copiar los archivos del proyecto y la solución
COPY . .

# Restaurar dependencias y compilar el proyecto
RUN dotnet restore ./ControlBingo/ControlBingo.csproj
RUN dotnet publish ./ControlBingo/ControlBingo.csproj -c Release -o /app/publish

# Fase 2: Runtime Nginx
FROM nginx:alpine AS runtime
WORKDIR /usr/share/nginx/html

# Copiar los archivos publicados al servidor web de nginx
COPY --from=build /app/publish/wwwroot .

# Exponer el puerto 80
EXPOSE 80

# Iniciar Nginx en primer plano
CMD ["nginx", "-g", "daemon off;"]