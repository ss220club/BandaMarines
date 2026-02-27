# Модулярный Stickyban (Banda)

## Область изменений
- Изменения выполняются только в `modular/admin/code/stickyban*`.
- Хардкод вне модуляра не изменяется.
- Интеграция идет через существующие `hascall/call`-хуки.

## Базовые инварианты
- Канонический ключ root: `identifier = ckey(trim(identifier))`.
- Для пустого/мусорного `identifier` используется синтетика `legacy_empty_<root_id>`.
- Источник истины: только DB.
- Legacy import отключен модульным no-op перехватом.

## Графовая модель кластеров
- Сильные связи:
  - одинаковый нормализованный `identifier`;
  - общий `CID`;
  - общий `CKEY`.
- Ограниченная IP-связь:
  - IP используется только для root, которые уже имеют сильный сигнал.
- Для whitelist/delete используется расширенный режим графа:
  - учитываются и `whitelisted` CKEY-строки, чтобы whitelist не терял связность на legacy-дублях.

## Нормализация дублей
- Нормализация обрабатывает граф-кластеры дублей и переносит match-строки в canonical root.
- Canonical root выбирается по правилу:
  - сначала active;
  - затем максимальный `id`.
- `reason/message/date/adminid` берутся из newest root (максимальный `id`).
- Важное правило:
  - если в кластере нет active root, canonical не активируется принудительно.

## Whitelist и «отлепление»
- Whitelist в админ-действии применяется на весь граф-кластер выбранного root.
- Проверка stickyban учитывает whitelist по расширенному граф-кластеру.
- Это предотвращает ситуацию, когда один legacy-root whitelisted, а соседний дубль продолжает банить.

## Удаление кластера
- Удаление stickyban из UI работает как удаление граф-кластера:
  - удаляются root в кластере;
  - удаляются их CKEY/CID/IP match-строки.
- Кластер определяется в расширенном режиме графа (с учетом whitelist-CKEY связности).

## Индексы
- Ожидаемые уникальные инварианты:
  - `stickyban(identifier)`
  - `stickyban_matched_ckey(linked_stickyban, ckey)`
  - `stickyban_matched_cid(linked_stickyban, cid)`
  - `stickyban_matched_ip(linked_stickyban, ip)`
- На старте выполняется best-effort ресинк индексов через adapter sync.

## Стартовый поток
1. Cleanup сирот/дубликатов в match-таблицах.
2. Graph normalize root-дублей.
3. Best-effort ресинк stickyban-индексов.

## Админ-операции
- Аудит: состояние таблиц, кандидаты cleanup, дубли по identifier и граф-кластерам.
- Normalize: принудительное схлопывание дублей по графу.
- Purge CKEY: глобальная очистка CKEY-связей.
