# CSBNorm Downloads

## Binaires disponibles

### Windows
- **csbnorm-windows.exe** - Version 1.0.0 pour Windows (x64)
  
  Placez le binaire ici pour qu'il soit disponible au téléchargement.

### Utilisation

Après téléchargement, vous pouvez :

1. **Option 1 : Ajouter au PATH système**
   ```powershell
   # Déplacer vers un dossier dans le PATH
   Move-Item csbnorm-windows.exe C:\Windows\System32\csbnorm.exe
   ```

2. **Option 2 : Utiliser localement**
   ```powershell
   # Dans le dossier du projet
   .\csbnorm-windows.exe check .
   ```

3. **Option 3 : Créer un alias**
   ```powershell
   # Dans votre profil PowerShell
   Set-Alias csbnorm "C:\path\to\csbnorm-windows.exe"
   ```

### Commandes disponibles

```bash
# Vérifier un projet
csbnorm check ./mon-projet

# Vérifier avec rapport HTML
csbnorm check ./mon-projet --report=html --output=rapport.html

# Vérifier uniquement certaines règles
csbnorm check ./mon-projet --rules=security,database

# Lister toutes les règles
csbnorm rules

# Afficher la version
csbnorm --version
```

## Versions futures

- **Linux** (x64, ARM64)
- **macOS** (Intel, Apple Silicon)

---

Pour contribuer ou signaler des bugs : [GitHub Repository]
