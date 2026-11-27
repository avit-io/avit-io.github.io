---
title: "Bottega: eval/apply con i tipi"
date: 2026-11-27T08:00:00+01:00
abstract: >
  Bottega è un linguaggio totale con tipi dipendenti, scritto in Racket nella forma di Pie, e
  sopra di lui tre linguaggi per casi d'uso diversi. Il suo cuore è l'eval/apply del post
  precedente, con una cosa in più: i valori bloccati, che restano dove nessuna regola si applica.
  Da lì vengono refl, il confronto tra termini aperti e un kernel di quarantacinque righe. Ogni
  dialetto è una libreria e un realizzatore sopra lo stesso nucleo: le pipeline per Dagger, la
  configurazione per Nix, l'architettura di Elm. In tutti e tre i test sono prove.
---

**In sintesi.** [Il post precedente](/blog/eval-apply-impalcatura/) finiva sotto il λ, dove
eval/apply da solo non basta e un type checker deve confrontare termini con variabili libere.
[Bottega](https://github.com/avit-io/bottega) è il posto dove ho costruito quella risposta. È un
linguaggio totale con tipi dipendenti, scritto in Racket, con la sintassi di Pie: `claim`, poi
`define`, solo tonde. Sopra il nucleo ci sono tre `#lang`, ciascuno per un mestiere. Questo post
segue il percorso dall'`eval` al dialetto.

## 1. Lo stesso eval, con i tipi

Il valutatore di bottega sta in `bottega/core/eval.rkt`, centocinquantacinque righe. Il suo cuore
è riconoscibile:

```racket
(define (evaluate env t)
  (match t
    [(tvar i) (list-ref env i)]                       ; una variabile: l'ambiente
    [(tglob n) (reduce n '())]                        ; un nome globale: δ, e forse ι
    [(tapp f u i) (apply-value (evaluate env f) (evaluate env u) i)]
    [(tlam x i body) (vlam x i env body)]             ; la closure
    …))

(define (apply-value f u i)
  (match f
    [(vlam _ _ env body) (evaluate (cons u env) body)]   ; β: estendere l'ambiente
    [(vrigid l sp) (vrigid l (extend sp))]               ; una variabile senza valore: si blocca
    [(vglob n sp) (reduce n (extend sp))]                ; una definizione: forse ora riduce
    …))
```

Le regole del post precedente ci sono tutte. β è il primo caso di `apply-value`: il corpo della
closure si valuta nel suo ambiente, esteso con l'argomento. δ e ι sono insieme in `reduce`: un
nome definito per clausole riduce quando ha tutti i suoi argomenti *e* una delle clausole li
riconosce. Il pattern match su un costruttore è la regola ι.

La differenza sta nei casi che il valutatore di SICP non ha. Quando si controlla un tipo, `n` è
una variabile del contesto e non ha valore. `evaluate` non si ferma con un errore: produce un
valore *bloccato*, `vrigid`, che si porta dietro gli argomenti che riceve. E una definizione che
non può ridurre resta un `vglob` con i suoi argomenti, in attesa. Sono i termini neutri della
normalizzazione per valutazione: i punti dove il calcolo non può andare avanti, per ora.

## 2. Che cosa vuol dire refl

Con i valori bloccati si capisce che cosa può chiudere `refl` e che cosa no. La somma è definita
sul primo argomento:

```racket
(claim + (→ Nat Nat Nat))
(define (+ n m)
  (match n
    (zero m)
    ((add1 k) (add1 (+ k m)))))
```

`(+ 0 n)` riduce: il primo argomento è il costruttore `zero`, la prima clausola lo riconosce, e
resta `n`. Quindi `(≡ (+ 0 n) n)` si chiude con `refl`. `(+ n 0)` invece è bloccato: `n` è
neutro, nessuna clausola sa se è `zero` o `add1`, e ι non scatta. Il checker lo dice così:

```text
b: refl: expected (≡ (+ n 0) n), found (≡ (+ n 0) (+ n 0))
```

Per chiudere `(≡ (+ n 0) n)` serve una prova per induzione, che fa il lavoro che il calcolo non
può fare:

```racket
(claim +-zero (Π ((n Nat)) (≡ (+ n 0) n)))
(define (+-zero n)
  (match n
    (zero     refl)
    ((add1 k) (cong add1 (+-zero k)))))
```

Dentro ciascun ramo `n` non è più neutro: è `zero`, oppure `(add1 k)`, e `+` torna a ridurre.
È il confine scritto in cima a questo sito, visto da vicino: ciò che il calcolo decide, e ciò che
una prova deve istituire.

Il confronto dei due lati lo fa `unify`, settanta righe. Confronta valori, non sintassi. Quando
trova due funzioni le applica entrambe a una variabile fresca e confronta i risultati: è la
regola η, ed è anche il readback, fatto solo quanto serve. Due costruttori diversi sono un
conflitto. Due variabili bloccate sono uguali se sono la stessa variabile con argomenti uguali.

## 3. Chi controlla il controllore

L'elaboratore è la parte grande e furba: metavariabili, argomenti impliciti, `auto` che prova
per calcolo, gli errori con riga e colonna. Non è fidato. Ogni termine che produce passa da
`bottega/core/kernel.rkt`, quarantacinque righe, che conosce soltanto Π e gli universi
stratificati e ricontrolla tutto con lo stesso `evaluate` e lo stesso `unify`. Se l'elaboratore
sbaglia, il kernel rifiuta. È lo schema di de Bruijn: la fiducia sta in un pezzo piccolo
abbastanza da leggerlo.

Il resto della totalità sta prima: ricorsione strutturale, copertura dei casi, positività
stretta dei tipi induttivi. Un programma bottega termina, e una prova bottega non può girare a
vuoto.

## 4. Un nucleo, tre mestieri

Racket è un linguaggio per fare linguaggi. Un `#lang` è un modulo che decide come leggere e
come espandere il resto del file. Bottega usa questa torre così: ogni dialetto riesporta il
nucleo, aggiunge una libreria e un vocabolario, e consegna il risultato a qualcosa che esiste
già. Il programma dichiara un piano come dato, il type checker ne prova le proprietà, il
realizzatore lo esegue. Le prove si cancellano; restano le forme normali.

**`#lang disegno`** descrive pipeline per [Dagger](https://dagger.io): build, test, rilasci.
La pipeline non si esegue mentre la si scrive: è un valore, che diventa GraphQL solo alla fine.
Così se ne possono dimostrare le proprietà di ordine:

```racket
(claim prod-dopo-staging
  (Π ((src Dir)) (Precedes (targets? "staging") (targets? "prod") (rilascio src))))
(define (prod-dopo-staging src) auto)
```

**`#lang prospettiva`** descrive un servizio una volta sola, e ogni ambiente come una sua
proiezione. Ne escono i file di configurazione, attraverso Nix. I teoremi sono le invarianti
della proiezione, provati per ogni ambiente:

```racket
; qa è una prova di prod salvo la taglia: stesso cluster, quindi stessa porta.
(claim qa≈prod (≡ (Values.containerPort (main qa)) (Values.containerPort (main prod))))
(define qa≈prod auto)
```

**`#lang affresco`** è l'architettura di Elm, lato server: un modello, un `update` totale, una
vista. Il runtime tiene il modello e manda al browser solo le differenze. La vista arriva al
browser attraverso `reify`, lo stesso readback del type checker: il valore della vista viene
riletto come forma normale, e la forma normale diventa HTML. I test sono prove, anche sulla
forma della pagina:

```racket
; fermo, il tempo non lo raggiunge
(claim stopped-is-silent (Π ((s Nat)) (≡ (subs (model s false)) (list))))
(define (stopped-is-silent s) refl)
```

Cambiare il cronometro perché faccia tick anche da fermo non dà un test rosso più tardi: dà un
errore di compilazione adesso, sulla riga della prova.

## 5. L'impalcatura, di nuovo

Il post precedente diceva che, una volta costruito eval/apply, la riscrittura si può
dimenticare. Bottega spinge l'idea un passo più in là. Neanche i dialetti hanno regole proprie:
sono librerie scritte nel linguaggio, più un realizzatore fuori. Un `#lang` nuovo non tocca
`evaluate`, non tocca il kernel. Aggiunge parole, e le prove su quelle parole le controlla lo
stesso nucleo di sempre.

Il nome viene dalla bottega rinascimentale, dove il disegno diventava opera e l'apprendista
cominciava da due esercizi: una sfera con la sua luce, e un pavimento in prospettiva. Disegno e
prospettiva sono due dei tre dialetti. Il terzo, l'affresco, è quello che si dipinge sull'intonaco
fresco, una giornata alla volta, quando l'impalcatura è già montata.

Il codice è su [GitHub](https://github.com/avit-io/bottega), con un libro di esercizi e un
ricettario per ciascun dialetto.
