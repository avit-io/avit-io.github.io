---
title: "Una promessa e il modo di riscuoterla"
date: 2026-06-09
abstract: "Introduttori ed eliminatori, induzione e ricorsione, letti dal luogo che li rende sensati: le meaning explanations. Una lectio sul perché gli eliminatori non si inventano — si riscuotono da ciò che gli introduttori hanno promesso — e su cosa cambia quando, per comodità, andiamo a guardarli da un altrove categoriale."
---

## Da dove descriviamo la MLTT?

Cominciamo da una domanda che di solito si salta, e che invece decide il senso di tutto ciò che diremo dopo: da quale luogo stiamo parlando? Ogni volta che enuncio una proprietà della teoria dei tipi di Martin-Löf (Martin-Löf Type Theory, MLTT) — «l'eliminatore è determinato dagli introduttori», «vale l'armonia», «questo tipo è iniziale» — quell'enunciato non galleggia nel vuoto: vive in un metalinguaggio, e cambia significato a seconda del metalinguaggio in cui lo pronuncio.

Il punto non è pedanteria. È che nessuna fondazione si solleva da sola, come il barone di Münchhausen che pretendeva di tirarsi fuori dalla palude per i propri capelli. Se descrivo la MLTT dall'interno della MLTT formalizzata in Agda, sto usando teoria dei tipi per descrivere teoria dei tipi: pratica utilissima, ma non una fondazione — Agda non giustifica le regole, le esegue, dato per buono il proprio nucleo. Se la descrivo dall'interno della teoria degli insiemi, sto in piedi su qualcosa di più grande, e ho solo spostato la palude. Il trilemma è inaggirabile: o regredisco all'infinito, o giro in tondo, o mi fermo da qualche parte per decisione.

Ci sono, onestamente, tre luoghi da cui guardare. Il primo è **interno al significato**: le *meaning explanations* di Martin-Löf, che giustificano le regole non appoggiandole a un altro formalismo, ma a un resoconto pre-matematico di cosa sia un elemento canonico (canonical form) e cosa sia computare. Il secondo è **categoriale/algebrico**: si entra in una metateoria più ricca e si osservano proprietà — algebra iniziale (initial algebra), proprietà universale, catamorfismo. Il terzo è **dimostrativo** (proof-theoretic): metateoria volutamente povera, dopo Gödel, in cui l'armonia diventa un teorema di normalizzazione.

In questa lectio scelgo il primo come **casa**. Gli altri due li visiterò, ma ogni volta dichiarando di uscire e poi rientrando: sono modi di parlare *da un altrove*. La regola che mi do è semplice e severa — non contrabbandare mai il vocabolario dell'altrove dentro una frase che finge di essere interna alla MLTT.

---

## La grammatica di Gentzen

La forma su cui tutto poggia è di Gerhard Gentzen. Nella deduzione naturale ogni costrutto si presenta con due tipi di regole: le regole di **introduzione**, che dicono come asserirlo, come fabbricarne un abitante; e le regole di **eliminazione**, che dicono come servirsene. Per la congiunzione: la introduco mettendo insieme una prova di *A* e una di *B*; la elimino estraendone *A*, oppure *B*. Per l'implicazione: la introduco scaricando un'assunzione, la elimino con il modus ponens.

C'è una metafora che terrò per mano fino alla fine. La regola di introduzione è **una promessa**: «ecco come si fa una cosa di questo tipo, ecco che aspetto ha una sua testimonianza canonica». La regola di eliminazione è **il modo di riscuotere quella promessa**: dato che ho in mano una cosa di quel tipo, ecco a cosa ho diritto. Tutta la storia di questo saggio è la storia di un vincolo tra le due: la riscossione deve dare esattamente ciò che è stato promesso. Né meno, né più.

---

## L'armonia, vista da casa

Visto da casa — dalle meaning explanations — quel vincolo non è un teorema che dimostro altrove. È la **condizione stessa di sensatezza** delle regole. Conoscere un tipo *significa* sapere quali siano le sue forme canoniche: ed è precisamente ciò che gli introduttori stabiliscono. Gli introduttori non descrivono un dominio preesistente, lo *istituiscono*. La promessa, qui, viene prima dell'oggetto.

