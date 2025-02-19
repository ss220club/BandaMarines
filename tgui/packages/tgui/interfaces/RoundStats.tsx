import { useBackend } from '../backend';
import { Collapsible, LabeledList, Section, Stack } from '../components';
import { Window } from '../layouts';

export const RoundStats = (props) => {
  return (
    <Window width={500} height={550}>
      <Window.Content>
        <Stack fill vertical>
          <RoundStatsContent />
        </Stack>
      </Window.Content>
    </Window>
  );
};

type StatsData = {
  stats: Stats[];
};

type Stats = {
  title: string;
  total_kills: number;
  total_deaths: number;
  steps_walked: number;
  humans_killed: number;
  xenos_killed: number;
  total_friendly_fire: number;
  total_revives: number;
  total_lives_saved: number;
  total_shots: number;
  total_shots_hit: number;
  total_hits: number;
  niche_stats: NicheStat[];
  castes: Caste[];
};

type NicheStat = {
  name: string;
  value: number;
};

type Caste = {
  abilities_used: AbilityStat[];
  total_hits: number;
  stats: Stats;
};

type AbilityStat = {
  name: string;
  value: number;
};

export const RoundStatsContent = (props, context) => {
  const { data } = useBackend<StatsData>();
  const { stats } = data;

  return (
    <Stack fill vertical>
      <Stack.Item grow>
        {stats.map((stat) => (
          <Section key={stat.title}>
            <Collapsible title={stat.title} open>
              <Section>
                <RegularStatData
                  total_kills={stat.total_kills}
                  total_deaths={stat.total_deaths}
                  steps_walked={stat.steps_walked}
                  humans_killed={stat.humans_killed}
                  xenos_killed={stat.xenos_killed}
                  niche_stats={stat.niche_stats}
                />
              </Section>
              {stat.castes ? (
                <XenoStatData />
              ) : (
                <HumanStatData
                  total_friendly_fire={stat.total_friendly_fire}
                  total_revives={stat.total_revives}
                  total_lives_saved={stat.total_lives_saved}
                  total_shots={stat.total_shots}
                  total_shots_hit={stat.total_shots_hit}
                />
              )}
            </Collapsible>
          </Section>
        ))}
      </Stack.Item>
    </Stack>
  );
};

const RegularStatData = (props, context) => {
  const { data } = useBackend<Stats>();
  const {
    total_kills,
    total_deaths,
    steps_walked,
    humans_killed,
    xenos_killed,
    niche_stats,
  } = props;

  return (
    <Collapsible title="Общая статистика4" open>
      <LabeledList>
        {steps_walked && (
          <LabeledList.Item label="Шагов сделано">
            {steps_walked}
          </LabeledList.Item>
        )}
        {!!total_kills && (
          <LabeledList.Item label="Всего убито">{total_kills}</LabeledList.Item>
        )}
        {!!humans_killed && (
          <LabeledList.Item label="Убито людей">
            {humans_killed}
          </LabeledList.Item>
        )}
        {!!xenos_killed && (
          <LabeledList.Item label="Убито ксеноморфов">
            {xenos_killed}
          </LabeledList.Item>
        )}
        {!!total_deaths && (
          <LabeledList.Item label="Количество смертей">
            {total_deaths}
          </LabeledList.Item>
        )}
        {/* {!!niche_stats &&
          niche_stats.map((niche_stat) => (
            <LabeledList.Item key={niche_stat.name} label={niche_stat.name}>
              {niche_stat.value}
            </LabeledList.Item>
          ))} */}
      </LabeledList>
    </Collapsible>
  );
};

const HumanStatData = (props, context) => {
  const { data } = useBackend<Stats>();
  const {
    total_friendly_fire,
    total_revives,
    total_lives_saved,
    total_shots,
    total_shots_hit,
  } = props;

  return (
    <Collapsible title="Статистика человека" open>
      <LabeledList>
        {!!total_shots && (
          <LabeledList.Item label="Выстрелов сделано">
            {total_shots}
          </LabeledList.Item>
        )}
        {!!total_shots && (
          <LabeledList.Item label="Точность">
            {Math.round((total_shots_hit / total_shots) * 100) + `%`}
          </LabeledList.Item>
        )}
        {!!total_friendly_fire && (
          <LabeledList.Item label="Попаданий по своим">
            {total_friendly_fire}
          </LabeledList.Item>
        )}
        {!!total_revives && (
          <LabeledList.Item label="Количество воскрешений">
            {total_revives}
          </LabeledList.Item>
        )}
        {!!total_lives_saved && (
          <LabeledList.Item label="Людей реанимировано">
            {total_lives_saved}
          </LabeledList.Item>
        )}
      </LabeledList>
    </Collapsible>
  );
};

const XenoStatData = (props, context) => {
  const { data } = useBackend<Stats>();
  const { total_hits } = data;

  return (
    <Collapsible title="Статистика ксеноморфа" open>
      <LabeledList>
        {!!total_hits && (
          <LabeledList.Item label="Попаданий когтями">
            {total_hits}
          </LabeledList.Item>
        )}
      </LabeledList>
    </Collapsible>
  );
};

const XenoCasteStats = (props, context) => {
  const { data } = useBackend<Stats>();
  const { total_hits } = data;

  return (
    <LabeledList>
      <RegularStatData />
      {!!total_hits && (
        <LabeledList.Item label="Попаданий когтями">
          {total_hits}
        </LabeledList.Item>
      )}
    </LabeledList>
  );
};
