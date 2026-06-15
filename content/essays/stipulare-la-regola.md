---
title: "Stipulare la regola"
date: 2026-06-15
abstract: >
  La regola di ∀-introduzione non descrive un «per ogni» preesistente:
  lo costituisce. Questo saggio segue il gesto inferenziale — la scarica
  dell'ipotesi, il legame simultaneo su termine e tipo, la condizione di
  freschezza che traduce «arbitrario» in «universale» — fino alla tesi che
  il significato è ciò che la regola permette. Ma la stipulazione non è
  arbitrio: l'armonia la vincola, e decido la regola, non le sue conseguenze
  — la consistenza non è stipulabile, né dimostrabile dall'interno (Gödel-II),
  solo dall'esterno e a caro prezzo. Lo stesso atto costitutivo si ripete su
  tre piani: la regola costituisce il quantificatore, la scrittura costituisce
  l'intenzione, la frase costituisce il pensiero vago. Un atto che determina
  ciò di cui sembrava mera esecuzione, partendo non dal nulla ma da un vincolo
  capace di riconoscere il falso prima di possedere il vero.
---

## I. Il sospetto iniziale

C'è un momento, leggendo una regola d'inferenza, in cui si ha la sensazione che qualcosa venga fatto passare troppo in fretta. Si prende una regola innocua, di quelle che ogni manuale di teoria dei tipi scrive senza commento, e si guarda il salto dalla premessa alla conclusione:

$$\frac{\Gamma,\; x : A \;\vdash\; b : B(x)}{\Gamma \;\vdash\; \lambda(x).b \;:\; \Pi(x{:}A).\, B(x)}$$

Sopra la barra ho una derivazione condotta in un contesto in cui $x : A$ è un'ipotesi attiva: una variabile fissa, posata lì, di cui non so nulla se non il suo tipo. Sotto la barra ho un termine $\lambda(x).b$ che abita un tipo dipendente $\Pi(x{:}A).\, B(x)$ — e quel $\Pi$, per la corrispondenza di Curry–Howard, *è* il quantificatore universale. Ho costruito una prova del «per ogni».

La domanda che vale la pena prendere sul serio, invece di scavalcarla, è: **dove, esattamente, in questo passaggio, ho guadagnato il "per ogni"?** Perché tra il dire «sia $x$ un elemento qualsiasi di $A$» e il dire «per ogni $x$ in $A$» c'è uno scarto. Non è un'identità tipografica. È un salto di sintassi, e i salti di sintassi vanno pagati. La tentazione è di liquidarlo dicendo: «be', tanto $x$ era arbitrario, quindi non importa quale fosse, quindi vale per tutti». Ma questa è una scorciatoia, non una giustificazione. "Arbitrario" e "universale" non sono la stessa cosa, e fingere che lo siano significa saltare proprio il passo che si voleva capire.

Questo scritto è il tentativo di non saltarlo.

---

## II. Dove sta il peso del «per ogni»

Cominciamo con ciò che la regola, scritta per intero, effettivamente fa. Il passaggio sopra→sotto non nasconde la generalizzazione: la rende visibile, purché si guardi nel posto giusto. Il peso del «per ogni» è interamente in tre movimenti simultanei.

Il primo è la **scarica dell'ipotesi** (*discharge*). Sopra la barra $x : A$ sta nel contesto $\Gamma$: è un'assunzione viva, qualcosa di cui la derivazione si serve. Sotto la barra $x : A$ non è più in $\Gamma$. È migrato. È diventato il binder $\lambda(x)$ nel termine e il binder $\Pi(x{:}A)$ nel tipo. Quel movimento — da ipotesi-nel-contesto a variabile-legata-nella-conclusione — *è* la generalizzazione universale. Non è un effetto collaterale del passaggio: è il passaggio. È lì, e solo lì, che il «per ogni» viene pagato.

Il secondo è il **legame simultaneo su due piani**. La stessa $x$ viene vincolata nello stesso istante nel termine ($\lambda(x).b$, la prova) e nel tipo ($\Pi(x{:}A).B(x)$, la proposizione). Non c'è un momento «e poi aggiungo il quantificatore». Il quantificatore *è* il $\Pi$, e compare perché la regola lo introduce. Curry–Howard non è una metafora qui: il $\lambda$ *è* la prova del $\forall$, il $\Pi$ *è* il $\forall$.

Il terzo è l'unica cosa che la scrittura abbreviata effettivamente sottintende: la **condizione di freschezza**. La regola è corretta solo se $x$ non compare libera in $\Gamma$:

