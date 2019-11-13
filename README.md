# Набор утилит для автоматической разборки/сборки внешних обработок и отчетов, при помещении (commit) в git

[![Join the chat at https://gitter.im/xDrivenDevelopment/precommit1c](https://badges.gitter.im/xDrivenDevelopment/precommit1c.svg)](https://gitter.im/xDrivenDevelopment/precommit1c?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge&utm_content=badge) Здесь вы можете задавать любые вопросы разработчикам и активным участникам

[![GitHub release](https://img.shields.io/github/release/xDrivenDevelopment/precommit1c.svg)](https://github.com/xDrivenDevelopment/precommit1c/releases)

## Что к чему

----

**precommit1c** - инструмент для хранения в Git исходников внешних отчетов/обработок, технически состоит из:

* v8files-extractor.os - скрипт для OneScript, получающий список помещаемых файлов при коммите, фильтрующий по расширению только внешние отчёты/обработки, расширения и запускающий команды для распаковки этих файлов. Так же позволяет собирать обработки из полученных исходников.
* [V8Reader.epf](http://infostart.ru/public/106310/) - внешняя обработка 1С, которая с помощью  [v8unpack](http://svn2.assembla.com/svn/V8Unpack/track/) разбирает внешние обработки, определяет нормальные  наименования для каталогов форм, файлов модулей объектов и т. д. и раскладывает их в нормальную структуру папок.
* pre-commit - собственно командный файл, вызываемый git перед каждым помещением. Выполняет роль простой запускалки скрипта v8files-extractor.os

## Установка

1. Зависимости:
    * OneScript [http://oscript.io/](http://oscript.io/)
    * установленная платформа 1С:Предприятие 8
    * git
    * в случае запуска из под wine необходим msscriptcontrol
    * Библиотеки [oscript-library]( https://github.com/EvilBeaver/oscript-library)

2. По умолчанию считается, что пути к oscript.exe и git.exe находятся в переменной path, иначе необходимо указать явный путь в файле pre-commit

3. Путь хранения исходных текстов разобранных обработок по умолчанию используется как **src** (для обеспечения совместимости со старыми версиями обработки), однако его можно переназначить в файле `pre-commit`

### Установка через OneScript Package Manager (предпочтительно)

1. Выполните установку precommit1c из командной строки `opm install precommit1c` (предполагается, что OneScript уже установлен и командная строка запущена с правами администратора). При этом необходимые библиотеки oscript будут установлены автоматически.

2. Перейдите в рабочий каталог репозитория, для которого следует использовать автоматическую сборку/разборку.

3. Выполните из командной строки `precommit1c --install` (здесь можно без прав администратора).

### Установка через zip-архив

1. Скачайте zip-архив precommit1c.zip со страницы [последнего релиза](https://github.com/xDrivenDevelopment/precommit1c/releases/latest).

2. Содержимое архива необходимо разархивировать в каталог .git/hooks/ вашего проекта.  

*Примечание:* каталог .git по умолчанию скрыт.  
В итоге у вас должна получиться следующая структура каталога:
```
.git\
    hooks\
        pre-commit
        V8Reader
        tools
        v8files-extractor.os
```

3. Установите необходимые библиотеки oscript - их список можно посмотреть в списке зависимостей в файле `packagedef`.

### Установка через git clone

1. Склонируйте репозиторий `precommit1c` в удобное место.

2. После клонирования репозитория необходимо инициализировать используемые подмодули.  
Откройте командую строку и выполните команды:

```cmd
cd путь/к/репозиторию/precommit1c
git submodule update --init --recursive
```

3. Cодержимое каталога необходимо скопировать в каталог .git/hooks/ вашего проекта.  
*Примечание:* каталог .git по умолчанию скрыт.  
В итоге у вас должна получиться следующая структура каталога:

```
.git\
    hooks\
        pre-commit
        V8Reader
        tools
        v8files-extractor.os
```

4. Установите необходимые библиотеки oscript - их список можно посмотреть в списке зависимостей в файле `packagedef`.

## Запуск

После установки достаточно для проверки сделать commit для любого файла epf/erf/cfe, и в вашем репозитории автоматически должна создаться папка *src*, полностью повторяющая структуру проекта, изменённые или добавленные файлы распакуются в папки с аналогичными наименованиями.

## Командная строка запуска OneScript

```
oscript v8files-extractor.os ?

Утилита сборки/разборки внешних файлов 1С

Параметры командной строки:
        --decompile inputPath outputPath
                Разбор файлов на исходники
        --help
                Показ этого экрана
        --git-check-config
                Проверка настроек репозитория git
        --git-precommit outputPath [--remove-orig-bin-files]
                Запустить чтение индекса из git и определить список файлов для разбора, разложить их и добавить исходники в индекс
                Если передан флаг --remove-orig-bin-files, обработанные файлы epf/erf будут удалены из индекса git
        --compile inputPath outputPath [--recursive]
                Собрать внешний файл/обработку.
                Если указан параметр --recursive, скрипт будет рекурсивно искать исходные коды отчетов и обработок в указанном каталоге и собирать их, повторяя структуру каталога
        --install [--remove-orig-bin-files]
                Установить precommit1c для текущего репозитория git
                Если передан флаг --remove-orig-bin-files, обработанные файлы epf/erf будут удалены из индекса git

Общие параметры:
        --use-designer
                Если передан этот флаг, то для операций сборки/разборки будет использован конфигуратор 1С.
                ТОЛЬКО ДЛЯ ВЕРСИЙ ПЛАТФОРМЫ 8.3.8 И ВЫШЕ!
        --ib-connection-string
                Строка подключения к информационной базе (для Windows-путей обязательно экранировать '\' так: '\\'!)
        --ib-user
                Имя пользователя в информационной базе
        --ib-pwd
                Пароль пользователя в информационной базе
```

## Ограничения

Дополнительно необходимы настройки git для возможности использования кириллических наименований внешних обработок, длинных имён файлов и корректной работы с окончаниями строк:

```shell
git config --local core.quotepath false
git config --local core.longpaths true
```

Не стоит называть файлы с разным расширением epf и erf одинаковыми именами - каталоги с исходниками создаются только по наименованию без учёта расширения и возможен конфликт имен.

### Для корректной работы на 1С версии 8.3.9.2016 и старше

Начиная с версии 8.3.9.2016 1С встроила в платформу механизмы защиты открытия внешних отчетов и обработок. Как обойти данное ограничение написано на ИТС:
> Защита считается отключенной, если строка соединения с информационной базой удовлетворяет одному из шаблонов, указанных в параметре DisableUnsafeActionProtection файла conf.cfg.

Т.о. в файл C:\Program Files (x86)\1cv8\conf\conf.cfg необходимо добавить строку `DisableUnsafeActionProtection=.*`
Подробнее [на ИТС](http://its.1c.ru/db/v838doc#bookmark:dev:TI000001873)

## Особенности распаковки макетов

При использовании v8Reader макеты выгружаются в файлы, соответствующие их типам, дополнительно обрабатываются специальные случаи:

* У макетов табличных документов дополнительно создаются .txt версии, чтобы их было легче сравнивать в текстовом редакторе.
* У макетов типа html дополнительно выгружаются файлы вложений.
* Макеты в двоичных данных выгружаются либо в .bin, либо (для печатных форм) в тот тип файла, который указан в имени макета (например, `ПФ_MXL_КакаяТоПечатнаяФорма` будет выгружен в `ПФ_MXL_КакаяТоПечатнаяФорма.mxl`).

## Известные проблемы

1. При использовании некоторых версий SourceTree (удобный клиент git) может возникать следующая ошибка:

>`.git/hooks/pre-commit: line 4: oscript: command not found`
Несколько вариантов решения:

+ убедиться, что команда `oscript` доступна
  + для проверки вызвать из командной строки или Win+R `cmd /k oscript`
+ откатиться на предыдущую версию SourceTree
  + рекомендуется
+ указать полный путь к `oscript.exe` в файле `pre-commit` внутри своего репозитария.
  + не рекомендуется, т.к. данную операцию нужно будеть делать для каждого репозитария

## Включение полных отладочных логов для анализа проблем

1. Нужно выполнить следующее:

  * добавить нужную обработку в индекс git - например, `git add XXX.epf`
  * установить переменную среды `LOGOS_CONFIG` или заполнить спец.файл настройки логов
  * выполнить `git commit` или `precommit1c --git-precommit`
  * Например, рядом с файлом `v8files-extractor.os` положить файл `logos.cfg` со следующим текстом `logger.rootLogger=DEBUG`
  * или переименовать файл-пример `logos.debug-example.cfg` в `logos.cfg`
  * Или создать и выполнить командный файл

```bat
git add XXX.epf
@set LOGOS_CONFIG=logger.rootLogger=DEBUG
@precommit1c --git-precommit src
```

  * где каталог `src` - выходной каталог, где хранятся исходники

2. Для отключения отладочных логов выполнить обратные действия

## Что внутри

Как это работает: `v8files-extractor.os` полностью повторяет иерархию папок относительно корня репозитория только в папке SRC (от слова source), для каждой изменённой внешней обработки создаётся своя папка и туда с помощью v8unpack распаковывается помещаемая обработка, с помощью v8reader определяются наименования макетов, форм, модуля обработки и переименовываются, переименования сохраняются в служебном файле renames.txt, те файлы, которые невозможно определить или же носят чисто служебный характер, переносятся в каталог *und*.

Файлы расширений *.cfe распаковываются на исходники штатными средствами 1С.

## Лицензия

Лицензировано на условиях Apache License 2.0. Смотрите файл [LICENSE.md](LICENSE.md) в корневом каталоге репозитория.
