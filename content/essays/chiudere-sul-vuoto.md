---
title: "Chiudere sul vuoto: la regola sotto l'assurdo"
date: 2026-06-19
abstract: >
  La presentazione consueta consegna `absurd : ⊥ → C` come una clausola Agda,
  `absurd ()`: una stipulazione sintattica che sembra arbitraria proprio perché
  non c'è elemento su cui calcolare. Ma quella lambda è una regola di inferenza
  reificata, e la vera stipulazione vive nel sequente e nella sua meaning
  explanation. ⊥ non ha regola destra (nessun elemento); ha una regola sinistra
  *senza premesse* (ex falso), giustificata — non imposta — dal fatto che zero
  forme canoniche danno zero equazioni da onorare. Su questa base: `¬A = A ⊃ ⊥`;
  `A ∨ ¬A` non si deriva perché ∨-destra pretende di impegnarsi a un lato; e
  `¬¬(A ∨ ¬A)` si deriva, ma la sua derivazione mostra ciò che la lambda CPS
  nasconde — una contrazione sull'ipotesi negativa. La lambda «scritta secondo
  il canone classico» è il termine reificato di quell'albero: letto l'albero, il
  canone classico si riduce a un'unica regola strutturale.
---

**In sintesi.** Quasi ogni esposizione dell'assurdo fa la stessa cosa: scrive `absurd : ⊥ → C`, lo definisce con `absurd ()`, e prosegue. Il malcapitato resta con una lambda che sembra arbitraria — e lo sembra per una ragione esatta: non c'è alcun elemento di ⊥ su cui calcolare, quindi la clausola non *fa* niente, è pura stipulazione sintattica. Ma quella lambda non è il fondamento: è una regola di inferenza **reificata**, nel senso preciso di [*Da regola a funzione*](../da-regola-a-funzione). La vera stipulazione — quella che la giustifica invece di imporla — sta nel sequente e nella meaning explanation che lo regge. Questo articolo rimette le regole davanti alle lambda. Sotto, riemerge la storia della chiusura di [*Almeno, al più, e il criceto*](../almeno-al-piu-e-il-criceto): ⊥ è quel racconto valutato su zero costruttori. E in fondo, il terzo escluso e la sua doppia negazione si separano non per un trucco, ma per dove cade una contrazione.

## 1. La regola sotto la lambda

Cominciamo da ciò che Agda fa scrivere:

```agda
data ⊥ : Set where
  -- nessun costruttore

absurd : {C : Set} → ⊥ → C
absurd ()
```

Il `()` non è una clausola vuota: è la dichiarazione che *non c'è clausola da scrivere*, perché non c'è costruttore su cui ramificare. Preso così, è opaco. Per renderlo trasparente bisogna risalire all'oggetto di cui è la reificazione: la regola di eliminazione di ⊥, che nel metalinguaggio si scrive come un sequente. E qui le stipulazioni vere sono **due**, una in negativo e una in positivo.

La prima è un'assenza. ⊥ **non ha regola destra**: non esiste alcuna inferenza che concluda `Γ ⊢ ⊥` a partire da premesse più semplici, perché non c'è costruttore di ⊥. Questo, e non un postulato metafisico, è il significato di «non puoi avere un elemento di ⊥»: non è che gli elementi siano vietati altrove, è che *non è stata data alcuna regola per fabbricarne uno*.

La seconda è una regola sinistra, ed è ex falso:

```
──────────  (⊥L)
 Γ, ⊥ ⊢ C
```

Si legga con attenzione a *cosa manca*: la barra non ha premesse. È una regola a **zero premesse**, per `C` qualunque. Confrontata con l'eliminatore di `ℕ` — due costruttori, due premesse (il caso `zero`, il caso `succ`) — `⊥L` è lo stesso identico schema con il numero di premesse portato a zero. Niente da coprire, dunque, e in cambio `C` arbitrario. È il «al più niente» del criceto: fissato il limite superiore a zero costruttori, l'esaustività diventa vacua, e da una clausola vacua segue tutto.