$$\frac{\Gamma,\; x : A \;\vdash\; b : B(x) \qquad x \notin \mathrm{FV}(\Gamma)}{\Gamma \;\vdash\; \lambda(x).b \;:\; \Pi(x{:}A).\, B(x)}$$

In molte presentazioni questa condizione resta implicita, affidata alla convenzione di Barendregt — le variabili legate si assumono sempre fresche. Ma è precisamente la condizione che traduce «arbitrario» in «universale». Ed è qui che il sospetto iniziale trova la sua risoluzione: **"arbitrario" non è "universale", ed è la freschezza a impedire che lo siano gratuitamente.** Se $x$ comparisse già libera in $\Gamma$ — se cioè il contesto avesse già detto qualcosa su quella $x$ — la scarica sarebbe illecita, e il «per ogni» non si darebbe. Un'equivalenza non ha condizioni laterali. Una regola sì. Quello che la regola fa non è identificare due nozioni: è collegarle *sotto condizione*, e marcare con la condizione il confine oltre il quale il collegamento si rompe.

---

## III. Siamo noi a dire che quel movimento è generalizzazione

Stabilito *dove* sta il peso, resta la domanda più scomoda: in virtù di cosa quel movimento *conta* come generalizzazione?

La risposta onesta è spiazzante. Non c'è nulla, *dentro* i simboli $\lambda$, $\Pi$, dentro la barra, dentro il tragitto di $x$ dal contesto al binder, che intrinsecamente *significhi* «per ogni». Sono segni e una regola di riscrittura su giudizi. Siamo noi che, scrivendo la regola in quella forma e con quella condizione di freschezza, **decidiamo che quel movimento conti come generalizzazione universale**. Il significato del $\forall$ è dato dalla regola, non scoperto nella notazione. Non stiamo tracciando con una notazione un «per ogni» platonico preesistente: stiamo *costituendo* il «per ogni» tramite la regola.

Questa è la tesi inferenzialista nella sua forma più nuda — la linea che va da Gentzen a Prawitz a Dummett: **le regole di inferenza definiscono il significato delle costanti logiche.** Il quantificatore universale non è nient'altro che il suo comportamento inferenziale: la coppia formata dalla sua regola di introduzione (come lo costruisci: scarichi $x$ dal contesto) e dalla sua regola di eliminazione (come lo usi: da $f : \Pi(x{:}A).B(x)$ e $a : A$ ricavi $f\,a : B(a)$). Il significato *è* l'uso, e l'uso è ciò che le due regole, insieme, permettono. Non c'è un senso che esista *prima* del suo impiego regolato e che le regole poi descrivano. È la stessa lettura del senso come prova che ho seguito altrove, in [*La verità non abita altrove*](../la-verita-non-abita-altrove): la prova non raggiunge una verità che la precede, la costituisce.

A questo punto sorge spontanea l'obiezione, ed è bene affrontarla invece di nasconderla. Si dirà: ma noi *scegliamo* proprio quella regola, e non un'altra, perché ci appare naturale — perché la pratica del matematico che dice «preso $x$ generico…» ci suggerisce già che arbitrario equivalga a universale. Dunque, in fondo, l'intuizione dell'equivalenza è ciò che guida la mano.

La distinzione da tenere ferma è tra **ciò che motiva** una regola e **ciò che la giustifica**. È vero che l'intuizione «arbitrario ↦ universale» rende la $\forall$-introduzione la candidata ovvia: è la *ragione* per cui scegliamo quella regola e non un'altra. Ma «motivata da» non è «giustificata da». Se l'intuizione fosse la giustificazione, la regola sarebbe valida per evidenza introspettiva, e ricadremmo nello psicologismo che Frege ha demolito una volta per tutte: la logica non si fonda su come funziona la nostra mente. L'intuizione apre la porta; non firma il permesso. Chi firma il permesso è qualcos'altro, e ha un nome proof-theoretico.

---

## IV. L'armonia, ovvero perché non possiamo stipulare a casaccio

Se il significato è ciò che la regola permette, allora siamo noi a stipularlo. Ma questa libertà non è arbitrio. C'è un vincolo, ed è interno alla logica stessa, non importato da fuori.

