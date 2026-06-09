---
title: "La copula nel codice: proof-driven development in Agda"
date: 2026-06-09
abstract: >
  Scrivere codice corretto non è diverso dal costruire una prova.
  In Agda, il tipo è la proposizione, il buco è la copula mancante,
  l'implementazione è la parte satura. Un percorso da zero —
  liste, concatenazione, inversione — per mostrare che il
  type-checker non è un guardiano: è la giuntura stessa.
---

## La proposizione aperta

In Agda ogni definizione inizia come proposizione aperta. Si scrive una
firma — un tipo — e il corpo è un buco:

```agda
reverse' : {A : Set} → List A → List A
reverse' xs = ?
```

Il type-checker risponde con un *goal*:

```
Goal: List A
——————————————
xs : List A
```

Questo non è un errore. È il riconoscimento che la copula manca. Il tipo
`List A → List A` dichiara una relazione tra soggetto e predicato, ma nessun
termine li tiene assieme. Nel lessico di
[*I tempi della copula*](https://github.com/avit-io/tempi-della-copula),
la firma è la proposizione con la giuntura aperta: `?` occupa il posto dove
la copula dovrebbe stare.

La differenza con un linguaggio a tipizzazione dinamica non è solo tecnica.
In Python l'assenza di implementazione è silenzio: il programma prosegue finché
non raggiunge il punto mancante e allora crasha. In Agda l'assenza di
implementazione è uno *stato epistemico esplicito*: il buco è visibile, ha un
tipo, porta con sé il contesto. Il file con un buco non è un programma
incompleto — è una proposizione con la copula sospesa. Il type-checker non
controlla a posteriori: custodisce la giuntura in attesa che il termine la chiuda.

Quando si lavora con più buchi contemporaneamente, ognuno porta il suo goal
e il suo contesto. Si può lasciare aperta la struttura generale della prova,
chiudere i rami più semplici con `refl`, delegare i più complessi a variabili
nominali. La prova avanza non come scrittura lineare ma come riduzione
progressiva dell'apertura: ogni termine costruito chiude una copula, ogni
copula chiusa restringe lo spazio dei termini che possono chiudere le restanti.

---

## Costruttori come regole di introduzione

Definiamo le liste da zero. L'unica importazione necessaria è l'uguaglianza
proposizionale:

```agda
module PDD where

open import Relation.Binary.PropositionalEquality
  using (_≡_; refl; sym; trans; cong)

data List (A : Set) : Set where
  []  : List A
  _∷_ : A → List A → List A
```

Il parametro `A : Set` non è un argomento nel senso operazionale: è il
contesto. Nelle regole sequenti:

$$
\frac{\Gamma \vdash A : \mathsf{Set}}{\Gamma \vdash \mathsf{List}\,A : \mathsf{Set}}
\qquad
\frac{\Gamma \vdash A : \mathsf{Set}}{\Gamma \vdash [\,] : \mathsf{List}\,A}
\qquad
\frac{\Gamma \vdash x : A \quad \Gamma \vdash xs : \mathsf{List}\,A}{\Gamma \vdash x \mathbin{∷} xs : \mathsf{List}\,A}
$$

Il costruttore `_∷_` è la terza regola scritta in un alfabeto diverso. Non è
una sintesi più semplice: è la stessa cosa. Quello che in logica è "regola di
introduzione" e quello che in Agda è "costruttore" sono lo stesso atto
costruttivo — la saturazione della giuntura con materiale concreto.

Il parametro `A : Set`, reso implicito dalle graffe nel codice, non scompare:
cambia forma. Nel termine `x ∷ xs` il contesto `A` è ancora presente, assorbito
nei tipi di `x` e `xs`. Il contesto non viene cancellato dall'applicazione della
regola; viene preso dentro la struttura del termine costruito. L'essay
*The Substance of Context* su queste stesse pagine mostra il versante astratto
di questa osservazione; qui si vede nel concreto.

La concatenazione segue la struttura del primo argomento:

```agda
_++_ : {A : Set} → List A → List A → List A
[]       ++ ys = ys
(x ∷ xs) ++ ys = x ∷ (xs ++ ys)
```

Le due clausole sono eliminazione di `List A`. Costruttori e eliminatori si
corrispondono — le regole di introduzione determinano la forma delle regole
di eliminazione, e questa corrispondenza determina a sua volta la forma delle
prove sui tipi induttivi. Non è una convenzione sintattica: è la struttura del
giudizio che si riflette a livello dei termini.

---

## I lemmi come giudizi intermedi

Ogni lemma è una proposizione — il suo tipo — e la prova è la saturazione di
quella proposizione. Ne costruiamo tre, ciascuno necessario al successivo.

**`++-rightId`**: `[]` è neutro destro per la concatenazione.

```agda
++-rightId : {A : Set} (xs : List A) → xs ++ [] ≡ xs
++-rightId []       = refl
++-rightId (x ∷ xs) = cong (x ∷_) (++-rightId xs)
```

Il caso base chiude con `refl`. La proposizione `[] ++ [] ≡ []` è vera per
riduzione definitoria: la prima clausola di `_++_` porta `[] ++ []` a `[]`
per pattern matching, senza residuo computazionale. `refl` è la copula
congelata — il caso in cui soggetto e predicato coincidono per giudizio,
senza modalità, senza prove alternative. È l'uguaglianza giudizionale:
decidibile, proof-irrelevant, priva di spessore.

Il passo induttivo è `cong (x ∷_) (++-rightId xs)`. L'ipotesi induttiva
`++-rightId xs` prova `xs ++ [] ≡ xs`. La funzione `cong` trasporta questa
prova attraverso il costruttore `x ∷_`: se `xs ++ []` e `xs` sono uguali,
allora anche `x ∷ (xs ++ [])` e `x ∷ xs` sono uguali. La copula non si
congela: viene coniugata nel modo `_∷_`, si propaga lungo la struttura del
costruttore.

**`++-assoc`**: la concatenazione è associativa.

```agda
++-assoc : {A : Set} (xs ys zs : List A)
         → (xs ++ ys) ++ zs ≡ xs ++ (ys ++ zs)
++-assoc []       ys zs = refl
++-assoc (x ∷ xs) ys zs = cong (x ∷_) (++-assoc xs ys zs)
```

La struttura è identica a `++-rightId`. Il caso base collassa per riduzione
definitoria; il passo induttivo propaga la copula lungo `_∷_`. La forma della
prova è determinata dalla forma del tipo, e la forma del tipo è determinata
dalla forma di `List`. La ricorsione avviene sul primo argomento perché
`_++_` è definita per ricorsione sul primo argomento: il tipo e la sua prova
hanno la stessa scheletro.

**`reverse-++`**: l'inversione distribuisce invertendo l'ordine dei fattori.

```agda
reverse' : {A : Set} → List A → List A
reverse' []       = []
reverse' (x ∷ xs) = reverse' xs ++ (x ∷ [])

reverse-++ : {A : Set} (xs ys : List A)
           → reverse' (xs ++ ys) ≡ reverse' ys ++ reverse' xs
reverse-++ []       ys = sym (++-rightId (reverse' ys))
reverse-++ (x ∷ xs) ys =
  trans (cong (_++ (x ∷ [])) (reverse-++ xs ys))
        (++-assoc (reverse' ys) (reverse' xs) (x ∷ []))
```

Il caso base non chiude con `refl`. La proposizione da provare si riduce a
`reverse' ys ≡ reverse' ys ++ []` — l'inverso di `++-rightId (reverse' ys)`.
`sym` ribalta la direzione della copula: il cammino era stato costruito
nell'altra direzione, `sym` lo percorre al contrario. La copula ha un verso;
`sym` ne è la negazione formale.

Il passo induttivo compone due cammini con `trans`. Il primo,
`cong (_++ (x ∷ [])) (reverse-++ xs ys)`, trasporta l'ipotesi induttiva
appendendo `(x ∷ [])` a destra di entrambi i lati:

$$
\mathsf{reverse'}(xs\mathbin{++}ys) \mathbin{++} (x \mathbin{∷} [\,])
\;\equiv\;
(\mathsf{reverse'}\,ys \mathbin{++} \mathsf{reverse'}\,xs) \mathbin{++} (x \mathbin{∷} [\,])
$$

Il secondo, `++-assoc (reverse' ys) (reverse' xs) (x ∷ [])`, riorganizza le
parentesi:

$$
(\mathsf{reverse'}\,ys \mathbin{++} \mathsf{reverse'}\,xs) \mathbin{++} (x \mathbin{∷} [\,])
\;\equiv\;
\mathsf{reverse'}\,ys \mathbin{++} (\mathsf{reverse'}\,xs \mathbin{++} (x \mathbin{∷} [\,]))
$$

`trans` li compone: il termine di arrivo del primo è il termine di partenza
del secondo. Il risultato è esattamente `reverse' ((x ∷ xs) ++ ys) ≡ reverse' ys ++ reverse' (x ∷ xs)`
dopo le riduzioni definitorie. La copula è stata coniugata due volte in
successione: `trans` è la composizione dei coniugati.

