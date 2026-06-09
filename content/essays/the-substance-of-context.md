---
title: "The Substance of Context"
date: 2026-06-09
abstract: "In Martin-Löf type theory, contexts precede types as stage precedes performance. Yet both are formed by the same rules: extending a context by $x{:}A$ is the same constructive act as introducing the first component of a $\\Sigma$ type. Every context internalises as a type; every context entry is a type declaration in disguise. The wall between meta-language and language is not made of different substances — it is maintained by an epistemic act, the colon read as declaration rather than assertion."
---

When we write $\Gamma \vdash a : A$, the turnstile marks a boundary.
To its left: $\Gamma$, a list of variable declarations, each carrying a type.
To its right: the judgment proper — the assertion that $a$ inhabits $A$.
The standard reading places $\Gamma$ firmly on the meta-linguistic side.
It is background, scaffolding, the set of presuppositions against which the
judgment makes sense.

But what is this scaffolding made of?
A context entry $x : A$ is not a mere name; it carries a *type*.
A type is precisely what the right-hand side of the turnstile speaks about.
If we look at the material of a context, we find the same stuff as types:
dependent families, telescoping declarations, the very fabric of the language.
The meta-linguistic container turns out to be made of the linguistic contents
it was supposed to precede.

This note makes the observation precise and asks what, then, maintains the separation.

---

## Judgment forms

Following Martin-Löf, four primitive judgment forms:

$$
\begin{aligned}
&\Gamma \vdash A \;\text{type} \\
&\Gamma \vdash A \equiv B \;\text{type} \\
&\Gamma \vdash a : A \\
&\Gamma \vdash a \equiv b : A
\end{aligned}
$$

and one presupposed by all of them:

$$\Gamma \;\text{ctx}$$

This last judgment is the foundation.
Before we may speak of types or terms in a context, the context itself must
be *valid* — well-formed in the sense that each entry's type can be checked
against the preceding entries.
It is prior to the four, yet structurally quieter: it carries no explicit
subject or predicate, only the bare assertion that $\Gamma$ is coherent.

---

## Forming contexts

The rules for context validity are two:

$$
\frac{}{\cdot \;\text{ctx}}
\qquad\qquad
\frac{\Gamma \;\text{ctx} \qquad \Gamma \vdash A \;\text{type}}
     {\Gamma,\, x{:}A \;\text{ctx}}
$$

The empty context is valid unconditionally.
A context may be extended by a fresh variable $x$ of type $A$, provided
$A$ is already a valid type in $\Gamma$.

The extension rule deserves attention.
Its premises are: a valid context $\Gamma$, and a type $A$ formed in that context.
Its conclusion is a *new* context — one level up, in the meta-language.

---

## Forming types

Now look at the formation rules for the dependent type constructors:

$$
\frac{\Gamma \vdash A \;\text{type} \qquad \Gamma,\, x{:}A \vdash B \;\text{type}}
     {\Gamma \vdash \Pi(x{:}A).\, B \;\text{type}}
\qquad\qquad
\frac{\Gamma \vdash A \;\text{type} \qquad \Gamma,\, x{:}A \vdash B \;\text{type}}
     {\Gamma \vdash \Sigma(x{:}A).\, B \;\text{type}}
$$

The premises are identical for $\Pi$ and $\Sigma$: a type $A$ in $\Gamma$,
and a type $B$ in the extended context $\Gamma, x{:}A$.

Now place context extension next to $\Sigma$-formation:

$$
\frac{\Gamma \;\text{ctx} \qquad \Gamma \vdash A \;\text{type}}
     {\Gamma,\, x{:}A \;\text{ctx}}
\qquad\qquad
\frac{\Gamma \vdash A \;\text{type} \qquad \Gamma,\, x{:}A \vdash B \;\text{type}}
     {\Gamma \vdash \Sigma(x{:}A).\, B \;\text{type}}
$$

The left rule takes a context and a type and produces a *context*.
The right rule takes a type, uses context extension as an internal hypothesis,
and produces a *type*.

The act of binding — appending $x{:}A$ — appears in both.
In $\Sigma$-formation, $\Gamma, x{:}A$ is a hypothesis inside the rule, never named as conclusion.
In context extension, it *is* the conclusion.

The same constructive act of binding a variable of type $A$ is performed in
both cases.
What differs is not the act but its *destination*: a new context or a new type,
meta-language or language.

---

## The telescope

This structural identity has a direct consequence.
A finite context

$$\Gamma \;=\; (x_1{:}A_1,\;\; x_2{:}A_2(x_1),\;\; \ldots,\;\; x_n{:}A_n(x_1,\ldots,x_{n-1}))$$

can always be *internalised* as a type in the empty context:

$$\cdot \;\vdash\; \Sigma x_1{:}A_1.\;\Sigma x_2{:}A_2(x_1).\;\cdots\; A_n(x_1,\ldots,x_{n-1}) \;\text{ type}$$

This $\Sigma$ type is the *telescope* of $\Gamma$ — the type that packs all of $\Gamma$'s
declarations into a single former.
Elements of this $\Sigma$ type are exactly the *substitutions* for $\Gamma$:
tuples $(a_1, a_2(a_1), \ldots, a_n)$ that simultaneously fill all variables declared in $\Gamma$.

