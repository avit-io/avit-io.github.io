---
title: "Almeno, al più, e il criceto"
date: 2026-06-17
abstract: >
  Un mini-saggio su J, K e le chiusure di β e ι. Quasi tutti i libri di teoria dei
  tipi scrivono la regola di calcolo del ricorsore e proseguono, lasciandone muto il
  movente. Qui lo si ricostruisce per ι, β, J e K: un tipo non è chiuso dai suoi
  costruttori, ma dal contratto fra costruttori ed eliminatore — gli introduttori
  danno il «almeno», l'eliminatore il «al più», e la regola di calcolo ne certifica
  la coerenza. Da qui perché ℕ chiude e Id no, perché J non dimostra UIP, perché Bool
  è un h-set per decidibilità (Hedberg) mentre Bool = Bool ha un cammino non banale
  (ua not) un piano sopra, e perché le funzioni chiudono dall'altro lato — per
  identificazione, via η, fino a un criceto opaco indistinguibile dalla sua
  espansione. La morale: ciò che la teoria-base lascia libero non è «cosa esiste»,
  ma «cosa conta come lo stesso».
---

## Premessa: il geroglifico

Quasi tutti i libri di teoria dei tipi, a un certo punto, scrivono questa riga:

$$\mathsf{rec}\;z\;s\;\mathsf{zero} \;\triangleright\; z$$

e proseguono. È una riga onesta ma muta: *descrive* una regola di calcolo senza dire perché quella e non un'altra, e chi la legge per la prima volta si trova a fare reverse engineering di un significato che l'autore ha interiorizzato al punto di non vederlo più. Questo saggio prova a fare l'opposto: prendere quella riga, e quelle sue cugine (β per le funzioni, le proiezioni di Σ, `J` per l'uguaglianza), e ricostruirne il *movente* — non cosa fanno, ma perché devono esistere e cosa decidono davvero.

Il filo conduttore è una sola idea, declinata su più tipi: **un tipo non è chiuso dai suoi costruttori. È chiuso dal contratto tra costruttori ed eliminatore, e la regola di calcolo (ι, β) è ciò che tiene quel contratto coerente.** Da qui discendono `J`, `K`, l'h-set di `Bool`, il cammino non banale di `Bool = Bool`, e — alla fine — un criceto.

---

## I. Cos'è un ricorsore, e perché ι non è una scelta

Definire `ℕ` come «zero e succ» è una sequenza di affermazioni *positive*: esiste `zero`, ed esiste `succ n` per ogni `n`. Ma questa frase è vuota finché non puoi *consumare* un naturale. Lo strumento per consumarlo è il **ricorsore** (`rec`): non un concetto vago di «ricorsione», ma un oggetto preciso, consegnato in dotazione insieme al tipo nel momento in cui lo definisci. La sua forma è dettata dai costruttori: due costruttori, due ingredienti.

`rec z s n` si legge: *processa `n`, sapendo che per `zero` la risposta è `z` e per i successori usi `s`*. E allora:

$$\mathsf{rec}\;z\;s\;\mathsf{zero} \;\triangleright_\iota\; z$$

non è una scelta. È una tautologia: `z` *è per definizione* «la risposta nel caso zero», quindi processare `zero` non può che restituire `z`. Cambiarla renderebbe `z` un nome bugiardo. La regola gemella,

$$\mathsf{rec}\;z\;s\;(\mathsf{succ}\,n) \;\triangleright_\iota\; s\;n\;(\mathsf{rec}\;z\;s\;n)$$

è la ricorsione vera e propria: per gestire `succ n` ti giri prima a gestire `n`. Queste due righe **sono** la ι-rule degli induttivi. Non un'ottimizzazione di calcolo: la condizione perché «definito dai costruttori» significhi qualcosa.

Lo stesso movente vale per ogni connettivo. Per le funzioni (`Π`):

$$(\lambda x.\,t)\,u \;\triangleright_\beta\; t[u/x]$$

è la condizione perché `λ` catturi davvero «input ↦ output» e non un simbolo opaco. Per le coppie (`Σ`): $\mathsf{fst}\,(a,b) \triangleright a$ è la condizione perché la coppia sia davvero una coppia. Tre righe, una sola idea: **ogni connettivo è una coppia introduzione/eliminazione, e la regola di riduzione è il giunto che certifica che si parlano davvero.** Il nome di questo principio è *armonia* (Gentzen, Prawitz, Dummett) — la stessa promessa-e-riscossione che ho seguito in [*Una promessa e il modo di riscuoterla*](../una-promessa); β e ι ne sono la versione operativa.

