---
title: "Per una matematica del senso"
date: 2026-06-10
abstract: "Brouwer sosteneva che la matematica fosse un'attività della mente, libera dal linguaggio, anteriore a qualunque sistema formale. Questo saggio segue quella tesi fino in fondo — non come curiosità storica, ma come domanda viva: cosa significa fare matematica se gli oggetti non esistono prima di essere costruiti? La risposta cambia non solo gli strumenti, ma il senso stesso di ciò che si fa."
---

## Una domanda che di solito si salta

Quando un matematico annuncia che ha dimostrato un teorema, che cosa ha fatto esattamente?

La risposta ovvia è: ha trovato una sequenza di passi che porta dalle ipotesi alla conclusione. Ma questa risposta descrive la forma del risultato, non il suo carattere. Dietro c'è una domanda più profonda: il teorema era già vero prima della dimostrazione? Il matematico ha *scoperto* qualcosa che esisteva, o ha *prodotto* qualcosa che prima non c'era?

La maggior parte dei matematici, in pratica, risponde come platonisti: le verità matematiche esistono in modo necessario e indipendente, la dimostrazione è il percorso che le raggiunge. Il lavoro del matematico è esplorativo — cartografa un territorio che non ha creato.

L'intuizionismo parte da una risposta diversa. Non come eccezione tecnica alla matematica ordinaria, ma come risposta radicalmente alternativa alla domanda su cosa sia la matematica. Seguire quella risposta fino in fondo cambia tutto: gli oggetti, i connettivi, il significato dell'esistenza, la natura della verità. Non si tratta di rinunciare a qualcosa — si tratta di partire da altrove.

---

## Brouwer: la matematica è un atto mentale

L. E. J. Brouwer sosteneva che la matematica fosse un'attività della mente — pre-linguistica, pre-formale, radicata nell'intuizione pura della successione temporale. Non una descrizione di oggetti che esistono altrove, ma la costruzione stessa di quegli oggetti, nell'atto del pensarli.

La tesi è più precisa di quanto sembri. Non si dice che la matematica sia *soggettiva*, nel senso che ogni matematico potrebbe avere la sua. Si dice che gli oggetti matematici non hanno esistenza indipendente dall'atto costruttivo che li porta in essere. Il numero due non abita in un reame platonico aspettando di essere scoperto: viene in essere nel momento in cui si compie l'iterazione dell'atto costruttivo che lo costituisce. Ma — e questo è il punto critico — quell'atto è governato da strutture che non sono arbitrarie. La costruzione è vincolata, non inventata liberamente.

Da qui segue il rifiuto del principio del terzo escluso — P ∨ ¬P — ma non come capriccio tecnico. La ragione è questa: affermare P ∨ ¬P significa affermare che P ha già un valore di verità determinato, indipendentemente da qualunque atto costruttivo. Ma se gli oggetti matematici vengono in essere nella costruzione, non c'è "già determinato" che non sia ancorato a una costruzione effettiva. Il terzo escluso non è una verità logica universale: è la proiezione nella logica di un'ontologia platonica, l'assunzione tacita che le proposizioni abbiano valori di verità che abitano da qualche parte prima di essere dimostrate.

Questo non è scetticismo. Non si dice che non possiamo sapere se P è vera. Si dice che la domanda "P è vera prima di essere dimostrata?" è mal posta — non per limiti epistemici, ma per ragioni ontologiche. Non c'è un "prima" rilevante.

---

## Il senso dei connettivi

Una delle conseguenze più concrete di questo impegno riguarda il significato delle costanti logiche.

Nel quadro classico, il significato di un connettivo è dato dalle condizioni di verità: A ∧ B è vero se e solo se A è vero e B è vero. Le condizioni di verità sono determinate da uno stato del mondo — o, in matematica, da una configurazione del reame platonico — indipendentemente dalla nostra capacità di accedervi.

Nell'intuizionismo, il significato di un connettivo è dato da ciò che conta come sua costruzione. Non dalle condizioni che lo renderebbero vero in un mondo ipotetico, ma da ciò che effettivamente si deve fare per asserirlo. Una prova di A ∧ B è una prova di A e una prova di B. Una prova di A → B è un procedimento che, data qualunque prova di A, produce una prova di B. Una prova di ∃x.P(x) è un termine t e una prova di P(t) — non l'indicazione che "da qualche parte nel dominio esiste un x", ma la consegna di quell'x con la sua garanzia.

