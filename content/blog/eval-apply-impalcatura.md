---
title: "Eval/apply, e l'impalcatura che si dimentica"
date: 2026-11-27
abstract: >
  Il calcolo si può definire con regole locali di riscrittura: β per applicare una funzione,
  δ per svolgere una definizione, ι per far incontrare un eliminatore e un costruttore. Eval/apply
  prende quelle regole e le chiude in due procedure che si chiamano a vicenda: la sostituzione
  diventa un ambiente, la strategia diventa l'ordine di due chiamate. Una volta mostrato che la
  macchina fa ciò che le regole dicono, le regole si possono dimenticare: diventano teoremi su
  eval, e eval/apply diventa la base. Tranne in un punto, sotto il λ, dove l'impalcatura ritorna.
---

**In sintesi.** Un programma funzionale calcola riscrivendosi: un redex alla volta, finché non
resta un valore. Le regole che dicono come riscrivere sono poche, e ciascuna ha un nome greco.
Ma nessun interprete serio le applica così come sono scritte. SICP, al capitolo 4, parte invece da
due procedure, `eval` e `apply`, che si chiamano a vicenda. Questo post mostra che cosa c'è dentro
quella coppia: le stesse regole, impacchettate, più due cose che le regole non dicono.

## 1. Gli ingredienti

Tre regole bastano per un frammento con funzioni, definizioni e booleani.

```text
β   ((λ (x) b) v)       ⟶  b[x := v]          applicare è sostituire
δ   f                   ⟶  e                  se (define f e)
ι   (if true a b)       ⟶  a                  un eliminatore incontra un costruttore
    (if false a b)      ⟶  b
```

β è la regola del λ-calcolo: l'argomento prende il posto del parametro nel corpo. δ svolge un
nome nella sua definizione. ι è la regola degli induttivi: quando un eliminatore (qui `if`, per
i booleani; per i naturali sarebbe `ind-Nat`, come in
[un saggio precedente](/essays/pattern-matching-ed-eliminatori/)) trova davanti a sé un
costruttore, sceglie il ramo corrispondente.

Le regole dicono *che cosa* diventa un redex. Due cose non le dicono. Primo, *dove*: un redex
può stare in profondità dentro un termine, e serve una regola di congruenza che permetta di
riscrivere dentro un contesto. Secondo, *quando*: se ci sono due redex, quale si riduce prima.
Questa è la strategia, e cambia il risultato: con la strategia sbagliata un termine che ha un
valore può non arrivarci mai.

Applicate alla lettera, queste regole costano. Ogni passo cerca un redex nell'intero termine.
Ogni β copia il corpo e ci sostituisce dentro l'argomento, facendo attenzione a non catturare
variabili libere. Sono regole buone per *definire* il calcolo, cattive per *farlo*.

## 2. Eval/apply: le stesse regole, impacchettate

Ecco un valutatore per quel frammento, in Racket. Sono due procedure.

```racket
(struct closure (x body env))

(define (eval e env)
  (match e
    [(? number?) e]
    [(? boolean?) e]
    [(? symbol?) (lookup e env)]                                  ; δ
    [`(λ (,x) ,body) (closure x body env)]
    [`(if ,c ,a ,b) (if (eval c env) (eval a env) (eval b env))]  ; ι
    [`(,f ,a) (apply (eval f env) (eval a env))]))

(define (apply f v)
  (match f
    [(closure x body env) (eval body (extend env x v))]           ; β
    [(? procedure?) (f v)]))
