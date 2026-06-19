---
title: "Chiudere sul vuoto: dall'assurdo al terzo escluso"
date: 2026-06-19
abstract: >
  ⊥ è il caso limite della storia della chiusura: un tipo con zero costruttori.
  Il suo eliminatore — ex falso — è la chiusura «sul vuoto»: nessun caso da
  coprire, quindi qualsiasi cosa segue. Da qui la negazione è `A → ⊥`, e il
  terzo escluso `A ∨ ¬A` diventa una domanda sulla chiusura: non si dimostra,
  perché la somma è positiva e pretende un testimone che per `A` generico non
  hai. Eppure `¬¬(A ∨ ¬A)` si dimostra. La tesi è che la differenza è di
  polarità: la negazione doppia sposta l'enunciato sul lato negativo, dove non
  devi decidere — devi solo confutare la confutazione, e per farlo il
  confutatore lo consulti due volte con risposte opposte senza mai impegnarti.
---

**In sintesi.** In [*Almeno, al più, e il criceto*](../almeno-al-piu-e-il-criceto) la tesi era che un tipo non è chiuso dai suoi costruttori, ma dal contratto tra costruttori ed eliminatore: gli introduttori danno il «almeno», l'eliminatore il «al più». ⊥ è il caso limite di quella storia — il tipo con *zero* costruttori. Il suo «almeno» è vuoto, e il suo eliminatore, l'ex falso, è la chiusura portata all'estremo: non c'è nessun caso da coprire, quindi da `⊥` segue qualunque cosa. Su questa base la negazione è `A → ⊥`, e il terzo escluso `A ∨ ¬A` smette di essere uno slogan e diventa una domanda precisa sulla chiusura. La risposta è in due tempi: `A ∨ ¬A` non si dimostra, ma `¬¬(A ∨ ¬A)` sì — e la ragione è una differenza di *polarità*, non un trucco.

## 1. ⊥, il tipo chiuso sul vuoto

Riprendiamo lo schema. Un tipo induttivo viene con introduttori che fissano il limite inferiore («contiene *almeno* questi abitanti») e un eliminatore che fissa quello superiore («contiene *al più* questi»). La chiusura è quando i due combaciano, e l'eliminatore è il modo in cui il limite superiore viene *decretato*: accettarlo come regola **è** dichiarare che i costruttori esauriscono il tipo.

Applichiamolo al caso degenere. ⊥ è dichiarato così:

```agda
data ⊥ : Set where
  -- nessun costruttore
```

Il limite inferiore è vuoto: non si afferma l'esistenza di *nessun* abitante. La domanda è cosa diventi l'eliminatore quando i casi da coprire sono zero. La forma è la stessa di sempre — un caso per costruttore — ma con zero costruttori la lista delle premesse si svuota:

```agda
ind-⊥ : (C : ⊥ → Set) → (x : ⊥) → C x
ind-⊥ C ()
```

e nella versione non dipendente, quella che si incontra per prima:

```agda
absurd : {C : Set} → ⊥ → C
absurd ()
```

Quel `()` — il *pattern assurdo* — non è una clausola lasciata in bianco: è la dichiarazione che non c'è alcuna clausola da scrivere, perché non c'è alcun costruttore su cui ramificare. E qui sta il punto. L'eliminatore di `ℕ` ti chiede di coprire `zero` e `succ` per consegnarti `C`; l'eliminatore di ⊥ ti chiede di coprire *niente*, e in cambio ti consegna `C` **per qualsiasi `C`**. La chiusura sul vuoto è esattamente questa: con il limite superiore fissato a zero, l'esaustività è vacua, e da una vacuità si conclude tutto.

Vale la pena dirlo nei termini del «al più». Per `ℕ`, «al più zero e succ» è un'informazione che restringe. Per ⊥, «al più *niente*» non restringe: spalanca. Non perché ⊥ sia speciale, ma perché la stessa identica meccanica — *l'eliminatore copre tutti i casi, quindi puoi assumere di averli coperti* — letta su zero casi diventa «non devi coprire nulla, quindi assumi pure di aver concluso». Ex falso quodlibet non è un assioma aggiunto da fuori: **è la regola di eliminazione standard valutata sul tipo con zero costruttori.**

