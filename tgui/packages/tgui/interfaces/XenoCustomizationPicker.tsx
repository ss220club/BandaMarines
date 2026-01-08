import { useBackend } from 'tgui/backend';
import { Button, Dropdown, Stack } from 'tgui/components';
import { Window } from 'tgui/layouts';

type Data = {
  selected_caste: string;
  selected_customizations_for_caste: string[];
  available_customizations_for_caste: XenoCustomization[];
  assigned_map: string;
  castes: string[];
};

type XenoCustomization = {
  name: string;
  caste: string;
  key: string;
};

export const XenoCustomizationPicker = (props) => {
  const { act, data } = useBackend<Data>();
  const {
    selected_caste,
    selected_customizations_for_caste,
    castes,
    available_customizations_for_caste,
  } = data;
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
          <Stack.Item>
            {available_customizations_for_caste.map((customization, i) => (
              <Button
                key={i}
                selected={
                  selected_customizations_for_caste
                    ? selected_customizations_for_caste.includes(
                        customization.key,
                      )
                    : false
                }
                onClick={() =>
                  act('add_to_preview', {
                    new_customization: customization.key,
                  })
                }
              >
                {customization.name}
              </Button>
            ))}
          </Stack.Item>
          <Stack.Item>
            <Button onClick={() => act('save')}>Save</Button>
          </Stack.Item>
        </Stack>
      </Window.Content>
    </Window>
  );
};
