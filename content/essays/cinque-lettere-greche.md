---
title: "Cinque lettere greche"
date: 2026-06-12
abstract: >
  β, δ, ι, ζ, η: cinque lettere greche nominano le regole della conversione,
  l'uguaglianza che il typechecker decide da solo, senza chiedere prove.
  Ogni lettera è un modo diverso in cui due espressioni contano come la stessa:
  β calcola le applicazioni, δ apre i nomi, ι fa computare gli eliminatori
  sui costruttori, ζ scioglie i let, η riconosce la forma canonica anche dove
  il calcolo non arriva. Il CIC — il Calculus of Inductive Constructions —
  è leggibile come la somma di queste lettere: il Calculus of Constructions
  porta β, e la "I" del nome è esattamente ι. Il confine delle cinque lettere
  è il confine tra giudizio e proposizione: ciò che la conversione non raggiunge
  è ciò che richiede una prova.
---

## Un giudizio silenzioso

In ogni teoria dei tipi alla Martin-Löf convivono due uguaglianze. Una è un tipo: $a \equiv b$, l'identità proposizionale, qualcosa che si può assumere, negare, dimostrare. L'altra non è un tipo: è un *giudizio*, scritto $a = b : A$, e non si dimostra — si *decide*. È l'uguaglianza definizionale, o conversione: la relazione che il typechecker verifica da solo, in silenzio, ogni volta che controlla un termine, senza che nessuno gli porga una prova.

Il punto in cui questo giudizio entra nella teoria è una regola sola, la regola di conversione:

$$\frac{\Gamma \vdash t : A \qquad \Gamma \vdash A = B \;\, \mathsf{type}}{\Gamma \vdash t : B}$$

Se $t$ ha tipo $A$, e $A$ è *convertibile* a $B$, allora $t$ ha tipo $B$ — senza coercizioni, senza trasporti, senza lasciare traccia nel termine. È la regola che obbliga il typechecker a calcolare: per sapere se `Vec ℕ (2 + 2)` e `Vec ℕ 4` sono lo stesso tipo, deve eseguire `2 + 2`. Il typechecking, in queste teorie, contiene l'esecuzione.

Ma che cosa significa, esattamente, "convertibile"? La risposta è un elenco di regole, e la tradizione le nomina con lettere greche: β, δ, ι, ζ, η. La conversione è la più piccola relazione di equivalenza, congruente rispetto a tutti i costrutti del linguaggio, che le contiene tutte. Ogni lettera è un modo diverso in cui due scritture contano come la stessa cosa. Vale la pena di guardarle una per una, perché ognuna ha un carattere proprio — e perché il CIC, il calcolo che sta sotto Coq, è leggibile come la somma letterale di queste lettere.

---

## β: il motore

La più antica viene dal λ-calcolo di Church, dove conviveva con α (la rinominazione delle variabili legate, così innocua che di solito non si conta nemmeno):

$$(\lambda x.\, t)\; s \;\;\triangleright_{\beta}\;\; t[s/x]$$

Applicare una funzione a un argomento si riduce a sostituire l'argomento nel corpo. È la regola che fa del λ-calcolo un modello di computazione: tutto ciò che una macchina di Turing sa fare, lo fa una catena di β-riduzioni.

```agda
module Conversione where

open import Data.Nat using (ℕ; zero; suc; _+_)
open import Data.Product using (_×_; _,_; proj₁; proj₂)
open import Relation.Binary.PropositionalEquality using (_≡_; refl; cong)

β-ex : (λ (n : ℕ) → suc n) 1 ≡ 2
β-ex = refl
```

Il buco proposizionale si chiude con `refl` perché il riduttore, applicando β, ha già portato il membro sinistro su `2`: come in [*La copula nel codice*](../copula-nel-codice), `refl` non costruisce nulla — certifica che il lavoro era già stato fatto dalla conversione. Ogni volta che un `refl` passa il typechecking, una o più delle cinque lettere hanno lavorato prima di lui.

C'è una proprietà strutturale di β che conviene notare subito, perché le altre lettere si misureranno con essa: β si attiva guardando il *termine*. Un redex β è riconoscibile sintatticamente — un'applicazione il cui operatore è una λ — senza sapere nulla del tipo. Si dice che β è *untyped*, o diretta dalla sintassi. Non tutte le lettere avranno questo privilegio.

---

## ι: la lettera che rende induttivo il calcolo

Il Calculus of Constructions di Coquand e Huet (1988) era un calcolo puro: λ, applicazione, tipi dipendenti, una gerarchia di universi, e la sola β come conversione. I numeri naturali si codificavano alla Church, e la codifica era elegante quanto inadeguata: niente principio di induzione dimostrabile, predecessore in tempo lineare.

L'estensione di Christine Paulin-Mohring aggiunge le *definizioni induttive* come primitive: si dichiara un tipo elencando i suoi costruttori, e il calcolo genera da sé il principio di eliminazione. Ma un eliminatore senza regole di calcolo è lettera morta: serve dire che cosa fa quando incontra un costruttore. Queste regole di calcolo sono le ι-rules:

