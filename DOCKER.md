# CSBNorm - Déploiement Docker

Ce projet peut être conteneurisé avec Docker pour un déploiement facile.

## 🐳 Build et Run

### Option 1 : Docker simple

```bash
# Build l'image
docker build -t csbnorme-web .

# Run le container
docker run -d -p 8080:8080 --name csbnorme csbnorme-web

# Accéder au site
# http://localhost:8080
```

### Option 2 : Docker Compose (Recommandé)

```bash
# Démarrer tous les services
docker-compose up -d

# Voir les logs
docker-compose logs -f

# Arrêter les services
docker-compose down
```

## 🔧 Configuration

### Variables d'environnement

Vous pouvez personnaliser le comportement avec des variables d'environnement :

```bash
docker run -d \
  -p 8080:8080 \
  -e ASPNETCORE_ENVIRONMENT=Production \
  -e ASPNETCORE_URLS=http://+:8080 \
  --name csbnorme \
  csbnorme-web
```

### Ports

- **8080** : Port HTTP de l'application

## 📦 Image Docker

L'image Docker utilise :
- **Base** : `mcr.microsoft.com/dotnet/aspnet:9.0`
- **SDK** : `mcr.microsoft.com/dotnet/sdk:9.0` (pour le build)
- **Multi-stage build** : Pour une image finale légère
- **Utilisateur non-root** : Pour la sécurité

## 🚀 Déploiement en production

### Docker Hub

```bash
# Tag l'image
docker tag csbnorme-web votre-username/csbnorme-web:1.0.0

# Push vers Docker Hub
docker push votre-username/csbnorme-web:1.0.0

# Pull et run sur le serveur de production
docker pull votre-username/csbnorme-web:1.0.0
docker run -d -p 80:8080 votre-username/csbnorme-web:1.0.0
```

### Kubernetes

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: csbnorme-web
spec:
  replicas: 2
  selector:
    matchLabels:
      app: csbnorme
  template:
    metadata:
      labels:
        app: csbnorme
    spec:
      containers:
      - name: web
        image: votre-username/csbnorme-web:1.0.0
        ports:
        - containerPort: 8080
---
apiVersion: v1
kind: Service
metadata:
  name: csbnorme-service
spec:
  type: LoadBalancer
  ports:
  - port: 80
    targetPort: 8080
  selector:
    app: csbnorme
```

## 🛠️ Commandes utiles

```bash
# Voir les containers en cours
docker ps

# Voir les logs
docker logs csbnorme

# Accéder au shell du container
docker exec -it csbnorme /bin/bash

# Arrêter le container
docker stop csbnorme

# Redémarrer
docker restart csbnorme

# Supprimer le container
docker rm csbnorme

# Supprimer l'image
docker rmi csbnorme-web
```

## 🔍 Troubleshooting

### Le container ne démarre pas
```bash
# Vérifier les logs
docker logs csbnorme

# Vérifier la santé du container
docker inspect csbnorme
```

### Erreur de port déjà utilisé
```bash
# Utiliser un autre port
docker run -d -p 8081:8080 csbnorme-web
```

### Problème de permissions
L'image utilise un utilisateur non-root (`appuser`) pour la sécurité. Si vous avez des problèmes de permissions, vérifiez les volumes montés.