Il vincolo è l'**armonia** tra introduzione ed eliminazione (Prawitz, Dummett). La regola che introduce il $\Pi$ (scarico $x$ dal contesto) e la regola che lo elimina (l'applicazione) devono combaciare: devo poter eliminare esattamente ciò che ho introdotto, senza guadagnare informazione che non avevo messo, senza perderne. La verifica che le due regole sono armoniche *è* la β-riduzione: $(\lambda(x).b)\,a$ si riduce a $b[a/x]$. L'eliminazione disfa precisamente l'introduzione. Niente avanza, niente manca. È lo stesso patto promessa-riscossione che ho discusso in [*Una promessa e il modo di riscuoterla*](../una-promessa): gli introduttori promettono, gli eliminatori riscuotono esattamente ciò che è stato promesso.

Il controesempio classico è il connettivo `tonk` di Arthur Prior: un connettivo con una regola di introduzione presa da una parte e una di eliminazione presa dall'altra, scelte in modo che *non* combacino. Il risultato è che `tonk` permette di derivare qualsiasi cosa da qualsiasi cosa: il sistema esplode. `tonk` mostra che non ogni stipulazione è legittima — che «definire un connettivo tramite regole» non è una licenza incondizionata. Una stipulazione disarmonica produce un mostro: un simbolo il cui "uso permesso" include $\bot$, l'assurdo, e con esso tutto.

Ecco dunque la posizione precisa. Siamo noi a stipulare l'uso, e l'uso è il significato — ma la stipulazione non è gratuita: è vincolata dall'armonia. E l'armonia, a sua volta, è ciò che si manifesta, su scala globale, come **normalizzazione** dei termini, ovvero come il **Hauptsatz** di Gentzen: il teorema di eliminazione del taglio. La β-riduzione del λ-calcolo dipendente *è* la cut-elimination della deduzione — è il filo che ho seguito in [*Sotto le lettere, il taglio*](../sotto-le-lettere-il-taglio). Normalizzazione forte e Hauptsatz sono i due volti — type-theoretic e proof-theoretic — della stessa coerenza interna.

Vale la pena fermarsi su un equivoco tentante, perché è facile cadervi. Si potrebbe pensare che il Hauptsatz sia ciò che ci permette di «non nominare mai il per ogni», di usare la notazione corta $\Pi(x{:}A).B(x)$ senza riscrivere ogni volta il quantificatore. Non è così, e confondere le due cose nasconde la struttura. Ci sono due «risparmi» distinti e indipendenti. Il primo è puramente notazionale: poter scrivere $\Pi(x{:}A).B$ come il modo di scrivere il tipo, con la $x$ legata gestita dalla convenzione sul binding. Questo è zucchero sintattico, ed è permesso dalla *regola di formazione*, non dal Hauptsatz. Il secondo è l'eliminazione dei *passi intermedi* — ed è il Hauptsatz, ma ciò che esso elimina sono i **tagli** (i lemmi, le composizioni di derivazioni), non i quantificatori. Anzi: il corollario del Hauptsatz, la *subformula property*, garantisce che il $\forall$, se compare nella conclusione, compare come sottoformula nei passi della derivazione normale. Il Hauptsatz *preserva* il quantificatore; non lo cancella. Il legame vero tra il quantificatore e il Hauptsatz non è «il taglio mi risparmia di scrivere $\forall$», ma «la β-riduzione che disfa la $\forall$-introduzione è la cut-elimination» — cioè l'armonia che rende quella regola buona, e non `tonk`.

---

## V. Decido la regola, non le conseguenze

Mettiamo insieme i fili fin qui. Stipulando la regola, decido il significato e insieme delimito ciò che è permesso derivare. Non sono due atti: la barra d'inferenza non *descrive* un comportamento, lo **costituisce**. Dire *come si comporta* il simbolo (cosa scarico, cosa lego, sotto quale condizione) *è già* dire *cosa autorizzo* (quali derivazioni esistono, quali no). Significato ed estensione del lecito sono la stessa cosa vista da due lati.

Ma — ed è il confine che salva questa posizione dal convenzionalismo ingenuo — **decido la regola, non le sue conseguenze.** Sono libero di porre la $\Pi$-introduzione in quella forma, di chiamare «per ogni» quel movimento. Quello è un atto, non una scoperta. Una volta posta, però, non decido più io se la regola è armonica, se normalizza, se è conservativa, se evita l'esplosione. Quello è fissato dalla regola stessa, contro cui non ho più voce. **Posso stipulare `tonk`; non posso stipulare che `tonk` sia consistente.** La consistenza non è in mio potere stipulativo.

