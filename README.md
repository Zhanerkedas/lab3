# ЛР3 — Администрирование Linux-сервера с помощью Bash

**Студент:** Өскенбай Жанерке Дастанқызы
**Группа:** СР 16:30
**Вариант:** 10 (службы ssh, cron, postgresql; пороги 70/70/70 %; N = 2; cron каждые 3 минуты)

## Скрипты

| Файл | Назначение | Запуск |
|---|---|---|
| health_check.sh | отчёт о состоянии сервера: сеть, CPU/RAM/Disk, службы, пользователи | `./health_check.sh` |
| create_users.sh | массовое создание пользователей из CSV с группами по отделам | `sudo ./create_users.sh employees.csv` |
| employees.csv | список сотрудников (5 человек, 3 отдела) | — |
| log_analyze.sh | анализ журнала SSH: неудачные входы, кандидаты на блокировку (>=2), sudo без прав | `./log_analyze.sh auth_sample.log` |
| crontab.txt | расписание запуска health_check.sh каждые 3 минуты | `crontab -l` |

## Пример вывода log_analyze.sh

    Всего неудачных попыток входа: 11
    Успешных входов: 4
    Кандидаты на блокировку (>= 2 неудачных попыток):
    185.220.101.4 — 7 попыток
    45.155.205.233 — 3 попыток
    Попытки sudo пользователями без прав (NOT in sudoers):
    Oct 27 14:40:09 — пользователь d.nurlanova, команда: /bin/cat /etc/shadow

## Пример вывода health_check.sh

    CPU: 1%
    RAM: 55%
    Disk: 43%
    ssh: active
    cron: active
    postgresql: active
