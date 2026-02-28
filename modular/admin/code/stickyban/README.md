# Модулярный Stickyban (Banda)

## Область изменений
- Изменения выполняются только в `modular/admin/code/stickyban*`.
- Хардкод вне модуляра не изменяется.
- Интеграция идет через существующие `hascall/call`-хуки.

## Ключевые инварианты
- Канонический ключ root: `identifier = ckey(trim(identifier))`.
- Для пустого/мусорного `identifier` используется `legacy_empty_<root_id>`.
- Источник истины: только DB.
- Legacy import отключен no-op перехватчиком.

## Двухуровневый whitelist
- Уровень 1: глобальный реестр `stickyban_whitelist` по `ckey` (персистентный).
- Уровень 2: локальные `whitelisted`-связи в `stickyban_matched_ckey` (совместимость с текущим runtime).
- Выдача whitelist из sticky-панели записывает и в global, и в cluster.
- При удалении sticky-кластера локальные whitelist-связи сначала поднимаются в global.
- При `purge_ckey_globally` глобально whitelisted CKEY сохраняет whitelist-защиту.

## Политика авто-блокировки (анти-ложные срабатывания)
- Direct CKEY hit блокирует сразу.
- Иначе блокировка только при минимум 2 разных сигналах из набора `CKEY/CID/IP`.
- Одиночный CID или одиночный IP не блокирует.
- Для globally whitelisted CKEY:
  - авто-блокировка не применяется;
  - `match_sticky` не записывает новые IP/CID-связи.

## Графовая модель кластера
- Сильные связи:
  - одинаковый нормализованный `identifier`;
  - общий `CKEY`;
  - общий `CID`.
- IP используется как gated-сигнал (только для root, у которых уже есть сильный сигнал).
- Для whitelist/delete используется расширенный граф (включая `whitelisted` CKEY-связи).

## Нормализация дублей
- Нормализатор схлопывает граф-кластеры в canonical root.
- Canonical root выбирается по правилу:
  1. active имеет приоритет;
  2. при равенстве берется максимальный `id`.
- `reason/message/date/adminid` у canonical берутся из newest root (максимальный `id`).
- Match-строки переносятся в canonical, дубли root удаляются.

## Индексы и startup-поток
- Уникальные инварианты:
  - `stickyban(identifier)`
  - `stickyban_matched_ckey(linked_stickyban, ckey)`
  - `stickyban_matched_cid(linked_stickyban, cid)`
  - `stickyban_matched_ip(linked_stickyban, ip)`
  - `stickyban_whitelist(ckey)`
- На старте:
  1. Синхронизация local whitelist -> global whitelist.
  2. Cleanup сирот/дубликатов в match-таблицах.
  3. Graph normalize root-дублей.
  4. Best-effort ресинк индексов.

## Админ-операции
- `Sticky WL`: отдельная панель глобального whitelist, поиск по CKEY, add/remove.
- `Аудит Stickyban`: состояние таблиц + дубли + global whitelist + политика матчинг-порогов.
- `Нормализовать дубли Stickyban`: принудительное схлопывание дублей по графу.
- `Очистить Sticky CKEY`: удаляет CKEY-связи по всему stickyban, но сохраняет whitelist-защиту.