Resta la domanda che il malcapitato ha il diritto di porre: *perché* mi è lecito concludere `C` dal nulla? La risposta non è «perché Agda accetta `()`». È la meaning explanation. Una regola di eliminazione, alla Martin-Löf, è giustificata specificando come l'eliminatore *calcola* su ciascuna forma canonica del tipo. ⊥ non ha forme canoniche; quindi non c'è alcuna equazione di calcolo da dare, e — soprattutto — nessuna obbligazione da verificare. La regola `⊥L` è giustificata da un dovere **vuoto**: è l'unica coerente con «non c'è alcuna prova canonica di cui rendere conto». Per questo `absurd` non è arbitrario pur non calcolando mai: la canonicità garantisce che nessun termine chiuso raggiunga ⊥, quindi `absurd e` è un redex che non scatta mai — una regola giustificata e inerte. La lambda `absurd ()` era esattamente questo, reificato: una regola a zero premesse, il cui `()` segnala il punto in cui l'obbligazione, semplicemente, non c'è.

## 2. La negazione è A ⊃ ⊥, e le sue due regole

Con ⊥ a disposizione, la negazione non è una nuova primitiva: è l'implicazione verso l'assurdo. Nel metalinguaggio, `¬A` è `A ⊃ ⊥`, e prende in prestito le regole della freccia.

```
 Γ, A ⊢ ⊥                  Γ ⊢ A     Γ, ⊥ ⊢ C
──────────  (¬R)         ───────────────────── (¬L)
 Γ ⊢ ¬A                       Γ, ¬A ⊢ C
```

A destra: provare `¬A` è derivare `Γ, A ⊢ ⊥`, cioè *assunto un `A`, raggiungere l'assurdo*. A sinistra: avere `¬A` tra le ipotesi, più una prova di `A`, chiude su `C` qualunque — e si vede che la premessa destra `Γ, ⊥ ⊢ C` è proprio `⊥L`. Le due facce di ⊥ del §1 lavorano qui in tandem: `¬R` *convoglia* `A` dentro ⊥, `¬L` (passando per `⊥L`) *ridistribuisce* da ⊥ verso `C`. In Agda tutto questo si reifica in `¬ A = A → ⊥`, `λ a → …` per `¬R`, applicazione per `¬L`; ma è la coppia di sequenti a dire cosa significano.

## 3. Il terzo escluso: ∨-destra pretende di impegnarsi

Il terzo escluso, come formula, è una disgiunzione, e la disgiunzione si introduce a destra con due regole:

```
   Γ ⊢ A                  Γ ⊢ ¬A
────────── (∨R₁)        ────────── (∨R₂)
 Γ ⊢ A ∨ ¬A             Γ ⊢ A ∨ ¬A
```

Entrambe chiedono, *prima* di concludere `A ∨ ¬A`, di aver già derivato uno dei due lati. È la chiusura per esistenza dei tipi positivi: per stare a destra di `⊢`, la disgiunzione esige un testimone impegnato. E qui si vede, proof-theoretically, perché `⊢ A ∨ ¬A` non si deriva per `A` generico. Per l'eliminazione del taglio, una derivazione di `⊢ A ∨ ¬A` può essere normalizzata a una che termina con `∨R₁` o `∨R₂` — quindi con una derivazione di `⊢ A` oppure di `⊢ ¬A`. Ma `A` è una variabile: né `⊢ A` né `⊢ ¬A` hanno derivazione uniforme in `A`. Il terzo escluso generale non manca per pigrizia: manca perché `∨R` non concede di restare *sospesi tra i due lati*, e sospesi è l'unica cosa che, su `A` astratto, possiamo essere. Postularlo aggiungerebbe una regola destra che la metateoria non sanziona — la mossa che renderebbe `ℕ-elim` falso se sbucasse un costruttore segreto.

## 4. La derivazione della doppia negazione

L'enunciato vicino, invece, si deriva — e stavolta esibiamo l'albero, non la lambda. L'obiettivo è `⊢ ¬¬(A ∨ ¬A)`, cioè `⊢ ((A ∨ ¬A) → ⊥) → ⊥`. Per `→R` basta derivare, posta `k : ¬(A ∨ ¬A)` tra le ipotesi, il sequente `k ⊢ ⊥`. In deduzione naturale:

```
                              [a]¹
                            ───────── (∨I sx)
                  [k]²       A ∨ ¬A
                  ──────────────────── (→E)
                          ⊥
                      ────────── (→I, scarica a)¹
           [k]²        A → ⊥                       ← è ¬A
           ──────────────────── (∨I dx)
                   A ∨ ¬A
           ──────────────────── (→E)
                     ⊥
               ─────────────── (→I, scarica k)²
               ((A ∨ ¬A) → ⊥) → ⊥
```