Context extension corresponds exactly to $\Sigma$ extension:

$$(\Gamma,\;\, x{:}A) \;\longleftrightarrow\; \Sigma\Gamma.\, A$$

The categorical reading makes this fully precise.
In a comprehension category, contexts are objects and types over $\Gamma$ are
display maps $A \to \Gamma$.
Context extension is the domain of such a map; the $\Sigma$ type is its image in the fiber.
The two notions are dual faces of the same display.

A context, then, is not a formless list of names.
It is a type that happens to have been introduced one variable at a time,
*declared* rather than *asserted*.

---

## The colon as epistemic act

If contexts and types are made of the same stuff — if every context *is* a
type, just written differently — what maintains the separation between them?
What prevents the meta-language from collapsing into the object language?

The answer is the colon, read as an act rather than as a relation.

In the element judgment $\Gamma \vdash a : A$, the colon is the copula of
*assertion*: we *claim* that $a$ inhabits $A$.
In the context entry $x : A$, the colon is the copula of *assumption*:
we *presuppose* that $x$ ranges over $A$.
The same symbol records two different epistemic stances toward the same material.

Martin-Löf distinguishes between a *judgment*, which is a claim that can be
known and verified, and a *hypothesis*, which is a declaration accepted without
verification.
A context is a list of hypotheses.
A turnstile judgment is an assertion made under those hypotheses.
The colon appears in both, but in the hypothesis it carries no assertoric force —
it is content without act.
In the judgment it carries the full weight of a claim.

This is exactly the distinction Frege drew between propositional content and
the assertion stroke.
$A$ may be the same content whether we assume it or assert it;
what differs is the epistemic act that accompanies it.
Martin-Löf's type theory internalises this distinction into its syntax:
the turnstile $\vdash$ is the mark of assertion, and everything to its left is
content stripped of assertoric force.

The wall between meta-language and language, between $\Gamma$ and $A$,
between context and type, is not a difference in kind.
It is a difference in standing — the same fabric, but on one side it is *given*
(assumed, declared) and on the other it is *made* (judged, verified).

---

## A remark on the logical framework

The identification of contexts with types is not merely a philosophical observation;
it is also a design choice.

In the *Logical Framework* of Harper, Honsell, and Plotkin, contexts and types
genuinely live at the same level: a context is a sequence of LF types, and
there is no separate "ctx" judgment distinct from the type judgment.
The distinction between object-language context and object-language type collapses,
because LF has its own classifier `Type` that covers everything uniformly.

In MLTT proper, the stratification is maintained — and intentionally so.
The "ctx" judgment is primitive, not derivable from the type judgment.
This is a choice about where the metatheory sits.
Martin-Löf's answer is that the metatheory must remain outside, in the region
of pure judgment, to preserve the decidability of type checking.
The internalisation of contexts as $\Sigma$ types is a theorem about expressive power,
not a collapse of the stratification.

What this shows is that the stratification is held up not by a difference in
mathematical objects but by a difference in the *use* to which those objects
are put.
The `:` of $x{:}A$ in a context and the `:` of $\Gamma \vdash a{:}A$ in a judgment
are the same sign deployed in two different epistemic modes.
Move the wall and you get a logical framework.
Keep it and you get a type theory with decidable checking.
Either way, the wall is made of judgment, not of substance.

---

## Same substance, different acts

In *I Tempi della Copula*, the four judgment forms are described as a
2×2 structure whose axes are type/element and assertion/equality.
The copula `:` is not a third object between term and type but the act of
junction itself — the recognition that a term inhabits a type.
What makes the act is not the symbol but the mode of presentation.

The present observation follows the same logic one level up.
A context entry and a type are not two different kinds of thing.
They are the same kind — a type — deployed in two modes:
*declared* (entered into a hypothesis list) and *asserted* (made the subject of a judgment).
The turnstile records the transition between modes.

This means the traditional picture of context as *prior* to type —
as the stage that must already be in place before any type can appear —
is correct but incomplete.
It is correct because the epistemic act of declaring precedes the act of asserting:
hypotheses must be in place before claims can be made.
It is incomplete because it suggests that contexts are of a different nature than types,
that they precede types the way a frame precedes a painting.
In fact, the frame is painted with the same paint.

---

## Conclusion

The formation rules for contexts and for $\Sigma$ types share the same premises.
Every context telescopes into a $\Sigma$ type; every $\Sigma$ type is a context
waiting to be extended.
The meta-linguistic act of extending a context by $x{:}A$ is the same constructive
act as introducing a new $\Sigma$ factor.
What differs is the destination of this act: a new context or a new type,
meta-language or language.

The colon maintains this distinction not by pointing to different mathematical
objects but by recording two different epistemic stances: declaration and assertion.
Remove the epistemic act — place both sides of the turnstile at the same level —
and the distinction dissolves into a logical framework.
This is not wrong; it is a different choice about where to keep the wall.

The substance of context is type.
The wall is made of judgment.
