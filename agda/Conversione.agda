module Conversione where

open import Data.Nat using (ℕ; zero; suc; _+_)
open import Data.Product using (_×_; _,_; proj₁; proj₂)
open import Relation.Binary.PropositionalEquality using (_≡_; refl; cong)

-- β
β-ex : (λ (n : ℕ) → suc n) 1 ≡ 2
β-ex = refl

-- ι
0+n : (n : ℕ) → 0 + n ≡ n
0+n n = refl

n+0 : (n : ℕ) → n + 0 ≡ n
n+0 zero    = refl
n+0 (suc n) = cong suc (n+0 n)

-- η
η-fun : {A B : Set} (f : A → B) → f ≡ (λ x → f x)
η-fun f = refl

η-pair : {A B : Set} (p : A × B) → p ≡ (proj₁ p , proj₂ p)
η-pair p = refl

-- ζ (let)
ζ-ex : (let k = 3 in k + k) ≡ 6
ζ-ex = refl
