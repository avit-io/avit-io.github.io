---
title: projects
intro: "two workshops, one bet: a proof is a test that covers every input. in agda, a formally verified observability stack: metrics, logs, alerts and dashboards, correct by construction. in racket, the scheme of sicp: a total mltt core in the style of pie, and a tower of #langs on top whose tests are proofs."
groups:
  - name: agda · observability
    items:
      - name: prometea
        url: https://github.com/avit-io/prometea
        desc: semantic framework for prometheus metrics — meaning, no syntax
      - name: henql
        url: https://github.com/avit-io/henql
        desc: typed promql dsl — the type checker is your linter
        dep: prometea
      - name: loqeul
        url: https://github.com/avit-io/loqeul
        desc: total query algebra unifying logql & elastic, provably-correct optimizer
      - name: agdovana
        url: https://github.com/avit-io/agdovana
        desc: formally verified prometheus alerts → yaml
        dep: prometea
      - name: penelope
        url: https://github.com/avit-io/penelope
        desc: verifiable grafana dashboards — panel/query types & layout, proven
        dep: henql · loqeul
  - name: racket · bottega
    items:
      - name: bottega
        url: https://github.com/avit-io/bottega
        desc: a total mltt core in racket, in the style of pie — Π, Σ, ≡, data, refl by computation
      - name: "#lang disegno"
        url: https://github.com/avit-io/bottega/tree/main/disegno
        desc: dagger pipelines declared, not run — the plan is data, then graphql
        dep: bottega
      - name: "#lang prospettiva"
        url: https://github.com/avit-io/bottega/tree/main/prospettiva
        desc: one model, many environments as projections — the invariants are theorems, nix is the store
        dep: bottega
      - name: "#lang affresco"
        url: https://github.com/avit-io/bottega/tree/main/affresco
        desc: the elm architecture, total and server-side — the tests are proofs
        dep: bottega
      - name: disegno
        url: https://github.com/avit-io/disegno
        desc: the chez scheme original — the mltt kernel and the dagger planner bottega grew from
  - name: agda · substrate
    items:
      - name: janus
        url: https://github.com/avit-io/janus
        desc: the agda↔haskell ffi bridge — decode ∘ encode ≡ id, proven closed
      - name: cardea
        url: https://github.com/avit-io/cardea
        desc: service config as a monotone map over a lattice of env-var sets
      - name: ibisfs
        url: https://github.com/avit-io/ibisfs
        desc: a filesystem as a lattice, not a hierarchy
        dep: janus
      - name: gallicinium
        url: https://github.com/avit-io/gallicinium
        desc: server-side elm in agda — the model never leaves the server
        dep: janus
      - name: efesta
        url: https://github.com/avit-io/efesta
        desc: type-indexed, deferred-execution dagger sdk
        dep: janus
      - name: dagger_gleam
        url: https://github.com/avit-io/dagger_gleam
        desc: the same idea in gleam — pipelines as typed data
      - name: piforge
        url: https://github.com/avit-io/piforge
        desc: nix toolchains for agda, haskell, elm, gleam & latex — prebuilt
---
