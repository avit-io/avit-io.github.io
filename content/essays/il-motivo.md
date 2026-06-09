---
title: "Il motivo: la forma del buco che guida la prova"
date: 2026-06-09
abstract: >
  Quando si usa l'eliminatore J, si fornisce un "motivo":
  una famiglia di tipi P : (x : A) → a ≡ x → Set.
  Non è un dettaglio tecnico. Il motivo è il contesto
  esteso scritto come tipo dipendente — e capire questa
  equivalenza è capire perché la ricorsione dipendente
  ha esattamente quella forma e non un'altra.
---

## Il motivo come residuo del buco

Supponiamo di voler derivare `cong` usando J direttamente, senza aiuto dalla libreria. Si comincia con la firma e un buco al posto dell'argomento del motivo:

```agda
module Motive where

open import Relation.Binary.PropositionalEquality
  using (_≡_; refl)

J : (A : Set) (a : A)
  → (P : (x : A) → a ≡ x → Set)
  → P a refl
  → (x : A) → (p : a ≡ x) → P x p
J A a P pr .a refl = pr

-- proposizione aperta
cong' : {A B : Set} {x y : A} (f : A → B) → x ≡ y → f x ≡ f y
cong' {x = x} f p = J _ x {- ? -} refl _ p
```

Il buco al posto del motivo ha tipo:

```
(z : A) → x ≡ z → Set
```

Questo non è un tipo scelto arbitrariamente da J. È la forma che il buco *deve* avere perché il contesto sia esteso correttamente — perché J sappia, per ogni `z` raggiungibile da `x`, quale tipo si vuole abitare lì. Il motivo non si fornisce a J: si ricava dalla forma del buco che J espone, una volta passati il tipo e il punto di partenza.

La domanda che il buco pone è precisa: "cosa voglio dimostrare quando mi trovo in `z`, con un testimone `x ≡ z`?" Per `cong`, la risposta è immediata — si vuole `f x ≡ f z`. Il buco si chiude con `λ z _ → f x ≡ f z`, e il caso base — `z = x`, testimone `refl`, goal `f x ≡ f x` — si satura con `refl`:

```agda
cong' : {A B : Set} {x y : A} (f : A → B) → x ≡ y → f x ≡ f y
cong' {x = x} f p = J _ x (λ z _ → f x ≡ f z) refl _ p
```

Il motivo non è stato inventato — è stato letto. La forma del buco era già la risposta, in attesa di essere riconosciuta.

---

## Contesto esteso e famiglia di tipi: la stessa cosa

Il tipo del motivo è:

$$P : (x : A) \to a \equiv x \to \mathsf{Set}$$

Scritto come giudizio sequente, con `a : A` fissato nel contesto $\Gamma$:

$$\Gamma,\; x : A,\; p : a \equiv x \;\vdash\; C : \mathsf{Set}$$

Questi due modi di scrivere non sono presentazioni alternative per pubblici diversi. Sono due direzioni di lettura dello stesso oggetto.

La famiglia di tipi è il contesto visto dall'*esterno*: `P` è una funzione che riceve `x` e il testimone `p`, e produce un tipo. Il contesto esteso è la famiglia vista dall'*interno*: il tipo `C` vive in un ambiente di tipizzazione che ha già `x` e `p` disponibili come ipotesi, non come argomenti da ricevere. Il tipo `C` dipende da entrambi — può menzionarli, può ignorarli, ma li ha nel contesto.

Il passaggio da uno all'altro è la regola →-I:

$$\frac{\Gamma,\; x : A,\; p : a \equiv x \;\vdash\; C : \mathsf{Set}}{\Gamma \;\vdash\; \lambda x\, p \to C \;:\; (x : A) \to a \equiv x \to \mathsf{Set}}$$

La λ non è zucchero sintattico. È la corrispondenza tra avere una variabile nel contesto come ipotesi e riceverla come argomento di una funzione — la stessa corrispondenza che governa →-I in tutta la teoria dei tipi. Ogni volta che si scrive `λ x p → C`, si prende il contesto esteso `x : A, p : a ≡ x ⊢ C` e lo si legge dall'esterno come funzione. Ogni volta che si estende il contesto con `x : A, p : a ≡ x`, si descrive il dominio di quella λ.

Il codice lo mostra nel caso di `subst`:

