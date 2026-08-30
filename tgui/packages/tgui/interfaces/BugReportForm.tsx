import type { BooleanLike } from 'common/react';
import React, { useState } from 'react';
import { useBackend } from 'tgui/backend';
import { Flex, Section } from 'tgui/components';
import { ButtonCheckbox } from 'tgui/components/Button';
import { Window } from 'tgui/layouts';
interface FormTypes {
  awaiting_admin_approval: BooleanLike;
  report_details: FormDetails;
}

// all the information necessary to pass into the github api
type FormDetails = {
  steps: string;
  title: string;
  description: string;
  expected_behavior: string;
  admin_note: string;
  log: string;
};

const InputTitle = (props) => {
  return (
    <h2>
      {props.children}
      {props.required && <span className="input-title-required">{' *'}</span>}
    </h2>
  );
};

export const BugReportForm = (props) => {
  const { act, data } = useBackend<FormTypes>();
  const { awaiting_admin_approval, report_details } = data;
  const [checkBox, setCheckbox] = useState(false);

  const [title, setTitle] = useState(report_details?.title || '');
  const [steps, setSteps] = useState(report_details?.steps || '');
  const [description, setDescription] = useState(
    report_details?.description || '',
  );
  const [expected_behavior, setExpectedBehavior] = useState(
    report_details?.expected_behavior || '',
  );
  const [admin_note, setAdminNote] = useState(report_details?.admin_note || '');
  const [log, setLog] = useState(report_details?.log || '');

  const submit = () => {
    if (!title || !description || !expected_behavior || !steps || !checkBox) {
      alert('Пожалуйста, заполните все обязательные поля!');
      return;
    }
    const updatedReportDetails = {
      title,
      steps,
      description,
      expected_behavior,
      admin_note,
      log,
    };
    act('confirm', updatedReportDetails);
  };

  return (
    <Window
      title={'Форма отчёта об ошибке'}
      width={700}
      height={awaiting_admin_approval ? 1000 : 700}
    >
      <Window.Content>
        <Section fill scrollable>
          <Flex direction="column" height="100%">
            <Flex.Item className="text-center">
              <a
                href="https://github.com/ss220club/BandaMarines/issues"
                target="_blank"
                rel="noreferrer"
                className="link"
              >
                Репозиторий GitHub
              </a>
            </Flex.Item>
            <Flex.Item>
              <h2 className="tip">
                {
                  'СОВЕТ: пожалуйста, опишите проблему как можно подробнее, это действительно очень помогает'
                }
              </h2>
            </Flex.Item>
            <Flex.Item>
              <InputTitle required>{'Заголовок'}</InputTitle>
              <input
                width="100%"
                className="textarea"
                value={title}
                onChange={(e) => setTitle(e.target.value)}
              />
            </Flex.Item>
            <Flex.Item my={2}>
              <InputTitle required>{'Описание'}</InputTitle>
              {'Опишите ошибку'}
              <textarea
                rows={3}
                className="textarea"
                onInput={(e) => {
                  const target = e.target as HTMLTextAreaElement;
                  target.style.height = 'auto';
                  target.style.height = `${target.scrollHeight}px`;
                }}
                value={description}
                onChange={(e) => setDescription(e.target.value)}
              />
            </Flex.Item>
            <Flex.Item my={2}>
              <InputTitle required>
                {'Чем отличается от ожидаемого поведения?'}
              </InputTitle>
              {'Опишите, что по вашему мнению должно было произойти'}
              <textarea
                rows={3}
                className="textarea"
                onInput={(e) => {
                  const target = e.target as HTMLTextAreaElement;
                  target.style.height = 'auto';
                  target.style.height = `${target.scrollHeight}px`;
                }}
                value={expected_behavior}
                onChange={(e) => setExpectedBehavior(e.target.value)}
              />
            </Flex.Item>
            <Flex.Item my={2}>
              <InputTitle required>
                {'Как воспроизвести эту ошибку?'}
              </InputTitle>
              {'Укажите шаги для воспроизведения, чем подробнее, тем лучше'}
              <textarea
                rows={4}
                className="textarea"
                onInput={(e) => {
                  const target = e.target as HTMLTextAreaElement;
                  target.style.height = 'auto';
                  target.style.height = `${target.scrollHeight}px`;
                }}
                value={steps}
                onChange={(e) => setSteps(e.target.value)}
                placeholder={'1) Шаг 1\n2) Шаг 2\n3) Шаг 3\n'}
              />
            </Flex.Item>
            {!!awaiting_admin_approval && (
              <Flex.Item my={2}>
                <InputTitle>{'Заметка администратора'}</InputTitle>
                {'Дополнительные примечания к отчёту об ошибке'}
                <textarea
                  rows={4}
                  className="textarea"
                  onInput={(e) => {
                    const target = e.target as HTMLTextAreaElement;
                    target.style.height = 'auto';
                    target.style.height = `${target.scrollHeight}px`;
                  }}
                  value={admin_note}
                  onChange={(e) => setAdminNote(e.target.value)}
                />
              </Flex.Item>
            )}
            <Flex.Item my={2}>
              <InputTitle>{'Логи'}</InputTitle>
              {'Вставьте сюда соответствующие логи'}
              <textarea
                rows={4}
                className="textarea"
                onInput={(e) => {
                  const target = e.target as HTMLTextAreaElement;
                  target.style.height = 'auto';
                  target.style.height = `${target.scrollHeight}px`;
                }}
                value={log}
                onChange={(e) => setLog(e.target.value)}
              />
            </Flex.Item>
            <Flex.Item my={2} className={'text-center'}>
              <ButtonCheckbox
                checked={checkBox}
                onClick={() => {
                  setCheckbox(!checkBox);
                }}
              >
                {awaiting_admin_approval
                  ? 'Я подтверждаю, что этот отчёт соответствует правилам GitHub'
                  : 'Мне не удалось найти существующую проблему на GitHub'}
                {!checkBox && (
                  <span className="input-title-required">{' *'}</span>
                )}
              </ButtonCheckbox>
            </Flex.Item>
            <Flex.Item my={2}>
              <Flex className="flex-center">
                <Flex.Item mx={1}>
                  <div className="button-cancel" onClick={() => act('cancel')}>
                    {awaiting_admin_approval ? 'Отклонить' : 'Отмена'}
                  </div>
                </Flex.Item>
                <Flex.Item mx={1}>
                  <div className="button-submit" onClick={submit}>
                    {awaiting_admin_approval ? 'Одобрить' : 'Отправить'}
                  </div>
                </Flex.Item>
              </Flex>
            </Flex.Item>
          </Flex>
        </Section>
      </Window.Content>
    </Window>
  );
};