---

## II. La chiusura è intro + elim, mai gli intro da soli

Ecco il primo snodo. «Tipo chiuso / definito dai costruttori» **non** significa «ogni elemento è sintatticamente un costruttore». Significa qualcosa di operativo: ogni elemento *chiuso* (senza variabili libere) **si calcola** fino a un costruttore. Questa è la **canonicità**, ed è un teorema metateorico — di quelli che, per Gödel, non puoi dimostrare *dentro* la teoria, perché normalizzazione implica consistenza.

Ma il punto concettuale è un altro, e lo si formula così:

- gli **introduttori** dicono «il tipo contiene *almeno* queste cose» → limite **inferiore**;
- l'**eliminatore** dice «il tipo contiene *al più* queste cose» → limite **superiore**.

La chiusura è quando i due limiti combaciano. Un solo lato non chiude niente: «almeno zero e succ» e «non c'è nient'altro» sono affermazioni di natura logica diversa (esistenziale-positiva vs universale-negativa), e la seconda non si deriva dalla prima. Serve l'eliminatore.

E il modo in cui l'eliminatore «decreta» il limite superiore è sottile: **la sua stessa validità è l'affermazione di chiusura.** `ℕ-elim` ti chiede di coprire `zero` e `succ`, né più né meno. Se esistesse un terzo costruttore segreto `weird : ℕ`, l'eliminatore vecchio diventerebbe *falso* (dimostreresti i due casi, otterresti `P` ovunque, ma `P weird` potrebbe fallire). Accettare `ℕ-elim` come regola **è** decretare che zero e succ esauriscono `ℕ`.

Il quadro completo è a tre:

```
intro   →  "almeno questi"          (esistenza, limite inferiore)
elim    →  "al più questi"          (esaustività, limite superiore)
ι-rule  →  "elim onora gli intro"   (coerenza tra i due)
─────────────────────────────────────────────────────────────
i tre insieme = tipo chiuso; ciascuno da solo non chiude
```

Detta nei termini dell'inferenzialismo: il significato dei costruttori *è* l'uso fissato dall'eliminatore. E la chiusura non si stipula a parte — **cade fuori** dall'aver dichiarato un uso *totale* che copre *esattamente* quei casi. La totalità (garantita dalla metateoria) è il ponte che trasforma «casi coperti» in «elementi coperti». Cambia l'uso, e cambi quanto chiudi — a parità identica di costruttori. È qui che entra `Id`.

---

## III. `Id`, e la chiusura che non arriva

`Id` prende tre argomenti: un tipo `A` e due elementi. `Id A x y` è «prova che `x` e `y` sono uguali». Ha un solo costruttore:

$$\mathsf{refl} : \mathsf{Id}\,A\,a\,a$$

`Id A a a` non è una forma speciale: è solo `Id A x y` con lo stesso valore nei due slot. Niente di magico nel *tipo*. La domanda da un milione è la stessa di `ℕ`: **gli unici abitanti di `Id A a a` sono `refl`?**

L'eliminatore di `Id` è `J`, e la sua ι-rule è di nuovo forzata, tautologica:

$$\mathsf{J}\;P\;d\;a\;\mathsf{refl} \;\triangleright_\iota\; d$$

Ma — ed è il cuore del saggio — `J` impone un limite superiore *più debole* di `ℕ-elim`. Per vederlo, basta guardare i **motive** (la proprietà che vuoi dimostrare; su come si *legge* il motive di `J` dalla forma del buco, [*Il motivo*](../il-motivo)):

```
motive di J :   P : (x : A)(y : A)(p : Id A x y) → Type     -- due punti LIBERI
motive di K :   P : (x : A)(p : Id A x x) → Type            -- UN punto, contato DUE volte
```

Qui sta tutta la differenza tra `J` e `K`, e **non** sta nella forma di `Id` (uno solo), né in `refl` (uno solo). Sta in **quanti elementi il motive tiene liberi**:

