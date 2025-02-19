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
  total_friendly_fire: number;
  total_revives: number;
  total_lives_saved: number;
  total_shots: number;
  total_shots_hit: number;
  total_hits: number;
  niche_stats: Statistic[];
  castes: CasteStat[];
  abilities_used: Statistic[];
  human_kill_feed: Statistic[];
  xeno_kill_feed: Statistic[];
};

type Statistic = {
  name: string;
  value: number;
};

type CasteStat = {
  name: string;
  stats: Stats;
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
                  niche_stats={stat.niche_stats}
                  human_kill_feed={stat.human_kill_feed}
                  xeno_kill_feed={stat.xeno_kill_feed}
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
    niche_stats,
    human_kill_feed,
    xeno_kill_feed,
  } = props;

  return (
    <Collapsible title="Общая статистика" open>
      <LabeledList>
        {steps_walked && (
          <LabeledList.Item label="Шагов сделано">
            {steps_walked}
          </LabeledList.Item>
        )}
        {!!total_kills && (
          <LabeledList.Item label="Всего убито">{total_kills}</LabeledList.Item>
        )}
        {!!human_kill_feed && (
          <KillFeedData
            title={'Убито людей: ' + human_kill_feed.length}
            killfeed={human_kill_feed}
          />
        )}
        {!!xeno_kill_feed && (
          <KillFeedData
            title={'Убито ксеноморфов: ' + xeno_kill_feed.length}
            killfeed={xeno_kill_feed}
          />
        )}
        {!!total_deaths && (
          <LabeledList.Item label="Количество смертей">
            {total_deaths}
          </LabeledList.Item>
        )}
        {!!niche_stats &&
          niche_stats.map((niche_stat) => (
            <LabeledList.Item key={niche_stat.name} label={niche_stat.name}>
              {niche_stat.value}
            </LabeledList.Item>
          ))}
      </LabeledList>
    </Collapsible>
  );
};

const KillFeedData = (props, context) => {
  const { data } = useBackend<Statistic>();
  const { title, killfeed } = props;

  return (
    <Collapsible title={title}>
      <LabeledList>
        {killfeed.map((kills) => (
          <LabeledList.Item key={kills.name} label={kills.name}>
            {kills.value}
          </LabeledList.Item>
        ))}
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