C'è un'asimmetria da tenere a mente, e tornerà. La canonicità garantisce che ogni termine *chiuso* di ⊥ si calcoli fino a un costruttore — ma costruttori non ce ne sono. Quindi non esiste alcun termine chiuso di ⊥, e `absurd` non viene *mai* eseguito su un argomento concreto: è una promessa che resta perennemente non riscossa, perché la premessa non arriva mai. ⊥ è utile non per ciò che se ne ottiene calcolando, ma per ciò che la sua sola presenza in un'ipotesi *autorizza*.

## 2. La negazione è una funzione verso il vuoto

Con ⊥ a disposizione, la negazione non è una primitiva nuova: è una definizione.

```agda
¬_ : Set → Set
¬ A = A → ⊥
```

`¬ A` è il tipo delle funzioni che mandano ogni eventuale abitante di `A` nell'impossibile. Dimostrare `¬ A` significa esibire una procedura: *dammi un `a : A` e ti costruisco un assurdo*. Non è la dichiarazione metafisica «`A` è falso», ed è bene non confonderli — è l'impegno costruttivo, ben più concreto, che *qualsiasi* prova di `A` collasserebbe su ⊥.

Si noti la polarità. `¬ A` è un tipo funzione: un tipo **negativo**, definito da come si comporta quando lo applichi, non da costruttori che lo riempiono. Per usarlo serve un `a : A` da dargli in pasto; in cambio si ottiene un `⊥`, e da quel `⊥` — qui rientra l'ex falso del §1 — si ottiene qualunque cosa. Le due facce di ⊥ lavorano insieme: la negazione *convoglia* tutto verso ⊥, l'ex falso *ridistribuisce* da ⊥ verso tutto. Tenere distinte le due direzioni — ⊥ come conclusione in cui si fa confluire, ⊥ come premessa da cui si finanzia — è la chiave per leggere ciò che segue.

## 3. Il terzo escluso e perché non chiude

Il terzo escluso, come tipo, è una somma:

```agda
lem : {A : Set} → A ⊎ ¬ A
lem = ?
```

E qui la storia della chiusura morde. `⊎` è un tipo **positivo**: i suoi abitanti sono `inl a` oppure `inr b`, e — come per ogni positivo — la chiusura è *per esistenza*. Per introdurre un abitante di `A ⊎ ¬ A` devi **impegnarti** a un costruttore: o esibisci un `a : A` e scrivi `inl a`, o esibisci una confutazione `f : ¬ A` e scrivi `inr f`. Non c'è una terza via, ed è proprio l'eliminatore di `⊎` — il case split — a decretarlo.

Ma per un `A` *generico* non hai né l'uno né l'altro. Non hai un abitante di `A`, perché `A` è una variabile e potrebbe essere vuoto; non hai una confutazione di `A`, perché potrebbe essere abitato. Il buco `?` non si riempie. Detto con la canonicità: un ipotetico termine chiuso di `A ⊎ ¬ A` polimorfo dovrebbe calcolarsi fino a `inl` o `inr`, e così *deciderebbe* `A` uniformemente per ogni `A` — cosa che nessun programma può fare. Il terzo escluso generale non è un teorema mancante per pigrizia: è esattamente ciò che la chiusura per esistenza vieta. Assumerlo come schema equivarrebbe a postulare un costruttore che l'eliminatore non sanziona — la stessa mossa che renderebbe `ℕ-elim` falso se sbucasse un `weird : ℕ`.

## 4. La negazione doppia, invece, chiude

Si dimostra però qualcosa di vicinissimo:

```agda
dnem : {A : Set} → ¬ ¬ (A ⊎ ¬ A)
dnem k = k (inr (λ a → k (inl a)))
```

Una riga. Leggiamola. Srotolando le definizioni, `¬ ¬ (A ⊎ ¬ A)` è `((A ⊎ ¬ A) → ⊥) → ⊥`: prendere un *confutatore* `k` del terzo escluso e produrre `⊥`. Il confutatore `k` ha tipo `(A ⊎ ¬ A) → ⊥`: per contratto, qualunque prova di `A ∨ ¬A` gli dia, lui restituisce un assurdo.

Lo sfrutto due volte, con impegni opposti.