Si percorre dal basso. Per ottenere `⊥` applico `k` a una prova di `A ∨ ¬A` costruita con `∨I-dx`: mi serve dunque `¬A`, cioè `A → ⊥`. Per provarlo assumo `[a]¹` e — qui è il nodo — applico *di nuovo* `k`, stavolta all'*altro* lato, `inl a` ottenuto con `∨I-sx`. Ne esce `⊥`; scaricando `a` ottengo `¬A`; con `∨I-dx` e una seconda applicazione di `k` ottengo l'`⊥` finale; scaricando `k` ho la doppia negazione.

Il punto da guardare è l'ipotesi `[k]²`: compare a **due foglie distinte** dell'albero, e una sola `→I²` le scarica entrambe. Lo stesso `k` interrogato due volte, con risposte opposte — `inl a` in alto, `inr (¬A)` in basso. Nessun assurdo viene *consumato* qui: lo si *produce* due volte, sfruttando che `k`, per il suo tipo, accetta entrambi i lati e rende `⊥`.

## 5. La contrazione è tutto «il canone classico»

Quella doppia occorrenza di `[k]` ha un nome preciso tra le regole strutturali: è una **contrazione**. In sequente,

```
 Γ, ¬(A∨¬A), ¬(A∨¬A) ⊢ ⊥
─────────────────────────── (contrazione)
   Γ, ¬(A∨¬A) ⊢ ⊥
```

la derivazione usa l'ipotesi negativa `¬(A∨¬A)` due volte e poi la contrae a una. È *l'unico* passo che dà alla doppia negazione il suo sapore classico. La prova è che, in logica lineare — dove la contrazione non è gratuita ma va richiesta con `!` — `¬¬(A ∨ ¬A)` non passa: senza poter duplicare `k`, non puoi interrogarlo con risposte opposte, e resti come al §3, costretto a impegnarti a un lato. La logica intuizionista, invece, concede la contrazione liberamente; per questo l'albero del §4 sta in piedi, e il risultato resta del tutto costruttivo — non c'è alcun `⊥` consumato per magia, solo uno prodotto e una struttura riusata.

Ora la lambda «scritta secondo il canone classico» si scioglie. Il termine

```agda
dnem : {A : Set} → ¬ ¬ (A ⊎ ¬ A)
dnem k = k (inr (λ a → k (inl a)))
```

è la reificazione esatta di quell'albero, sotto Curry–Howard: `→I` diventa `λ`, `→E` diventa applicazione, `∨I` diventa `inl`/`inr`, e — il punto — la contrazione su `¬(A∨¬A)` diventa la **variabile `k` legata una volta e usata due**. Ciò che sembrava un trucco da continuation-passing rubato alla logica classica è una derivazione LJ in cui l'unica sottigliezza strutturale è una contrazione su una formula negativa. È qui che si colloca il teorema di Glivenko — `⊢_c φ` se e solo se `⊢_i ¬¬φ` per la logica proposizionale: la verità classica rientra nel costruttivo non perché si aggiunga il terzo escluso, ma perché due negazioni la confinano sul lato negativo, dove l'unico debito da saldare è un `⊥` e l'unica licenza richiesta è duplicare l'ipotesi che lo produce.

## 6. In una riga

`absurd ()` non era il fondamento: era una regola reificata, e la sua giustificazione — non la sua imposizione — è `⊥L`, una regola a zero premesse coperta da una meaning explanation vuota. La negazione è `A ⊃ ⊥` con le regole della freccia. Il terzo escluso non si deriva perché `∨R` esige di impegnarsi a un lato, e su `A` astratto non puoi; la sua doppia negazione si deriva perché due frecce verso ⊥ la spostano sul lato negativo, dove basta contrarre l'ipotesi confutatrice e interrogarla due volte. La lambda CPS che restava in mano al malcapitato è il termine di quell'albero: classica solo nel senso, localissimo, di una contrazione.

---

### Riferimenti essenziali

- Martin-Löf — *Intuitionistic Type Theory* (1984), per ⊥ e la meaning explanation dell'eliminazione.
- Gentzen — *Untersuchungen über das logische Schließen* (1935), per LJ, le regole strutturali e l'eliminazione del taglio.
- Glivenko — *Sur quelques points de la logique de M. Brouwer* (1929), per il teorema della doppia negazione.
