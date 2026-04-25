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
  й: 'q',
  ц: 'w',
  у: 'e',
  к: 'r',
  е: 't',
  н: 'y',
  г: 'u',
  ш: 'i',
  щ: 'o',
  з: 'p',
  ф: 'a',
  ы: 's',
  в: 'd',
  а: 'f',
  п: 'g',
  р: 'h',
  о: 'j',
  л: 'k',
  д: 'l',
  я: 'z',
  ч: 'x',
  с: 'c',
  м: 'v',
  и: 'b',
  т: 'n',
  ь: 'm',
} as const;

const RU_RADIO_LABELS = {
  'Depart.': 'Отдел',
  Intercom: 'ВнутрСвязь',
  'L Hand': 'Л Рука',
  'R Hand': 'П Рука',
  Whisper: 'Шёпот',
  Alpha: 'Альфа',
  'CLF Med': 'КОФ Мед',
  Bravo: 'Браво',
  'CLF Engi': 'КОФ Инж',
  'Charl.': 'Чарли',
  Charlie: 'Чарли',
  'CLF Cmd.': 'КОФ Кмд',
  Delta: 'Дельта',
  'CLF CCT': 'КОФ CCT',
  Echo: 'Эхо',
  'PMC Engi': 'ЧВК Инж',
  'Foxtr.': 'Фокстрот',
  Foxtrot: 'Фокстрот',
  'PMC Med': 'ЧВК Мед',
  Ship: 'Корабль',
  CLF: 'КОФ',
  JTAC: 'JTAC',
  'UPP CCT': 'СПН CCT',
  SOF: 'ССО',
  Military: 'Воен',
  SpecOps: 'СпецОпер',
  Provost: 'Провост',
  MedSci: 'МедИс',
  Engi: 'Инж',
  'UPP Engi': 'СПН Инж',
  Colony: 'Колония',
  'PMC CCT': 'ЧВК CCT',
  MP: 'ВоенПол',
  PMC: 'ЧВК',
  Hive: 'Улей',
  Yautja: 'Хищники',
  Army: 'Армия',
  'Yautja Ovr.': 'Yautja Ovr.',
  Int: 'Разведка',
  Intel: 'Разведка',
  'UPP Kdo': 'СПН Кмдс',
  Req: 'Запросы',
  UPP: 'СПН',
  'Cmd.': 'Кмд',
  Command: 'Кмд',
  'UPP Cmd.': 'СПН Кмд',
  Hyperdyne: 'Гипердайн',
  'W-Y Corp': 'В-Ю Корп',
  'W-Y Sec': 'В-Ю Безоп',
  'W-Y Pub': 'В-Ю Общ',
  CIA: 'ЦРУ',
  HC: 'ВысшКмд',
  'PMC Cmd.': 'ЧВК Кмд',
} as const;

export function RuRadioLabel(input: string) {
  return RU_RADIO_LABELS[input] ?? input;
}

const EN_CHANNEL_LABELS = {
  Говорить: 'say',
  Рация: 'comms',
  Эмоция: 'me',
  Шёпот: 'whisper',
  Ментор: 'mentor',
  Админ: 'asay',
  Улей: 'hive',
  Хищники: 'yautja',
} as const;

export function EnChannelLabel(input: string) {
  return EN_CHANNEL_LABELS[input] ?? input.toLowerCase();
}

/**
 * Radio prefixes.
 * Contains the properties:
 * id - string. css class identifier.
 * label - string. button label.
 */
