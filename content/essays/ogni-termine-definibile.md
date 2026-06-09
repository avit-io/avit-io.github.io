---
title: "Ogni termine definibile porta la sua relazione"
date: 2026-06-09
abstract: >
  Il teorema di Lindenbaum-Tarski — ogni insieme definibile è chiuso sotto
  gli automorfismi della struttura — fallisce in ITT per i tipi con più di
  un elemento. Martin-Löf sostituisce il quantificatore universale sugli
  isomorfismi con una relazione canonica associata a ogni tipo: non invarianza
  sotto tutte le biiezioni, ma covarianza rispetto alla relazione propria del tipo.
  Il teorema risultante — ogni termine definibile è relation-invariant —
  si dimostra costruendo un modello semantico bidimensionale per ricorsione
  sulle regole del linguaggio; per Bool, il refl semantico e il refl proposizionale
  coincidono esattamente.
---

## Il teorema che non regge

Il teorema di Lindenbaum e Tarski dice, nella versione standard:
ogni predicato definibile in una struttura è invariante sotto i suoi automorfismi.
Se σ : M ≅ M è un automorfismo e M ⊨ φ(a), allora M ⊨ φ(σ(a)).
La definibilità garantisce l'invarianza: nessun termine del linguaggio può distinguere
un elemento dalla sua immagine sotto un automorfismo.

In ITT la versione analoga sarebbe: per ogni tipo A, ogni automorfismo σ : A ≅ A,
e ogni predicato definibile P : A → Set, vale P(a) ≃ P(σ(a)).

Bool ha un automorfismo canonico: `not`. Mappa `true` su `false` e viceversa,
ed è la propria inversa. Se il teorema di Tarski reggesse in ITT, nessun predicato
definibile su Bool potrebbe distinguere `true` dalla sua immagine sotto `not`. Ma lo fa
immediatamente:

```agda
module Tarski where

open import Data.Bool using (Bool; not; true; false)
open import Data.Empty using (⊥)
open import Relation.Binary.PropositionalEquality using (_≡_; refl)

P : Bool → Set
P b = b ≡ true

_ : P true
_ = refl

_ : P (not true) → ⊥
_ = λ ()
```

`P true` è abitata da `refl`. `P (not true)` è `P false` è `false ≡ true`:
non abitata. La stessa proprietà definibile separa `true` dalla sua immagine
sotto l'unico automorfismo non banale di Bool.

Questo non è un accidente. Bool è il tipo più semplice con più di un elemento.
Qualunque tipo con due o più elementi distinti ammette un predicato che li discrimina.
Lindenbaum-Tarski fallisce non per una scelta sfortunata, ma perché ITT è intensionale:
può dare nomi specifici a elementi specifici, e nominarli diversamente da come li
tratta un isomorfismo.

---

## La relazione che appartiene al tipo

La riparazione di Martin-Löf non restringe il linguaggio.
Sostituisce la domanda.

Invece di chiedere: $P(a) \simeq P(\sigma(a))$ per ogni automorfismo $\sigma$,
si chiede: se $(a, a')$ sono in relazione secondo $A^*$, allora $(P\,a, P\,a')$
sono in relazione secondo $(A \to \mathsf{Set})^*$.

Ogni tipo A porta con sé una relazione canonica $A^* : A \to A \to \mathsf{Set}$.
Un termine chiuso $t : A$ è *relation-invariant* se $A^*(t, t)$ — se $t$ è self-related.
Non si quantifica su tutti gli automorfismi: si richiede che $t$ sia in relazione con se stesso,
secondo la relazione propria del suo tipo.

Questo è il caso $n = 0$: termini chiusi, senza variabili libere.
Self-related significa che il termine è in relazione con se stesso nella relazione del tipo.
Per $A^* = {\_}{\equiv}{\_}$, questo è riflessività proposizionale: $A^*(a, a) = (a \equiv a)$,
testimoniato da `refl`.
Self-related = reflexive = extensional: le tre formulazioni coincidono quando la relazione
canonica è l'identità.

Eliminare il quantificatore universale sugli isomorfismi non indebolisce il teorema.
Lo cambia di oggetto. Il teorema di Tarski parla di invarianza sotto *tutte* le biiezioni:
è falso in ITT. Il teorema di Martin-Löf parla di covarianza rispetto alla relazione
*propria* del tipo: è dimostrabile, e più informativo. Non dice solo che qualcosa è
invariante — dice *rispetto a quale relazione specifica*.

---

## Il contesto si triplica

Per un termine in contesto le cose si complicano nella forma, non nella struttura.

Sia $\Gamma = (x_1 {:} A_1, \ldots, x_n {:} A_n)$. Il *contesto esteso* $\Gamma^*$ è:

$$\Gamma^* \;=\; x_1^{\dagger} {:} A_1,\;\; x_1^{*} {:} A_1,\;\; r_1 {:} A_1^*(x_1^{\dagger}, x_1^{*}),\;\; \ldots,\;\; x_n^{\dagger} {:} A_n,\;\; x_n^{*} {:} A_n,\;\; r_n {:} A_n^*(x_n^{\dagger}, x_n^{*})$$