- `J` ti fa ragionare su due punti *indipendenti*, e solo dopo guardare il caso in cui coincidono. Per dimostrare `P` su ogni prova, *basta* coprire `refl`. Ma «basta coprire `refl`» **non equivale** a «ogni prova è `refl`».
- `K` parte già dalla diagonale `a` contro `a`, e ti permette di affermare *ogni prova di `a = a` è `refl`* — la **Uniqueness of Identity Proofs** (UIP).

`J` da solo **non** dimostra UIP. La regola di calcolo ($\mathsf{J}\;\dots\;\mathsf{refl} \triangleright d$) è forzata dalla forma del tipo; ma *quale eliminatore prendi come primitivo* — solo `J`, oppure `J + K` — **non lo è**. È una stipulazione, e poteva essere diversa.

Perché `ℕ` chiude e `Id` no, a parità di schema induttivo? Per via dell'**indice**. In `ℕ` i costruttori riempiono tutto il tipo: coprire zero e succ copre tutto. In `Id A a b` c'è l'indice `b`, e `refl` abita solo la **diagonale** `b = a`. `J` propaga la proprietà *facendo scorrere `b`* — funziona benissimo finché un estremo è libero di muoversi. Ma sulla **diagonale fissa** `Id A a a`, dove `b` è inchiodato ad `a`, a `J` manca il grado di libertà per concludere «qui c'è solo `refl`». Quella chiusura è *extra*: si chiama `K`.

```
ℕ:    i costruttori coprono tutto, nessun indice da inseguire
      → canonicità + elim = chiusura piena, "non c'è altro" è teorema

Id:   c'è un indice (il secondo punto); refl copre solo la diagonale
      J propaga lungo l'estremo LIBERO → ottimo finché un capo si muove
      ma sulla diagonale FISSA a=a l'indice non si muove
      → J NON dà "ogni prova è refl"; quella chiusura è K
```

---

## IV. L'intuizione di fondo: «ho detto *almeno* refl, non *esattamente* refl»

C'è un punto in cui chiunque ricostruisca questa storia da zero prova un turbamento legittimo: *mettere un solo costruttore dice «ho almeno `refl`», non «ho esattamente `refl`».* E con il solo `J`, **non puoi escludere che ci sia altro.** Questa non è ingenuità: è la situazione reale.

La tentazione, a questo punto, è di leggerla *classicamente*: «se non dimostro che è solo `refl`, allora forse ce n'è un altro *là fuori* che non riesco a vedere». Questo è il riflesso platonico — lo stesso *altrove* contro cui argomenta [*La verità non abita altrove*](../la-verita-non-abita-altrove) — e va prosciugato, perché è il vero ostacolo.

La lettura costruttiva onesta non ha tre caselle (vero / falso / vero-ma-inaccessibile). Ne ha due: **o lo costruisci (affermato), o non lo costruisci (non affermato).** «Indipendente» sta nella seconda casella, non in una terza. In MLTT-base, la frase «ogni `p : a = a` è `refl`» non è né provabile né confutabile — e questo *non* vuol dire «c'è un fatto nascosto». Vuol dire che **non hai costruito né un testimone che sia uno solo, né un testimone che siano più di uno.** La cardinalità delle prove non è *ignota*: è *non ancora data*, perché nessuno dei due testimoni è sul tavolo.

L'analogia che scioglie il platonismo, senza topologia: *un gruppo*. Ti do «un gruppo `G`» e chiedo quanti elementi ha il centro. Risposta: **dipende da quale gruppo.** Nessuno grida al platonismo, nessuno cerca «il vero numero che la teoria-dei-gruppi non vede». È ovvio che «un gruppo» è sotto-specificato e che la risposta la dà l'*istanza*. `Id` è identico: «la teoria dei tipi» parla di `A` *generico*, come «la teoria dei gruppi» parla di `G` generico. «Quante prove di `a = a`?» è «quanti elementi nel centro?»: dipende da *quale* `A`. `J` è la teoria *generale* che — giustamente — non risponde; `K` e l'univalenza sono i modi di *fissare l'istanza*.

Il platonismo esce dal poro solo perché mille anni di abitudine ci dicono che l'uguaglianza è una *proprietà vero/falso del mondo*. In teoria dei tipi `p : a = a` è un **elemento**, come `3 : ℤ`. «Quante prove» si conta come si conta il centro di un gruppo. Non c'è un di-fuori da indovinare.

