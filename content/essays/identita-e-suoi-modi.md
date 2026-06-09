---
title: "L'identità e i suoi modi: uguaglianza giudizionale, definitoria e congruenza in Agda"
date: 2026-06-09
abstract: >
  Ci sono almeno tre cose che chiamiamo "uguaglianza" nella
  teoria dei tipi. Confonderle è il modo più rapido per
  perdere il filo di una prova. Questo articolo le distingue
  dall'interno, mostrando che la congruenza non è un assioma
  aggiunto ma l'eliminatore dell'identità applicato a una
  famiglia particolare — e che tutto si regge sul contesto.
---

## Tre piani, una giuntura

In MLTT ci sono almeno tre nozioni di uguaglianza, e confonderle produce errori
che non sono sintattici ma concettuali — si lavora al livello sbagliato.

La stringa `[] ++ ys ≡ ys` concentra tutte e tre. La prima clausola di `_++_`
è `[] ++ ys = ys`: non un'equazione all'interno del sistema, ma una regola di
riduzione del meta-livello. Quando il type-checker incontra `[] ++ ys`, lo porta
a `ys` per puro passo computazionale, senza che nessun termine-prova sia stato
costruito. Questa è l'**uguaglianza giudizionale**: una relazione tra il riduttore
e un'espressione. Decidibile. Proof-irrelevant per costruzione — la domanda
"chi abita questa uguaglianza?" non si pone, perché non c'è un tipo che la ospiti.

L'**uguaglianza definitoria** è la conseguenza esplicita del giudizionale: due
termini sono definitoriamente uguali se il riduttore li porta alla stessa forma
normale. Il type-checker li tratta come intercambiabili in qualsiasi contesto di
tipo. Se un goal richiede `ys`, il termine `[] ++ ys` è già accettabile — non
perché qualcuno abbia costruito una prova, ma perché i due termini condividono
la stessa forma normale. L'identità definitoria non ha un tipo, non abita nulla,
non richiede un testimone. È la relazione invisibile che governa
l'interscambiabilità nel type-checker.

Poi c'è l'**identità proposizionale**: `[] ++ ys ≡ ys` come tipo. Ora
l'uguaglianza ha una forma — è un oggetto del sistema, non una relazione del
riduttore con le espressioni. Il tipo `[] ++ ys ≡ ys` ha abitanti: in questo
caso specifico, `refl` lo chiude. Ma il fatto che `refl` lo chiuda non è banale
— accade perché i due lati sono definitoriamente uguali. La giuntura
proposizionale si apre sopra quella definitoria: il terzo piano sorge dal secondo.

Tre livelli, dunque. Il giudizionale opera nel riduttore. Il definitorio è la
soglia: il confine dove il meta-livello diventa pertinente per l'utente. Il
proposizionale è il tipo: la copula recupera una forma che si può costruire,
trasportare, comporre. I tre non sono alternative — sono stratificati. Il secondo
presuppone il primo, il terzo presuppone il secondo.

Il confine tra definitorio e proposizionale è la giuntura di questo articolo:
dove la riduzione automatica si ferma e il termine-prova deve cominciare a
lavorare.

---

## refl non dimostra: riconosce

`refl : a ≡ a` è il solo costruttore dell'identità proposizionale. La sua
banalità apparente nasconde qualcosa di preciso.

Il type-checker accetta `refl : x ≡ y` se e solo se `x` e `y` sono
definitoriamente uguali. Non è `refl` a dimostrare che sono uguali: è la loro
uguaglianza definitoria a permettere che `refl` sia tipabile. L'ordine è questo,
non l'inverso.

Nell'articolo precedente `refl` compariva come copula congelata — il caso in cui
soggetto e predicato coincidono per giudizio, senza residuo computazionale.
Questa lettura va precisata: `refl` non costruisce nulla. Non trasporta. Non
combina. `refl` certifica che il riduttore ha già fatto il lavoro: i due lati
condividono la stessa forma normale prima ancora che si apra il tipo `_≡_`.

Le conseguenze pratiche sono immediate. Quando Agda accetta `refl` in risposta
a un buco, il buco non era davvero aperto — era aperto proposizionalmente ma già
chiuso definitoriamente. Il type-checker aveva già ridotto entrambi i lati alla
stessa forma normale; il buco era una finestra su qualcosa già deciso. `refl` non
chiude la giuntura: dichiara che era già chiusa.