Gli eliminatori, allora, non sono liberi: sono *responsabili* davanti a quel significato. La loro giustificazione è una sola, ed è elegante: poiché ogni elemento chiuso del tipo computa a una forma canonica, per definire un'operazione su tutti gli elementi basta dire cosa fa sulle forme canoniche, cioè sui costruttori. Riscuotere significa agire per casi sulla promessa.

Da qui i due lati dell'**armonia (harmony)**, nel senso di Dag Prawitz e Michael Dummett. La *local soundness* dice che la riscossione non pretende più di quanto sia stato promesso: una introduzione immediatamente seguita da una eliminazione è una deviazione (detour) che si può cancellare — è la riduzione β, che disfa esattamente ciò che il costruttore aveva composto. La *local completeness* dice che la riscossione è abbastanza ricca da ricostruire ciò che era stato promesso: ogni termine si può ri-espandere come la sua eliminazione seguita da una re-introduzione — è l'espansione η. Soundness: l'eliminatore non bara. Completeness: l'eliminatore non lascia nulla sul tavolo. Insieme, dicono che promessa e riscossione combaciano.

---

## Curry–Howard: la promessa è un programma

Tutto questo ha un secondo nome, per chi viene dall'informatica. Nella corrispondenza di Curry–Howard le proposizioni sono tipi e le prove sono programmi (termini). Allora la regola di introduzione è la **costruzione** di un dato, e la regola di eliminazione è la sua **computazione**. La riduzione β — che per il logico era la cancellazione di una deviazione nella prova — per il programmatore è semplicemente l'esecuzione: applicare una funzione a un argomento. La promessa è un valore costruito; riscuoterla è calcolare. Che le due letture siano la stessa cosa non è un gioco di parole: è il motivo per cui l'armonia logica e la buona definizione dei programmi sono il medesimo fenomeno guardato da due lati.

---

## FIEC: i numeri naturali

Portiamo la promessa su un caso concreto, e adottiamo la mappa in quattro tempi che governa ogni tipo induttivo — **FIEC**: Formazione, Introduzione, Eliminazione, Computazione.

La **Formazione** dichiara che c'è un tipo. La **Introduzione** ne fissa le forme canoniche, cioè la promessa: un naturale è `zero`, oppure il `succ` di un naturale, e nient'altro.

{{< rawhtml >}}
<pre class="Agda">
data ℕ : Set where
  zero : ℕ
  succ : ℕ → ℕ
</pre>
{{< /rawhtml >}}

La **Eliminazione** è il modo di riscuotere. Nella sua forma non dipendente è il **ricorsore**: per usare un numero basta dire cosa fare su `zero` e cosa fare a ogni passo di successore — i due casi promessi, niente di più.

{{< rawhtml >}}
<pre class="Agda">
rec : {C : Set} → C → (ℕ → C → C) → ℕ → C
rec z s zero     = z
rec z s (succ n) = s n (rec z s n)
</pre>
{{< /rawhtml >}}

La **Computazione** è la coppia di equazioni che vedete a destra dei segni di uguale: `rec z s zero` riduce a `z`, `rec z s (succ n)` riduce a `s n (rec z s n)`. Sono le regole β dell'eliminatore, ed è qui che la riscossione "consuma" la promessa caso per caso.

Resta un'osservazione che è il cuore del legame fra induzione e ricorsione, e che troppi corsi presentano come due cose. Sono **una sola regola**. Se al bersaglio fisso `C` del ricorsore lascio dipendere dal numero — `P n` invece di `C` — ottengo l'eliminatore dipendente, che è esattamente il **principio di induzione**.

{{< rawhtml >}}
<pre class="Agda">
ind : (P : ℕ → Set)
    → P zero
    → ((n : ℕ) → P n → P (succ n))
    → (n : ℕ) → P n
ind P z s zero     = z
ind P z s (succ n) = s n (ind P z s n)
</pre>
{{< /rawhtml >}}

Guardate le due definizioni una accanto all'altra: la trama è identica. La ricorsione è l'eliminatore con motivo (motive) costante; l'induzione è l'eliminatore con motivo dipendente. La differenza non è nel meccanismo, è solo in *cosa* promettiamo di costruire — un valore sempre dello stesso tipo, oppure una prova che varia con il numero. Da qui, ogni funzione si scrive riscuotendo. L'addizione, per esempio, è solo il ricorsore travestito:

