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

type Data = {
  selected_caste: string;
  selected_customizations_for_caste: string[];
  available_customizations_for_caste: XenoCustomization[];
  assigned_map: string;
  castes: string[];
  used_slots_for_caste: number;
};

type XenoCustomization = {
  name: string;
  caste: string;
  key: string;
  no_access_text: string;
  slot_bitflag: number;
  customization_type: string;
};

export const XenoCustomizationPicker = (props) => {
  const { act, data } = useBackend<Data>();
  const {
    selected_caste,
    selected_customizations_for_caste,
    castes,
    available_customizations_for_caste,
    used_slots_for_caste,
  } = data;
  return (
    <Window width={600} height={350}>
      <Window.Content>
        <Stack fill>
          <Stack.Item>
            <Dropdown
              options={castes}
              selected={selected_caste}
              onSelected={(value) => act('change_caste', { new_caste: value })}
            />
          </Stack.Item>
          <Stack.Item grow>
            <Section fill>
              <Flex direction="column">
                {available_customizations_for_caste.length
                  ? available_customizations_for_caste.map(
                      (customization, i) => (
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
                      ),
                    )
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
  const legsUsed =
    customization.slot_bitflag & 1 && used_slots_for_caste & 1 ? 'ноги ' : '';
  const bodyUsed =
    customization.slot_bitflag & 2 && used_slots_for_caste & 2
      ? 'туловище '
      : '';
  const armsUsed =
    customization.slot_bitflag & 4 && used_slots_for_caste & 4 ? 'руки ' : '';
  const headUsed =
    customization.slot_bitflag & 8 && used_slots_for_caste & 8 ? 'голова ' : '';
  const tailUsed =
    customization.slot_bitflag & 16 && used_slots_for_caste & 16
      ? 'хвост '
      : '';
  const allBodyPieces = legsUsed + bodyUsed + armsUsed + headUsed + tailUsed;
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
  const { act, data } = useBackend<Data>();
  const { customization } = props;
  const isLoreFriendly =
    customization.customization_type === 'xeno_customization_lore_friendly';
  return (
    <Tooltip
      content={
        isLoreFriendly
          ? 'Кастомизация будет видна (Lore Friendly)'
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
