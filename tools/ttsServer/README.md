## Описание
Это self-hosted версия TTS сервера на основе моделей Silero. Совместима с билдом на момент 13.09.2023

Модели Silero предоставлены https://github.com/snakers4/silero-models/tree/master

Модель поновее:
https://models.silero.ai/models/tts/ru/v4_ru.pt

## Требования

Python 3.11.+ (версии ниже не проверял, просьба отписаться об этом.)

- ffmpeg (Устанавливать вручную)
- torch
- soundfile
- pydub
- flask

Подробнее в `requirements.txt`

## Установка

Воспользуйтесь в командной строке, открытой в папке tools\ttsServer: `pip install -r requirements.txt`
Или воспользуйтесь файлом `install_requirements.bat`

Если не установлен ffmpeg, установите его. https://ffmpeg.org/download.html
Или через: `winget install ffmpeg`


## Как пользоваться

Включите в конфигурации билда в `config.txt` (раскомментируйте следующее):
`TTS_TOKEN_SILERO mytoken` (токен не важен, он не используется)
`TTS_URL_SILERO https://example.com`
`TTS_ENABLED`
`TTS_CACHE` 

Запустите `tts_server.py` через bat файл `launch_server.bat` или воспользуйтесь командной строкой и введите `python tts_server.py`.
Будет выведен адрес сервера и номер порта для подключения к API, заполните файл `config.txt` в строчке `TTS_URL_SILERO` появившийся адрес
Пример задания:
`TTS_URL_SILERO http://127.0.0.1:5000/tts/`

Внимание: производительность разняется от компьютеру к компьютеру. Возможны задержки от 0.5 секунд.

## Примечания

Модели, поставляемые вышеуказанным репозиторием, содержат меньшее количество голосов, чем используемое на игровом сервере.
По умолчанию стоит мужской голос `aidar`
Если желаете поменять голос озвучки, в файле tts_server.py поменяйте значение primary_speaker на желаемое.
Уточняйте возможные голоса в самом репозитории.

Если хотите поменять модель, удалите или переместите файл `model.pt`, а в `tts_processor` заместо ссылки на модель в `torch.hub.download_url_to_file...`
поставьте желаемую ссылку.

Также вы можете скачать модель вручную и переименовать её в `model.pt`, ознакомьтесь с инструкциями в репозитории моделей.



## Авторство

Сделано https://github.com/Vladisvell
Модели предоставлены https://github.com/snakers4/silero-models