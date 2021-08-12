
# ПРОЕКТ

Прт роявлении такой ошибки:

Uncaught Error: Call to undefined function json_encode() in phar
настройка WordPress через  **_wp-cli_**, ошибка возникает при вызове wp-cli. Необходимо кстановить пакет **_php-json_**


Используемые в ролях в проекта специфические команды:

##### BorgBackup
Генерация пароля пользователя для использования в роли borg  
- **openssl passwd -6 qwerty** - генерация хэша пароля qwerty. Параметр -6 говорит о генерации sha512 алгоритме.
##### Firewall
##### Nginx
##### MySQL
##### Rsyslog
##### Wdprs
##### Zabbix