export const RADIO_PREFIXES = {
  ':h ': {
    id: 'department',
    label: 'Depart.',
  },
  '.h ': {
    id: 'department',
    label: 'Depart.',
  },
  '#h ': {
    id: 'department',
    label: 'Depart.',
  },
  ':i ': {
    id: 'comms',
    label: 'Intercom',
  },
  '.i ': {
    id: 'comms',
    label: 'Intercom',
  },
  '#i ': {
    id: 'comms',
    label: 'Intercom',
  },
  ':l ': {
    id: 'comms',
    label: 'L Hand',
  },
  '.l ': {
    id: 'comms',
    label: 'L Hand',
  },
  ':r ': {
    id: 'comms',
    label: 'R Hand',
  },
  '.r ': {
    id: 'comms',
    label: 'R Hand',
  },
  ':w ': {
    id: 'whisper',
    label: 'Whisper',
  },
  '.w ': {
    id: 'whisper',
    label: 'Whisper',
  },
  '#w ': {
    id: 'whisper',
    label: 'Whisper',
  },
  ':a ': {
    id: 'alpha',
    label: 'Alpha',
  },
  '.a ': {
    id: 'alpha',
    label: 'Alpha',
  },
  '#a ': {
    id: 'clf-med',
    label: 'CLF Med',
  },
  ':b ': {
    id: 'bravo',
    label: 'Bravo',
  },
  '.b ': {
    id: 'bravo',
    label: 'Bravo',
  },
  '#b ': {
    id: 'clf-engi',
    label: 'CLF Engi',
  },
  ':c ': {
    id: 'charlie',
    label: 'Charl.',
  },
  '.c ': {
    id: 'charlie',
    label: 'Charl.',
  },
  '#c ': {
    id: 'clf-cmd',
    label: 'CLF Cmd.',
  },
  ':d ': {
    id: 'delta',
    label: 'Delta',
  },
  '.d ': {
    id: 'delta',
    label: 'Delta',
  },
  '#d ': {
    id: 'clf-cct',
    label: 'CLF CCT',
  },
  ':e ': {
    id: 'echo',
    label: 'Echo',
  },
  '.e ': {
    id: 'echo',
    label: 'Echo',
  },
  '#e ': {
    id: 'pmc-engi',
    label: 'PMC Engi',
  },
  ':f ': {
    id: 'foxtrot',
    label: 'Foxtr.',
  },
  '.f ': {
    id: 'foxtrot',
    label: 'Foxtr.',
  },
  '#f ': {
    id: 'pmc-med',
    label: 'PMC Med',
  },
  ':g ': {
    id: 'ship',
    label: 'Ship',
  },
  '.g ': {
    id: 'ship',
    label: 'Ship',
  },
  '#g ': {
    id: 'clf',
    label: 'CLF',
  },
  ':j ': {
    id: 'jtac',
    label: 'JTAC',
  },
  '.j ': {
    id: 'jtac',
    label: 'JTAC',
  },
  '#j ': {
    id: 'upp-cct',
    label: 'UPP CCT',
  },
  ':k ': {
    id: 'sof',
    label: 'SOF',
  },
  '.k ': {
    id: 'yautja',
    label: 'Military',
  },
  '#k ': {
    id: 'specops',
    label: 'SpecOps',
  },
  '#l ': {
    id: 'provost',
    label: 'Provost',
  },
  ':m ': {
    id: 'medsci',
    label: 'MedSci',
  },
  '.m ': {
    id: 'medsci',
    label: 'MedSci',
  },
  '#m ': {
    id: 'upp-med',
    label: 'UPP Med',
  },
  ':n ': {
    id: 'engi',
    label: 'Engi',
  },
  '.n ': {
    id: 'engi',
    label: 'Engi',
  },
  '#n ': {
    id: 'upp-engi',
    label: 'UPP Engi',
  },
  ':o ': {
    id: 'colony',
    label: 'Colony',
  },
  '.o ': {
    id: 'colony',
    label: 'Colony',
  },
  '#o ': {
    id: 'pmc-cct',
    label: 'PMC CCT',
  },
  ':p ': {
    id: 'security',
    label: 'MP',
  },
  '.p ': {
    id: 'security',
    label: 'MP',
  },
  '#p ': {
    id: 'pmc',
    label: 'PMC',
  },
  ':q ': {
    id: 'hive',
    label: 'Hive',
  },
  '.q ': {
    id: 'hive',
    label: 'Hive',
  },
  '#q ': {
    id: 'hive',
    label: 'Hive',
  },
  '#r ': {
    id: 'yautja',
    label: 'Yautja',
  },
  ':s ': {
    id: 'army',
    label: 'Army',
  },
  '.s ': {
    id: 'army',
    label: 'Army',
  },
  '#s ': {
    id: 'yautja',
    label: 'Yautja Ovr.',
  },
  ':t ': {
    id: 'intel',
    label: 'Int',
  },
  '.t ': {
    id: 'intel',
    label: 'Int',
  },
  '#t ': {
    id: 'upp-kdo',
    label: 'UPP Kdo',
  },
  ':u ': {
    id: 'req',
    label: 'Req',
  },
  '.u ': {
    id: 'req',
    label: 'Req',
  },
  '#u ': {
    id: 'upp',
    label: 'UPP',
  },
  ':v ': {
    id: 'command',
    label: 'Cmd.',
  },
  '.v ': {
    id: 'command',
    label: 'Cmd.',
  },
  '#v ': {
    id: 'upp-cmd',
    label: 'UPP Cmd.',
  },
  ':x ': {
    id: 'hyperdyne',
    label: 'Hyperdyne',
  },
  '.x ': {
    id: 'hyperdyne',
    label: 'Hyperdyne',
  },
  '#x ': {
    id: 'hyperdyne',
    label: 'Hyperdyne',
  },
  ':y ': {
    id: 'wy',
    label: 'W-Y Corp',
  },
  '.y ': {
    id: 'wy',
    label: 'W-Y Corp',
  },
  '#y ': {
    id: 'wysec',
    label: 'W-Y Sec',
  },
  ':1 ': {
    id: 'wypub',
    label: 'W-Y Pub',
  },
  '.1 ': {
    id: 'wypub',
    label: 'W-Y Pub',
  },
  '#1 ': {
    id: 'wypub',
    label: 'W-Y Pub',
  },
  ':2 ': {
    id: 'cia',
    label: 'CIA',
  },
  '.2 ': {
    id: 'cia',
    label: 'CIA',
  },
  '#2 ': {
    id: 'cia',
    label: 'CIA',
  },
  ':z ': {
    id: 'highcom',
    label: 'HC',
  },
  '.z ': {
    id: 'highcom',
    label: 'HC',
  },
  '#z ': {
    id: 'pmc-cmd',
    label: 'PMC Cmd.',
  },
} as const;

