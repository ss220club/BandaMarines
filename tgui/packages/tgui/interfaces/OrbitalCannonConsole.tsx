import type { BooleanLike } from 'common/react';
import { useBackend } from 'tgui/backend';
import {
  Box,
  Button,
  Collapsible,
  Dimmer,
  Divider,
  Icon,
  NoticeBox,
  ProgressBar,
  Section,
} from 'tgui/components';
import { Window } from 'tgui/layouts';

type Data = {
  hefuel: number;
  incfuel: number;
  clusterfuel: number;
  linkedcannon: string | null;
  linkedtray: string | null;
  loadedtray: BooleanLike;
  chamberedtray: BooleanLike;
  warhead: string;
  fuel: number;
  worldtime: number;
  nextchambertime: number;
  chamber_cooldown: number;
  disabled: BooleanLike;
};

export const OrbitalCannonConsole = () => {
  const { act, data } = useBackend<Data>();

  const timeLeft = data.nextchambertime - data.worldtime;
  const timeLeftPct = timeLeft / data.chamber_cooldown;

  const cantChamber = timeLeft > 0 || !data.loadedtray;

  const fullyLoaded = !!data.warhead && data.fuel > 0;

  const fuelLoadedPct = data.fuel / 6;

  return (
    <Window width={500} height={500}>
      <Window.Content scrollable>
        <Section title="Статус боеголовки">
          {(!!data.warhead && (
            <NoticeBox info>{data.warhead} загружена!</NoticeBox>
          )) || <NoticeBox danger>Боеголовка не загружена!</NoticeBox>}
        </Section>
        <Section title="Статус топлива">
          <Box textAlign="center">
            <ProgressBar
              width="100%"
              value={fuelLoadedPct}
              ranges={{
                bad: [-Infinity, 0.51],
                good: [0.51, Infinity],
              }}
            >
              <Box textAlign="center">
                Загруженных баков с твёрдым топливом: {data.fuel}
              </Box>
            </ProgressBar>
          </Box>
          <Divider />
          <Collapsible title="Требования к топливу для боеголовок">
            <Box>
              Фугасная орбитальная боеголовка: <b>{data.hefuel}</b>
              <br />
              Зажигательная орбитальная боеголовка: <b>{data.incfuel}</b>
              <br />
              Кластерная орбитальная боеголовка: <b>{data.clusterfuel}</b>
            </Box>
          </Collapsible>
        </Section>
        <Section title="Статус пусковой кассеты">
          {timeLeft > 0 && (
            <ProgressBar
              width="100%"
              value={timeLeftPct}
              ranges={{
                good: [-Infinity, 0.33],
                average: [0.33, 0.67],
                bad: [0.67, Infinity],
              }}
            >
              <Box textAlign="center">
                {Math.ceil(timeLeft / 10)} сек до того, как пушка будет готова к
                зарядке!
              </Box>
            </ProgressBar>
          )}
          {(!data.loadedtray && (
            <Button
              fontSize="20px"
              textAlign="center"
              fluid
              disabled={!fullyLoaded}
              icon="truck-loading"
              color="good"
              onClick={() => act('load_tray')}
            >
              Загрузить пусковую кассету
            </Button>
          )) || (
            <Box>
              {(!data.chamberedtray && (
                <Button
                  fontSize="20px"
                  textAlign="center"
                  fluid
                  icon="sign-out-alt"
                  color="good"
                  onClick={() => act('unload_tray')}
                >
                  Выгрузить пусковую кассету
                </Button>
              )) || (
                <NoticeBox fontSize="15px" textAlign="center" danger>
                  Пусковая кассета находится в патроннике, вы не можете её
                  выгрузить.
                </NoticeBox>
              )}
            </Box>
          )}
          {!data.chamberedtray && !!data.loadedtray && (
            <Button.Confirm
              fontSize="20px"
              textAlign="center"
              disabled={!!cantChamber || !fullyLoaded}
              fluid
              icon="sign-in-alt"
              color="good"
              confirmContent="Вы не сможете выгрузить пусковую кассету. Уверены?"
              onClick={() => act('chamber_tray')}
            >
              Дослать пусковую кассету
            </Button.Confirm>
          )}
        </Section>
        {(!data.linkedtray || !data.linkedcannon || !!data.disabled) && (
          <Dimmer fontSize="32px">
            <Icon name="exclamation-triangle" />
            {!data.linkedtray && ' Пусковая кассета не подключена к консоли!'}
            {!data.linkedcannon && ' Пушка не подключена к консоли!'}
            {!!data.disabled && '  Пушка отключена!'}
          </Dimmer>
        )}
      </Window.Content>
    </Window>
  );
};