È qui che il convenzionalismo puro si spezza. La libertà è sulla *posizione* delle regole; la necessità è su *cosa segue* dal sistema che ho posto. E questa necessità ha la forma, ineludibile, del paradosso wittgensteiniano del seguire-la-regola: se ogni applicazione successiva fosse di nuovo libera interpretazione, non avrei stipulato alcuna regola — avrei stipulato nulla. La normatività che creo stipulando è precisamente ciò che, da quel momento, non è più a mia disposizione turno per turno. Mi vincolo. La libertà si spende nell'atto di porre la regola; la necessità è ciò a cui mi consegno ponendola. È una libertà che si esercita una volta sola e poi diventa legge.

---

## VI. Non posso dimostrare, dall'interno, di non generare mostri

C'è un ultimo gradino, e porta un nome preciso.

Ho stipulato le regole. La garanzia che non producano $\bot$ — il mostro, l'esplosione in cui tutto diventa derivabile — non è tra i teoremi del sistema. E non lo è *necessariamente*: è il **secondo teorema di incompletezza di Gödel**. Un sistema sufficientemente espressivo e coerente non può dimostrare la propria coerenza con i propri mezzi. Se $T \vdash \mathrm{Con}(T)$, allora $T$ è incoerente. Paradossalmente, l'unico sistema che «dimostra di non generare mostri» è proprio quello che li genera tutti: la rassicurazione interna è il sintomo della malattia, non la prova della salute.

Questo si innesta esattamente sulla struttura del paragrafo precedente. Poiché la regola *è* il confine del permesso, chiedere «il sistema dimostra di non permettere mostri?» è chiedere al confine di certificare sé stesso restando dentro il territorio che esso stesso delimita. Non può: dovrebbe collocarsi fuori dal proprio perimetro per guardarlo, ma esso *è* il perimetro.

Eppure questo non conduce al nichilismo, e la distinzione che lo evita è la stessa che attraversa tutto lo scritto: **non posso dimostrare la consistenza dall'*interno*; posso dimostrarla dall'*esterno*.** E lo si fa davvero. La cut-elimination di Gentzen *è* una prova di consistenza: se ogni derivazione normalizza e nessuna derivazione normale conclude $\bot$, allora $\bot$ non è derivabile. Il Hauptsatz — che ci ha accompagnato dal §IV — è proprio lo strumento con cui si dimostra «il sistema non genera mostri». Solo che lo si paga con una risorsa presa *fuori* dal recinto: Gentzen usa l'induzione transfinita fino all'ordinale $\varepsilon_0$, che l'aritmetica di Peano non sa di poter scalare. Si sposta il punto d'appoggio in un metasistema più forte, e *lì* la consistenza si dimostra.

Il che riproduce, un piano più in alto, la stessa dialettica di libertà e necessità. Per fidarmi del sistema-oggetto devo stipulare un metasistema; ma quel metasistema, a sua volta, non dimostra la *propria* consistenza. La domanda «ma è davvero senza mostri?» non viene mai chiusa *dentro*: viene solo *spostata in alto*. È una regressione che non tocca fondo, perché un livello finale auto-garantito sarebbe di nuovo un sistema che dimostra $\mathrm{Con}$ di sé — di nuovo Gödel-II a vietarlo.

La posizione esatta, allora, è triplice e va tenuta tutta insieme: la coerenza **non è stipulabile** (decido le regole, non le conseguenze); **non è dimostrabile dall'interno** (Gödel-II); **è dimostrabile dall'esterno**, ma solo assumendo di più — e quel «di più» eredita lo stesso buco. L'assenza di mostri non è mai qualcosa che *possiedo*; è qualcosa di cui mi fido su basi che stanno sempre un gradino oltre ciò che ho formalizzato. Stipulare la regola è stato un atto libero; verificarla è un atto che richiede sempre di stare *fuori* da ciò che si verifica. Dentro, resto — necessariamente, dimostrabilmente — senza quella prova.

---

## VII. L'intenzione non precede la regola: la regola la completa

Fin qui ho parlato del simbolo stipulato. Ma c'è un movimento ulteriore, ed è quello che dà allo scritto il suo senso non solo logico ma — diciamo la parola — esistenziale. Riguarda *me* che stipulo, non il $\Pi$ stipulato.

