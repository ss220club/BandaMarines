import type { Channel } from './ChannelIterator';
import {
  LANGUAGE_PREFIXES,
  LIVING_TYPES,
  type LivingType,
  RADIO_PREFIXES,
  RADIO_PREFIXES_MAP,
  SMALL_WINDOW_SIZE,
  WIDTH_WINDOW_SIZE,
} from './constants';

/**
 * Once byond signals this via keystroke, it
 * ensures window size, visibility, and focus.
 */
export function windowOpen(channel: Channel, scale: boolean): void {
  setWindowVisibility(true, scale);
  Byond.sendMessage('open', { channel });
}

/**
 * Resets the state of the window and hides it from user view.
 * Sending "close" logs it server side.
 */
export function windowClose(scale: boolean): void {
  setWindowVisibility(false, scale);
  Byond.winset('map', {
    focus: true,
  });
  Byond.sendMessage('close');
}

/**
 * Modifies the window size.
 */
export function windowSet(size = SMALL_WINDOW_SIZE, scale: boolean): void {
  const pixelRatio = scale ? window.devicePixelRatio : 1;

  const sizeStr = `${WIDTH_WINDOW_SIZE * pixelRatio}x${size * pixelRatio}`;

  Byond.winset(null, {
    'tgui_say.size': sizeStr,
    'tgui_say.browser.size': sizeStr,
  });
}

/** Helper function to set window size and visibility */
function setWindowVisibility(visible: boolean, scale: boolean): void {
  const pixelRatio = scale ? window.devicePixelRatio : 1;

  const sizeStr = `${WIDTH_WINDOW_SIZE * pixelRatio}x${SMALL_WINDOW_SIZE * pixelRatio}`;

  Byond.winset(null, {
    'tgui_say.is-visible': visible,
    'tgui_say.size': sizeStr,
    'tgui_say.browser.size': sizeStr,
  });
}

export const isHuman = (type: LivingType) => type === LIVING_TYPES.HUMAN;
export const isXeno = (type: LivingType) => type === LIVING_TYPES.XENO;
export const isSynth = (type: LivingType) => type === LIVING_TYPES.SYNTH;
export const isYautja = (type: LivingType) => type === LIVING_TYPES.YAUTJA;

const CHANNEL_REGEX = /^[:.#№][\wА-яёЁ]\s/;
const LANGUAGE_REGEX = /^![\wА-яёЁ]\s/;

function normalizeRadioPrefixes(input: string): string {
  const radioSymbol = input.slice(0, 1);
  const radioKey = input.slice(1, 2);
  const normalizedRadioKey = RADIO_PREFIXES_MAP[radioKey] || radioKey;

  return radioSymbol + normalizedRadioKey + ' ';
}

/** Tests for a channel prefix, returning it or none */
export function getPrefix(
  value: string,
): keyof typeof RADIO_PREFIXES | keyof typeof LANGUAGE_PREFIXES | null {
  if (!value || value.length < 3) {
    return null;
  }

  const rawPrefix = value.slice(0, 3)?.toLowerCase();
  const isRadioPrefix = CHANNEL_REGEX.test(value);
  const isLanguagePrefix = LANGUAGE_REGEX.test(value);
  const adjusted = isRadioPrefix
    ? normalizeRadioPrefixes(rawPrefix)
    : rawPrefix;

  if (isLanguagePrefix) {
    return LANGUAGE_PREFIXES[adjusted as keyof typeof LANGUAGE_PREFIXES]
      ? (adjusted as keyof typeof LANGUAGE_PREFIXES)
      : null;
  }

  if (
    !isRadioPrefix ||
    !RADIO_PREFIXES[adjusted as keyof typeof RADIO_PREFIXES]
  ) {
    return null;
  }

  return adjusted as keyof typeof RADIO_PREFIXES;
}

export type RadioPrefixType = keyof typeof RADIO_PREFIXES;
export type LanguagePrefixType = keyof typeof LANGUAGE_PREFIXES;
export type PrefixType = RadioPrefixType | LanguagePrefixType;

export type PrefixData = {
  id: string | null;
  label: string;
};

export function isLanguagePrefix(
  prefix: PrefixType,
): prefix is LanguagePrefixType {
  return !!LANGUAGE_PREFIXES[prefix as LanguagePrefixType];
}

export function resolvePrefixData(
  prefix: PrefixType | null,
): PrefixData | null {
  if (!prefix) {
    return null;
  }

  if (LANGUAGE_PREFIXES[prefix as LanguagePrefixType]) {
    const data = LANGUAGE_PREFIXES[prefix as LanguagePrefixType];
    return {
      id: data.id,
      label: data.label,
    };
  }

  if (RADIO_PREFIXES[prefix as RadioPrefixType]) {
    const data = RADIO_PREFIXES[prefix as RadioPrefixType];
    return {
      id: data.id,
      label: data.label,
    };
  }

  return null;
}
