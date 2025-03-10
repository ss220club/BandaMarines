import { useState } from 'react';

import { useBackend } from '../../backend';
import { Input, Section, Table } from '../../components';
import { TableCell, TableRow } from '../../components/Table';
import { Window } from '../../layouts';

type NewPlayerData = {
  new_players: NewPlayer[];
  search: {
    search_age: number;
    search_hours: number;
  };
};

type NewPlayer = {
  ckey: string;
  client_hours: number;
  first_join: string;
  days_first_join: number;
  byond_account_age: string;
};

export const CheckNewPlayers = (props, context) => {
  const { act, data } = useBackend<NewPlayerData>();
  const [ageSearch, setAgeSearch] = useState('');
  const [hoursSearch, setHoursSearch] = useState('');

  const handleSearch = () => {
    act('change_search', {
      age_search: ageSearch,
      hours_search: hoursSearch,
    });
  };

  if (!data || !data.new_players) {
    return <Section>No new players available.</Section>;
  }

  const filteredPlayers = data.new_players.filter((player) => {
    const matchesAge =
      !ageSearch || player.days_first_join >= Number(ageSearch);
    const matchesHours =
      !hoursSearch || player.client_hours >= Number(hoursSearch);
    return matchesAge && matchesHours;
  });

  return (
    <Window width={550} height={800}>
      <Window.Content className="CheckNewPlayers" scrollable>
        <Section>
          <Input
            value={ageSearch}
            onInput={(_, value) => {
              setAgeSearch(value);
              handleSearch();
            }}
            width="48%"
            placeholder="Min Account Age"
          />
          <Input
            value={hoursSearch}
            onInput={(_, value) => {
              setHoursSearch(value);
              handleSearch();
            }}
            width="48%"
            placeholder="Min Playtime (hours)"
          />
        </Section>

        {/* Player List */}
        {filteredPlayers.length === 0 ? (
          <Section>No players match your search criteria.</Section>
        ) : (
          <Table>
            {filteredPlayers.map((player) => (
              <TableRow key={player.ckey}>
                <TableCell width="20%" textAlign="left">
                  {player.ckey}
                </TableCell>
                <TableCell width="20%" textAlign="right">
                  {player.client_hours}
                </TableCell>
                <TableCell width="20%" textAlign="right">
                  {player.first_join}
                </TableCell>
                <TableCell width="20%" textAlign="right">
                  {player.days_first_join}
                </TableCell>
                <TableCell width="20%" textAlign="right">
                  {player.byond_account_age}
                </TableCell>
              </TableRow>
            ))}
          </Table>
        )}
      </Window.Content>
    </Window>
  );
};
