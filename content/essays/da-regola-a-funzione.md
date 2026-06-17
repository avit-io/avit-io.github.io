---
title: "Da regola a funzione: cosa succede quando suc diventa un termine"
date: 2026-06-17
abstract: >
  In Agda scriviamo `suc : ℕ → ℕ` e lo trattiamo come una funzione: lo
  componiamo, lo passiamo a `map`. Ma nel metalinguaggio il successore non è
  una funzione, è una regola di inferenza. Cosa cambia per strada? La tesi è in
  due tempi: una reificazione trasforma la regola in un termine del linguaggio;
  poi l'η-espansione sancisce che quel termine si comporta come una funzione.
  Sono due movimenti distinti — e attribuire all'η il merito della
  trasformazione fa perdere il punto.
---

C'è un'osservazione che chiunque studi i tipi induttivi in Agda finisce per fare, di solito senza riuscire a metterla bene a fuoco. Quando definiamo i naturali nel metalinguaggio — nel calcolo dei sequenti, nelle regole di Martin-Löf, comunque vogliamo chiamarlo — il successore *non è una funzione*. È una regola. Eppure in Agda lo scriviamo `suc : ℕ → ℕ`, gli diamo un tipo funzione, lo passiamo a `map`, lo componiamo. Qualcosa è cambiato per strada.

Questo articolo cerca di dire con precisione *cosa* cambia. La tesi è in due tempi: prima una **reificazione** trasforma una regola metalinguistica in un termine del linguaggio; poi l'**η-espansione** sancisce che quel termine si comporta a tutti gli effetti come una funzione. Sono due movimenti distinti, e confonderli — come capita di fare quando si attribuisce all'η il merito della trasformazione — fa perdere il punto.

## I naturali nel metalinguaggio

Cominciamo da dove i naturali nascono per davvero: le regole di formazione e introduzione.

```
                  n : ℕ
─────         ──────────
0 : ℕ          succ n : ℕ
```

Leggiamole per quello che sono. La prima è un *assioma*: `0 : ℕ` è una derivazione che sta in piedi da sola. La seconda è una *regola di inferenza*: una funzione, sì, ma una funzione **sulle derivazioni**, non un termine del linguaggio. Dice "se hai una derivazione del giudizio `n : ℕ`, allora hai una derivazione del giudizio `succ n : ℕ`".

Qui `succ` non è un oggetto. Non vive dentro la teoria. Vive nel giudizio, nel tratto orizzontale. È uno **schema**: prende derivazioni, restituisce derivazioni, e questa operazione accade nel metalinguaggio in cui ragioniamo *sulla* teoria dei tipi, non dentro di essa.

Le conseguenze sono concrete. Nel metalinguaggio puro non puoi:

- **astrarre** su `succ` — non c'è nessun `λ` che lo possa catturare, perché `λ` astrae su termini e `succ` non è un termine;
- **applicarlo parzialmente** o tenerlo "sospeso" — una regola la applichi quando hai le premesse, punto;
- **passarlo a qualcosa di higher-order** — non c'è nessun "qualcosa" a cui passarlo, perché non è un valore.

`succ` è puro verbo. La distanza con ciò che faremo in Agda è esattamente questa: lì `suc` diventerà un nome, un sostantivo, una cosa che si può maneggiare.

## La reificazione in Agda

Guardiamo la definizione che tutti scriviamo:

```agda
data ℕ : Set where
  zero : ℕ
  suc  : ℕ → ℕ
```

A prima vista sembra una trascrizione fedele delle regole di sopra. Non lo è. È una **dichiarazione**, e dichiara due *costanti del linguaggio*: `zero`, di tipo `ℕ`, e `suc`, di tipo `ℕ → ℕ`. Quel `ℕ → ℕ` è un tipo abitato da termini, e `suc` è uno di questi abitanti — un termine, un valore, una cosa.

Questo è il primo movimento, ed è il meno appariscente proprio perché Agda lo fa in silenzio. La regola di introduzione, che nel metalinguaggio era uno schema sulle derivazioni, viene **reificata**: diventa un abitante del tipo funzione, internalizzato nella teoria. Da meta-operazione a oggetto del discorso.

Il guadagno è immediato ed è tutto ciò che prima non potevi fare:

```agda
due-volte : ℕ → ℕ
due-volte = suc ∘ suc      -- lo componi

ap : (ℕ → ℕ) → ℕ → ℕ
ap f n = f n

_ : ap suc zero ≡ suc zero  -- lo passi a un higher-order
_ = refl
```

`suc ∘ suc` non avrebbe **nessun senso** sulle regole di inferenza del metalinguaggio — non componi derivazioni con `∘`. Ha senso qui perché `suc` è ora un termine di tipo `ℕ → ℕ`, e `∘` è un'ordinaria funzione che prende e restituisce termini di tipo funzione.

Vale la pena insistere su un punto facile da scivolarci sopra: **non è che Agda abbia "scoperto" che `succ` era una funzione tutto il tempo.** Nel metalinguaggio non lo era, e non c'era niente da scoprire. Agda ha *deciso* di rappresentarla come un termine di tipo funzionale. È una scelta di design della teoria dei tipi intensionale, non un teorema. Il successore-come-funzione è un artefatto della reificazione.

## Dove entra l'η — e dove no