---

## V. Fissata l'istanza, la teoria decide: `Bool` è un h-set

Se la teoria generale non risponde, l'istanza concreta sì. E `Bool` è il caso dove si decide — *dentro* la teoria, costruttivamente, senza assiomi calati dall'alto.

La chiave è il **teorema di Hedberg**:

> se un tipo ha **uguaglianza decidibile** (per ogni `x, y` sai costruire *o* `x = y` *o* `x ≠ y`), allora è un **h-set**: ogni `p : x = y` è unica, quindi ogni `p : a = a` è `refl`.

`Bool` ha uguaglianza decidibile banalmente: guardi i due bit e decidi, con un match a quattro casi. Hedberg lo mangia e restituisce «`Bool` è un h-set». Dunque per `Bool` la domanda «quante prove di `true = true`?» ha risposta secca: **una**, `refl`, *dimostrata*. Il fantasma «oltre `refl`», *al livello dei punti di `Bool`*, **non esiste, e lo si prova**.

Nota l'eleganza, perfettamente nello spirito costruttivo: non è `K` calato a rendere `Bool` un insieme — è la **decidibilità**, una proprietà che *costruisci tu* col match. Dove sai decidere l'uguaglianza, l'unicità delle prove te la regala Hedberg. La chiusura di `Bool` te la sei *guadagnata*, non assunta.

Attenzione però a cosa è `Bool`: un esempio *a favore* di «solo `refl`», **non** un controesempio a qualcosa. Trovare un gruppo abeliano non dimostra che i gruppi sono abeliani; `Bool` è «il gruppo abeliano». Per *rompere* «solo `refl` in generale» serve il testimone opposto — un tipo dove costruisci due prove distinte — e quello, per Hedberg, **non** può vivere tra i tipi a uguaglianza decidibile.

---

## VI. Il controesempio vero vive un piano sopra: `Bool = Bool`

Dove si trova allora un cammino genuinamente diverso da `refl`? Non tra i *punti* di `Bool` (lì c'è solo `refl`), ma tra `Bool` e sé stesso **nell'universo dei tipi**: `Bool = Bool`. E richiede **univalenza** — un'estensione costruttiva legittima (realizzata in Cubical Type Theory), non un trucco.

La costruzione, in tre passi:

1. **Un'equivalenza non banale di `Bool` in sé**: la negazione `not`, che scambia `true` e `false`. È invertibile (`not ∘ not = id`), quindi `not : Bool ≃ Bool`. Esibita a mano.
2. **Univalenza converte equivalenze in cammini**: `ua : (A ≃ B) → (A = B)`. Applicata, `p := ua not : Bool = Bool`.
3. **Prova che `p ≠ refl`**: trasportare lungo `ua not` *è* applicare `not`, quindi `transport p true = not true = false`. Ma `transport refl true = true`. Se fosse `p = refl`, avresti `false = true`, costruttivamente assurdo. Dunque `p ≠ refl`. ∎

Esibito: un cammino `Bool = Bool` distinto da `refl`, costruito da `not`, con prova costruttiva della distinzione. E nota *dove* è andato:

```
livello dei punti:  true = true   →  SOLO refl       (Bool è h-set, Hedberg)
livello dei tipi:   Bool = Bool   →  ALMENO DUE: refl e ua(not)
                                      distinti perché trasportano diverso
```

`true = true` è povero perché `Bool` come insieme è discreto. `Bool = Bool` è ricco perché l'*universo* ha struttura: i suoi cammini *sono* le equivalenze, e `Bool` ha due auto-equivalenze (identità e scambio). Il «secondo abitante» non è un fantasma platonico: è **letteralmente `not`**, la negazione di bit, travestita da uguaglianza.

Questo scioglie la tensione del §IV:

- in **MLTT-base** «ogni `p : Bool = Bool` è `refl`» è **indipendente** — non costruisci né uno né più di uno;
- in **Cubical** è **falsa**, con testimone `ua(not)` sul tavolo, calcolabile.

In *nessuna* delle due esiste il «vero-ma-inaccessibile». La matematica costruttiva **chiude** su ciò che afferma: o ti dà l'oggetto, o tace — e tacere *non è* affermare-e-nascondere.

---

## VII. L'altro asse: `Π`, η, e la chiusura per identificazione

Naturale chiedersi, a questo punto: e le funzioni? Anche le `λ` sono «non chiuse»? Qui la risposta si **ribalta**, ed è istruttivo capire perché.

`ℕ` e `Id` sono tipi **positivi**: definiti dai costruttori; la loro chiusura riguarda l'*esistenza* degli abitanti («ce n'è un altro oltre i costruttori?»). `Π` è **negativo**: definito dall'*eliminatore* (l'applicazione). Cosa sia una funzione non è fissato elencando come la costruisci, ma da **come si comporta quando la applichi**. E il criterio di chiusura cambia natura: non «è una `λ`?», ma — passando per **η** —

