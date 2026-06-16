---
title: "La geometria viene dopo"
date: 2026-06-12
abstract: "Si dice che con la teoria dei tipi omotopica le fondazioni della matematica «diventano geometriche»: i tipi sono ∞-gruppoidi, gli spazi vengono prima. Questo saggio sostiene che la lettura va rovesciata. Il primitivo sono i processi costruttivi — termini, regole, trasformazioni — e l'omotopia è la forma globale che le relazioni di identità proof-relevant assumono quando si alza lo sguardo. Scambiare questa forma emergente per un dominio ontologico di base è scambiare l'epifenomeno per il fondamento."
---

## Uno slogan da esaminare

C'è uno slogan che accompagna la teoria dei tipi omotopica fin dalla sua nascita: *i tipi sono ∞-gruppoidi*. E un suo corollario divulgativo: con HoTT, *le fondazioni della matematica diventano geometriche*. Lo spazio — si dice — entra nelle fondamenta. Dopo un secolo di insiemi, finalmente l'omotopia al piano terra dell'edificio.

Lo slogan è efficace, ed è anche il modo in cui molti sono arrivati alla teoria. Ma contiene un verbo — *sono* — che merita di essere interrogato. Che cosa si afferma, esattamente, quando si dice che i tipi *sono* ∞-gruppoidi? Che la teoria dei tipi ha scoperto di parlare, da sempre e a sua insaputa, di oggetti geometrici? Che gli spazi vengono prima, e le regole li descrivono?

La tesi di questo saggio è che la lettura vada rovesciata. Il primitivo non sono spazi, ∞-gruppoidi o «oggetti geometrici»: sono processi costruttivi — termini, programmi, regole di introduzione ed eliminazione, trasformazioni osservabili. L'omotopia non è il dominio che la teoria rappresenta dall'esterno: è la forma globale che le relazioni di identità generate dalle regole assumono quando si alza il punto di vista. Confondere le due cose significa scambiare un epifenomeno per un'ontologia.

---

## Da dove nasce davvero la struttura

Conviene partire dal punto tecnico, perché il punto tecnico è sorprendentemente netto.

La teoria dei tipi di Martin-Löf non contiene, tra i suoi primitivi, nulla di geometrico. Contiene un tipo identità: per ogni tipo $A$ e ogni coppia di elementi $a, b : A$, un tipo $\mathrm{Id}_A(a,b)$, con una regola di introduzione — $\mathrm{refl}$, che testimonia che ogni cosa è uguale a sé stessa — e una regola di eliminazione, $J$, che dice come usare una prova di identità. Tutto qui. Nessun punto, nessun cammino, nessuna nozione di continuità.

Eppure da queste regole la struttura sgorga da sola. Hofmann e Streicher mostrarono che le regole *non* impongono che due prove di identità siano uguali tra loro: la struttura delle identità è proof-relevant, le prove di uguaglianza sono oggetti con una loro individualità. E poi il risultato decisivo, dimostrato da Lumsdaine e da van den Berg e Garner: la torre delle identità iterate — identità tra elementi, identità tra prove di identità, identità tra queste, e così via — porta *da sé* la struttura di un ω-gruppoide debole. Non è un assioma. Non è un'interpretazione. È un teorema sulla sintassi: chiunque scriva le regole del tipo identità ha già scritto, senza saperlo, un generatore di ∞-gruppoidi.

Questo fatto viene spesso citato come prova che «i tipi sono spazi». Ma si noti la direzione della derivazione. Nessuno ha messo gli spazi dentro le regole: le regole, da sole, generano una struttura che — vista da fuori, riassunta nelle sue proprietà globali — un occhio allenato riconosce come quella che la topologia algebrica studia da un secolo. La geometria non sta tra le premesse. Sta tra le conseguenze.

Nel saggio precedente avevamo chiamato questa struttura la *geometria interna della medesimezza*: i modi in cui due costruzioni contano come la stessa, i modi tra i modi, l'articolazione che la copula porta con sé. È un nome deliberato: la geometria è il modo in cui la medesimezza si articola, non il suolo su cui poggia.

---

## La marea che sale

Grothendieck descriveva il proprio modo di lavorare con l'immagine della *mer qui monte*: non si attacca il problema di punta, si alza lentamente il livello del mare finché il problema si ritrova sommerso, e ciò che sembrava una scogliera diventa il fondale di un paesaggio più ampio.

