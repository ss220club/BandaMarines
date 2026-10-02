import { useState } from 'react';

import { useBackend } from '../backend';
import { Button, Input, LabeledList, NoticeBox, Section } from '../components';
import { Window } from '../layouts';

type DeclineData = {
  nominative: string;
  genitive: string;
  dative: string;
  accusative: string;
  instrumental: string;
  prepositional: string;
};

export const DeclineNameEditor = (props) => {
  const { act } = useBackend();
  const { data } = useBackend<DeclineData>();
  const [nominative, setNominative] = useState(data.nominative);
  const [genitive, setGenitive] = useState(data.genitive);
  const [dative, setDative] = useState(data.dative);
  const [accusative, setAccusative] = useState(data.accusative);
  const [instrumental, setInstrumental] = useState(data.instrumental);
  const [prepositional, setPrepositional] = useState(data.prepositional);
  return (
    <Window width={450} height={325}>
      <Window.Content>
        <Section title={''}>
          <LabeledList>
            <LabeledList.Item label="Именительный (Кто? Что?)">
              <Input
                width="100%"
                value={nominative}
                placeholder="Клоун/Ассистуха..."
                onChange={(_, value) => setNominative(value)}
              />
            </LabeledList.Item>
            <LabeledList.Item label="Родительный (Кого? Чего?)">
              <Input
                width="100%"
                value={genitive}
                placeholder="Клоуна/Ассистухи..."
                onChange={(_, value) => setGenitive(value)}
              />
            </LabeledList.Item>
            <LabeledList.Item label="Дательный (Кому? Чему?)">
              <Input
                width="100%"
                value={dative}
                placeholder="Клоуну/Ассистухе..."
                onChange={(_, value) => setDative(value)}
              />
            </LabeledList.Item>
            <LabeledList.Item label="Винительный (Кого? Что?)">
              <Input
                width="100%"
                value={accusative}
                placeholder="Клоуна/Ассистуху..."
                onChange={(_, value) => setAccusative(value)}
              />
            </LabeledList.Item>
            <LabeledList.Item label="Творительный (Кем? Чем?)">
              <Input
                width="100%"
                value={instrumental}
                placeholder="Клоуном/Ассистухой..."
                onChange={(_, value) => setInstrumental(value)}
              />
            </LabeledList.Item>
            <LabeledList.Item label="Предложный (О/В ком/чём?)">
              <Input
                width="100%"
                value={prepositional}
                placeholder="Клоуне/Ассистухе..."
                onChange={(_, value) => setPrepositional(value)}
              />
            </LabeledList.Item>
          </LabeledList>
          <Button.Confirm
            fluid
            textAlign="center"
            mt={1.5}
            confirmColor="green"
            confirmContent="Вы уверены?"
            disabled={
              !nominative ||
              !genitive ||
              !dative ||
              !accusative ||
              !instrumental ||
              !prepositional
            }
            onClick={() =>
              act('confirm', {
                declinedNames: [
                  nominative,
                  genitive,
                  dative,
                  accusative,
                  instrumental,
                  prepositional,
                ],
              })
            }
          >
            Подтвердить
          </Button.Confirm>
          <NoticeBox color="bad" warning textAlign="center">
            Вы отвечаете за корректность и подверждаете отсутствие злого умысла
            при склонении (например, полная смена имени в других падежах).
            Склонения имени подвергаются таким же правилам, как и имя персонажа.
          </NoticeBox>
        </Section>
      </Window.Content>
    </Window>
  );
};