$$f \;=_\eta\; \lambda x.\,f\,x \qquad (f : A \to B)$$

η dice: *ogni* `f : A → B` è uguale alla sua espansione. Sembra estensionale, ma **non lo è**, e la distinzione è cruciale:

- **η** è strutturale: riguarda la *forma* di `f`, dice «`f` è già in forma-funzione». Non guarda *cosa fa* `f` su nessun input. È intensionale: `λx. x+0` e `λx. x` restano **diversi** (η non apre i corpi a confrontarli per valore).
- **funext** («se `f x = g x` per ogni `x`, allora `f = g`») è estensionale: quantifica sui comportamenti. **η non la implica.** funext è indipendente da MLTT-base — esattamente come UIP.

Quindi il parallelo corretto con tutto il saggio è **funext ↔ UIP**, non η. Su entrambi gli assi, ciò che la base lascia libero **non è «cosa esiste»**, ma **«cosa conta come lo stesso»**. Per `ℕ` quel nodo è stretto (decidibile, h-set); per `Id` e per `Π` è lasciato lasco, e lo stringi scegliendo gli assiomi (`K` / univalenza; funext — che l'univalenza, peraltro, *implica*).

### η dice davvero qualcosa di nuovo?

Sì, e si vede in due righe. Con `f` opaca (una variabile), le due forme normali β stanno ferme:

```
β-nf di  f         =  f
β-nf di  λx. f x   =  λx. f x      -- nessun redex β: già normale!
```

Le due β-forme-normali sono *sintatticamente diverse*. β è **bloccata**, perché `f x` è l'applicazione di una *variabile*, non di una lambda: niente da contrarre. η è esattamente l'identificazione che β non raggiunge mai — è la quinta delle [*Cinque lettere greche*](../cinque-lettere-greche), l'unica che non calcola. Il criterio «uguali sse stesse forme normali» è corretto **solo se la nf include η** — e il modo sano di includerla è *type-directed* (al tipo `A → B` espandi entrambi a `λx. (-) x`, poi confronti i corpi), non come riscrittura cieca (che non terminerebbe). Resta intensionale: confronta i corpi *come termini*, non i comportamenti.

Da notare: quando `f` è *manifestamente* una lambda, l'uguaglianza torna per **sola β**:

$$\lambda x.\,f\,x \;=\; \lambda x.\,(\lambda y.\,\mathit{body})\,x \;\triangleright_\beta\; \lambda x.\,\mathit{body}[y:=x] \;=_\alpha\; f$$

η serve **solo** per le `f` *opache*. È precisamente «estendi alle funzioni opache l'identità che per le lambda esibite vale già per β».

---

## VIII. Il criceto

E qui arriviamo alla formulazione più profonda di η, che è anche la più divertente. Rifiutare `f ≡ λx. f x` «in generale» equivale a dire: *anche se ci fosse un abitante di `A → B` non in forma λ, io lo distinguerei.* Accettare η equivale a dire l'opposto:

> *anche se ci fosse un abitante non-λ, non lo distinguerei dalla sua espansione `λx. (-) x`.*

Rendiamolo concreto. Estendi Agda con un builtin:

```agda
postulate criceto : Bool → Bool   -- dentro: una ruota e un roditore che morde il bit
```

`criceto` abita `Bool → Bool` e **non è una lambda**: è una scatola opaca, un postulato, niente `λ` da nessuna parte. Il sogno è realizzato — un abitante di un tipo funzione che non è in forma-λ. E η, impassibile, dichiara `criceto ≡ λx. criceto x`. **Non apre la scatola.** Non chiede come il criceto produca l'output. Dice solo: qualunque cosa tu sia, sei indistinguibile dalla tua espansione.

Ed è coerente, perché l'**unica cosa** che puoi fare con `criceto` è *applicarlo a un bit*. Non puoi ispezionarne il corpo, non puoi chiedergli «sei una λ?». La sua intera interfaccia osservabile è: gli dai `true`, morde, ti ridà un bit. E su quella interfaccia,

```
(λx. criceto x) true  ▷β  criceto true   -- gira la ruota
criceto true                              -- stesso criceto, stessa ruota
```

sono *identici*. La differenza «criceto vs sua espansione» è **osservativamente vuota**. η non cancella il criceto: dichiara che quella presunta differenza **non era osservabile in partenza**. Per questo è intensionale e non estensionale — collassa differenze di *forma* (vuote, in un tipo negativo), non differenze di *comportamento su input* (quelle le vede ancora; sarebbe funext a collassarle).

Si scopre così che esistono **due modi opposti di chiudere un tipo**:

```
POSITIVI (ℕ, Id):   chiusura per ESISTENZA
                    "c'è un altro abitante?" → si escludono (o si lascia aperto)
                    per Id la base tace → sottodeterminato

NEGATIVO (Π) + η:   chiusura per IDENTIFICAZIONE
                    "e se ci fosse un non-λ?" → non lo si nega: lo si ASSORBE,
                    indistinguibile da λx.(-)x
```

I positivi chiudono *escludendo*; il negativo chiude *identificando*. Il criceto non viene bandito dall'universo — viene *invitato e ribattezzato* `λx. criceto x`, e nessuno dentro la teoria potrà mai accorgersi che sotto il cofano c'era un roditore invece di un binder.

---

## Conclusione: cosa la teoria afferma, e cosa tace

Il filo, riavvolto:

- **β e ι non descrivono, costituiscono.** Sono il giunto che rende un costruttore qualcosa di più di un simbolo. `rec z s zero ▷ z` è tautologico solo *dopo* aver capito che `z` *è* la risposta per zero.
- **La chiusura è intro + elim.** Gli introduttori danno il limite inferiore («almeno»), l'eliminatore quello superiore («al più»), la regola di calcolo la coerenza. Cambia l'eliminatore e cambi quanto chiudi.
- **`J` vs `K` non è pulizia notazionale.** Data la forma di `Id`, la regola di calcolo è forzata, ma *quale eliminatore* prendere come primitivo no. `J` tiene due estremi liberi e propaga da `refl`; `K` incolla gli estremi e impone UIP. La base sceglie `J` e tace sul resto — perché tacere la rende il tronco comune da cui si diramano sia la teoria set-troncata (`+K`) sia HoTT (`+univalenza`, dove `K` è *falsa*).
- **L'indeterminazione non è platonismo.** «Indipendente» non è «vero-ma-nascosto»: è «non ho costruito né uno né più di uno». Come il centro di «un gruppo», la cardinalità delle prove dipende dall'istanza. `Bool` la fissa a uno (Hedberg, da decidibilità); `Bool = Bool` in Cubical la fissa ad almeno due, col testimone `ua(not)` sul tavolo. In nessun caso un «esiste» che non si tocca.
- **Le funzioni chiudono dall'altro lato.** `Π` è negativo: η garantisce che ogni abitante *è* una funzione (chiusura per identificazione, intensionale), ma *non* che funzioni co-comportanti siano uguali (funext, estensionale, opzionale). Sull'asse dell'identità, `Π` e `Id` hanno lo stesso buco: la base non fissa «cosa conta come lo stesso».

La morale, in una riga: **in teoria dei tipi ciò che resta libero non è «cosa esiste», ma «cosa conta come lo stesso» — e la teoria-base è abbastanza onesta da non spacciare il secondo per il primo.** La chiusura, quando arriva, è la stanchezza di chi prova a costruire il controesempio e non ci riesce — oppure, dall'altro lato, è la cecità deliberata che non distingue un criceto dalla sua ombra-λ. Mai la certezza metafisica che un fantasma non esista. La type theory non promette «non c'è altro». Promette, al massimo, «non lo esibirai» — e su `Id`, con squisita onestà, ritira pure quella.
