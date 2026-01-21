import { useBackend } from 'tgui/backend';
import { Box, Section } from 'tgui/components';
import { Window } from 'tgui/layouts';

type Data = { xcoord: number; ycoord: number; zcoord: number };

export const Binoculars = () => {
  const { data } = useBackend<Data>();

  const x_coord = data.xcoord;
  const y_coord = data.ycoord;
  const z_coord = data.zcoord;

  return (
    <Window width={450} height={200}>
      <Window.Content scrollable>
        <Section
          title="УПРОЩЕННЫЕ КООРДИНАТЫ ЦЕЛИ"
          textAlign="center"
          fontSize="15px"
        >
          <Box fontSize="30px">
            ДОЛГОТА : {x_coord}, ШИРОТА : {y_coord}, ВЫСОТА : {z_coord}
          </Box>
        </Section>
      </Window.Content>
    </Window>
  );
};
