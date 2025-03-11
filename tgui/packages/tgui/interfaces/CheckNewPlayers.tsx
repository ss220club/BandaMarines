import { useState } from 'react';

import { useBackend } from '../backend';
import { Button, Input, Section, Table } from '../components';
import { Window } from '../layouts';

type NewPlayerData = {
  new_players: NewPlayer[];
};

type NewPlayer = {
  ckey: string;
  client_hours: number;
  first_join: string;
  days_first_join: number;
  byond_account_age: string;
};

export const CheckNewPlayers = () => {
  const { data, act } = useBackend<NewPlayerData>();
  const { new_players } = data;

  // State for search criteria
  const [clientHoursFilter, setClientHoursFilter] = useState('');
  const [daysFirstJoinFilter, setDaysFirstJoinFilter] = useState('');

  // Filtered players based on search criteria
  const filteredPlayers = new_players.filter(player => {
    const clientHoursMatch = clientHoursFilter ? player.client_hours < Number(clientHoursFilter) : true;
    const daysFirstJoinMatch = daysFirstJoinFilter ? player.days_first_join < Number(daysFirstJoinFilter) : true;
    return clientHoursMatch && daysFirstJoinMatch;
  });

  return (
    <Window width={850} height={450}>
      <Section style={{ padding: '10px' }}>
        <Input
          placeholder="Client Hours <"
          value={clientHoursFilter}
          onChange={(e) => setClientHoursFilter(e.target.value)}
        />
        <Input
          placeholder="Days First Join <"
          value={daysFirstJoinFilter}
          onChange={(e) => setDaysFirstJoinFilter(e.target.value)}
        />
      </Section>
      <Table>
        <Table.Row header>
          <Table.Cell>Ckey</Table.Cell>
          <Table.Cell>Playtime</Table.Cell>
          <Table.Cell>First Joined</Table.Cell>
          <Table.Cell>Days from first join</Table.Cell>
          <Table.Cell>byond_account_age</Table.Cell>
          <Table.Cell>Actions</Table.Cell>
        </Table.Row>
        {Array.isArray(filteredPlayers) && filteredPlayers.map((player) => (
          <Table.Row key={player.ckey}>
            <Table.Cell>{player.ckey}</Table.Cell>
            <Table.Cell>{player.client_hours}</Table.Cell>
            <Table.Cell>{player.first_join}</Table.Cell>
            <Table.Cell>{player.days_first_join}</Table.Cell>
            <Table.Cell>{player.byond_account_age}</Table.Cell>
            <Table.Cell width="30px">
              <Button
                onClick={() => {
                  act('open_pp', {
                    ckey: player.ckey,
                  });
                }}
              >
                PP
              </Button>
            </Table.Cell>
          </Table.Row>
        ))}
      </Table>
    </Window>
  );
};