La semantica omotopica di HoTT è esattamente questo: una marea che sale sul calcolo. Si parte dai processi — termini che si riducono, prove che si normalizzano, programmi che computano — e si alza il punto di vista. Al primo livello si vedono i tipi con i loro elementi. Si sale: si vedono le identità, e si scopre che hanno struttura. Si sale ancora: le identità tra identità, le coerenze, le coerenze tra coerenze. A una certa altezza, il paesaggio che si distende sotto lo sguardo ha la forma inconfondibile della teoria dell'omotopia: tipi che si comportano come spazi, famiglie dipendenti come fibrazioni, l'eliminatore $J$ come sollevamento lungo i cammini.

Il modello simpliciale di Voevodsky, il modello dei gruppoidi, i modelli nelle categorie di mappa — tutto questo è la cartografia del paesaggio sommerso. Ed è cartografia preziosa: senza il modello simpliciale nessuno avrebbe formulato l'univalenza, senza i modelli nessuno saprebbe che certe estensioni sono coerenti. Ma una carta nautica organizza il mare: non lo fonda. La semantica categoriale e omotopica è un modo astratto di *organizzare* i processi costruttivi — di riassumerne le proprietà invarianti, di riconoscere che il pattern globale coincide con pattern già noti altrove. Riconoscere non è fondare. Il fatto che la marea, salendo, riveli una forma familiare non dice che la forma fosse lì prima dell'acqua.

---

## Le biglie e l'arcobaleno

C'è un'immagine che rende l'errore visibile.

Si prenda un mucchio di biglie, ciascuna con semplici regole locali di interazione: come si dispongono rispetto alle vicine, come rifrangono la luce che le attraversa. Si guardi il mucchio da lontano: appare un pattern ad arcobaleno. Il pattern è reale — non è un'illusione ottica, è una proprietà oggettiva della configurazione, riproducibile, studiabile, dotata di una sua matematica. Si può scrivere un trattato sugli arcobaleni di biglie, e sarebbe buona scienza.

L'errore comincia quando si conclude: *le biglie sono arcobaleni*. O peggio: l'arcobaleno è la realtà fondamentale, e le biglie ne sono una rappresentazione. A quel punto si è scambiata la forma globale generata dalle interazioni locali per la sostanza che le genera. Il pattern è diventato l'ontologia.

«I tipi sono ∞-gruppoidi» ha esattamente questa struttura. L'∞-gruppoide è il pattern: la forma globale, osservata da fuori, della rete di identità proof-relevant che le regole generano. Le regole sono le biglie. Dire che la forma globale *è* ciò che i tipi sono — e che dunque le fondazioni «diventano geometriche» — è concludere che le biglie sono arcobaleni.

Si badi: chiamare l'omotopia *epifenomeno* non significa sminuirla. Significa collocarla. L'epifenomeno, qui, non è un'apparenza né uno scarto: è la forma emergente, perfettamente reale, di ciò che le regole fanno. Ciò che si nega non è la realtà del pattern — è la sua *priorità ontologica*. L'arcobaleno c'è. Ma non viene prima delle biglie, e non le spiega.

---

## L'obiezione più forte

L'obiezione va presa nella sua forma migliore: storicamente, la geometria è venuta *prima*. Voevodsky arrivò alla teoria dei tipi dall'omotopia, non viceversa. L'univalenza non fu derivata dalle regole: fu *vista* nel modello simpliciale, e poi aggiunta come assioma. Se l'omotopia fosse un epifenomeno, come avrebbe potuto guidare la scoperta?

La risposta richiede di distinguere il contesto della scoperta dall'ordine della costituzione. Che la forma globale sia stata vista prima delle regole che la generano è un fatto sulla biografia delle idee, non sulla loro architettura. Anche la termodinamica è stata scoperta prima della meccanica statistica: nessuno ne conclude che il calore fondi le molecole. Il pattern, proprio perché è reale e riconoscibile, può fare da guida euristica potentissima — è il vantaggio di avere carte nautiche di mari simili. Ma la guida euristica non è il fondamento.

