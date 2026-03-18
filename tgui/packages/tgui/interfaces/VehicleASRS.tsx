import { Fragment, useEffect, useState } from 'react';
import { useBackend } from 'tgui/backend';
import {
  Box,
  Button,
  Icon,
  NoticeBox,
  ProgressBar,
  Section,
  Stack,
} from 'tgui/components';
import { Window } from 'tgui/layouts';

type Vehicle = {
  id: string;
  name: string;
  category: string;
  locked?: boolean;
  failure_message?: string;
  limit_reached?: boolean;
  category_locked?: boolean;
};

type CategoryInfo = {
  name: string;
  used: number;
  limit: number;
};

type Data = {
  elevator_moving: boolean;
  elevator_raised: boolean;

  categories: CategoryInfo[];
  vehicles: Vehicle[];
};

export const VehicleASRS = () => {
  const { act, data } = useBackend<Data>();

  const [dots, setDots] = useState('.');
  const [progress, setProgress] = useState(0);

  if (!data) {
    return null;
  }

  const { elevator_moving, elevator_raised, categories, vehicles } = data;

  // Анимация точек
  useEffect(() => {
    const interval = setInterval(() => {
      setDots((prev) => (prev === '...' ? '.' : prev + '.'));
    }, 400);
    return () => clearInterval(interval);
  }, []);

  // ✅ Исправленный прогресс (10 сек + плавный)
  useEffect(() => {
    if (!elevator_moving) {
      setProgress(0);
      return;
    }

    const start = Date.now();

    const interval = setInterval(() => {
      const elapsed = Date.now() - start;
      const t = Math.min(elapsed / 10000, 1);

      const eased = 1 - Math.pow(1 - t, 3);

      setProgress(eased);
    }, 100);

    return () => clearInterval(interval);
  }, [elevator_moving]);

  return (
    <Window width={520} height={600}>
      <Window.Content>
        <Stack fill vertical>
          {/* 📊 Категории */}
          <Stack.Item>
            <Section title="Лимиты категорий">
              <Stack vertical>
                {categories.map((cat) => {
                  const remaining = cat.limit - cat.used;

                  return (
                    <Box key={cat.name}>
                      <Icon name="folder" mr={1} />
                      <b>{cat.name}</b>
                      <Box
                        ml={2}
                        color={
                          (remaining <= 0 && 'bad') ||
                          (remaining <= cat.limit / 2 && 'average') ||
                          'good'
                        }
                      >
                        {cat.used}/{cat.limit} (осталось {remaining})
                      </Box>
                    </Box>
                  );
                })}
              </Stack>
            </Section>
          </Stack.Item>

          {/* 🚗 Транспорт */}
          <Stack.Item grow>
            <Section title="Транспорт" fill scrollable>
              <Stack vertical>
                {vehicles.map((v, i) => {
                  const prev = vehicles[i - 1];
                  const showHeader = !prev || prev.category !== v.category;

                  return (
                    <Fragment key={v.id}>
                      {showHeader && (
                        <Box mt={2} bold>
                          <Icon name="list" mr={1} />
                          {v.category}
                        </Box>
                      )}

                      {Boolean(v.locked) && (
                        <NoticeBox color="bad">{v.failure_message}</NoticeBox>
                      )}

                      {Boolean(v.limit_reached) && (
                        <Box color="gray">{v.name} — лимит достигнут</Box>
                      )}

                      {Boolean(v.category_locked) && (
                        <Box color="gray">
                          {v.name} — категория заблокирована
                        </Box>
                      )}

                      {!v.locked && !v.limit_reached && !v.category_locked && (
                        <Button
                          fluid
                          icon="truck"
                          onClick={() => act('get_vehicle', { id: v.id })}
                        >
                          {v.name}
                        </Button>
                      )}
                    </Fragment>
                  );
                })}
              </Stack>
            </Section>
          </Stack.Item>

          {/* 🚀 ЛИФТ */}
          <Stack.Item>
            <Section title="Транспортная платформа">
              {/* статус */}
              <Box mb={1}>
                <Icon name="truck" mr={1} />
                Статус: <b>{elevator_raised ? 'Поднята' : 'Опущена'}</b>
              </Box>

              {/* движение */}
              {elevator_moving ? (
                <>
                  <NoticeBox>
                    <Icon name="spinner" spin mr={1} />
                    Платформа движется{dots}
                  </NoticeBox>

                  <Box mt={1}>
                    <ProgressBar value={progress} />
                  </Box>
                </>
              ) : null}

              {/* кнопка */}
              <Box mt={2} textAlign="right">
                <Button
                  width="200px"
                  height="40px"
                  icon={elevator_raised ? 'power-off' : 'power-off'}
                  disabled={elevator_moving}
                  onClick={() =>
                    act(elevator_raised ? 'lower_elevator' : 'raise_elevator')
                  }
                >
                  {elevator_raised ? 'Опустить платформу' : 'Поднять платформу'}
                </Button>
              </Box>
            </Section>
          </Stack.Item>
        </Stack>
      </Window.Content>
    </Window>
  );
};