Questa non è una restrizione sul significato ordinario: è un'alternativa a esso. Il significato intuizionista di A → B non è il significato classico indebolito — è un significato diverso, che descrive una cosa diversa. La differenza diventa visibile sul terzo escluso: classicamente, P ∨ ¬P è immediatamente vera perché il mondo è determinato; intuizionisticamente, P ∨ ¬P richiederebbe una prova di P oppure una prova di ¬P, e non c'è ragione generale per cui una delle due debba essere sempre disponibile.

Dummett aveva formulato questo come una tesi semantica generale: il significato di una proposizione è dato dalle sue *condizioni di verificazione*, non dalle sue condizioni di verità. Capire A → B vuol dire saper produrre B da A — non contemplare la relazione tra i fatti che li renderebbero veri. Il significato sta nell'uso, e l'uso è costruttivo.

---

## La formalizzazione e il suo doppio

Arend Heyting formalizzò la logica intuizionista negli anni Trenta. Brouwer accolse la formalizzazione con distanza — non perché fosse sbagliata, ma perché coglieva il rischio di uno spostamento sottile: quando si scrivono le regole, il centro di gravità si sposta dall'*atto* alle *regole*. Il sistema formale diventa l'oggetto, e il suo studio può procedere indipendentemente dall'impegno filosofico che lo aveva motivato.

Martin-Löf aveva affrontato questo rischio direttamente. Le *meaning explanations* della MLTT non sono parte del sistema — sono il livello pre-matematico che dà senso al sistema. Prima di qualunque regola formale, si spiega cosa sia una forma canonica, cosa significhi computare, cosa conti come elemento di un tipo. Le regole vengono dopo, come modo di regimentare questo livello di significato già stabilito.

La struttura è: significato prima, formalismo dopo. Non il contrario.

Ma questa struttura è fragile nell'uso quotidiano. Un proof assistant implementa le regole — non le spiegazioni di significato. Quando si scrive un termine in Agda o Lean, il type-checker verifica che il termine sia ben tipato: controlla che le regole siano rispettate. Non verifica che l'uso sia filosoficamente coerente, che ci sia un impegno costruttivo soggiacente, che la prova sia costruita nel senso inteso da Martin-Löf. Quelle cose non si possono formalizzare — stanno a monte.

Il sistema è corretto e utile. Ma è un residuo del senso, non il senso stesso.

---

## Cosa cambia ontologicamente

Se si prende sul serio l'impegno costruttivo, la matematica cambia nei suoi oggetti — non solo nelle sue tecniche.

Il continuo costruttivo è diverso dal continuo classico. I numeri reali costruttivi sono sequenze di razionali con un modulo di convergenza specificato: non "sequenze che convergono da qualche parte", ma "sequenze di cui posso calcolare quanto si sono avvicinate in n passi". Questa non è una versione peggiorata del reale classico: è una nozione diversa, più fine sotto certi aspetti. Errett Bishop, costruendo l'analisi costruttiva, ottenne teoremi che nel quadro classico non hanno equivalenti: per esempio, che ogni funzione costruttiva da $[0,1]$ a $\mathbb{R}$ è uniformemente continua — non come assioma aggiuntivo, ma come conseguenza del significato costruttivo di "funzione".

Le funzioni costruttive sono tutte computabili — non come limitazione, ma come conseguenza di ciò che "funzione" significa quando si parte dall'impegno costruttivo: un procedimento effettivo che, dato un input, produce un output. Nel quadro classico si parla di funzioni non computabili come di oggetti legittimi; nel quadro costruttivo quella categoria non ha oggetti, perché una funzione che non sia un procedimento effettivo non è una funzione nel senso pertinente.

Questo è il punto in cui la critica standard all'intuizionismo — "mutila la matematica" — mostra il suo presupposto. La matematica classica non è il termine di paragone naturale da cui l'intuizionismo si discosta: è una possibilità, basata su un impegno ontologico. L'intuizionismo è un'altra possibilità, basata su un impegno diverso. Confrontarle come se una fosse la matematica e l'altra una restrizione è già aver scelto — implicitamente, senza averlo dichiarato.

