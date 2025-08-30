# Utiliza la imagen oficial de .NET 8 para construir y publicar la app
FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS base
WORKDIR /app
EXPOSE 80
EXPOSE 443

FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /src
COPY . .
RUN dotnet restore
RUN dotnet publish -c Release -o /app/publish

FROM base AS final
WORKDIR /app
COPY --from=build /app/publish .
# Variables de entorno para producción (ajusta según tus necesidades)
ENV ASPNETCORE_URLS=http://+:80
ENTRYPOINT ["dotnet", "ControlBingo.dll"]
