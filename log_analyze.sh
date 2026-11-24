#!/bin/bash
# ЛР3. Анализ журнала аутентификации (вариант 10, N=2)
LOG="${1:-auth_sample.log}"
N=2
echo "Всего неудачных попыток входа: $(grep -c 'Failed password' "$LOG")"
echo "Успешных входов: $(grep -c 'Accepted' "$LOG")"
echo
echo "Топ IP-адресов по неудачным попыткам:"
grep 'Failed password' "$LOG" | grep -oE 'from [0-9.]+' | awk '{print $2}' \
  | sort | uniq -c | sort -rn
echo
echo "Попытки входа под несуществующими пользователями:"
grep 'invalid user' "$LOG" | awk '{for(i=1;i<=NF;i++) if($i=="user") print $(i+1)}' | sort -u
echo
echo "Кандидаты на блокировку (>= $N неудачных попыток):"
grep 'Failed password' "$LOG" | grep -oE 'from [0-9.]+' | awk '{print $2}' \
  | sort | uniq -c | sort -rn | awk -v n="$N" '$1 >= n {print $2 " — " $1 " попыток"}'
echo
echo "Попытки sudo пользователями без прав (NOT in sudoers):"
grep 'NOT in sudoers' "$LOG" | awk '{cmd=substr($0, index($0,"COMMAND=")+8); print $1" "$2" "$3" — пользователь "$6", команда: "cmd}'
