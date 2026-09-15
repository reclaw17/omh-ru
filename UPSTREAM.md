# For rlaope/oh-my-hermes maintainers

This overlay is the user-pack path. Shipping `ru` in the product is a separate change: copy `ru.json` to `src/routing/trigger_packs/ru.json`, regenerate artifacts, add precision cases.

Open as an issue (paste the block below):

https://github.com/rlaope/oh-my-hermes/issues/new

---

**Title:** `feat(routing): ship a Russian trigger language pack (ru), ja/zh-shaped`

**Body:**

```md
Follows the shipped ja/zh pack shape from #1193, not a Korean-scale table.
Overlay (user pack, not a fork): https://github.com/reclaw17/omh-ru
Related: #1535 (user packs reach the hint rail on main via #1539). This issue is about shipping `ru` so nobody has to drop a file.

## Proposal

Add `src/routing/trigger_packs/ru.json`: 20 skills, ~87 short natural phrases, the same skill set as `ja.json` / `zh.json`. Cyrillic becomes trigger-backed the same way Han and Kana did — by shipping a pack, not by growing the Korean table.

Source of truth:

https://raw.githubusercontent.com/reclaw17/omh-ru/main/ru.json

Skills: accessibility-audit, adversarial-consensus, backend, build-failure-triage, code-review, deep-interview, design-orchestration, design-quality-gate, frontend, llm-app-dev, maestro, native-debugging, plan, research, rust, ultraqa, ultrawork, verification-gate, visual-qa, long-document-reading.

No `OMH_LANG=ru`, no chat-copy, no README.ru.md in this change. Output localization stays a separate surface.

## Why not a 200+ phrase table

`docs/DIRECTION.md` froze the Korean table. A synonym sheet is that anti-pattern. This pack copies ja/zh: few phrases per skill, containment-safe, no bare `план` / `ревью` / `ошибка`.

## Suggested corpus additions

Negative controls (`ROUTING_PRECISION_CASES`):

- `что такое фронтенд?` → direct answer, not frontend
- `что значит параллельная реализация в ос?` → direct answer, not ultrawork
- `спасибо` → direct answer

Interventions (`ROUTING_INTERVENTION_CASES`):

- `сделай ревью кода` → code-review
- `суммаризируй этот договор` → long-document-reading
- `сделай фронтенд` + `посадочная страница` → frontend
- `сборка упала` → build-failure-triage

## Landing cost (same as ja/zh in #1193)

1. Drop `ru.json` into `src/routing/trigger_packs/`.
2. Regenerate `skills/*/SKILL.md`, `docs/WORKFLOWS.md`, other generated artifacts.
3. Add the cases above; both corpora assert exact counts.
4. `tests/test_trigger_language_packs.py` must stay green (validate, phrases live, phrases reach the catalog).

Additive. English/ja/zh/ko scoring unchanged. A local user `ru.json` still merges on top.
```
