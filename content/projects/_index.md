---
title: projects
intro: "a formally verified observability stack in agda — metrics, logs, alerts and dashboards, correct by construction. nothing renders empty, nothing inverts a threshold: the type checker rejects it first."
groups:
  - name: observability
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
  - name: substrate
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
