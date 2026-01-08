import { useBackend } from 'tgui/backend';
import { ByondUi } from 'tgui/components';
import { Section } from 'tgui/components';
import { Window } from 'tgui/layouts';

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
        <Section fill title={`Каста: ${selected_caste}`}>
          <ByondUi
            width="100%"
            height="100%"
            params={{
              id: assigned_map,
              type: 'map',
            }}
          />
        </Section>
      </Window.Content>
    </Window>
  );
};