$$\mathsf{rec}\;(\mathsf{zero})\; z\; s \;\triangleright_{\iota}\; z \qquad\qquad \mathsf{rec}\;(\mathsf{suc}\; n)\; z\; s \;\triangleright_{\iota}\; s\; n\; (\mathsf{rec}\; n\; z\; s)$$

L'eliminatore computa sui costruttori. In Agda la stessa cosa appare come pattern matching: ogni clausola di una definizione per casi è una ι-rule. E la "I" di CIC — *Inductive* — è esattamente questa lettera: ciò che distingue il CIC dal CC non è un assioma in più, è ι. Ogni dichiarazione `Inductive` (o `data`) estende la conversione con nuove regole di calcolo: il calcolo non è chiuso, è uno *schema* — ogni tipo che l'utente dichiara porta in dote le proprie ι.

Il carattere di ι si vede meglio nella sua asimmetria. Si definisca l'addizione per ricorsione sul primo argomento. Allora:

```agda
0+n : (n : ℕ) → 0 + n ≡ n
0+n n = refl

n+0 : (n : ℕ) → n + 0 ≡ n
n+0 zero    = refl
n+0 (suc n) = cong suc (n+0 n)
```

`0 + n ≡ n` si chiude con `refl`: il primo argomento è il costruttore `zero`, ι scatta, la conversione fa tutto. `n + 0 ≡ n` no: il primo argomento è una *variabile*, e una variabile non è un costruttore. ι è cieca davanti ai termini neutri — quelli la cui riduzione è bloccata da una variabile. Per attraversare quella cecità serve l'induzione: una prova, caso per caso, che vive nel mondo proposizionale. La distanza tra le due uguaglianze — una gratuita, una che costa una ricorsione — non è un difetto dell'addizione: è la mappa esatta di dove arriva ι e dove comincia il lavoro di chi dimostra.

---

## η: l'uguaglianza che non calcola

Le prime quattro lettere — β, δ, ι, ζ — sono regole di *riduzione*: hanno un verso, semplificano, e la loro iterazione termina su una forma normale. η è di un'altra natura. Per le funzioni dice:

$$f \;=_{\eta}\; \lambda x.\, f\, x \qquad (f : A \to B)$$

e per le coppie:

$$p \;=_{\eta}\; (\mathsf{proj}_1\, p,\; \mathsf{proj}_2\, p) \qquad (p : A \times B)$$

```agda
η-fun : {A B : Set} (f : A → B) → f ≡ (λ x → f x)
η-fun f = refl

η-pair : {A B : Set} (p : A × B) → p ≡ (proj₁ p , proj₂ p)
η-pair p = refl
```

Non c'è calcolo, qui: nessuno dei due lati è "più semplice". η è un principio di *unicità*: ogni abitante di un tipo funzione *è* una λ, ogni abitante di un tipo coppia *è* una coppia di proiezioni. Se β dice come gli abitanti del tipo si *usano* quando hanno forma canonica, η dice che la forma canonica è l'unica forma che c'è.

E qui η perde il privilegio di β: non è diretta dalla sintassi, è diretta dal *tipo*. Per sapere se espandere `f` in `λ x. f x` bisogna sapere che `f` ha tipo funzione; il termine da solo non basta. Per questo η è la lettera implementativamente più delicata, e quella su cui i sistemi divergono. Agda ha η per le funzioni e per i record (le coppie della libreria standard sono record: per questo `η-pair` si chiude con `refl`); Coq ha aggiunto η per le funzioni alla conversione solo nella versione 8.4, e quella per i record solo con le *primitive projections*. E nessuno dei due ha η per i tipi induttivi veri e propri: un η per `Bool` — ogni `b : Bool` è convertibile a `if b then true else false`, e quindi ogni contesto applicato a `b` si decide per casi — sembra innocuo, ma per i tipi somma in presenza di tipi dipendenti spinge la conversione verso l'indecidibilità. η segna il punto in cui l'appetito di uguaglianze gratuite incontra il prezzo della decidibilità.

C'è un η che il lettore avrà già desiderato e che manca dall'elenco: due funzioni uguali punto per punto non sono convertibili. L'estensionalità funzionale non è una lettera greca — è un teorema indimostrabile in ITT, un assioma in Coq, una conseguenza dell'univalenza in HoTT. La conversione si ferma un passo prima, e quel passo è esattamente lo spessore che separa il giudizio dalla proposizione.

---

## δ e ζ: le lettere del nominare

Le ultime due lettere non parlano di funzioni né di induzione: parlano di *definizioni*, e per questo sembrano minori. Non lo sono.

δ è lo *svolgimento dei nomi*: se `two` è stato definito come `suc (suc zero)`, allora `two` è convertibile al suo corpo. La lettera viene dalle δ-rules di Curry per le costanti; in Coq governa le `Definition`, in Agda lo svolgimento delle definizioni per equazioni (dove, a rigore, δ e ι si fondono: una definizione per pattern matching si svolge solo quando ι può scattare).

