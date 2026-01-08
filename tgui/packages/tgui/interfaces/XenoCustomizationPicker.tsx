import { useBackend } from 'tgui/backend';
import { Dropdown, Stack } from 'tgui/components';
import { Window } from 'tgui/layouts';

type Data = {
  selected_caste: string;
  selected_customizations: string[];
  assigned_map: string;
  castes: string[];
};

export const XenoCustomizationPicker = (props) => {
  const { act, data } = useBackend<Data>();
  const { selected_caste, selected_customizations, castes } = data;
  return (
    <Window width={600} height={350} theme="hive_status">
      <Window.Content>
        <Stack fill>
          <Stack.Item>
            <Dropdown
              options={castes}
              selected={selected_caste}
              onSelected={(value) => act('change_caste', { new_caste: value })}
            />
          </Stack.Item>
        </Stack>
      </Window.Content>
    </Window>
  );
};