---

## Il senso come fondamento

La distinzione che l'intuizionismo introduce non è tra matematica con terzo escluso e matematica senza terzo escluso. È tra due risposte alla domanda su cosa siano gli oggetti matematici e cosa significhi che qualcosa esista in matematica.

Per il platonista, esistere vuol dire abitare il reame delle entità matematiche — atemporali, necessarie, indipendenti. La dimostrazione di ∃x.P(x) punta verso quell'abitante senza doverlo consegnare: basta mostrare che deve esserci, per esclusione o per argomento indiretto.

Per l'intuizionista, esistere vuol dire essere costruito — essere un procedimento che si può compiere, un termine che si può esibire, un'operazione che si può eseguire. La dimostrazione di ∃x.P(x) non punta verso niente: *è* la consegna. Non c'è esistenza senza costruzione, e la costruzione non è un certificato di qualcosa che esisteva già — è l'atto che porta in essere l'oggetto.

Questa differenza non è epistemica — non riguarda ciò che possiamo conoscere, ma ciò che c'è. È la differenza tra due ontologie della matematica.

I sistemi formali costruttivi — MLTT, la logica di Heyting, e le loro estensioni — sono tentativi di regimentare l'ontologia costruttiva. Sono strumenti preziosi, e il lavoro tecnico che ci ruota attorno è genuino e importante. Ma non sono la rifondazione: sono la forma scritta di una rifondazione che avviene al livello del senso. Aggiungere assiomi a MLTT per ottenere effetti che si desideravano comunque è un'operazione legittima — ma non è lo stesso di partire dal senso e costruire le regole da lì.

Il lavoro difficile dell'intuizionismo — il lavoro che Brouwer aveva in mente — è quello di chiedersi cosa significhi costruire, cosa conti come forma canonica, perché certe regole siano giustificate e non altre, dove stia il fondamento quando non si può appellare a un reame platonico preesistente. Questo lavoro non si fa nei sistemi formali: si fa al livello in cui Martin-Löf scriveva le meaning explanations, al livello pre-matematico che egli chiamava il punto in cui dobbiamo già concordare su cosa conti come atto di costruzione, prima di poter cominciare.

Non è una fondazione assoluta. È il terreno a partire dal quale si lavora onestamente — con la consapevolezza che le regole che scriviamo dopo dipendono da ciò che abbiamo già capito prima.

---

## La matematica come atto

L'intuizionismo non è una scelta di stile né un'opzione fondazionale tra tante. È una risposta alla domanda su cosa si stia facendo quando si fa matematica.

Se la risposta è: cartografare un territorio che esiste indipendentemente da noi — allora i sistemi costruttivi sono strumenti, utili quanto si vuole, ma non portatori di un impegno particolare. Si usano perché hanno proprietà interessanti, come si usa un martello perché bussa i chiodi bene.

Se la risposta è: costruire oggetti attraverso atti vincolati — atti che non sono liberi (la costruzione deve rispettare la struttura del tipo) ma non sono neanche scoperti (non c'è niente lì prima) — allora i sistemi costruttivi non sono strumenti: sono l'espressione diretta di ciò che la matematica è. Le regole non descrivono un'attività che sarebbe possibile anche senza di esse: la regimentano, la rendono comunicabile, la tengono onesta.

Brouwer chiamava questo *languageless thought* — pensiero pre-linguistico — proprio per sottolineare che la costruzione matematica viene prima della sua descrizione. La lingua, il simbolo, la regola formale vengono dopo, come tentativo di catturare ciò che già accade nella mente che costruisce. Il formalismo è prezioso — ma è sempre la traccia di qualcosa che lo precede.

Rifondare la matematica dal senso significa allora questo: non partire da un sistema formale e chiedersi quali teoremi si possono ottenere, ma partire dalla domanda sul senso degli atti costruttivi — cosa significhi introdurre un tipo, cosa significhi abitarlo, cosa significhi che una funzione esista — e costruire i sistemi formali come forma scritta di quei significati già compresi.

È un lavoro più lento, meno direttamente produttivo, e in parte inevitabilmente filosofico. Ma è il lavoro che distingue una matematica del senso da una matematica delle regole.