C'è poi un fatto interno alla teoria che depone nella stessa direzione, e lo avevamo già incontrato parlando del *muro*: l'univalenza, finché resta un assioma, è un corpo estraneo. Un assioma è esattamente una verità appoggiata dall'esterno — il segno che qualcosa è stato visto nel modello ma non ancora ricondotto al processo. E infatti la storia successiva di HoTT è la storia del tentativo di riportarla a casa: la teoria cubica le dà contenuto computazionale, al prezzo di un primitivo — l'intervallo — che ha ancora un sapore geometrico; la Higher Observational Type Theory prova a farla affiorare dal significato stesso dei costruttori di tipo, senza residui. La direzione del lavoro è inequivocabile: *dal* modello geometrico *verso* la giustificazione processuale. Se la geometria fosse il fondamento, questo lavoro non avrebbe senso — non si giustifica il fondamento in termini di ciò che fonda. Lo si fa solo se si sa, o si sente, che il fondamento sta dall'altra parte.

---

## Che cosa costa lo slogan

Si potrebbe pensare che, in fondo, sia solo una questione di enfasi. Non lo è, e il saggio sulla verità che non abita altrove dice perché.

Il platonismo, avevamo visto, non è una tesi sul terzo escluso: è la postulazione di un piano di realtà matematica separato da ogni processo di costruzione, con il problema dell'accesso che ne segue. La lettura geometrica di HoTT, presa alla lettera, ricostruisce esattamente quel piano — solo arredato diversamente. Al posto degli insiemi, gli ∞-gruppoidi; al posto dell'universo cumulativo, l'(∞,1)-topos. Ma la struttura dell'impegno è la stessa: c'è un *là* — un reame di oggetti omotopici — e la teoria dei tipi è il linguaggio con cui lo descriviamo da qui. La domanda di Benacerraf si ripresenta intatta: come accediamo agli ∞-gruppoidi? E la risposta, di nuovo, è un'etichetta: intuizione geometrica.

È per questo che «le fondazioni diventano geometriche» è una regressione platonizzante, non un progresso concettuale. Si era partiti da una teoria in cui esistere significa essere costruito — in cui l'esistenza di un oggetto è la consegna di un termine, e la verità accade nel giudizio. Lo slogan la riconsegna allo schema rappresentazionale: di qua il linguaggio, di là gli oggetti, in mezzo il mistero della corrispondenza. Tutto il guadagno dell'impostazione costruttiva — l'ontologia processuale unica, senza altrove — viene restituito alla cassa.

Nella prospettiva intuizionista forte, il fondamento è processuale: esistere matematicamente significa essere costruibile in un certo regime di regole. I regimi sono molti — si può lavorare con UIP o senza, con l'univalenza o senza, con l'intervallo cubico o senza — e ciascuno genera la propria fenomenologia di identità. La geometria è la tassonomia di alto livello di questi regimi: il vocabolario con cui classifichiamo le forme globali che i diversi regimi producono. Tassonomia preziosa, ma tassonomia. Non una seconda realtà che sta sotto i regimi e li fonda.

---

## Il vero contenuto di HoTT

Niente di tutto questo toglie interesse alla teoria dei tipi omotopica. Al contrario: la libera per il suo significato più profondo.

Letta in questo verso, HoTT è la dimostrazione più spettacolare che abbiamo della tesi costruttiva. Si parte *esclusivamente* da processi: regole di introduzione, regole di eliminazione, computazione. Nessuno spazio tra i primitivi, nessun continuo, nessun punto. E da questo materiale apparentemente esangue emerge una fenomenologia di una ricchezza che nessuno aveva previsto: l'intera teoria dell'omotopia, il continuo come tipo di alta dimensione, i gruppi di omotopia delle sfere calcolati per via sintetica, una geometria astratta che in certi casi vede più lontano di quella classica. La povertà ontologica dei mezzi e la ricchezza fenomenologica dei risultati: questo è il contenuto filosofico di HoTT.

Lo slogan «i tipi sono ∞-gruppoidi» racconta questa storia alla rovescia — e raccontandola alla rovescia se la perde. Se gli spazi erano già lì, e la teoria dei tipi li descrive, allora HoTT è solo un linguaggio comodo per una realtà nota: utile, ma filosoficamente muto. È solo nella lettura processuale che la teoria dice qualcosa di nuovo sul mondo matematico: che basta la costruzione, che la medesimezza articolata genera lo spazio, che la geometria — tutta la geometria che vi compare — *viene dopo*.

L'arcobaleno sul mucchio di biglie è uno spettacolo che merita tutta l'attenzione che riceve. Ma le fondamenta non sono diventate colorate. Sono rimaste quello che erano: biglie, e regole su come si toccano.
