import { useEffect, useState } from 'react';
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

export const VehicleASRS = (props) => {
  const { act, data } = useBackend<Data>();

  // Состояния интерфейса
  const [selectedCategory, setSelectedCategory] = useState<string | null>(null);
  const [dots, setDots] = useState('.');
  const [progress, setProgress] = useState(0);

  if (!data) return null;

  const { elevator_moving, elevator_raised, categories, vehicles } = data;

  // Фильтрация техники для активной вкладки
  const filteredVehicles = vehicles.filter(
    (v) => v.category === selectedCategory,
  );

  // Анимация ожидания (точки)
  useEffect(() => {
    const interval = setInterval(() => {
      setDots((prev) => (prev === '...' ? '.' : prev + '.'));
    }, 400);
    return () => clearInterval(interval);
  }, []);

  // Плавный прогресс-бар для движения платформы (10 секунд)
  useEffect(() => {
    if (!elevator_moving) {
      setProgress(0);
      return;
    }
    const start = Date.now();
    const interval = setInterval(() => {
      const elapsed = Date.now() - start;
      const t = Math.min(elapsed / 10000, 1);
      setProgress(1 - Math.pow(1 - t, 3)); // Кубическое смягчение для реалистичности
    }, 100);
    return () => clearInterval(interval);
  }, [elevator_moving]);

  return (
    <Window width={520} height={600}>
      <Window.Content>
        <Stack fill vertical>
          {/* =========================================
              ВЕРХНЯЯ ЧАСТЬ: ДИНАМИЧЕСКИЙ КОНТЕНТ (ВКЛАДКИ)
              ========================================= */}
          <Stack.Item grow>
            {/* РЕЖИМ 1: СПИСОК КАТЕГОРИЙ */}
            {!selectedCategory && (
              <Section title="СИСТЕМА ХРАНЕНИЯ (ASRS)" fill scrollable>
                <NoticeBox info mb={2}>
                  Выберите категорию для запроса техники. Следите за лимитами
                  развертывания.
                </NoticeBox>
                <Stack vertical>
                  {categories.map((cat) => {
                    const isFull = cat.used >= cat.limit;
                    return (
                      <Button
                        key={cat.name}
                        fluid
                        height="36px"
                        onClick={() => setSelectedCategory(cat.name)}
                      >
                        <Stack align="center" fill>
                          <Stack.Item grow>
                            <Icon name="folder" mr={1} opacity={0.7} />
                            <b>{cat.name.toUpperCase()}</b>
                          </Stack.Item>
                          <Stack.Item>
                            <Box color={isFull ? 'bad' : 'good'} bold>
                              [{cat.used} / {cat.limit}]
                            </Box>
                          </Stack.Item>
                          <Stack.Item>
                            <Icon name="chevron-right" opacity={0.5} />
                          </Stack.Item>
                        </Stack>
                      </Button>
                    );
                  })}
                </Stack>
              </Section>
            )}

            {/* РЕЖИМ 2: ВЫБРАННАЯ КАТЕГОРИЯ (ТЕХНИКА) */}
            {selectedCategory && (
              <Section
                title={`КАТЕГОРИЯ: ${selectedCategory.toUpperCase()}`}
                fill
                scrollable
                buttons={
                  <Button
                    icon="arrow-left"
                    color="transparent"
                    onClick={() => setSelectedCategory(null)}
                  >
                    НАЗАД В МЕНЮ
                  </Button>
                }
              >
                <Stack vertical>
                  {filteredVehicles.length === 0 ? (
                    <Box color="label" textAlign="center" mt={2} italic>
                      В данной категории нет доступной техники.
                    </Box>
                  ) : (
                    filteredVehicles.map((v) => {
                      const isDisabled =
                        v.locked || v.limit_reached || v.category_locked;

                      return (
                        <Box
                          key={v.id}
                          mb={1}
                          p={1}
                          backgroundColor="rgba(0,0,0,0.2)"
                        >
                          <Stack align="center">
                            <Stack.Item grow>
                              <Box bold fontSize="13px">
                                <Icon name="truck" mr={1} opacity={0.7} />
                                {v.name.toUpperCase()}
                              </Box>
                              {Boolean(v.locked) && (
                                <Box color="bad" fontSize="11px" mt={0.5}>
                                  <Icon name="exclamation-triangle" mr={0.5} />
                                  {v.failure_message}
                                </Box>
                              )}
                              {v.limit_reached && (
                                <Box color="average" fontSize="11px" mt={0.5}>
                                  ДОСТИГНУТ ЛИМИТ РАЗВЕРТЫВАНИЯ
                                </Box>
                              )}
                            </Stack.Item>
                            <Stack.Item>
                              <Button
                                icon="download"
                                color={isDisabled ? 'transparent' : 'default'}
                                disabled={isDisabled}
                                onClick={() => act('get_vehicle', { id: v.id })}
                              >
                                ЗАПРОСИТЬ
                              </Button>
                            </Stack.Item>
                          </Stack>
                        </Box>
                      );
                    })
                  )}
                </Stack>
              </Section>
            )}
          </Stack.Item>

          {/* =========================================
              НИЖНЯЯ ЧАСТЬ: СТАТИЧНАЯ ПАНЕЛЬ ЛИФТА
              ========================================= */}
          <Stack.Item>
            <Section title="УПРАВЛЕНИЕ ТРАНСПОРТНОЙ ПЛАТФОРМОЙ">
              <Stack align="center">
                {/* Левая сторона: Статус */}
                <Stack.Item grow>
                  <Box fontSize="14px" color="label">
                    <Icon
                      name={elevator_moving ? 'cog' : 'server'}
                      spin={elevator_moving}
                      mr={1}
                      color={elevator_moving ? 'average' : 'good'}
                    />
                    СТАТУС ПЛАТФОРМЫ:{' '}
                    <Box
                      as="span"
                      bold
                      color={elevator_moving ? 'average' : 'white'}
                    >
                      {elevator_moving
                        ? `ТРАНСПОРТИРОВКА${dots}`
                        : elevator_raised
                          ? 'ПОДНЯТА'
                          : 'ОПУЩЕНА'}
                    </Box>
                  </Box>
                </Stack.Item>

                {/* Правая сторона: Кнопка */}
                <Stack.Item>
                  <Button
                    width="220px"
                    height="40px"
                    textAlign="center"
                    fontSize="13px"
                    bold
                    icon="power-off"
                    // Зеленая, если готова к использованию, серая если в движении
                    color={elevator_moving ? 'default' : 'success'}
                    disabled={elevator_moving}
                    onClick={() =>
                      act(elevator_raised ? 'lower_elevator' : 'raise_elevator')
                    }
                  >
                    {elevator_raised
                      ? 'ОПУСТИТЬ ПЛАТФОРМУ'
                      : 'ПОДНЯТЬ ПЛАТФОРМУ'}
                  </Button>
                </Stack.Item>
              </Stack>

              {/* Прогресс-бар появляется только при движении */}
              {elevator_moving && (
                <Box mt={2}>
                  <ProgressBar value={progress} color="average" />
                </Box>
              )}
            </Section>
          </Stack.Item>
        </Stack>
      </Window.Content>
    </Window>
  );
};
