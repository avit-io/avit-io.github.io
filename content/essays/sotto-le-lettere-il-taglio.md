---
title: "Sotto le lettere, il taglio"
date: 2026-06-15
abstract: >
  β, ι, λ sembrano i mattoni primitivi del calcolo, ma non lo sono: sono
  le ombre, in deduzione naturale, di un solo gesto che il calcolo dei
  sequenti di Gentzen rende visibile — il taglio, l'incollatura tra ciò
  che produce una A e ciò che la consuma. Eliminare il taglio è computare,
  e lo Hauptsatz è il teorema che si può sempre fare. Ma il taglio non è il
  fondamento: il suo caso centrale si riduce solo perché la regola sinistra
  combacia con la destra, e quel combaciare è l'armonia — cioè la meaning
  explanation messa in moto. Il calcolo dei sequenti, da solo, non sceglie
  la MLTT: è il senso a indurlo, selezionando un solo succedente, le regole
  strutturali, e poi spingendolo in alto verso i tipi dipendenti. La domanda
  "che cosa è primitivo?" si dissolve in una distinzione di livelli: il
  taglio è il motore, la meaning explanation è il senso che lo induce.
---

## Una domanda mal posta

C'è una tentazione, quando si guarda da vicino il λ-calcolo, di prenderne i pezzi per mattoni ultimi. La λ che lega una variabile, l'applicazione che la scioglie, la β che le fa reagire: sembrano gli atomi del calcolo, ciò sotto cui non si scava più. In [*Cinque lettere greche*](../cinque-lettere-greche) le abbiamo trovate insieme alle altre — δ, ι, ζ, η — come i modi in cui la conversione dichiara che due scritture sono la stessa cosa. Ma chiamarle primitive è un errore di prospettiva. Nessuna di esse è un inizio: sono tutte affioramenti di un gesto più semplice, che il λ-calcolo nasconde proprio perché lo ha fuso dentro la propria asimmetria.

Per vederlo bisogna fare un passo indietro, fino al 1934, e mettere il λ-calcolo accanto al sistema da cui è la controfigura.

## I due sistemi di Gentzen

