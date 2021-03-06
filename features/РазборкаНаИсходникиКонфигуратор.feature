# language: ru

Функционал: Выполнение операций по разборке на исходники конфигуратором
    Как Пользователь
    Я хочу иметь возможность разбирать внешние файлы на исходники с помощью конфигуратора
    Чтобы я мог проще следить за изменениями в коде

Контекст:
    Допустим я создаю временный каталог и сохраняю его в контекст
    И я сохраняю каталог проекта в контекст
    И я устанавливаю временный каталог как рабочий каталог
    И я установил рабочий каталог как текущий каталог
    И я выполняю команду "vanessa-runner" с параметрами "init-dev"

Сценарий: Разборка файла из заданной папки без указания информационной базы
    Когда я выполняю команду "oscript" с параметрами "<КаталогПроекта>/v8files-extractor.os --decompile <КаталогПроекта>/tests/Fixture.epf <РабочийКаталог> --use-designer"
    Тогда в рабочем каталоге содержатся исходники обработки "Fixture" в формате "designer"

Сценарий: Разборка каталога с вложенными каталогами без указания информационной базы
    Дано я создаю каталог "bin" в рабочем каталоге
    И я создаю каталог "1" в подкаталоге "bin" рабочего каталога
    И я копирую файл "Fixture.epf" из каталога "tests" проекта в подкаталог "bin/1" рабочего каталога
    И я создаю каталог "src" в рабочем каталоге
    Когда я выполняю команду "oscript" с параметрами "<КаталогПроекта>/v8files-extractor.os --decompile <РабочийКаталог>/bin <РабочийКаталог>/src --use-designer"
    Тогда в подпапке "src/1" рабочего каталога содержатся исходники обработки "Fixture" в формате "designer"

Сценарий: Разборка файла из заданной папки с указанием информационной базы
    Когда я выполняю команду "oscript" с параметрами "<КаталогПроекта>/v8files-extractor.os --decompile <КаталогПроекта>/tests/Fixture.epf <РабочийКаталог> --use-designer --ib-connection-string /F<РабочийКаталог>/build/ib"
    Тогда в рабочем каталоге содержатся исходники обработки "Fixture" в формате "designer"

Сценарий: Разборка каталога с вложенными каталогами с указанием информационной базы
    Дано я создаю каталог "bin" в рабочем каталоге
    И я создаю каталог "1" в подкаталоге "bin" рабочего каталога
    И я копирую файл "Fixture.epf" из каталога "tests" проекта в подкаталог "bin/1" рабочего каталога
    И я создаю каталог "src" в рабочем каталоге
    Когда я выполняю команду "oscript" с параметрами "<КаталогПроекта>/v8files-extractor.os --decompile <РабочийКаталог>/bin <РабочийКаталог>/src --use-designer --ib-connection-string /F<РабочийКаталог>/build/ib"
    Тогда в подпапке "src/1" рабочего каталога содержатся исходники обработки "Fixture" в формате "designer"