Il caso base di `++-rightId` nell'articolo precedente segue esattamente questo
schema: la proposizione `[] ++ [] ≡ []` si chiude con `refl` perché `[] ++ []`
si riduce a `[]` per la prima clausola di `_++_`. Non c'è un termine-prova da
costruire — c'è il riconoscimento che il riduttore ha già trovato la forma comune.

Il contrario di `refl` è un'uguaglianza proposizionale che non cade sotto la
riduzione definitoria. `xs ++ [] ≡ xs`, per `xs` variabile, non si chiude con
`refl`: `_++_` è definita per ricorsione su `xs`, e il riduttore non sa come
ridurre `xs ++ []` quando `xs` è uno sconosciuto. Qui il piano proposizionale
deve lavorare dove quello definitorio si ferma.

---

## L'eliminatore J: aprire la giuntura congelata

L'identità proposizionale ha un solo costruttore: `refl`. Ne deriva che ha un
solo eliminatore: `J`. Non si ottiene informazione da un termine di tipo `a ≡ b`
spezzandolo in componenti — non ha struttura interna visibile nel senso in cui
ce l'hanno le liste. Lo si usa fornendo un *motivo* e un caso base, e lasciando
che `J` trasporti il risultato lungo il testimone dell'identità.

```agda
module Identity where

open import Relation.Binary.PropositionalEquality
  using (_≡_; refl)

J : (A : Set) (a : A)
  → (P : (x : A) → a ≡ x → Set)
  → P a refl
  → (x : A) → (p : a ≡ x) → P x p
J A a P pr .a refl = pr
```

La clausola `.a refl` è il cuore di tutto. Il dot pattern `.a` segnala che quando
`p` è `refl`, il tipo di `p` forza `x` ad essere definitoriamente uguale ad `a`.
Non è un vincolo aggiunto — è la conseguenza diretta del fatto che `refl : a ≡ a`
e della sua parametrizzazione. La regola di computazione è: `J A a P pr a refl = pr`.
Il caso base, e nient'altro.

Il motivo `P : (x : A) → a ≡ x → Set` è una famiglia di tipi parametrizzata sia
dall'altro estremo `x` sia dal testimone `p : a ≡ x`. Questa doppia
parametrizzazione è ciò che rende `J` sufficiente: il motivo può dipendere da
dove si arriva (`x`) e da come ci si arriva (`p`). In MLTT classico il testimone
non porta informazione aggiuntiva — un'identità è un'identità, non ha struttura
interna su cui discriminare. Ma la famiglia può dipendere da `p` come variabile
libera anche senza discriminarla: è la generalità che garantisce la forza di `J`.

`J` non smonta l'identità nel senso di aprirla. La usa come strumento di
trasporto: dato un fatto che vale nel caso base (`x = a`, testimoniato da `refl`),
lo estende a qualsiasi `x` raggiunto da `a` tramite un'identità. La copula non
viene smontata — orienta il contesto in cui il trasporto avviene.

---

## cong, sym, trans come derivazioni

Nessuno dei tre è un primitivo. Sono istanze di `J` con scelte diverse del motivo.

**`cong`**

```agda
-- proposizione aperta
cong : {A B : Set} {x y : A}
     → (f : A → B) → x ≡ y → f x ≡ f y
cong {x = x} f p = ?
```

Il motivo deve descrivere cosa si vuole all'altra estremità del trasporto.
Partendo da `x`, con `p : x ≡ y`, si vuole `f x ≡ f y`. Il motivo è quindi
`λ y _ → f x ≡ f y`: per ogni `y` raggiunto da `x`, la famiglia è `f x ≡ f y`.
Il caso base — `y = x`, `p = refl` — richiede `f x ≡ f x`, che è `refl`.

```agda
cong : {A B : Set} {x y : A}
     → (f : A → B) → x ≡ y → f x ≡ f y
cong {x = x} f p =
  J _ x (λ y _ → f x ≡ f y) refl _ p
```

L'apparente facilità di `cong` nasconde la struttura del motivo: non è `f` che
porta l'uguaglianza — è `J` che trasporta, usando `f` per costruire la famiglia
verso cui si trasporta. La copula passa attraverso `f` perché il motivo la include
nella forma del tipo di destinazione.

**`sym`**

```agda
-- proposizione aperta
sym : {A : Set} {x y : A} → x ≡ y → y ≡ x
sym {x = x} p = ?
```

Il motivo deve descrivere l'inversione. Partendo da `x`, si vuole arrivare a
`y ≡ x`. Il motivo è `λ y _ → y ≡ x`: il punto fisso `x` compare a destra. Il
caso base richiede `x ≡ x`, che è `refl`.

