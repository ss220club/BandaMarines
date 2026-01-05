import { useBackend } from 'tgui/backend';
import { ByondUi } from 'tgui/components';
import { Section, Stack } from 'tgui/components';
import { Window } from 'tgui/layouts';

const CharacterPreview = (props: {
  readonly height: string;
  readonly id: string;
}) => {
  return (
    <ByondUi
      width="220px"
      height={props.height}
      params={{
        id: props.id,
        type: 'map',
      }}
    />
  );
};

type Data = {
  selected_caste: string;
  selected_customizations: string[];
  assigned_map: string;
};

export const XenoCustomizationPicker = (props) => {
  const { act, data } = useBackend<Data>();
  const { selected_caste, selected_customizations, assigned_map } = data;
  return (
    <Window width={600} height={350} theme="hive_status">
      <Window.Content>
        <Stack fill>
          <Stack.Item>
            <Section fill title={`Каста: ${selected_caste}`}>
              {<CharacterPreview id={assigned_map} height="100%" />}
            </Section>
          </Stack.Item>
        </Stack>
      </Window.Content>
    </Window>
  );
};