ζ è la regola del `let`: $\mathsf{let}\; x := t\; \mathsf{in}\; u \;\triangleright_{\zeta}\; u[t/x]$. Si potrebbe pensare che `let` sia zucchero per una β-redex, e che ζ sia ridondante. Nel CIC non lo è: dentro il corpo di un `let`, il typechecker *sa* che `x` è convertibile a `t`, mentre dentro una λ la variabile è opaca — è una variabile, e abbiamo visto che le variabili bloccano ι. Il `let` dipendente è più forte dell'applicazione: porta con sé la definizione, non solo il tipo.

La profondità di δ sta in un dettaglio dell'ingegneria di Coq che è in realtà un atto epistemico. Una prova chiusa con `Qed` è *opaca*: il suo corpo esiste, è stato verificato, ma δ non lo svolge — per la conversione, quel nome è un atomo. Una prova chiusa con `Defined` è *trasparente*: il suo corpo partecipa al calcolo. La scelta tra `Qed` e `Defined` è la scelta di che cosa, di una prova, si consegna al futuro: solo l'enunciato, o anche il processo. δ è la lettera che rende questa scelta possibile — l'unica delle cinque il cui comportamento è deciso, caso per caso, da chi scrive.

---

## Il CIC come somma di lettere

Si può ora leggere il nome per intero. *Calculus of Constructions*: λ-calcolo con tipi dipendenti e universi, conversione generata da β. *Inductive*: definizioni induttive primitive, e con esse ι — uno schema aperto di regole di calcolo, uno per ogni tipo dichiarato. Attorno, le lettere del nominare: δ per le definizioni globali con la loro trasparenza regolabile, ζ per le definizioni locali. E, tardivamente, η, l'unicità delle forme canoniche per funzioni e record. La conversione del CIC contemporaneo è la chiusura congruente di:

$$\beta \;\cup\; \delta \;\cup\; \iota \;\cup\; \zeta \;\cup\; \eta$$

Che questa relazione sia *decidibile* non è un dettaglio: è la condizione di esistenza del typechecker. La decidibilità discende da due teoremi sul sistema di riduzione — la normalizzazione forte (ogni catena di riduzioni termina) e la confluenza (l'ordine delle riduzioni non conta): per decidere se due termini sono convertibili si normalizzano entrambi e si confrontano le forme normali, modulo α e η. Ogni lettera che si aggiunge alla conversione deve ripagare questo debito: deve preservare la terminazione e la confluenza, o il giudizio silenzioso smette di essere un giudizio e diventa una ricerca senza garanzie. La teoria dei tipi *estensionale* di Martin-Löf, che riversa l'intera uguaglianza proposizionale dentro quella definizionale, paga il prezzo per intero: il suo typechecking è indecidibile. Le cinque lettere sono, viste così, un compromesso calibrato — tutta l'uguaglianza gratuita che si può avere senza perdere la macchina.

---

## Il confine

Le cinque lettere tracciano un confine, e il confine è la cosa più istruttiva che hanno da mostrare.

Da un lato sta ciò che la conversione raggiunge: le uguaglianze che non costano nulla, che nessuno dimostra, che il typechecker attraversa senza lasciare traccia nel termine. `0 + n` e `n`. Una funzione e la sua η-espansione. Un nome e il suo corpo. Questo lato è il regno del giudizio: la medesimezza che la macchina *riconosce*.

Dall'altro lato sta ciò che richiede un atto: `n + 0 ≡ n`, l'estensionalità funzionale, la commutatività dell'addizione. Uguaglianze vere, ma non gratuite — ognuna esige una costruzione, un termine di prova, un abitante del tipo identità. Questo lato è il regno della proposizione: la medesimezza che va *istituita*. In [*L'identità e i suoi modi*](../identita-e-suoi-modi) la distinzione era formulata dal lato di `refl`: `refl` non dimostra, certifica che la giuntura era già chiusa. Ora si può dire *da che cosa* era stata chiusa: da β, δ, ι, ζ, η. `refl` è esattamente il punto di contatto tra i due regni — il termine di prova il cui unico contenuto è "la conversione basta".

E il confine non è fisso. Ogni `data` che si dichiara aggiunge ι-rules e sposta la linea; ogni scelta tra `Qed` e `Defined` decide da che parte della linea cadrà una prova; ogni proposta di estendere la conversione — η per le somme, uguaglianze definizionali aggiuntive, le equazioni delle teorie dei tipi osservazionali — è una rinegoziazione del confine, con la decidibilità come posta. Le cinque lettere greche non sono un inventario di dettagli implementativi: sono i nomi propri dei modi in cui un sistema formale può dire "è lo stesso" senza che nessuno glielo debba dimostrare. Tutto il resto — tutto ciò che le lettere non coprono — è, precisamente, la matematica.