- Costruisco `inr (λ a → k (inl a))`, cioè una prova di `¬ A`. Per farne una, prendo un ipotetico `a : A` e passo a `k` l'*altra* alternativa, `inl a : A ⊎ ¬ A`. `k (inl a)` ha tipo `⊥`, dunque `λ a → k (inl a)` ha tipo `A → ⊥`, cioè `¬ A`. Bene: `inr (…) : A ⊎ ¬ A`.
- Ora ho una prova del terzo escluso — quella che dice «`A` è falso» — e la do di nuovo a `k`. `k (inr (…)) : ⊥`. Fatto.

Nessun `absurd` viene invocato: non *consumo* ⊥ con l'ex falso, lo *produco*. È la faccia di ⊥ come conclusione, quella del §2: la negazione doppia non chiede di ricavare qualcosa dal vuoto, chiede solo di far confluire l'argomento nel vuoto. E ci riesce perché `k` è una macchina che trasforma in ⊥ *qualunque* lato del terzo escluso io le porga.

## 5. Perché la doppia passa e la singola no

La differenza tra §3 e §4 non è di quantità — una negazione in più — ma di **polarità**, ed è qui che le due metà dell'articolo si saldano.

`A ∨ ¬A` è positivo: chiude per esistenza, e introdurlo pretende che io *decida*, una volta per tutte, quale costruttore. Per `A` generico non posso.

`¬¬(A ∨ ¬A)` è `(A ∨ ¬A) → ⊥ → ⊥`: due frecce verso il vuoto lo trasportano sul lato **negativo**. Un tipo negativo non si abita decidendo, si abita *rispondendo a chi lo interroga* — e l'unico obbligo, alla fine, è consegnare un `⊥`. Questo cambia tutto. Non devo più scegliere se `A` valga o no; devo solo mostrare che *negarlo entrambi i lati* è impossibile. E per mostrarlo dispongo di `k`, un confutatore che per costruzione accetta sia `inl` sia `inr`. Posso allora consultarlo **due volte con risposte opposte** — `inl a` nel costruire il ramo interno, `inr f` in quello esterno — senza mai impegnarmi io a un lato solo.

È la mossa impossibile al §3. Lì dovevo *essere* il valore, e un valore di `⊎` è uno e un solo costruttore. Qui *alimento* un confutatore, e un confutatore lo posso provocare quante volte voglio, dandogli ogni volta la risposta che mi fa comodo. La negazione doppia è precisamente la modalità che concede di ragionare classicamente — di usare «`A` o non `A`» come se fosse deciso — **a patto che il prodotto finale sia solo un `⊥`**. Finché ti accontenti di chiudere su ⊥, puoi giocare entrambe le carte; nel momento in cui pretendi un testimone vero, di nuovo positivo, l'impegno torna obbligatorio e il giocattolo si rompe.

Questo non è un fatto isolato del terzo escluso. È il **teorema di Glivenko**: una formula della logica proposizionale è dimostrabile classicamente se e solo se la sua doppia negazione è dimostrabile intuizionisticamente. `¬¬(A ∨ ¬A)` ne è l'istanza più nitida — la verità classica che, sotto due negazioni, rientra senza residui nel costruttivo. La doppia negazione non *aggiunge* il terzo escluso alla teoria: lo confina dietro a una `⊥` finale, dove non serve più decidere nulla.

## 6. In una riga

⊥ è la chiusura del §1 valutata su zero costruttori: «al più niente», dunque ex falso. La negazione `A → ⊥` convoglia verso quel vuoto; l'ex falso ne ridistribuisce. Il terzo escluso `A ∨ ¬A` non chiude perché è positivo e pretende un testimone che per `A` generico non esiste; `¬¬(A ∨ ¬A)` chiude perché la doppia negazione lo sposta sul lato negativo, dove basta consegnare un `⊥` e il confutatore lo si interroga due volte con risposte opposte senza mai impegnarsi. La stessa identica meccanica della chiusura — chi deve *esistere*, chi deve solo *finire in ⊥* — spiega, senza assiomi extra, perché un enunciato resista e la sua doppia negazione no.

---

### Riferimenti essenziali

- Martin-Löf — *Intuitionistic Type Theory* (1984), per ⊥ e le sue meaning explanations.
- Glivenko — *Sur quelques points de la logique de M. Brouwer* (1929), per il teorema della doppia negazione.
- The Little Typer (Friedman, Christiansen), per `Absurd` e `ind-Absurd`.
