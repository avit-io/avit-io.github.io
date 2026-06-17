---
title: "Pattern matching, eliminatori e conservatività"
date: 2026-06-17
abstract: >
  Cosa Agda aggiunge alla MLTT, e perché senza K non aggiunge nulla di
  logicamente nuovo. Il pattern matching dipendente è strettamente più ricco
  come linguaggio di definizione, ma la sua forza logica dipende da K: con
  l'eliminazione standard dimostra l'assioma K, che J non dimostra; sotto
  `--without-K` ogni definizione è traducibile in MLTT con J più gli induttivi
  standard. Quest'ultimo è un risultato metateorico — un teorema sulla teoria,
  non dimostrabile al suo interno.
---

**In sintesi.** Nella teoria dei tipi di Martin-Löf un tipo induttivo viene con i suoi
eliminatori canonici e le rispettive ι-rule; le funzioni si definiscono applicandoli.
Agda offre invece un costrutto di definizione per clausole — il pattern matching
dipendente — che è strettamente più ricco come *linguaggio di definizione*. La domanda
è se questa ricchezza si traduca anche in maggiore forza *logica*. La risposta dipende
da K: con l'eliminazione standard il pattern matching dimostra l'assioma K, che J non
dimostra; sotto `--without-K` ogni definizione è invece traducibile in MLTT con J più
gli induttivi standard. Quest'ultimo fatto è un risultato *metateorico*: un teorema
sulla teoria, non dimostrabile al suo interno.

## 1. Punto di partenza: gli eliminatori di ℕ

In *The Little Typer* e nella tradizione di Martin-Löf, un tipo induttivo è specificato
da un pacchetto fisso di regole: una **formation rule** (ℕ è un tipo), le
**introduction rule** (i costruttori `zero` e `suc`), una sola **elimination rule** che
postula l'esistenza di un combinatore con un certo tipo, e le **ι-rule** che dicono come
quel combinatore calcola su ciascun costruttore. Per i naturali, l'eliminatore dipendente
fondamentale è l'induzione:

```agda
ind-Nat : (P : ℕ → Set) → (n : ℕ)
        → P zero
        → ((k : ℕ) → P k → P (suc k))
        → P n
ind-Nat P zero    b s = b
ind-Nat P (suc n) b s = s n (ind-Nat P n b s)
```

Gli altri tre eliminatori del libro sono casi degeneri, ottenuti collassando il *motive*
dipendente `P` in uno costante e scartando ciò che non serve:

```agda
rec-Nat   : {X : Set} → ℕ → X → (ℕ → X → X) → X
rec-Nat   n b s = ind-Nat (λ _ → X) n b s

iter-Nat  : {X : Set} → ℕ → X → (X → X) → X
iter-Nat  n b s = ind-Nat (λ _ → X) n b (λ _ ih → s ih)

which-Nat : {X : Set} → ℕ → X → (ℕ → X) → X
which-Nat n b s = ind-Nat (λ _ → X) n b (λ k _ → s k)
```

La gerarchia è netta: `ind-Nat` è la versione dipendente di `rec-Nat`; `iter-Nat` è
`rec-Nat` che ignora il predecessore; `which-Nat` è il caso senza vera ricorsione. Tutto
deriva dall'unico eliminatore dipendente.

## 2. L'eliminatore generico: ind-W

Si può salire di un livello: invece di un eliminatore *per ℕ*, uno generico parametrico
nel funtore, di cui `ind-Nat` è un'istanza. È l'eliminatore dei tipi W, le algebre
iniziali dei funtori polinomiali. Questa è la versione "alla J" feconda: un solo
eliminatore dipendente, esattamente come J è l'unico eliminatore della famiglia identità.

```agda
data W (S : Set) (P : S → Set) : Set where
  sup : (s : S) → (P s → W S P) → W S P

ind-W : {S : Set} {P : S → Set}
      → (M : W S P → Set)
      → ((s : S) (f : P s → W S P)
           → ((p : P s) → M (f p)) → M (sup s f))
      → (w : W S P) → M w
ind-W M step (sup s f) = step s f (λ p → ind-W M step (f p))
```

Codificando ℕ come `W Bool (λ b → if b then ⊤ else ⊥)` — `zero` ha zero figli, `suc` ne
ha uno — si recupera `ind-Nat` come istanza di `ind-W`. È il senso preciso in cui un
unico eliminatore generico genera tutta la famiglia.

## 3. Le ι-rule non sono pattern matching

Le due righe di `ind-Nat` *sembrano* due clausole di pattern matching, ma il loro statuto
è diverso. Sono le ι-rule di un *unico* combinatore la cui esistenza è postulata dalla
elimination rule. Il "pattern" `zero` / `suc n` non è selezione generica: è notazione
fissa per "l'argomento principale è nella forma del costruttore i-esimo". Non c'è un
motore che ispeziona termini; ci sono due equazioni cablate. Non si possono scrivere
pattern diversi, annidati, o su due argomenti insieme. La forma è determinata una volta
per tutte dai costruttori.

## 4. Il pattern matching di Agda è un linguaggio sopra gli eliminatori

Quando in Agda si scrive una funzione per clausole, Agda *non* aggiunge nuovi assiomi. Le
clausole sono compilate in un **case tree** che si traduce in applicazioni degli
eliminatori canonici. Questa traduzione è un teorema — il risultato di Goguen, McBride e
McKinna (*Eliminating Dependent Pattern Matching*, 2006) — non magia dell'implementazione.

