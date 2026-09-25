# Re-chiffre src/index.html (non versionné) vers index.html avec le sel de .staticrypt.json.
# Mot de passe : variable STATICRYPT_PASSWORD si elle est définie, sinon saisie interactive.
.PHONY: build publish

build:
	npx --yes staticrypt@3 src/index.html -d . --short --remember 30 \
		--template-title "Compte joint" --template-instructions "Mot de passe requis"
	@! grep -q "Compte joint : où on en est" index.html || (echo "ERREUR : index.html contient du texte en clair" && exit 1)

publish: build
	git add index.html .staticrypt.json
	git commit -m "Mise à jour du bilan compte joint"
	git push