Arriviamo all'intuizione che probabilmente ti ha portato fin qui: `suc n` *ha la stessa struttura* di una chiamata di funzione. Sintatticamente, `suc n` e `f n` sono indistinguibili — testa applicata a un argomento. E questo non è un caso: è proprio ciò che ci autorizza a trattare `suc` come una funzione a pieno titolo. La domanda è *cosa*, formalmente, ci dà questa autorizzazione.

La regola che hai in mente è l'**η per i tipi funzione**:

```
f : A → B
─────────────
f = λ x. f x
```

Dice che ogni termine di tipo funzione è *uguale* alla propria astrazione esplicita. Conseguenza profonda: un termine di tipo `A → B` è **completamente determinato dalla sua azione applicativa**. Non c'è nient'altro da sapere su `f`, se non cosa fa quando lo applichi. Due termini di tipo funzione che si applicano allo stesso modo su ogni argomento sono lo stesso termine.

Applichiamolo a `suc`. Poiché `suc : ℕ → ℕ`, l'η ci dà gratis:

```
suc = λ x. suc x
```

Ed *ecco* la giustificazione formale dell'intuizione. `suc` non solo *sembra* una funzione: è estensionalmente *indistinguibile* da `λ x. suc x`, un'astrazione esplicita. Tutto ciò che puoi fare con `suc` è applicarlo, e quando lo applichi si comporta come l'astrazione che ti aspetti. L'η chiude il cerchio: trasformato in termine di tipo `→`, `suc` *è* una funzione anche nel senso forte, estensionale, non solo nel senso di "ha quel tipo".

Ma — e qui sta il fraintendimento da evitare — **l'η non è il meccanismo che trasforma la regola in funzione.** L'ordine logico conta:

1. *Prima* la reificazione dà a `suc` il tipo `ℕ → ℕ`, facendone un termine.
2. *Poi*, e solo perché ora ha quel tipo, l'η si applica e ne sancisce il comportamento funzionale.

L'η **presuppone** che `suc` sia già un termine di tipo funzione: la sua premessa è `f : A → B`. Non può creare quel tipo dal nulla, può solo dire qualcosa su termini che quel tipo ce l'hanno già. Se attribuissimo all'η il salto da regola a funzione, metteremmo il carro davanti ai buoi: useremmo una regola sui termini funzione per spiegare come nasce un termine funzione. Il salto vero è la reificazione, silenziosa e precedente; l'η è il sigillo estensionale che viene dopo.

In sintesi:

| | cos'è `suc` | cosa puoi farne |
|---|---|---|
| **Metalinguaggio** | regola di inferenza (schema sulle derivazioni) | applicarla quando hai le premesse |
| **Agda, dopo la reificazione** | termine di tipo `ℕ → ℕ` | comporlo, passarlo, astrarlo |
| **Agda, con l'η** | termine *estensionalmente uguale* a `λ x. suc x` | trattarlo come una funzione qualsiasi |

## Una funzione un po' speciale

Resta una domanda, e ignorarla lascerebbe l'impressione sbagliata che `suc` sia diventato una funzione *qualsiasi* di tipo `ℕ → ℕ`. Non lo è, e la differenza è sostanziale.

Prendi una funzione ordinaria `f : ℕ → ℕ`, diciamo `f n = n + 1`. Estensionalmente fa la stessa cosa di `suc`. Eppure su `suc` puoi fare pattern matching, e su `f` no:

```agda
pred : ℕ → ℕ
pred zero    = zero
pred (suc n) = n        -- discrimino su suc
```

Quel `suc n` a sinistra dell'uguale non sta *chiamando* `suc`: sta *decostruendolo*. Il successore, in quanto costruttore, gode di due proprietà che nessuna funzione ordinaria possiede:

- **iniettività**: da `suc m ≡ suc n` segue `m ≡ n`;
- **disgiunzione** (no-confusion): `suc n ≢ zero`, sempre, e più in generale costruttori distinti producono valori distinti.

Una `f : ℕ → ℕ` arbitraria non offre nessuna delle due — `f` potrebbe essere costante, potrebbe collassare valori diversi sullo stesso output. È proprio questa generatività che rende `suc` adatto a essere *eliminato*: è su di lui che l'induttore/eliminatore di `ℕ` può ramificare.

Quindi il quadro completo è a tre strati, non a due. La reificazione fa di `suc` un termine; l'η ne fa una funzione in senso estensionale; ma essere un **costruttore** è qualcosa *in più* dell'avere tipo `ℕ → ℕ`. `suc` è un `ℕ → ℕ` particolare, marcato, su cui il pattern matching discrimina e di cui l'eliminazione conosce la struttura. La tua intuizione — "`suc n` è come una chiamata di funzione" — è corretta nella forma e ben fondata nell'η; ma la forma applicativa nasconde che, sotto, c'è un oggetto con più garanzie di qualunque funzione che capiti di avere lo stesso tipo.

## In una riga

`succ` parte come regola metalinguistica, non come funzione. La **reificazione** lo internalizza in un termine di tipo `ℕ → ℕ`; l'**η** certifica che quel termine è estensionalmente una funzione; ed essere un **costruttore** gli aggiunge iniettività, disgiunzione e potere di eliminazione che nessuna funzione ordinaria dello stesso tipo possiede. L'intuizione della "chiamata di funzione" è giusta — purché si sappia che l'η la giustifica ma non la genera, e che sotto la forma applicativa c'è più di una semplice funzione.