Quindi l'intuizione "Agda lo pone come base" è corretta a livello di *interfaccia*, ma a
livello di *fondamenti* il pattern matching resta derivato. La differenza con *The Little
Typer* è di esposizione: TLT fa scrivere a mano il bytecode (gli eliminatori), Agda fa
scrivere il linguaggio ad alto livello e compila.

## 5. Dove il pattern matching eccede gli eliminatori: K

C'è però un punto in cui il pattern matching di *default* dimostra cose che gli
eliminatori *non* dimostrano. L'esempio canonico è l'assioma K:

```agda
K : {A : Set} {x : A} (P : x ≡ x → Set)
  → P refl → (p : x ≡ x) → P p
K P pr refl = pr
```

Questa clausola passa il typecheck con il pattern matching standard, ma **non è derivabile
da J**. J non consente di matchare `refl` su un'identità `x ≡ x` con entrambi gli estremi
fissi: richiede che un estremo sia generico. Il pattern matching libero usa
l'*unificazione* per identificare i due `x`, assumendo così implicitamente l'unicità delle
dimostrazioni di identità. Per questo esiste `--without-K`: spegne esattamente i passi di
unificazione che vanno oltre J. In HoTT, dove K è falso, la differenza è sostanziale.

## 6. Il guadagno che resta sotto --without-K

Tolto K, il pattern matching è ancora più ricco del semplice "applica J" — ma come
*linguaggio*, non come *teoria*. Il raffinamento di Cockx, Devriese e Piessens
(*Eliminating dependent pattern matching without K*, 2014) precisa entrambe le cose. Il
potere extra ha due fonti:

1. **Unificazione con iniettività e disgiunzione dei costruttori.** L'eliminazione dei
   casi impossibili (pattern assurdo `()`) e l'unificazione degli indici usano che i
   costruttori sono iniettivi e disgiunti — proprietà *derivabili* da J, ma che il motore
   applica automaticamente e in modo annidato.
2. **Ricorsione well-founded sul case tree.** Le ricorsioni strutturali annidate o su più
   argomenti corrispondono a *torri* di eliminatori, non a un singolo eliminatore; il case
   tree certifica che la torre esiste e termina.

**La distinzione cruciale.** "Più espressivo di applicare J" ha due letture:

- **(A) come linguaggio di definizione — sì.** Esistono funzioni che il pattern matching
  definisce direttamente e che con J richiederebbero lemmi ausiliari espliciti
  (iniettività, no-confusion, accessibilità). Il costrutto va oltre.
- **(B) come teoria — no.** Il teorema è un risultato di *conservatività*: ogni
  definizione `--without-K` è traducibile in MLTT con J più gli induttivi standard. Non si
  può dimostrare con essa una proposizione indimostrabile in MLTT+J. Il guadagno è di
  ergonomia e accesso diretto a costruzioni derivabili, non di forza logica.

### Quadro di sintesi

|              | ι-rule / The Little Typer        | Pattern matching Agda                       |
|--------------|----------------------------------|---------------------------------------------|
| Clausole     | Una per costruttore, cablata     | Quante si vuole, annidate, multi-argomento  |
| Selezione    | Notazione fissa per il costruttore | Motore di unificazione generico           |
| Forza logica | Esattamente l'eliminatore        | Eliminatore + K (salvo `--without-K`)       |
| Statuto      | Primitiva del tipo               | Macro compilata negli eliminatori           |

## 7. Perché la conservatività è metateorica

Il fatto che `--without-K` non cambi l'espressività in senso (B) **non lo si dimostra
dall'interno della teoria: lo si dimostra in una metateoria**. La conservatività è un
enunciato *sulla* teoria — "ogni derivazione per pattern matching ammette una traduzione
in MLTT+J che preserva il giudizio" — e quantifica su derivazioni e termini come oggetti
sintattici. Dall'interno non sarebbe nemmeno formulabile naturalmente: occorrerebbe
riflettere la traducibilità sintattica come oggetto della teoria.

C'è anche un ostacolo di principio: per il secondo teorema di Gödel una teoria
sufficientemente forte non dimostra la propria coerenza, e i risultati di conservatività
di una teoria rispetto a sé hanno lo stesso carattere autoriferito. La prova di Cockx,
Devriese e Piessens procede infatti nel modo metateorico corretto: **costruisce** la
traduzione dal pattern matching agli eliminatori e ne **verifica** la correttezza nella
metateoria, esibendo per ogni definizione il termine MLTT+J corrispondente. La meaning
explanation resta il fondamento; Agda fornisce un compilatore verso quel fondamento molto
più ricco di ciò che si scriverebbe a mano, ma che — senza K — non eccede ciò che il
fondamento giustifica.

## 8. Ricapitolando

Rispetto agli eliminatori di ℕ: `ind-Nat`, `rec-Nat`, `iter-Nat`, `which-Nat` si scrivono
in Agda per pattern matching e sembrano primitivi, ma sotto `--without-K` sono ciascuno
una traduzione in `ind-W`/J. Il pattern matching ha solo risparmiato di scrivere la torre
di eliminatori a mano. Il vantaggio è (A); la base resta la meaning explanation. La frase
"Agda introduce un pattern matching completo anche con J e non K" è corretta letta come
(A) — un *modo di definizione* che MLTT "a eliminatori nudi" non ha — e scorretta letta
come (B), perché il teorema di traduzione fissa l'equiespressività logica. E questo
teorema, lo si è detto, vive nella metateoria.

---

### Riferimenti essenziali

- Goguen, McBride, McKinna — *Eliminating Dependent Pattern Matching* (2006).
- Cockx, Devriese, Piessens — *Eliminating dependent pattern matching without K* (ICFP 2014).
- Martin-Löf — *Intuitionistic Type Theory* (1984), per le meaning explanations.