La tentazione è descrivere la stipulazione così: ho in mente *come voglio che il sistema si comporti*, e poi trascrivo quella volontà in una regola. La regola obbedirebbe a un'intenzione già completa. Ma è falso, ed è falso per la stessa ragione per cui il significato non precede l'uso. Finché «come voglio che si comporti» sta nella mia testa come intenzione, **è indeterminato.** Non c'è, nella mia mente, prima di scrivere la regola, una risposta già pronta a *ogni* applicazione futura possibile. È di nuovo il rule-following: l'intenzione «voglio che generalizzi così» non contiene già in sé tutti i casi. È **scrivendo la regola** che l'intenzione si determina, all'infinito, caso per caso. La regola non *esprime* una volontà già piena; la **completa**.

Per questo «la regola è esattamente come voglio che il sistema si comporti» è vero in un senso e ingannevole nell'altro. È vero che non c'è un metro esterno: nessun comportamento «corretto» indipendente contro cui misurare la regola, nessun $\forall$ platonico. La regola è sovrana, il mio volere ne è la fonte. È ingannevole se lo leggo come «la regola conforma a un volere preesistente e completo»: quel volere completo non c'era. La regola non obbedisce alla mia intenzione, la **costituisce**. «Come voglio» e «cosa la regola fa» coincidono non perché la seconda azzecca la prima, ma perché la prima non esiste pienamente *fuori* dalla seconda.

Stipulare non è dunque trascrivere una volontà in simboli. È il gesto in cui la volontà — che prima era solo una spinta verso «qualcosa che generalizzi» — diventa per la prima volta una cosa precisa, con un dentro e un fuori, un lecito e un illecito, una condizione di freschezza che taglia. Mi do la legge, e nel darla scopro cosa volevo, che prima di darla non era ancora interamente lì.

---

## VIII. La stessa forma su tre piani

A questo punto la struttura si lascia vedere intera, e si ripete tre volte.

**Sul piano del simbolo:** la regola non descrive un «per ogni» che c'era, lo costituisce — ma è vincolata dall'armonia, non è arbitraria.

**Sul piano dell'intenzione:** il volere non precede la regola; la regola lo completa — ma c'era una spinta, una direzione, non il nulla.

**Sul piano del pensiero:** l'idea non precede la frase; la scrittura la fissa — ma c'era un criterio, una vaghezza che già sapeva dire di no.

Quest'ultimo piano merita un'ultima precisazione, perché è quello in cui si scrive davvero. Si parte da un'idea vaga; la si trascrive; e finalmente diventa non «ciò che si voleva dire» — come se ci fosse un bersaglio preesistente che la scrittura raggiunge — ma **l'unica cosa che ora si vuole dire**. Il bersaglio è prodotto nell'atto di tirare. Prima: vago, cioè molte continuazioni ancora possibili, nessuna privilegiata. Dopo: una, e le altre non sono più mie.

Eppure la vaghezza iniziale non era *niente*. Non si parte dal vuoto. Era una direzione senza contenuto — abbastanza per sentire che una trascrizione *tradisce* e un'altra *coglie*. E qui sta la cosa strana, quella che tiene insieme tutto: come posso riconoscere come mio, *dopo* averlo scritto, qualcosa che prima non possedevo? La risposta è che l'idea vaga non conteneva la frase, ma conteneva i *criteri* per accettarla o rifiutarla una volta apparsa. Era un **vincolo**, non un disegno. Determinava il fuori — cosa non andava bene — prima del dentro. Per questo posso sbagliare a trascrivermi, segno che *qualcosa* c'era; e insieme non sapere cosa volevo finché non l'ho scritto, segno che quel qualcosa non era ancora la frase.

È la stessa cosa, esattamente, dell'armonia che vincola la stipulazione senza dettarla, e della freschezza che condiziona la scarica senza compierla. Tre volte la medesima forma: **un atto che determina ciò di cui sembrava mera esecuzione, partendo non dal nulla ma da un vincolo capace di riconoscere il falso prima di possedere il vero.** Libertà che si spende fissando, contro un fondo che non è disegno ma è abbastanza da non essere caos.

E allora il passaggio dal vago all'unico — dall'intenzione indeterminata alla frase che la chiude — *è* il passaggio da $\Gamma,\, x : A \vdash$ a $\Gamma \vdash \Pi(x{:}A).B(x)$. Si scarica l'indeterminato nel binder, e ciò che resta sotto la barra è determinato. La regola d'inferenza con cui ho aperto non era un esempio scelto a caso per illustrare una tesi sul linguaggio: era già la tesi. Il gesto di stipulare il «per ogni» e il gesto di trascrivere un pensiero vago fino a renderlo l'unico che si vuole sono lo stesso gesto. Me lo sono dimostrato addosso.
