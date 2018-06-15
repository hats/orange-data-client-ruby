# Клиент для [Orange Data](http://orangedata.ru/) [![Build Status](https://travis-ci.org/hats/orange-data-client-ruby.svg?branch=master)](https://travis-ci.org/hats/orange-data-client-ruby)

## Установка

Скопируйте эту строчку в Gemfile приложения:

```ruby
gem 'orange_data', github: 'hats/orange-data-client-ruby'
```

После этого запустите:

    $ bundle

## Использование

### Генерация сертификатов `production`-окружения
Генерируем закрытый ключ с паролем зашифрованным алгоритмом AES256 и длинной 2048 Кбит:

    $ openssl genrsa -out orange_data_private.key -aes256 2048

Чтобы сгенерировать ключ без пароля, надо убрать `-aes256`.
Если хотите ключ длиннее 2048 Кбит, то замените `2048` число на необходимое.

Генерируем открытый ключ:

    $ openssl rsa -in orange_data_private.key -pubout -out orange_data_public.key
    
и преобразовываем его из pem-формата в xml (например [здесь](https://superdry.apphb.com/tools/online-rsa-key-converter)).

Полученный ключ в xml-формате загружаем в ЛК Orange Data в разделе [Интеграция -> Прямое подключение](https://lk.orangedata.ru/lk/integrations/direct), где просят ввести публичную часть ключа.

### Сертификаты для тестового окружения
В репозитории с [официальной документацией](https://github.com/orangedata-official/API) по подключению к API Orange Data находится архив с тестовыми сертификатами [File_for_test.zip](https://github.com/orangedata-official/API/blob/master/File_for_test.zip).
Из этого архива нужны следующие файлы: `client.crt`, `client.key`, `private_key_test.xml`. Первые два для шифрования запросов, а последний - для подписи содержимого.

Т.к. данный клиент не поддерживает ключи в xml-формате, необходимо `private_key_test.xml` конвертировать в `pem`. Для этого опять идем [сюда](https://superdry.apphb.com/tools/online-rsa-key-converter) и сохраняем полученный результат в `private_key_test.pem`.

### Конфигурация
Доступны следующие настройки:

- **DEBUG** - включает режим отладки
- **API_URL** - строка с адресом сервера ('https://apip.orangedata.ru:2443' - тестовое окружение)
- **API_PATH** - строка с путём к корню API('/api/v2')
- **API_KEY** - строка с приватным ключом (обычно совпадает с ИНН)
- **INN** - строка с ИНН компании
- **ORGANIZATION_KEY** - строка из orange_data_private.key или private_key_test.pem для тестового окружения
- **ORANGE_DATA_KEY** - строка из ИНН.key из архива скаченного в ЛК или client.key  для тестового окружения
- **ORANGE_DATA_CERTIFICATE** - строка из ИНН.crt из архива скаченного в ЛК или client.crt для тестового окружения
- **ORGANIZATION_KEY_PASSWORD** и **ORANGE_DATA_KEY_PASSWORD** - строки с паролями от соответствующих ключей
- **GROUP** - строка с группой устройств, с помощью которых будет пробит чек или nil
- **AGENT_TYPE** - признак агента
- **PAYMENT_TRANSFER_OPERATOR_PHONE_NUMBERS** - список с телефонами оператора перевода
- **PAYMENT_AGENT_OPERATION** - операция платежного агента
- **PAYMENT_AGENT_PHONE_NUMBERS** - список с телефонами платежного агента
- **PAYMENT_OPERATOR_PHONE_NUMBERS** - список с телефонами оператора по приему платежа
- **PAYMENT_OPERATOR_NAME** - название оператора перевода
- **PAYMENT_OPERATOR_ADDRESS** - адрес оператора перевода
- **PAYMENT_OPERATOR_INN** - ИНН оператора перевода
- **SUPPLIER_PHONE_NUMBERS** - телефон поставщика
- **ADDITIONAL_USER_ATTRIBUTE** - хэш с дополнительными реквизитами клиента
- **AUTOMAT_NUMBER** - номер автомата
- **TAXATION_SYSTEM** - система налогооблажения
- **RECEIPT_TYPE** - тип чека
- **TAX** - ставка НДС
- **PAYMENT_METHOD_TYPE** - признак способа расчёта 
- **PAYMENT_SUBJECT_TYPE** - признак предмета расчёта
- **RECEIPT_TYPES** - хэш с значениями типов чеков
- **AGENT_TYPES** - хэш с значениями типов агентов
- **TAX_TYPES** - хэш с значениями типов ставок НДС
- **PAYMENT_METHOD_TYPES** - хэш с типами признаков способа расчёта
- **PAYMENT_SUBJECT_TYPES** - хэш с типами признаков предмета расчёта
- **TAXATION_SYSTEM_TYPES** - хэш с типами систем налогооблажения
- **PAYMENT_TYPES** - хэш с типами оплаты

```ruby
OrangeData.configure do |c|
  c.debug = DEBUG
  c.api_url = API_URL
  c.api_path = API_PATH
  c.api_key = API_KEY
  c.inn = INN
  c.agent_type = AGENT_TYPE
  c.payment_transfer_operator_phone_numbers = PAYMENT_TRANSFER_OPERATOR_PHONE_NUMBERS
  c.payment_agent_operation = PAYMENT_AGENT_OPERATION
  c.payment_agent_phone_numbers = PAYMENT_AGENT_PHONE_NUMBERS
  c.payment_operator_phone_numbers = PAYMENT_OPERATOR_PHONE_NUMBERS
  c.payment_operator_name = PAYMENT_OPERATOR_NAME
  c.payment_operator_address = PAYMENT_OPERATOR_ADDRESS
  c.payment_operator_inn = PAYMENT_OPERATOR_INN
  c.supplier_phone_numbers = SUPPLIER_PHONE_NUMBERS
  c.additional_user_attribute = ADDITIONAL_USER_ATTRIBUTE
  c.automat_number = AUTOMAT_NUMBER
  c.receipt_type = RECEIPT_TYPE
  c.tax = TAX
  c.payment_method_type = PAYMENT_METHOD_TYPE
  c.payment_subject_type = PAYMENT_SUBJECT_TYPE
  c.taxation_system = TAXATION_SYSTEM
  c.receipt_types = RECEIPT_TYPES
  c.agent_types = AGENT_TYPES
  c.tax_types = TAX_TYPES
  c.payment_method_types = PAYMENT_METHOD_TYPES
  c.payment_subject_types = PAYMENT_SUBJECT_TYPES
  c.taxation_system_types = TAXATION_SYSTEM_TYPES
  c.payment_types = PAYMENT_TYPES

  c.organization_key = [ORGANIZATION_KEY, ORGANIZATION_KEY_PASSWORD] # или c.organization_key = ORGANIZATION_KEY если нет пароля
  c.orange_data_key = [ORANGE_DATA_KEY, ORANGE_DATA_KEY_PASSWORD] # или c.orange_data_key = ORANGE_DATA_KEY если нет пароля
  c.orange_data_certificate = ORANGE_DATA_CERTIFICATE
end
```

### Создание чека
```ruby
response = OrangeData::Receipt.new(
  id: '123',
  inn: '1234567890',
  group: 'Main',
  type: :income,
  key: '1234567890',
  customer_contact: '+79991234567',
  taxation_system: :osn
).add_position(
  quantity: 5,
  price: 10,
  text: 'Тестовый товар',
  tax: :vat_not_charged,
  payment_method_type: :full_calculation,
  payment_subject_type: :service,
  nomenclature_code: 'Тестовый товар'
).add_payment(
  type: :card,
  amount: 50
).add_agent(
  agent_type: 127,
  payment_transfer_operator_phone_numbers: ['+79998887766'],
  payment_agent_operation: 'Операция агента',
  payment_agent_phone_numbers: ['+79998887766'],
  payment_operator_phone_numbers: ['+79998887766'],
  payment_operator_name: 'Наименование оператора перевода',
  payment_operator_address: 'Адрес оператора перевода',
  payment_operator_inn: '3123011520',
  supplier_phone_numbers: ['+79998887766']
).add_customer_info(
  name: 'citation',
  value: 'В здоровом теле здоровый дух, этот лозунг еще не потух!'
).sync!
```
В случае успешного запроса возвращается объект с успешным ответом
```ruby
response.success? # => true
response.result # => { ... }
```

В случае неудачи возвращается объект с ошибками
```ruby
response.success? # => false
response.errors # => ['Some error']
```

### Состояние чека
```ruby
response = OrangeData::ReceiptStatus.new(id: id, inn: inn).sync!
```

В случае успешного запроса возвращается объект с успешным ответом
```ruby
response.success? # => true
response.result # => { ... }
```

В случае неудачи возвращается объект с ошибками
```ruby
response.success? # => false
response.errors # => ['Some error']
```
### Создание чека коррекции

В разработке

### Состояние чека коррекции

В разработке

### Raw-запрос
Если какой-то из методов не поддерживается данным клиентом, то всегда можно самостоятельно сделать запрос к нужному следующим образом
```ruby
OrangeData::Client.request(payload, api_name: api_method)
```
в качестве `api_method` принимаются следующие значения:

- **:add_receipt** - создание нового чека
- **:get_receipt_status** - получение статуса чека
- **:add_correction** - создание чека коррекции
- **:get_correction_status** - получение статуса чека коррекции
## Разработка

Загрузите репозиторий и запустите `bin/setup` для установки зависимостей. Затем, прогоните тесты `rake spec`.
Ещё, можно запустить консоль `bin/console` для проведения различных экспериментов.

## Ваш вклад к проект

Сообщения об обнаруженных багах и пулл-реквесты оставляйте на GitHub по этой [ссылке](https://github.com/hats/orange-data-client-ruby).

## Лицензия

[MIT License](https://opensource.org/licenses/MIT).