{{< rawhtml >}}
<pre class="Agda">
_+_ : ℕ → ℕ → ℕ
m + n = rec n (λ _ r → succ r) m
</pre>
{{< /rawhtml >}}

E la stessa trama si ripete identica su qualunque altro tipo induttivo. Per le liste, l'eliminatore ha un nome che il programmatore conosce: `foldr`.

{{< rawhtml >}}
<pre class="Agda">
data List (A : Set) : Set where
  []  : List A
  _∷_ : A → List A → List A

foldr : {A B : Set} → (A → B → B) → B → List A → B
foldr f e []       = e
foldr f e (x ∷ xs) = f x (foldr f e xs)
</pre>
{{< /rawhtml >}}

Questi frammenti vanno letti come **pratica interna**: stiamo computando con l'eliminatore, non stiamo fondando nulla. Agda qui è il banco di lavoro, non il tribunale.

---

## Una digressione da un altrove: l'algebra iniziale

Ora esco di casa, e lo dichiaro. Entro nella **metateoria categoriale**, e da lì le quattro regole FIEC prendono una forma sorprendentemente compatta. I costruttori `zero` e `succ` di ℕ si impacchettano in una sola mappa che dà un punto e un endomorfismo; un oggetto così attrezzato è un'*algebra* per il funtore $F(X) = 1 + X$. La regola di eliminazione più la regola di computazione, insieme, affermano una cosa precisa di questa algebra: che è **iniziale**. Per ogni altra algebra esiste *uno e un solo* omomorfismo che parte da ℕ e ne rispetta la struttura — ed è esattamente il ricorsore. È l'oggetto numerico naturale di Lawvere: l'eliminatore è il **catamorfismo unico**, e la sua unicità è la proprietà universale.

Questo altrove è illuminante. Ci dice *perché* il ricorsore ha proprio quella forma e non un'altra: non è una scelta, è ciò che l'inizialità impone. Ma adesso devo rientrare a casa, e dire con onestà cosa quell'osservazione **non** può fare. Dentro la MLTT, l'unicità dell'omomorfismo non è un'uguaglianza giudizionale: vale solo fino a uguaglianza proposizionale (propositional equality), e per dimostrarla servono l'estensionalità funzionale (function extensionality) o la regola η dell'eliminatore — più, naturalmente, l'induzione stessa per mostrare che le due funzioni coincidono punto per punto. La proprietà universale, importata all'interno, si indebolisce. La lettura categoriale **chiarisce** la forma degli eliminatori; non li **fonda**. La fondazione resta dov'era: nel fatto che ogni ℕ computa a una forma canonica, e che riscuotere per casi su quelle forme è sensato. L'inizialità è un bel ritratto della casa, fatto dalla strada; non è la casa.

Se mi concedessi un secondo altrove, quello dimostrativo, vedrei la stessa armonia ancora diversa: lì il principio di inversione di Prawitz diventa un *teorema* su un sistema di prove — normalizzazione, proprietà della sottoformula — in una metateoria abbastanza debole da non rendere vuoto il discorso. Anche questa è una vista dalla strada: osserva, non istituisce.

---

## Riscuotere è ricordare la promessa

Torniamo, per chiudere, alla casa e alla metafora. «Gli eliminatori si recuperano dagli introduttori» non è, da qui, un teorema preso in prestito da una teoria più grande: è la condizione che rende le regole sensate. La promessa fissata dai costruttori determina, fino in fondo, il modo legittimo di riscuoterla. Per questo, in un assistente di prova, quando scrivete una dichiarazione `data` non vi viene chiesto di inventare l'eliminatore: il sistema lo *genera*, perché era già contenuto, per intero, nei costruttori. L'input siete voi che fate la promessa; l'eliminatore è l'output meccanico.

E si capisce, allora, anche cosa custodisce questa disciplina. Prior immaginò un connettivo, *tonk*, con la regola di introduzione di una disgiunzione e quella di eliminazione di una congiunzione: una promessa minuscola e una riscossione esorbitante. Il risultato è che si dimostra qualunque cosa — la disarmonia è l'incoerenza. L'armonia, vista da casa, è esattamente ciò che impedisce a un linguaggio di promettere poco e pretendere molto. Tenere insieme la promessa e il modo di riscuoterla non è un'eleganza formale: è il patto che tiene onesto l'intero edificio. E sapere da dove lo stiamo guardando — questo, prima di tutto — è ciò che ci tiene onesti noi.