Gentzen, nelle *Untersuchungen über das logische Schließen*, non costruì un calcolo ma due. Il primo è la **deduzione naturale**: ogni connettivo ha regole di *introduzione* — come si dimostra $A \to B$, come si dimostra $A \wedge B$ — e regole di *eliminazione* — come si *usa* una dimostrazione di $A \to B$, cioè il modus ponens. È il sistema che Curry-Howard incolla al λ-calcolo: le introduzioni sono i costruttori (la λ è l'introduzione di $\to$), le eliminazioni sono i distruttori (l'applicazione è l'eliminazione di $\to$). E β, in questa lettura, ha un nome preciso: è l'eliminazione di un *detour*. Un'introduzione seguita immediatamente dalla sua eliminazione — si costruisce una funzione e la si applica subito — è un giro a vuoto, una formula massima che la normalizzazione cancella. β non è un atomo: è la sparizione di una piega.

Il secondo sistema è il **calcolo dei sequenti**, e ha una forma sorprendentemente diversa. Qui le regole di eliminazione *non esistono*. Un giudizio non è una formula ma un sequente $\Gamma \vdash \Delta$ — ipotesi a sinistra, conclusioni a destra — e ogni connettivo ha due regole: una **destra**, che lo costruisce nel succedente, e una **sinistra**, che lo manipola nell'antecedente. La regola destra di $\to$ è l'introduzione di prima travestita:

$$\frac{\Gamma,\, A \vdash B}{\Gamma \vdash A \to B}\;\;({\to}R)$$

La regola sinistra dice invece come *servirsi* di una freccia che si ha già tra le ipotesi:

$$\frac{\Gamma \vdash A \qquad B,\, \Delta \vdash C}{A \to B,\; \Gamma,\, \Delta \vdash C}\;\;({\to}L)$$

Destra: come si produce una $A \to B$. Sinistra: come si consuma. Non c'è un'eliminazione perché non serve: la dissimmetria fra "costruire" e "distruggere" della deduzione naturale qui è diventata la simmetria fra "a destra" e "a sinistra". E proprio questa simmetria fa emergere ciò che il λ-calcolo teneva nascosto.

## Il taglio: (da, a)

Resta una regola sola, e non appartiene a nessun connettivo. È il **taglio**:

$$\frac{\Gamma \vdash A \qquad A,\, \Delta \vdash C}{\Gamma,\, \Delta \vdash C}\;\;(\mathrm{cut})$$

Si legge da sinistra a destra come un'incollatura. La prima premessa *produce* una $A$: la $A$ sta nel succedente, è ciò che quella derivazione consegna. La seconda premessa *consuma* una $A$: la $A$ sta nell'antecedente, è ciò di cui quella derivazione si serve. Il taglio le mette in contatto e fa sparire la $A$ di mezzo. È, alla lettera, un *da* e un *a*: la stessa formula come uscita di una prova e ingresso di un'altra, e il taglio è il tubo che le connette. In termini ordinari il taglio è la composizione, o l'uso di un lemma: dimostro $A$ a parte, poi lo do per buono là dove mi serve.

E qui è il punto. Il taglio è l'unica regola del calcolo dei sequenti che si può *togliere*: è il contenuto del teorema centrale di Gentzen, lo **Hauptsatz**, l'eliminazione del taglio. Ogni dimostrazione che usa lemmi può essere riscritta in una che non ne usa — una dimostrazione *cut-free*, in cui ogni formula che compare è una sottoformula della conclusione (la *subformula property*: niente più viene introdotto solo per essere subito consumato). Eliminare il taglio non è un ripulire estetico: è *computare*. La dimostrazione con i tagli è il programma; quella senza è il valore. E lo Hauptsatz è il teorema che il calcolo termina sempre — la garanzia primitiva sotto ogni normalizzazione.

## β è un taglio principale

Si torni ora a β con questo in mano. Si prenda un taglio in cui la $A$ che fa da perno è stata appena introdotta *da entrambi i lati*: prodotta a destra da ${\to}R$, e consumata a sinistra da ${\to}L$. È il caso che Gentzen chiama *principale*. Riscriverlo è meccanico: la ${\to}R$ aveva costruito $A \to B$ a partire da una derivazione di $\Gamma, A \vdash B$; la ${\to}L$ aveva una derivazione di $A$ e una che usa $B$. Per togliere il taglio si dà la prova di $A$ dentro la derivazione di $\Gamma, A \vdash B$ — ottenendo $B$ — e si taglia quel $B$ contro chi lo usava.

Letta sui termini, questa riscrittura è una cosa sola: prendere l'argomento e sostituirlo nel corpo della funzione. È β. La β-riduzione del λ-calcolo *è* il caso principale dell'eliminazione del taglio sulla freccia — né più né meno. E lo stesso vale per ι: un tipo induttivo ha una regola destra per ogni costruttore e una regola sinistra che è il filtro per casi dell'eliminatore; il taglio principale fra un costruttore e il `case` è esattamente la ι-rule che fa computare il ricorsore. Quanto avevamo detto in *Cinque lettere* — che β e ι sono la stessa tappa, la **C** di FIEC, su due famiglie di tipi — ora si dice in una parola: la C è il taglio principale, e il cut-elimination è il gesto di cui β e ι sono due istanze. Sotto le lettere, una sola incollatura che si scioglie.

## La simmetria nascosta

Se β è un taglio, perché il λ-calcolo sembra così asimmetrico — tutto sbilanciato dalla parte delle funzioni, con la λ regina e il contesto muto? Perché la deduzione naturale ha fuso il consumo dentro l'eliminazione, e ha dato un nome solo al lato che produce. Curien e Herbelin, assegnando termini al calcolo dei sequenti (il calcolo $\lambda\mu\tilde\mu$, *The Duality of Computation*, 2000), hanno fatto riaffiorare il lato muto: accanto ai **termini** — i produttori — stanno i **contesti** — i consumatori — e un comando $\langle v \,|\, e\rangle$ non è altro che un taglio, l'urto fra un produttore e un consumatore lungo un tipo.

In questo calcolo la β non è data: è una *scelta*. Il taglio centrale $\langle \mu\alpha.c \,|\, \tilde\mu x.c'\rangle$ — un produttore che cattura il proprio contesto contro un consumatore che cattura il proprio termine — si può sciogliere in due modi, e i due modi sono la chiamata-per-nome e la chiamata-per-valore. L'ordine di valutazione di un linguaggio, che dentro il λ-calcolo sembra una convenzione esterna, qui è *l'orientamento del taglio*. La dissimmetria del λ-calcolo non era nella logica: era l'ombra proiettata dall'aver scelto, una volta per tutte e di nascosto, da che parte tagliare.

## L'armonia è la faccia del senso

A questo punto la tentazione si rovescia. Se β, ι, λ affiorano dal taglio, e il taglio è la composizione che il cut-elimination scioglie, allora *il taglio* è il vero primitivo — l'atto computazionale ultimo, di cui tutto il resto è notazione. È la tesi forte, ed è quasi giusta. Quasi, perché nasconde una domanda: *perché* il taglio principale si riduce?

Si rilegga la riscrittura della freccia. Funziona perché la regola sinistra di $\to$ chiede esattamente ciò che la regola destra fornisce: la destra produce una funzione *avendo* una derivazione di $B$ da $A$, la sinistra la usa *dando* una $A$ e *chiedendo* di usare $B$. C'è un combaciare preciso fra le due. Questo combaciare ha un nome antico: è l'**armonia**. Gentzen stesso lo diceva delle introduzioni in deduzione naturale — sono, in fondo, le *definizioni* dei connettivi, e le eliminazioni non sono che le loro conseguenze. Nel calcolo dei sequenti la frase diventa: la regola destra *definisce* il connettivo, la regola sinistra è *responsabile* verso di lei, e il taglio principale si riduce se e solo se la sinistra non chiede più di quanto la destra dia.

Allora il cut-elimination, nel suo caso che conta, non è un primitivo bruto: è l'armonia messa in moto. E l'armonia non è un fatto sintattico — è la **meaning explanation**. È il resoconto pre-matematico, à la Martin-Löf, di che cosa sia una forma canonica di $A$ e che cosa significhi computare fino a lei; le regole destre sono la sua forma scritta, le sinistre il suo debito. Lo Hauptsatz è la faccia formale di quel senso. È esattamente il terzo punto di vista promesso in [*Una promessa*](../una-promessa) — quello dimostrativo, «dopo Gödel, in cui l'armonia diventa un teorema di normalizzazione». Quel teorema, ora possiamo dire il suo nome, è lo Hauptsatz.

## Indurre il calcolo a produrre la MLTT

E qui le due tesi che sembravano alternative — il taglio è primitivo / il senso è primitivo — smettono di contraddirsi, perché non parlavano dello stesso livello. Il taglio è primitivo *come atto computazionale*; la meaning explanation è primitiva *come giustificazione*. Non competono per lo stesso posto: sono lo stesso gesto visto come motore e come senso.

Lo si vede meglio chiedendo che cosa, del calcolo dei sequenti, *non* è dato. Quanti succedenti ammette un sequente? Se più d'uno, si ha la logica classica, il controllo, le continuazioni — una dimostrazione che non si impegna su *un* testimone. Se al più uno, si ha l'intuizionismo. Quali regole strutturali si concedono? Indebolimento e contrazione libere danno una logica in cui un'ipotesi si scarta e si riusa a piacere; toglierle dà le logiche sottostrutturali, lineari. Il calcolo dei sequenti, da solo, è una *famiglia*: non sceglie. Ciò che lo induce a essere proprio quello della MLTT è la meaning explanation — «provare $A$ è avere un metodo che consegna *un* elemento canonico» fissa il succedente unico; «un testimone si può riusare e dimenticare» concede le strutturali; il resoconto delle forme canoniche decide quali connettivi esistono. Il senso *seleziona* il calcolo, e il cut-elimination poi *certifica* che la selezione è coerente.

C'è un secondo senso, ancora più forte, in cui il calcolo «deve essere indotto a produrre la MLTT». Il calcolo dei sequenti, di suo, è proposizionale e predicativo: parla di connettivi e quantificatori, non di tipi dipendenti, universi, famiglie induttive. La salita dal logico al tipato — dove vive la ι con il suo schema aperto, una regola di calcolo per ogni `data` dichiarato — non si legge meccanicamente dallo scheletro: è la meaning explanation a spingerla in alto, dichiarando che cosa conti come forma canonica di un tipo che l'utente inventa. Il sequente dà l'ossatura; il senso fa la salita. La MLTT non *è* il calcolo dei sequenti: è ciò che il calcolo dei sequenti produce quando lo si induce dal senso.

## Il prezzo combinatorio

Va detto dove l'identità fra cut-elimination e armonia si tende, se no si spaccia di nuovo una parte per il tutto. È solo il taglio *principale* a essere armonia — l'urto di una formula introdotta da entrambi i lati. Ma una dimostrazione vera è piena di tagli che non sono principali: la formula tagliata è stata introdotta da una parte e, dall'altra, giace sotto una regola strutturale, o sotto l'introduzione di un *altro* connettivo. Per quei tagli l'eliminazione non *riduce* nel senso del senso: *permuta*. Spinge il taglio più in su, lo duplica attraverso una contrazione, lo fa migrare finché non diventa principale o non sparisce.

Queste permutazioni non sono significato: sono il prezzo combinatorio di trasformare un'armonia *locale* — il singolo combaciare destra/sinistra — in una procedura *globale* che termina su ogni dimostrazione. È lo stesso scarto che in *Cinque lettere* separava le uguaglianze gratuite dalla macchina che le decide: tutta l'armonia che si può avere senza perdere la terminazione, e in più la contabilità che serve a renderla totale. Lo Hauptsatz è armonia *più* questo prezzo; confondere i due significherebbe credere che l'intero apparato del cut-elimination sia carico di senso, quando una buona metà è ingegneria della terminazione.

## Né l'uno né l'altro

Si può ora rispondere alla domanda da cui siamo partiti, e la risposta è che era mal posta. Che cosa è primitivo — β, il taglio, il senso? Nessuno dei tre, da solo, perché stanno su tre livelli. β e ι e λ sono affioramenti, in un calcolo asimmetrico, di un unico gesto. Quel gesto è il taglio, e scioglierlo è computare: a livello formale, il taglio è quanto di più primitivo ci sia. Ma il taglio si scioglie *perché* la regola sinistra è in armonia con la destra, e quell'armonia è la meaning explanation: a livello del senso, è lei a venire prima, ed è lei a indurre quale calcolo dei sequenti — fra i molti possibili — meriti di chiamarsi MLTT.

È, ancora una volta, il gesto di [*Una promessa*](../una-promessa): l'inizialità di Lawvere era «un bel ritratto della casa, fatto dalla strada; non la casa». Lo Hauptsatz è un altro ritratto, fatto da un'altra strada — quella dimostrativa, dopo Gödel — e ne mostra il motore con una precisione che la deduzione naturale offuscava. Ma nemmeno il motore è la casa. La casa resta dove [*Per una matematica del senso*](../per-una-matematica-del-senso) la lasciava: nel punto pre-matematico in cui si concorda su che cosa sia costruire, prima che un solo sequente sia scritto. Sotto le cinque lettere c'è il taglio; sotto il taglio, l'armonia; e sotto l'armonia non c'è più calcolo — c'è il senso che lo induce.
