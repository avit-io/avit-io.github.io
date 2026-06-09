{-# OPTIONS --safe #-}
module Armonia where

------------------------------------------------------------------------
-- Formazione + Introduzione: i numeri naturali e i loro costruttori.
-- Gli introduttori fissano le forme canoniche: un naturale è zero
-- oppure il successore di un naturale. Nient'altro.
------------------------------------------------------------------------

data ℕ : Set where
  zero : ℕ
  succ : ℕ → ℕ

------------------------------------------------------------------------
-- Eliminazione (non dipendente): il ricorsore.
-- Per usare un ℕ basta dire cosa fare su zero e cosa fare al passo
-- di successore: esattamente i due casi promessi dagli introduttori.
------------------------------------------------------------------------

rec : {C : Set} → C → (ℕ → C → C) → ℕ → C
rec z s zero     = z
rec z s (succ n) = s n (rec z s n)

------------------------------------------------------------------------
-- Eliminazione (dipendente): l'eliminatore, cioè il principio di
-- induzione. È il ricorsore in cui il bersaglio C diventa una
-- famiglia P n che dipende dal numero. Stessa regola, motivo diverso.
------------------------------------------------------------------------

ind : (P : ℕ → Set)
    → P zero
    → ((n : ℕ) → P n → P (succ n))
    → (n : ℕ) → P n
ind P z s zero     = z
ind P z s (succ n) = s n (ind P z s n)

------------------------------------------------------------------------
-- Computazione: le due equazioni di rec/ind valgono per definizione
-- (sono uguaglianze giudizionali, le regole β dell'eliminatore).
------------------------------------------------------------------------

-- Un esempio: l'addizione, scritta usando SOLO il ricorsore,
-- per ricorsione sul primo argomento.
_+_ : ℕ → ℕ → ℕ
m + n = rec n (λ _ r → succ r) m

------------------------------------------------------------------------
-- Le liste: la stessa trama FIEC su un altro tipo induttivo.
-- foldr è il loro ricorsore.
------------------------------------------------------------------------

data List (A : Set) : Set where
  []  : List A
  _∷_ : A → List A → List A

foldr : {A B : Set} → (A → B → B) → B → List A → B
foldr f e []       = e
foldr f e (x ∷ xs) = f x (foldr f e xs)
