/* eslint-disable func-style */
/**
 * @file
 * @copyright 2020 Aleksej Komarov
 * @license MIT
 */

const STRAIN_RU = {
  Observer: 'Старый Повар',
  Gardener: 'Наркобарон',
  Healer: 'Доктор',
  'Steel Crest': 'Камень',
  Acider: 'Мука',
  Eggsac: 'Яичко',
  'Resin Whisperer': 'Смоляной шептунчик',
  Vampire: 'Кровосос',
  Charger: 'Паравоз',
  Dancer: 'Балерина',
  Oppressor: 'Революционер',
  Vanguard: 'Гвардеец',
  Valkyrie: 'Валерьянка',
  Trapper: 'Минер',
  Berserker: 'Злой',
  Hedgehog: 'Ежик',
  Normal: 'Нормис',
};

const CASTES_RU = {
  // MARK: Hives
  Prime: 'Мега крутой',
  Corrupted: 'Зелененькие',
  Forsaken: 'Забытые',
  Mutated: 'Мутировавшие',
  Other: 'Другие',
  Yautja: 'Yautja',
  // MARK: Castes
  Larva: 'Червь',
  'Predalien Larva': 'Чужой Червь',
  Facehugger: 'Дружок',
  'Lesser Drone': 'Метаеб',
  Drone: 'Дрын',
  Runner: 'Руни',
  Sentinel: 'Бесполезный',
  Defender: 'Дефундя',
  Burrower: 'Копалка',
  Carrier: 'Носилка',
  Hivelord: 'Хайвлордик',
  Lurker: 'Мудак',
  Warrior: 'Гандон',
  Spitter: 'Токсичный',
  Boiler: 'Кипятильник',
  Praetorian: 'Преторианочка',
  Crusher: 'Ебалка',
  Ravager: 'Убивец',
  King: 'Батя',
  Queen: 'Многодетная мать',
  Predalien: 'Кракозябра',
  Hellhound: 'Адская гончая',
  Abomination: 'Кракозябра',
  Despoiler: 'Наркоман',
};

export function CastesRu(value: string) {
  return CASTES_RU[value] || value;
}

export function ReverseCastesRu(value: string) {
  return REVERSED_CASTES_RU[value] || value;
}

const REVERSED_CASTES_RU = Object.entries(CASTES_RU).reduce(
  (reversed_castes, [key, value]) => {
    reversed_castes[value] = key;
    return reversed_castes;
  },
  {},
);

export function StrainRu(value: string) {
  return STRAIN_RU[value] || value;
}

export function ReverseStrainRu(value: string) {
  return REVERSED_STRAIN_RU[value] || value;
}

const REVERSED_STRAIN_RU = Object.entries(STRAIN_RU).reduce(
  (reversed_strains, [key, value]) => {
    reversed_strains[value] = key;
    return reversed_strains;
  },
  {},
);