```agda
sym : {A : Set} {x y : A} → x ≡ y → y ≡ x
sym {x = x} p =
  J _ x (λ y _ → y ≡ x) refl _ p
```

Il motivo ha già incorporato l'inversione nella forma del tipo di destinazione.
`J` non sa che si sta invertendo qualcosa — trasporta lungo il motivo che gli è
stato dato. La nozione di inversione è nel design della famiglia, non nel
meccanismo di eliminazione.

**`trans`**

```agda
-- proposizione aperta
trans : {A : Set} {x y z : A} → x ≡ y → y ≡ z → x ≡ z
trans {x = x} p q = ?
```

Qui il motivo si applica alla seconda identità `q : y ≡ z`. Il punto fisso è
`y`; il punto variabile è `z`. La cosa da dimostrare per ogni `z` raggiunto da
`y` è `x ≡ z`. Il caso base — `z = y`, `q = refl` — richiede `x ≡ y`, che è
esattamente `p`.

```agda
trans : {A : Set} {x y z : A} → x ≡ y → y ≡ z → x ≡ z
trans {x = x} p q =
  J _ _ (λ z _ → x ≡ z) p _ q
```

La differenza essenziale rispetto a `cong` e `sym`: il caso base non è `refl`
ma `p`, una copula già costruita. `J` trasporta `p` lungo `q`, estendendo
l'estremità destra. La copula già costruita entra come punto di partenza del
trasporto, e il secondo estremo viene portato da `y` a `z`.

In tutti e tre i casi il pattern è identico: scegliere un motivo che descriva il
tipo del risultato in funzione del punto variabile, fornire il caso base, lasciare
che `J` produca il risultato per qualsiasi testimone. Il motivo è la descrizione
della proprietà da trasportare; `J` è la macchina che la istanzia a partire dal
caso base. Non c'è altra struttura da usare sull'identità proposizionale —
l'eliminatore è uno solo, e questo basta.

---

## Il contesto come orizzonte dell'identità

Ogni giudizio in MLTT vive in un contesto `Γ`. Questo vale anche per l'identità
proposizionale: `Γ ⊢ p : a ≡ b` non è una relazione tra `a` e `b` in assoluto
— è una relazione tra `a` e `b` dentro `Γ`.

Il contesto determina cosa può essere definitoriamente uguale. Due termini che
non si riducono alla stessa forma normale in `Γ` potrebbero farlo in un contesto
esteso che vincola una variabile. Il pattern matching nelle prove fa esattamente
questo: quando `xs` viene vincolato a `[]`, il contesto si estende con un vincolo
che rimuove l'ambiguità, e le riduzioni definitorie diventano disponibili dove
prima erano bloccate da una variabile libera. Il piano definitorio si allarga ogni
volta che il pattern matching restringe il piano proposizionale.

`J` fa lo stesso in astratto: prende un'identità come ipotesi nel contesto e la
usa per trasportare il motivo. Non importa come è stata costruita `p : a ≡ b` —
importa che sia nel contesto, disponibile come guida. La copula proposizionale non
è una relazione tra oggetti isolati: è sempre relativa all'orizzonte che la ospita.

Questo è il senso in cui la giuntura dipende dal contesto: cambiare il contesto
può rendere dimostrabile ciò che non lo era, può far collassare una prova
proposizionale in una riduzione definitoria, può aprire motivi che altrove sarebbero
vuoti. L'identità proposizionale non è la verità di un fatto eterno — è la
saturazione di una giuntura in un orizzonte dato.

Il saggio [*I tempi della copula*](https://github.com/avit-io/tempi-della-copula)
distingue tra copula congelata e copula coniugata. In MLTT questi si corrispondono
ai due piani fondamentali: l'uguaglianza giudizionale/definitoria, dove la copula
è già decisa prima che si apra il tipo, e l'identità proposizionale, dove la copula
diventa un termine manipolabile tramite `J`. Non serve un terzo piano. `cong`,
`sym`, `trans` sono istanze del secondo; i casi base con `refl` sono il confine
dove il secondo piano tocca il primo — dove la copula coniugata degenera in copula
congelata perché l'orizzonte non offre resistenza.

Il motivo di `J` — la famiglia `P : (x : A) → a ≡ x → Set` — è sempre una
domanda: quale proprietà di `x` si vuole stabilire, e quale parte di essa dipende
dal testimone dell'identità? La risposta a questa domanda è design, non tecnica.
Ogni prova che usa `J` è implicitamente una risposta, e la risposta determina
tutto ciò che segue.
