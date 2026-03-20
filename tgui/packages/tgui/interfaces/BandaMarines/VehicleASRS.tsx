import { useEffect, useState } from 'react';
import { useBackend } from 'tgui/backend';
import { Box, Button, Icon, NoticeBox, Section, Stack } from 'tgui/components';
import { Window } from 'tgui/layouts';

type Vehicle = {
  id: string;
  name: string;
  category: string;
  main_category: string;
  description?: string;
  locked?: boolean;
  failure_message?: string;
  limit_reached?: boolean;
  category_locked?: boolean;
};

type CategoryInfo = {
  name: string;
  used: number;
  limit: number;
  main_category: string;
};

type Data = {
  elevator_moving: boolean | number;
  elevator_raised: boolean | number;
  categories: CategoryInfo[];
  vehicles: Vehicle[];
};

export const VehicleASRS = (props) => {
  const { act, data } = useBackend<Data>();

  const [selectedCategory, setSelectedCategory] = useState<string | null>(null);
  const [dots, setDots] = useState('.');
  const [progress, setProgress] = useState(0);

  if (!data) return null;

  const { elevator_moving, elevator_raised, categories, vehicles } = data;

  const filteredVehicles = vehicles.filter(
    (v) => v.category === selectedCategory,
  );

  const groupedCategories = categories.reduce(
    (acc, cat) => {
      if (!acc[cat.main_category]) acc[cat.main_category] = [];
      acc[cat.main_category].push(cat);
      return acc;
    },
    {} as Record<string, CategoryInfo[]>,
  );

  useEffect(() => {
    const interval = setInterval(() => {
      setDots((prev) => (prev === '...' ? '.' : prev + '.'));
    }, 400);
    return () => clearInterval(interval);
  }, []);

  useEffect(() => {
    if (!elevator_moving) {
      setProgress(0);
      return;
    }
    const start = Date.now();
    const interval = setInterval(() => {
      const elapsed = Date.now() - start;
      const t = Math.min(elapsed / 10000, 1);
      setProgress(1 - Math.pow(1 - t, 3));
    }, 100);
    return () => clearInterval(interval);
  }, [elevator_moving]);

  return (
    <Window width={520} height={550}>
      <Window.Content>
        <Stack fill vertical>
          <Stack.Item grow>
            {!selectedCategory ? (
              <Section title="СИСТЕМА ХРАНЕНИЯ (ASRS)" fill scrollable>
                <NoticeBox info mb={2}>
                  Выберите категорию для запроса техники. Обратите внимание, что
                  категории используют общий лимит группы.
                </NoticeBox>
                <Stack vertical>
                  {Object.entries(groupedCategories).map(
                    ([mainCatName, cats]) => {
                      const groupLimitInfo = cats[0];
                      const isGroupFull =
                        groupLimitInfo.used >= groupLimitInfo.limit;

                      return (
                      <Box
                        key={mainCatName}
                        mb={2}
                        p={1}
                        backgroundColor="rgba(0,0,0,0.1)"
                      >
                          <Stack align="center" mb={1}>
                            <Stack.Item grow>
                              <Box bold color="label" fontSize="14px">
                          <Icon name="layer-group" mr={1} />
                          ГРУППА: {mainCatName.toUpperCase()}
                        </Box>
                            </Stack.Item>
                            <Stack.Item>
                              <Box color="label" bold fontSize="12px">
                                <Icon
                                  name={isGroupFull ? 'lock' : 'unlock'}
                                  mr={1}
                                />
                                {isGroupFull
                                  ? 'Резервы исчерпаны'
                                  : `Резервы доступны`}
                              </Box>
                            </Stack.Item>
                          </Stack>

                        {cats.map((cat) => {
                            const hasAvailableVehicles = vehicles.some(
                              (v) =>
                                v.category === cat.name &&
                                !v.locked &&
                                !v.limit_reached &&
                                !v.category_locked,
                            );
                            const isFull =
                              cat.used >= cat.limit || !hasAvailableVehicles;

                          return (
                            <Button
                              key={cat.name}
                              fluid
                              mb={1}
                              height="38px"
                              onClick={() => setSelectedCategory(cat.name)}
                            >
                              <Stack align="center" fill height="100%">
                                <Stack.Item grow>
                                  <Icon name="folder" mr={1} opacity={0.7} />
                                  <Box as="span" bold fontSize="14px">
                                    {cat.name}
                                  </Box>
                                </Stack.Item>
                                <Stack.Item>
                                    <Box
                                      color={isFull ? 'label' : 'text'}
                                      opacity={0.8}
                                      bold
                                    >
                                    <Icon
                                      name={
                                          isFull ? 'minus-circle' : 'circle'
                                      }
                                      mr={1}
                                    />
                                      {isFull ? 'Недоступно' : 'Доступно'}
                                  </Box>
                                </Stack.Item>
                                <Stack.Item>
                                    <Icon
                                      name="chevron-right"
                                      opacity={0.5}
                                      ml={1}
                                    />
                                </Stack.Item>
                              </Stack>
                            </Button>
                          );
                        })}
                      </Box>
                      );
                    },
                  )}
                </Stack>
              </Section>
            ) : null}

            {selectedCategory ? (
              <Section
                title={`КАТЕГОРИЯ: ${selectedCategory}`}
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
                          p={1.5}
                          backgroundColor="rgba(0,0,0,0.2)"
                        >
                          <Stack align="center">
                            <Stack.Item grow>
                              <Box bold fontSize="14px">
                                <Icon name="box" mr={1} opacity={0.7} />
                                <Box as="span" mr={1}>
                                  {v.name}
                                </Box>
                              </Box>
                              {v.locked && (
                                <Box color="bad" fontSize="12px" mt={0.5}>
                                  <Icon name="exclamation-triangle" mr={0.5} />В
                                  ремонте или недоступно
                                </Box>
                              )}
                              {v.category_locked && (
                                <Box color="average" fontSize="12px" mt={0.5}>
                                  <Icon name="users-slash" mr={0.5} />
                                  НЕДОСТУПНО
                                </Box>
                              )}
                              {v.limit_reached && (
                                <Box color="average" fontSize="12px" mt={0.5}>
                                  <Icon name="ban" mr={0.5} />
                                  Исчерпан лимит ({v.main_category})
                                </Box>
                              )}
                            </Stack.Item>
                            <Stack.Item>
                              <Button
                                icon="download"
                                color={isDisabled ? 'transparent' : 'default'}
                                disabled={!!isDisabled}
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
            ) : null}
          </Stack.Item>

          <Stack.Item>
            <Section title="УПРАВЛЕНИЕ ТРАНСПОРТНОЙ ПЛАТФОРМОЙ">
              <Stack align="center">
                <Stack.Item grow>
                  <Box fontSize="14px" color="label">
                    <Box mb={1}>
                    <Icon
                      name={elevator_moving ? 'cog' : 'server'}
                      spin={!!elevator_moving}
                      mr={1}
                      color={elevator_moving ? 'average' : 'good'}
                    />
                      СТАТУС ПЛАТФОРМЫ:
                    </Box>
                    <Box bold color={elevator_moving ? 'average' : 'white'}>
                      {elevator_moving
                        ? `ТРАНСПОРТИРОВКА${dots}`
                        : elevator_raised
                          ? 'ПОДНЯТА'
                          : 'ОПУЩЕНА'}
                    </Box>
                  </Box>
                </Stack.Item>

                <Stack.Item>
                  <Button
                    width="220px"
                    height="40px"
                    lineHeight="38px"
                    textAlign="center"
                    fontSize="13px"
                    bold
                    color="green"
                    disabled={!!elevator_moving}
                    onClick={() =>
                      act(elevator_raised ? 'lower_elevator' : 'raise_elevator')
                    }
                  >
                    <Icon name="power-off" mr={1} />
                    {elevator_raised
                      ? 'ОПУСТИТЬ ПЛАТФОРМУ'
                      : 'ПОДНЯТЬ ПЛАТФОРМУ'}
                  </Button>
                </Stack.Item>
              </Stack>
            </Section>
          </Stack.Item>
        </Stack>
      </Window.Content>
    </Window>
  );
};
