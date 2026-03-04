# Mini-projet : Vérificateur de site web

**Durée estimée : 30 minutes**

---

## Objectif

Créer un script `verifier_site.sh` qui vérifie si un site web est accessible en testant son code de réponse HTTP.

---

## Spécifications

### Arguments

- Le script prend **une URL** en argument (ex. : `https://example.com`)
- Si aucun argument n'est fourni : afficher un message d'erreur et quitter

### Vérification HTTP

Utilisez `curl` pour récupérer le code de statut HTTP :

```bash
curl -s -o /dev/null -w "%{http_code}" "URL"
```

- `-s` : mode silencieux (pas de progression)
- `-o /dev/null` : ne pas sauvegarder le contenu
- `-w "%{http_code}"` : afficher uniquement le code HTTP

### Messages à afficher selon le code

| Code HTTP | Message à afficher |
|-----------|-------------------|
| 200 | « Site accessible (OK) » |
| 301 ou 302 | « Redirection détectée » |
| 404 | « Page non trouvée (404) » |
| 500 | « Erreur serveur (500) » |
| Autres | « Code HTTP : XXX » (afficher le code) |

### Exemples d'utilisation

```bash
./verifier_site.sh https://google.com
# → Site accessible (OK)
# ou
# → Redirection détectée
# etc.

./verifier_site.sh https://example.com/404
# → Page non trouvée (404)

./verifier_site.sh
# → Erreur : veuillez fournir une URL en argument
```

---

## Conseils

1. Stockez le résultat de `curl` dans une variable : `code=$(curl -s -o /dev/null -w "%{http_code}" "$url")`
2. Utilisez `case` ou `if/elif/else` pour traiter les différents codes
3. Vérifiez que `curl` est installé (optionnel, pour aller plus loin)
4. Par défaut, `curl` ne suit pas les redirections : une URL qui renvoie 301 ou 302 donnera bien ce code. Pour tester 200, utilisez une URL qui répond directement (ex. : `https://google.com`).

---

## Critères de réussite

- [ ] Le script gère l'absence d'argument
- [ ] Le script utilise `curl` pour obtenir le code HTTP
- [ ] Les messages appropriés sont affichés pour 200, 301/302, 404, 500
- [ ] Les autres codes sont affichés de manière générique
