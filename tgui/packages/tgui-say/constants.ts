/** Window sizes in pixels */
export enum WindowSize {
  Small = 30,
  Medium = 50,
  Large = 70,
  Width = 325,
}

export const SMALL_WINDOW_SIZE = WindowSize.Small;
export const MEDIUM_WINDOW_SIZE = WindowSize.Medium;
export const LARGE_WINDOW_SIZE = WindowSize.Large;
export const WIDTH_WINDOW_SIZE = WindowSize.Width;

/** Line lengths for autoexpand */
export enum LineLength {
  Small = 30,
  Medium = 60,
  Large = 90,
}

export const SMALL_LINE_SIZE = LineLength.Small;
export const MEDIUM_LINE_SIZE = LineLength.Medium;
export const LARGE_LINE_SIZE = LineLength.Large;

export const LIVING_TYPES = {
  HUMAN: 'human',
  XENO: 'xeno',
  SYNTH: 'synth',
  YAUTJA: 'yautja',
} as const;

export type LivingType = (typeof LIVING_TYPES)[keyof typeof LIVING_TYPES];

export const RADIO_PREFIXES_MAP: Record<string, string> = {
  ':й ': ':q ',
  ':ц ': ':w ',
  ':у ': ':e ',
  ':к ': ':r ',
  ':е ': ':t ',
  ':н ': ':y ',
  ':г ': ':u ',
  ':ш ': ':i ',
  ':щ ': ':o ',
  ':з ': ':p ',
  ':ф ': ':a ',
  ':ы ': ':s ',
  ':в ': ':d ',
  ':а ': ':f ',
  ':п ': ':g ',
  ':р ': ':h ',
  ':о ': ':j ',
  ':л ': ':k ',
  ':д ': ':l ',
  ':я ': ':z ',
  ':ч ': ':x ',
  ':с ': ':c ',
  ':м ': ':v ',
  ':и ': ':b ',
  ':т ': ':n ',
  ':ь ': ':m ',
} as const;

/**
 * Radio prefixes.
 * Displays the name in the left button, tags a css class.
 */
export const RADIO_PREFIXES = {
  ':h ': {
    id: null,
    label: 'Отдел',
  },
  ':i ': {
    id: null,
    label: 'ВнутрСвязь',
  },
  ':w ': {
    id: null,
    label: 'Шёпот',
  },
  ':a ': {
    id: 'Alpha',
    label: 'Альфа',
  },
  ':b ': {
    id: 'Bravo',
    label: 'Браво',
  },
  ':c ': {
    id: 'Charlie',
    label: 'Чарли',
  },
  ':d ': {
    id: 'Delta',
    label: 'Дельта',
  },
  ':e ': {
    id: 'Echo',
    label: 'Эхо',
  },
  ':f ': {
    id: 'Foxtrot',
    label: 'Фокстрот',
  },
  ':g ': {
    id: null,
    label: 'Корабль',
  },
  ':j ': {
    id: 'JTAC',
    label: 'JTAC',
  },
  ':k ': {
    id: null,
    label: 'ССО',
  },
  ':m ': {
    id: 'MedSci',
    label: 'МедИс',
  },
  ':n ': {
    id: 'Engi',
    label: 'Инж',
  },
  ':o ': {
    id: null,
    label: 'Колония',
  },
  ':p ': {
    id: 'MP',
    label: 'ВоенПол',
  },
  ':q ': {
    id: 'Hivemind',
    label: 'Улей',
  },
  ':s ': {
    id: null,
    label: 'ЦРУ',
  },
  '#s ': {
    id: null,
    label: 'Хищники',
  },
  '#r ': {
    id: null,
    label: 'Хищники',
  },
  ':t ': {
    id: 'Intel',
    label: 'Разведка',
  },
  ':u ': {
    id: 'Req',
    label: 'Запросы',
  },
  ':v ': {
    id: 'Command',
    label: 'Команд',
  },
  ':x ': {
    id: null,
    label: 'Гипердайн',
  },
  ':y ': {
    id: 'wy',
    label: 'В-Ю Корп',
  },
  '.y ': {
    id: 'wy',
    label: 'В-Ю Корп.',
  },
  '#y ': {
    id: 'wysec',
    label: 'В-Ю Безопас.',
  },
  ':1 ': {
    id: 'wypub',
    label: 'В-Ю Общий',
  },
  '.1 ': {
    id: 'wypub',
    label: 'В-Ю Общий',
  },
  '#1 ': {
    id: 'wypub',
    label: 'В-Ю Общий',
  },
  '#z ': {
    id: null,
    label: 'ЧВК Кмд.',
  },
  '#p ': {
    id: null,
    label: 'ЧВК В-Ю',
  },
  '#e ': {
    id: null,
    label: 'ЧВК Инж.',
  },
  '#o ': {
    id: null,
    label: 'ЧВК CCT',
  },
  '#f ': {
    id: null,
    label: 'ЧВК Мед.',
  },
  '#k ': {
    id: null,
    label: 'Спец.Опер.',
  },
  ':Y ': {
    id: null,
    label: 'В-Ю Корп',
  },
  ':z ': {
    id: null,
    label: 'ВысшКоманд.',
  },
  '#l ': {
    id: null,
    label: 'Провост',
  },
  '#g ': {
    id: null,
    label: 'КОФ',
  },
  '#c ': {
    id: null,
    label: 'КОФ Кмд.',
  },
  '#b ': {
    id: null,
    label: 'КОФ Инж.',
  },
  '#a ': {
    id: null,
    label: 'КОФ Мед.',
  },
  '#d ': {
    id: null,
    label: 'КОФ ССТ',
  },
  '#u ': {
    id: null,
    label: 'СПН',
  },
  '#v ': {
    id: null,
    label: 'СПН Кмд.',
  },
  '#n ': {
    id: null,
    label: 'СПН Инж.',
  },
  '#m ': {
    id: null,
    label: 'СПН Мед.',
  },
  '#j ': {
    id: null,
    label: 'СПН ССТ',
  },
  '#t ': {
    id: null,
    label: 'СПН Кмдс.',
  },
} as const;
