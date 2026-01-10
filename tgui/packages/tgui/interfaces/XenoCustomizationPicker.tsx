import { useState } from 'react';
import { useBackend } from 'tgui/backend';
import {
  Button,
  Dropdown,
  Flex,
  Icon,
  Section,
  Stack,
  Tooltip,
} from 'tgui/components';
import { Window } from 'tgui/layouts';

import {
  CastesRu,
  ReverseCastesRu,
  ReverseStrainRu,
  StrainRu,
} from './BandaMarines/XenoCastes';

type Data = {
  selected_caste: string;
  selected_customizations_for_caste: string[];
  available_customizations_for_caste: XenoCustomization[];
  assigned_map: string;
  castes: string[];
  used_slots_for_caste: number;
  selected_strain: string;
  available_strains_for_caste: string[];
  positions: string[];
  selected_position: string;
  slots: CustomizationSlot[];
};

type XenoCustomization = {
  name: string;
  caste: string;
  key: string;
  no_access_text: string;
  slot_bitflag: number;
  customization_type: string;
};

type CustomizationSlot = {
  name: string;
  bitflag: number;
};

export const XenoCustomizationPicker = (props) => {
  const { act, data } = useBackend<Data>();
  const {
    selected_caste,
    castes,
    available_customizations_for_caste,
    selected_strain,
    available_strains_for_caste,
    positions,
    selected_position,
    slots,
  } = data;
  const [toShowBit, setShowBit] = useState(slots[1].bitflag);

  const castesRu = castes.map((value) => CastesRu(value));
  const strainsRu = available_strains_for_caste.map((value) => StrainRu(value));

  return (
    <Window width={600} height={350}>
      <Window.Content>
        <Stack fill>
          <Stack.Item>
            <Flex direction="column">
              <Section fill title="Позиция" align="center">
                <Flex direction="column">
                  {positions.map((new_position, i) => (
                    <Button
                      key={i}
                      onClick={() =>
                        act('change_position', { new_position: new_position })
                      }
                      selected={selected_position === new_position}
                    >
                      {new_position}
                    </Button>
                  ))}
                </Flex>
              </Section>
              <Section fill title="Слот" align="center">
                <Flex direction="column">
                  {slots.map((slot_data, i) => (
                    <Button
                      key={i}
                      onClick={() => setShowBit(slot_data.bitflag)}
                      disabled={
                        available_customizations_for_caste.filter(
                          (customization) =>
                            customization.slot_bitflag & slot_data.bitflag,
                        ).length === 0
                      }
                      selected={toShowBit === slot_data.bitflag}
                    >
                      {slot_data.name}
                    </Button>
                  ))}
                </Flex>
              </Section>
            </Flex>
          </Stack.Item>
          <Stack.Item grow>
            <Section
              fill
              title="Кастомизация"
              scrollable
              buttons={
                <Flex direction="row">
                  <Dropdown
                    menuWidth="10rem"
                    width="10rem"
                    options={strainsRu}
                    selected={StrainRu(selected_strain)}
                    displayText={StrainRu(selected_strain)}
                    onSelected={(value) =>
                      act('change_strain', {
                        new_strain: ReverseStrainRu(value),
                      })
                    }
                    disabled={strainsRu.length === 1}
                  />
                  <Dropdown
                    menuWidth="15rem"
                    width="15rem"
                    options={castesRu}
                    selected={CastesRu(selected_caste)}
                    displayText={CastesRu(selected_caste)}
                    onSelected={(value) =>
                      act('change_caste', { new_caste: ReverseCastesRu(value) })
                    }
                  />
                </Flex>
              }
            >
              <Flex direction="column">
                {available_customizations_for_caste.length
                  ? available_customizations_for_caste
                      .filter(
                        (customization) =>
                          customization.slot_bitflag & toShowBit,
                      )
                      .map((customization, i) => (
                        <Stack key={i} fill>
                          <Stack.Item>
                            <TooltipXenoVisibility
                              customization={customization}
                            />
                          </Stack.Item>
                          <Stack.Item>
                            <TooltipXenoAvailable
                              customization={customization}
                            />
                          </Stack.Item>
                          <Stack.Item grow={1}>
                            <AddToPreviewButton customization={customization} />
                          </Stack.Item>
                        </Stack>
                      ))
                  : 'Кастомизаций нет'}
              </Flex>
            </Section>
          </Stack.Item>
        </Stack>
      </Window.Content>
    </Window>
  );
};

const AddToPreviewButton = (props) => {
  const { act, data } = useBackend<Data>();
  const { selected_customizations_for_caste, used_slots_for_caste } = data;
  const { customization } = props;

  const slots = [
    { bit: 1, name: 'ноги' },
    { bit: 2, name: 'туловище' },
    { bit: 4, name: 'руки' },
    { bit: 8, name: 'голова' },
    { bit: 16, name: 'хвост' },
  ];
  const conflictingSlots = slots
    .filter(
      (slot) =>
        customization.slot_bitflag & slot.bit &&
        used_slots_for_caste & slot.bit,
    )
    .map((slot) => slot.name);
  const allBodyPieces = conflictingSlots.join(' ');

  return (
    <Button
      fluid
      selected={selected_customizations_for_caste.includes(customization.key)}
      onClick={() =>
        act('add_to_preview', {
          new_customization: customization.key,
        })
      }
      disabled={
        customization.slot_bitflag & used_slots_for_caste &&
        !selected_customizations_for_caste.includes(customization.key)
      }
      tooltip={
        customization.slot_bitflag & used_slots_for_caste &&
        !selected_customizations_for_caste.includes(customization.key)
          ? 'Уже заняты следующие слоты: ' + allBodyPieces
          : null
      }
    >
      {customization.name}
    </Button>
  );
};

const TooltipXenoVisibility = (props) => {
  const { customization } = props;
  const isLoreFriendly =
    customization.customization_type === 'xeno_customization_lore_friendly';
  return (
    <Tooltip
      content={
        isLoreFriendly
          ? 'Кастомизация будет видна всем (Lore Friendly)'
          : 'Кастомизация не будет видна всем (Non-Lore Friendly)'
      }
    >
      <Icon name="eye" color={isLoreFriendly ? 'green' : 'red'} />
    </Tooltip>
  );
};

const TooltipXenoAvailable = (props) => {
  const { act, data } = useBackend<Data>();
  const { customization } = props;
  const isAvailable = !customization.no_access_text;
  return !isAvailable ? (
    <Tooltip
      content={
        !isAvailable
          ? 'Доступно только превью. Причина: ' + customization.no_access_text
          : null
      }
    >
      <Icon name="lock" color="red" />
    </Tooltip>
  ) : (
    <Icon name="unlock" color="green" />
  );
};
