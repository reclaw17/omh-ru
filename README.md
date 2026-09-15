# omh-ru

Русский **user trigger pack** для [oh-my-hermes](https://github.com/rlaope/oh-my-hermes). Это **оверлей, не форк**: оригинал не клонируется, файл кладётся рядом с `model-chains.json`.

Та же форма, что shipped-паки `ja` / `zh`: 20 skills, короткие узкие фразы, без синонимного словаря. Длинный хвост дописывается в этот же `ru.json` локально — в апстрим OMH такой хвост не несём.

## Установка

**macOS / Linux**

```sh
curl -fsSL https://raw.githubusercontent.com/reclaw17/omh-ru/main/install.sh | sh
```

**Windows (PowerShell 5.1+)**

```powershell
irm https://raw.githubusercontent.com/reclaw17/omh-ru/main/install.ps1 | iex
```

Или из чекаута:

```sh
git clone https://github.com/reclaw17/omh-ru.git
cd omh-ru
sh install.sh
```

Кладёт сюда:

```text
$OMH_HOME/routing/trigger-packs/ru.json
```

`OMH_HOME` по умолчанию `~/.omh`. `omh update` этот файл **не трогает**.

Потом:

```sh
omh doctor
omh recommend "сделай ревью кода" --limit 1
```

В `omh doctor` ожидается строка вроде `user packs: ru (N phrases)`.

Перезапустите сессию Hermes — плагин грузится на старте.

## Версии OMH

| OMH | `omh recommend` / `route_decision` | карточка `[OMH Route Hint]` в чате |
|---|---|---|
| 2.0.3 (stable) | видит пак | нет — [#1535](https://github.com/rlaope/oh-my-hermes/issues/1535) |
| `main` / релиз новее 2.0.3 | видит пак | да — [#1539](https://github.com/rlaope/oh-my-hermes/pull/1539) |

На 2.0.3 пак уже полезен для скоринга. Чтобы карточка в чате тоже срабатывала: `omh update` до поколения новее 2.0.3, затем рестарт Hermes.

## Что покрыто

Те же 20 skills, что у `src/routing/trigger_packs/ja.json`:

`accessibility-audit`, `adversarial-consensus`, `backend`, `build-failure-triage`, `code-review`, `deep-interview`, `design-orchestration`, `design-quality-gate`, `frontend`, `llm-app-dev`, `maestro`, `native-debugging`, `plan`, `research`, `rust`, `ultraqa`, `ultrawork`, `verification-gate`, `visual-qa`, `long-document-reading`.

Фразы короткие и узкие: роутер матчит **вхождением**, поэтому нет голых «план» / «ревью» / «ошибка».

## Цикл обновления

```text
omh update          # оригинал OMH; ru.json не трогает
# инсталлер сюда — только когда обновился этот репо
omh doctor          # user packs: ru (...)
```

После `omh update`: если появился новый skill — дописать фразы в `ru.json` и снова прогнать инсталлер. Мёртвый skill id `omh doctor` откажет громко, не молча.

Снять пак:

```sh
curl -fsSL https://raw.githubusercontent.com/reclaw17/omh-ru/main/uninstall.sh | sh
```

## Чего этот репо не делает

- не переводит карточки OMH (`localized_copy.py` остаётся en/ko/ja/zh/es/fr/de)
- не добавляет `README.ru.md` и `omh setup --language ru`
- не является локалью Hermes Desktop (это другой проект)

Это сознательно: детерминированный роутинг живёт в JSON, остальное — в Hermes.

## В апстрим

Этот `ru.json` можно копировать в `src/routing/trigger_packs/ru.json` и открыть PR в [rlaope/oh-my-hermes](https://github.com/rlaope/oh-my-hermes). Для shipped-пака нужны ещё регенерация артефактов и негативные кейсы в `ROUTING_PRECISION_CASES`. Не расширять до размера корейской таблицы (949 фраз, заморожена).