```agda
-- Contesto esteso per subst:
--   Γ, y : A, _ : x ≡ y ⊢ P y : Set
-- Letto dall'esterno come famiglia:
--   λ y _ → P y : (y : A) → x ≡ y → Set

subst : {A : Set} (P : A → Set) {x y : A} → x ≡ y → P x → P y
subst P {x} p px = J _ x (λ y _ → P y) px _ p
```

Il motivo `λ y _ → P y` è il contesto esteso `y : A, _ : x ≡ y ⊢ P y` scritto come funzione. La λ segna esattamente il confine: a sinistra, il contesto con le sue due variabili; a destra, la famiglia che le riceve come argomenti. Passare dall'uno all'altro è meccanico — si applica →-I — ma non è banale: è la regola che rende visibile la corrispondenza tra astrazione e ipotesi.

---

## subst: il motivo come trasporto esplicito

`subst` è il caso in cui il motivo ignora il secondo argomento:

```agda
-- λ y _ → P y
-- Il testimone _ : x ≡ y è nel contesto ma non compare nel tipo.
-- Il trasporto dipende solo dalla destinazione y, non da come ci si arriva.
```

Questo è il caso più comune nella pratica, perché la maggior parte delle proprietà dipende solo dal punto di arrivo. Ma il contesto esteso porta entrambe le variabili — sia `y` che il testimone `p` — anche quando la famiglia ne usa solo una. Il contesto è sempre pieno; è la famiglia che può essere parzialmente dipendente.

Il caso opposto — in cui il motivo usa davvero il secondo argomento — rivela la piena forza di J. La firma lo permette: `P : (x : A) → a ≡ x → Set` riceve sia l'estremità che il testimone, e il tipo `C` può dipendere da entrambi come variabili libere nel contesto. Quando dipende solo dall'estremità, si ottiene `subst`. Quando dipende anche dal testimone, si ottiene qualcosa di più.

Lo schema di K illustra questo estremo nella sua forma più pura:

```agda
-- K : (a : A) → (P : a ≡ a → Set) → P refl → (p : a ≡ a) → P p
-- Qui il motivo dipende SOLO dal testimone p, non dall'estremità.
-- Entrambe le estremità sono fisse (entrambe sono a);
-- ciò che varia è la struttura della prova stessa.
```

K non è derivabile da J in MLTT. Questo non è una lacuna tecnica — è la traccia di una distinzione fondamentale. Il contesto esteso `y : A, p : a ≡ y ⊢ C` mette `p` a disposizione nel tipo `C`, ma non garantisce che `p` sia osservabile come struttura discriminabile. J trasporta il motivo lungo `p`; non consente di fare pattern matching su `p` come se fosse un dato con componenti interne. K richiederebbe esattamente questo: discriminare tra prove diverse della stessa identità.

Il fatto che K non si derivi dice: avere `p` nel contesto esteso non è lo stesso che poterlo aprire. Il contesto mette `p` a disposizione; J usa `p` come guida per il trasporto. Ma l'interno di `p` — se ha un interno — resta chiuso. La dipendenza dal testimone nell'esteso contesto è reale, ma la sua osservabilità è limitata.

---

## Il motivo nel pattern matching dipendente

In Agda, fare pattern matching su `p : a ≡ b` con il caso `refl` non è una semplice discriminazione strutturale. `refl` è il solo costruttore di `_≡_`, e il suo tipo è `a ≡ a`. Quando il type-checker accetta `refl` come pattern di `p : a ≡ b`, unifica `b` con `a` nel contesto corrente.

Questa unificazione è il motivo, scelto implicitamente.

```agda
-- Pattern matching diretto: il motivo è implicito.
-- Agda astrae y e p dal goal P y,
-- costruisce la famiglia λ y _ → P y,
-- la applica, restituisce il goal ridotto.

transport-match : {A : Set} (P : A → Set) {x y : A} → x ≡ y → P x → P y
transport-match P refl px = px
-- Nel caso refl: y ↦ x, goal P x, saturato da px.
```

Il passaggio è meccanico ma non banale. Quando Agda incontra `refl` come pattern di `p : x ≡ y`, deve calcolare: il goal corrente dipende da `y` in modo astraibile? Se sì, costruisce il motivo automaticamente — `λ y _ → P y` — lo applica a `x` e `refl`, e restituisce il goal ridotto `P x`. Se la dipendenza non è visibile — perché `y` è già stato ridotto a un termine specifico nel contesto, o perché compare in una posizione che non si presta alla generalizzazione — il type-checker fallisce.

