#!/usr/bin/env bash

PROJECT_DIR=~/bash-learning/jour1/mon_projet

# Créer l'arborescence
mkdir -p "$PROJECT_DIR"/{src,tests,docs,config}

# Créer les fichiers avec contenu
cat > "$PROJECT_DIR/src/main.sh" << 'EOF'
#!/usr/bin/env bash
echo "Hello World"
EOF

cat > "$PROJECT_DIR/src/utils.sh" << 'EOF'
#!/usr/bin/env bash
# Fichier utilitaire — à compléter
EOF

cat > "$PROJECT_DIR/tests/test_main.sh" << 'EOF'
#!/usr/bin/env bash
# Tests pour main.sh — à compléter
echo "Lancement des tests..."
EOF

cat > "$PROJECT_DIR/docs/README.md" << EOF
# Mon Projet

Créé le $(date '+%Y-%m-%d à %H:%M')

## Description

Projet d'apprentissage Bash.
EOF

cat > "$PROJECT_DIR/config/config.env" << 'EOF'
APP_NAME=mon_projet
VERSION=1.0
ENV=development
EOF

# Rendre les scripts exécutables
chmod +x "$PROJECT_DIR/src/main.sh"
chmod +x "$PROJECT_DIR/src/utils.sh"
chmod +x "$PROJECT_DIR/tests/test_main.sh"

# Afficher le résultat
echo "=== Projet créé avec succès ==="
echo ""
ls -R "$PROJECT_DIR"
