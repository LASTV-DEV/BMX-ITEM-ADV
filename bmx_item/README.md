# Script Vélos Item - Multi Framework

Script de vélos déployables compatible avec ESX, QBCore et Standalone.

## 🎯 Fonctionnalités

- ✅ Support multi-framework (ESX, QBCore, Standalone)
- ✅ 7 types de vélos différents
- ✅ Animation de déploiement et ramassage
- ✅ Texte 3D pour ramasser
- ✅ Configuration ultra détaillée
- ✅ Options avancées (verrouillage, invincibilité, auto-delete)

## 📦 Installation

### 1. Configuration du Framework

Ouvrez `config.lua` et changez la ligne :
```lua
Config.Framework = 'esx'  -- Options: 'esx', 'qbcore', 'standalone'
```

### 2. Installation ESX

1. Exécutez le fichier `items.sql` dans votre base de données
2. Ajoutez `ensure bmx_item` dans votre `server.cfg`
3. Redémarrez le serveur

### 3. Installation QBCore

1. Ajoutez les items de `items_qbcore.lua` dans `qb-core/shared/items.lua`
2. Ajoutez `ensure bmx_item` dans votre `server.cfg`
3. Redémarrez le serveur

### 4. Installation Standalone

1. Ajoutez `ensure bmx_item` dans votre `server.cfg`
2. Utilisez la commande `/givebike [type]` pour obtenir un vélo
   - Exemple: `/givebike bmx`
3. Redémarrez le serveur

## 🚲 Types de Vélos Disponibles

- `bmx` - BMX
- `cruiser` - Cruiser (vélo de plage)
- `fixter` - Fixter (vélo fixie)
- `scorcher` - Scorcher VTT
- `tribike` - TriBike Course
- `tribike2` - TriBike Sport
- `tribike3` - TriBike Pro

## ⚙️ Configuration

Toutes les options sont dans `config.lua` :

- Distances d'affichage et de ramassage
- Touche de ramassage
- Style du texte 3D
- Animations personnalisables
- Options par vélo (distance de spawn, poids, activation)
- Options avancées (auto-delete, verrouillage, invincibilité)

## 🎮 Utilisation

1. Utilisez l'item vélo depuis votre inventaire
2. Le vélo se déploie devant vous avec une animation
3. Utilisez le vélo normalement
4. Descendez et appuyez sur `E` pour le ramasser
5. Le vélo retourne dans votre inventaire

## 📝 Support

Pour ajouter un nouveau vélo, ajoutez-le dans `config.lua` :

```lua
['nom_velo'] = {
    label = 'Nom du Vélo',
    model = 'modele_gta',
    spawnDistance = 2.0,
    weight = 5,
    enabled = true
}
```

N'oubliez pas d'ajouter l'item dans votre base de données ou fichier items !