Il primo rimedio è `with`: portare la variabile rilevante sotto esame esplicito, forzando Agda a costruire il motivo prima del matching.

```agda
-- With: il motivo resta implicito, ma la generalizzazione è forzata.
-- `with p` chiede ad Agda di astrarre p (e y, tramite p) dal goal.

transport-with : {A : Set} (P : A → Set) {x y : A} → x ≡ y → P x → P y
transport-with P {x} p px
  with p
... | refl = px
-- Agda costruisce il motivo λ y _ → P x → P y.
-- Nel caso refl: y ↦ x, goal P x → P x, saturato da px.
```

Quando anche `with` non basta — quando il tipo del goal non dipende visibilmente da `y` dopo le riduzioni che il compilatore ha già compiuto — si scende a J con il motivo scritto nella forma che il buco avrebbe mostrato:

```agda
-- J con motivo esplicito: quello che il pattern matching aveva calcolato.

transport-J : {A : Set} (P : A → Set) {x y : A} → x ≡ y → P x → P y
transport-J P {x} p px = J _ x (λ y _ → P y) px _ p
--                                ^^^^^^^^^^^
--                                il motivo: λ y _ → P y
--                                è il contesto esteso letto dall'esterno
```

Le tre versioni sono la stessa operazione a livelli di esplicitezza crescente. Nel primo caso il motivo è completamente nascosto nel meccanismo del pattern matching. Nel secondo è reso necessario dalla struttura del `with`. Nel terzo è scritto nella forma che J richiede — la stessa forma che il buco del primo caso già mostrava, se si leggeva il goal prima di riempirlo.

L'annotazione esplicita non aggiunge informazione nuova: rende visibile il contesto esteso che il type-checker aveva già costruito prima di restituire il goal ridotto. E quel contesto esteso — `y : A, p : x ≡ y ⊢ P y` — è identico al motivo `λ y _ → P y`, salvo la direzione di lettura.

---

## La forma del buco è già la risposta

Il primo articolo diceva: il buco è la copula mancante. Il secondo: la copula si elimina tramite J, che richiede un motivo. Qui: il motivo è il contesto esteso — e il contesto esteso è la forma che il buco mostra all'utente.

Non c'è una distanza tra questi tre passaggi. Sono lo stesso oggetto visto in sequenza da angolazioni diverse.

Quando si apre il buco del motivo in `J _ x {- ? -} refl _ p`, il goal che Agda mostra è `(z : A) → x ≡ z → Set`. Non si deve trovare il motivo e poi riempire il buco — si legge il goal e il motivo è già lì, nella forma del tipo. Il buco non chiede un termine qualunque del tipo giusto: chiede la risposta alla domanda "cosa dimostro, per ogni `z` raggiungibile da `x`?" E quella domanda è già inscritta nella forma del buco stesso.

Questo rovescia il modo abituale di pensare alla costruzione di una prova. Non si parte da un motivo scelto a priori per poi costruire la prova che lo realizza. Il contesto accumulato fino a quel punto — le ipotesi disponibili, le variabili introdotte, le identità acquisite — determina già la forma del motivo. Il motivo non precede la prova: è la prova vista dal lato del tipo.

Un termine di tipo `P a refl` non porta traccia del contesto `x : A, p : a ≡ x` che ha guidato la sua costruzione. Non c'è nei nomi delle variabili, non c'è nell'albero sintattico del termine, non c'è in nessun annotazione che il type-checker conservi. Ma quel contesto era presente nella forma del buco — nella forma di `(x : A) → a ≡ x → Set` come tipo del buco vuoto del motivo. Quando il termine ha chiuso il buco, il contesto non è scomparso: è diventato la struttura del tipo che il termine abita.

Nei *Tempi della copula*, la copula che tace non tace perché è assente. Tace perché è diventata la struttura stessa dell'enunciato — la giuntura non è sparita, si è fatta forma. Così il contesto esteso non appare nel termine finale: non perché sia stato dimenticato, ma perché è diventato il tipo. Il motivo non è un argomento aggiunto alla prova dall'esterno: è l'impronta del contesto nel tipo, la forma della domanda già inscritta nell'enunciato che la risposta deve saturare.
