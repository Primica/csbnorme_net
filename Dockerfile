# Stage 1: Build
FROM mcr.microsoft.com/dotnet/sdk:10.0-preview AS build
WORKDIR /src

# Copier le fichier projet et restaurer les dépendances
COPY ["csbnorme_net.csproj", "./"]
RUN dotnet restore "csbnorme_net.csproj"

# Copier tout le reste et builder
COPY . .
RUN dotnet build "csbnorme_net.csproj" -c Release -o /app/build

# Stage 2: Publish
FROM build AS publish
RUN dotnet publish "csbnorme_net.csproj" -c Release -o /app/publish /p:UseAppHost=false

# Stage 3: Runtime
FROM mcr.microsoft.com/dotnet/aspnet:10.0-preview AS final
WORKDIR /app

# Créer un utilisateur non-root pour la sécurité
RUN useradd -m -s /bin/bash appuser && chown -R appuser:appuser /app
USER appuser

# Copier les fichiers publiés
COPY --from=publish /app/publish .

# Exposer le port
EXPOSE 8080

# Variables d'environnement
ENV ASPNETCORE_URLS=http://+:8080
ENV ASPNETCORE_ENVIRONMENT=Production

# Point d'entrée
ENTRYPOINT ["dotnet", "csbnorme_net.dll"]