export const LANGUAGE_PREFIXES = {
  '!0 ': {
    id: 'scandinavian',
    label: 'Scandinavian',
  },
  '!1 ': {
    id: 'english',
    label: 'English',
  },
  '!2 ': {
    id: 'japanese',
    label: 'Japanese',
  },
  '!3 ': {
    id: 'russian',
    label: 'Russian',
  },
  '!4 ': {
    id: 'german',
    label: 'German',
  },
  '!5 ': {
    id: 'spanish',
    label: 'Spanish',
  },
  '!6 ': {
    id: 'apollo',
    label: 'Apollo',
  },
  '!7 ': {
    id: 'telepathy',
    label: 'Telepathy',
  },
  '!8 ': {
    id: 'chinese',
    label: 'Chinese',
  },
  '!9 ': {
    id: 'french',
    label: 'French',
  },
  '!x ': {
    id: 'xenomorph',
    label: 'Xenomporph',
  },
  '!l ': {
    id: 'tactical sign language',
    label: 'Tactical Sign',
  },
  '!s ': {
    id: 'sainja',
    label: 'Sainja',
  },
  '!h ': {
    id: 'hellhound',
    label: 'Hellhound',
  },
  '!q ': {
    id: 'hivemind',
    label: 'Hivemind',
  },
  '!_ ': {
    id: 'primitive',
    label: 'Primitive',
  },
} as const;

const RU_LANGUAGE_LABELS = {
  Hivemind: 'Разум улья',
} as const;

export function RuLanguageLabel(input: string) {
  return RU_LANGUAGE_LABELS[input] ?? input;
}

export function RuPrefixLabel(input: string) {
  return RuLanguageLabel(RuRadioLabel(input));
}