---

## Il teorema: rev∘rev≡id

```agda
reverse-involutive : {A : Set} (xs : List A)
                   → reverse' (reverse' xs) ≡ xs
reverse-involutive []       = refl
reverse-involutive (x ∷ xs) =
  trans (reverse-++ (reverse' xs) (x ∷ []))
        (cong (x ∷_) (reverse-involutive xs))
```

Il caso base è `refl`. La lista vuota è invariante per costruzione:
`reverse' []` si riduce a `[]` per definizione, dunque `reverse' (reverse' [])`
si riduce a `[]` senza alcuna computazione aggiuntiva. Non c'è nulla da provare
perché non c'è nulla da distinguere — la copula collassa perché soggetto e
predicato coincidono dal principio, per la stessa ragione per cui `[]` non ha
spessore interno.

Il passo induttivo. Lo sviluppo esplicito:

$$
\begin{aligned}
&\mathsf{reverse'}(\mathsf{reverse'}(x \mathbin{∷} xs)) \\
&= \mathsf{reverse'}(\mathsf{reverse'}\,xs \mathbin{++} (x \mathbin{∷} [\,]))
   && \text{def. } \mathsf{reverse'} \\
&\equiv \mathsf{reverse'}(x \mathbin{∷} [\,]) \mathbin{++} \mathsf{reverse'}(\mathsf{reverse'}\,xs)
   && \texttt{reverse-++} \\
&= (x \mathbin{∷} [\,]) \mathbin{++} \mathsf{reverse'}(\mathsf{reverse'}\,xs)
   && \text{rid. definitoria} \\
&= x \mathbin{∷} \mathsf{reverse'}(\mathsf{reverse'}\,xs)
   && \text{rid. definitoria} \\
&\equiv x \mathbin{∷} xs
   && \text{ip. induttiva}
\end{aligned}
$$

I passi marcati con $=$ sono riduzioni definitorie: il type-checker le
riconosce automaticamente senza che la prova debba nominarle. I passi marcati
con $\equiv$ richiedono un termine esplicito.

Il primo termine è `reverse-++ (reverse' xs) (x ∷ [])`: il lemma costruisce il
cammino dalla forma dell'LHS alla forma intermedia. Da lì fino a
`x ∷ reverse' (reverse' xs)` è riduzione silente. L'ultimo termine è
`cong (x ∷_) (reverse-involutive xs)`: l'ipotesi induttiva saturata dal
costruttore.

Il `trans` che li collega non è accessorio. È la composizione di due coniugati:
il primo attraversa la struttura della concatenazione, il secondo chiude la
ricorsione. La prova è un cammino costruito termine per termine — non disegnato,
ma edificato.

---

## La saturazione

Il momento in cui Agda accetta il file non è una validazione esterna. Non c'è
un oracolo che osserva il codice e approva. Il type-checker non verifica a
posteriori: è la giuntura stessa. Finché `?` è aperto, tipo e termine sono
separati — la copula manca. Quando il termine viene costruito nel modo giusto,
la giuntura si chiude: la proposizione è satura.

Non c'è differenza ontologica tra "codice corretto" e "prova". Sono lo stesso
oggetto visto da due lati: dal lato del tipo è una proposizione con forma data;
dal lato del termine è quella forma saturata da un costruttore. Il file che
typechecka è una proposizione che è stata coniugata fino in fondo.

Qui la distinzione del saggio precedente torna con peso pieno. L'uguaglianza
giudizionale — `refl`, la copula congelata — è decidibile e proof-irrelevant:
non ha modalità, non distingue tra prove diverse dello stesso fatto. È la
copula nel suo grado zero, il momento in cui soggetto e predicato coincidono
senza residuo. L'identità proposizionale — il tipo `_≡_` usato lungo tutta la
prova — è più ricca: ha prove diverse (`sym`, `trans`, `cong`, le loro
composizioni), e queste prove sono esse stesse oggetti, non semplici testimoni.
La copula non si congela: si coniuga, si compone, si propaga.

In HoTT questo secondo livello si estende all'universo: l'univalenza è la copula
coniugata al livello dei tipi stessi, dove ogni equivalenza tra tipi diventa
un'identità. Ma la struttura è già visibile nel piccolo — in `reverse-involutive`
e nei lemmi che lo reggono. Ogni `trans` è una composizione di cammini; ogni
`cong` è un trasporto lungo un costruttore; ogni `refl` è il cammino vuoto. La
copula non è mai soltanto uno zero: è una famiglia di atti, di cui `refl` è il
caso degenere.

Il proof-driven development non è una metodologia. È la conseguenza diretta
di scrivere in un linguaggio dove il tipo precede il termine e la copula non
può essere elusa: non la si può posticipare a un test, non la si può fingere
con un mock, non la si può lasciare aperta senza che il compilatore lo sappia.
La giuntura è sempre visibile, sempre aperta finché non è stata chiusa da un
termine della forma giusta.