```

Ogni regola ha trovato un posto preciso.

- **δ è la lettura di un nome.** `lookup` cerca il nome nell'ambiente. Una definizione non si
  svolge nel testo: si legge quando serve.
- **β è `apply` di una closure.** Il corpo non viene copiato e non vi si sostituisce niente: lo si
  valuta in un ambiente esteso con il nuovo legame. L'ambiente è una sostituzione rimandata, e una
  sostituzione rimandata non cattura mai una variabile.
- **ι è il caso `if`.** Si valuta la condizione fino a un costruttore, `true` o `false`, e quello
  sceglie il ramo. La scelta la fa l'`if` di Racket: il linguaggio ospite presta il suo
  eliminatore al linguaggio ospitato. È il senso di *metacircolare*.
- **Congruenza e strategia non sono più regole.** Il «dove» è la ricorsione di `eval` sulla
  struttura del termine. Il «quando» è l'ordine di due chiamate: nell'applicazione, `eval` valuta
  operatore e operando *prima* di chiamare `apply`. È l'ordine applicativo, scritto come codice.

Il λ non si riduce: diventa un valore, una closure, cioè il codice insieme all'ambiente in cui è
nato. È la coppia che SICP disegna con due cerchi.

<figure>
  <picture>
    <source media="(prefers-color-scheme: dark)" srcset="/img/ambiente-dark.svg">
    <img src="/img/ambiente-light.svg" width="640" height="320"
         alt="un frame E1 con x: 3 e f; f punta a un oggetto procedura, due cerchi: il codice (λ (y) (* x y)) e un puntatore di ritorno a E1">
  </picture>
  <figcaption>Il modello ad ambienti (SICP 3.2). Il frame si legge: è ciò che eval consulta. La
  procedura si applica: un cerchio punta al codice, l'altro all'ambiente in cui è nata, ed è lì
  che apply aggiungerà il frame del parametro.</figcaption>
</figure>

## 3. Dimenticare l'impalcatura

Le regole del paragrafo 1 e il valutatore del paragrafo 2 dicono la stessa cosa, e lo si può
dimostrare: per un termine chiuso `e`, `(eval e ∅)` restituisce un valore se e solo se `e`
si riduce a un valore `v` con l'ordine applicativo, e il valore restituito è `v` (una closure al
posto di un λ, con l'ambiente al posto della sostituzione). Questo è il teorema di adeguatezza, e va dimostrato una volta.

Dopo, succede una cosa curiosa: le regole si possono dimenticare. Non spariscono: cambiano
ruolo. Prima erano la *definizione* del calcolo e la macchina era un'implementazione da
giustificare. Adesso la macchina è la definizione, e le regole sono *teoremi su di essa*. β, per
esempio, diventa una proprietà di `eval`:

```text
(eval ((λ (x) b) a) ρ)  =  (eval b ρ[x ↦ (eval a ρ)])
```

È quello che fa SICP al capitolo 4. Non parte dalla riscrittura, parte direttamente da `eval` e
`apply`: «il valutatore, che determina il significato delle espressioni di un linguaggio, è
soltanto un altro programma». La riscrittura è servita a costruirlo, come il ponteggio serve a
dipingere un affresco. Finito l'affresco, il ponteggio si smonta e la parete regge da sola.

Da lì in poi eval/apply è la base. Un linguaggio nuovo non si definisce con nuove regole di
riscrittura: si definisce con un nuovo `eval`, che sa leggere una forma in più. È la torre di
linguaggi di Racket, dove ogni `#lang` è, in fondo, un altro valutatore.

## 4. Dove l'impalcatura ritorna

C'è un punto in cui eval/apply non basta, ed è sotto il λ. `eval` si ferma ai valori: la closure
di `(λ (y) (+ 1 1))` resta com'è, con il suo `(+ 1 1)` non ridotto dentro. Per *eseguire* un
programma va benissimo. Per *confrontare* due programmi no.

Un type checker con tipi dipendenti deve decidere se due termini sono lo stesso termine, anche
quando contengono variabili che non hanno ancora un valore: che `(λ (y) (+ 1 1))` e
`(λ (y) 2)` sono uguali, o che `(+ 0 n)` si riduce a `n`. Gli serve la forma normale, e la
forma normale sta anche sotto i binder.

La soluzione conserva eval/apply e aggiunge un passo. *Normalization by evaluation* valuta il
termine in un dominio di valori in cui una variabile senza valore è un valore anch'essa, un
termine *neutro* che si blocca dove nessuna regola si applica. Poi rilegge il valore come
sintassi (*readback*), entrando nelle closure con una variabile fresca. Le regole β e ι non
compaiono mai come riscritture: le calcola `eval`, come sopra. Torna solo un pezzo
dell'impalcatura, il passo che rilegge, e insieme a lui la regola η.

È così che Pie, il linguaggio di *The Little Typer*, decide `same-as`. Ed è così che lo decide
bottega, il nucleo di teoria dei tipi in Racket su cui sto costruendo: quando una prova si chiude
con `refl`, nessuno ha riscritto niente. Ha valutato `eval`, ha riletto il readback, e i due lati
sono risultati la stessa forma normale. Ma questo è il prossimo post.