Ogni variabile originale diventa tre: la prima copia, la seconda copia, il testimone
che le due copie sono in relazione. Un contesto di $n$ variabili diventa un telescopio
di $3n$ variabili.

Per $n = 1$, $\Gamma = (x {:} A)$:

```agda
record RelCtx (A : Set) (A-rel : A → A → Set) : Set where
  field
    x-left  : A
    x-right : A
    wit     : A-rel x-left x-right
```

Il tripling non è arbitrario. È la forma minima per enunciare la covarianza:
il termine nell'istanza $x^{\dagger}$ è in relazione con il termine nell'istanza $x^{*}$,
tramite il testimone $r$. La relazione non è esterna al contesto — è dentro di esso,
come terza componente.

In [*The Substance of Context*](../the-substance-of-context), il contesto si internalizza
come tipo Σ e il confine tra meta-linguaggio e linguaggio è mantenuto dall'atto epistemico
della dichiarazione. Il contesto triplicato è ancora un tipo Σ — tre estensioni successive,
la stessa sostanza, la stessa parete.

---

## Due oggetti per ogni espressione

La prova del teorema procede per ricorsione sulle regole del linguaggio.
Ogni espressione sintattica $E$ viene interpretata come una coppia:

- $E^{\dagger}$ : il valore nel modello standard
- $E^{*}$ : la relazione su $E^{\dagger} \times E^{\dagger}$

Per Bool la scelta è quella di minima — la relazione che Bool già porta:

```agda
module Model where

  Bool† : Set
  Bool† = Bool

  Bool-rel : Bool† → Bool† → Set
  Bool-rel b b' = b ≡ b'

  true† : Bool†
  true† = true

  true-self : Bool-rel true† true†
  true-self = refl

  false† : Bool†
  false† = false

  false-self : Bool-rel false† false†
  false-self = refl
```

La relazione canonica di Bool è l'identità proposizionale. Due booleani sono in relazione
se e solo se sono uguali. I costruttori si interpretano come coppie: il valore e il
testimone che quel valore è self-related.

Perché questo risolve il problema della prima sezione. Il controesempio a Tarski era
$P = \lambda b.\, b \equiv \mathsf{true}$, non invariante sotto `not`. Nel modello
${\dagger}/{*}$, il teorema richiede che $P$ sia covariante rispetto a `Bool-rel`:
per ogni $b, b'$ con $b \equiv b'$, vale $P\,b \simeq P\,b'$. Questa è congruenza
proposizionale — `cong` la prova. $P$ non è invariante sotto `not`; è covariante
sotto `_≡_`. Le due proprietà non si implicano: la seconda è dimostrabile, la prima no.

La biiezione `not` non era nella relazione: `not true = false`, e `true ≡ false`
è disabitata. Il teorema di Martin-Löf non deve rendere conto di `not` perché `not`
non porta elementi correlati in elementi correlati. Il modello sceglie la sua relazione,
e poi ogni termine del linguaggio la rispetta.

---

## refl semantico

In ogni modello ${\dagger}/{*}$, per ogni tipo $A$ e ogni termine chiuso $a : A$,
la componente $a^{*}$ è un elemento di $A^*(a^{\dagger}, a^{\dagger})$: il testimone
che $a$ è self-related.

Per Bool: `true-self = refl : true ≡ true`.
Il testimone semantico di riflessività *è* `refl` proposizionale.

Questo non è un caso fortunato. Quando $A^* = {\_}{\equiv}{\_}$ — quando la relazione
canonica è l'identità proposizionale — le due nozioni di riflessività coincidono
esattamente. `refl` come termine del tipo $a \equiv a$ e $a^*$ come componente del
modello semantico sono la stessa cosa, letta da livelli diversi.

In [*La copula nel codice*](../copula-nel-codice), `refl` chiude il buco proposizionale
perché il riduttore ha già trovato la forma normale: non costruisce, riconosce.
In [*L'identità e i suoi modi*](../identita-e-suoi-modi), la distinzione è esplicita:
`refl` non dimostra, certifica che la giuntura era già chiusa.
Il modello semantico aggiunge un piano: $a^*$ certifica che $a$ è self-related nel
modello — la condizione che il teorema richiede. La struttura è la stessa:
un termine riflessivo che non costruisce ma riconosce. Il livello è diverso:
non il sintattico, il semantico.

Per i tipi la cui relazione canonica è l'identità proposizionale, il modello
bidimensionale è già dato dalla struttura dell'identità stessa.
Non si aggiunge una relazione: si sceglie quella che il tipo ha già.
E il refl semantico — la componente $a^*$ del modello — non è un nuovo ente:
è la vecchia `refl`, riletta come testimone di self-relatedness.

Ogni termine definibile porta la sua relazione perché la relazione non è esterna:
è la relazione propria del tipo, già scritta nella sua definizione.
