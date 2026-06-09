# avit-io.github.io

```
nix develop
hugo server -D        # http://localhost:1313
```

## Contenuto

| cartella | uso |
|---|---|
| `content/essays/` | articoli formali |
| `content/blog/` | post più brevi |
| `content/projects/_index.md` | lista progetti |

Nuovo essay:

```
content/essays/mio-titolo.md
```

```yaml
---
title: "Titolo"
date: 2026-06-09
abstract: "..."
---
```

## Snippet Agda

La shell include `agda` 2.8.0 con stdlib 2.3 già disponibile (primo `nix develop`
copia la stdlib in `~/.cache/piforge/`).

```
agda --html --html-dir=static/agda MyFile.agda
```

Poi nel post:

```html
{{< rawhtml >}}
<pre class="Agda">
  <!-- incolla contenuto del <pre> generato da agda --html -->
</pre>
{{< /rawhtml >}}
```

## Build

```
hugo --minify          # output in public/
```

Il deploy è automatico via GitHub Actions al push su `main`.
Prerequisito: in *Settings → Pages → Source* selezionare **GitHub Actions**.
