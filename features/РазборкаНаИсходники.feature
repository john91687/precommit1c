# language: ru

Функционал: Выполнение операций по разборке на исходники
    Как Пользователь
    Я хочу иметь возможность разбирать внешние файлы на исходники
    Чтобы я мог проще следить за изменениями в коде

Контекст:
    Допустим Я пропускаю этот сценарий в Linux
    И я создаю временный каталог и сохраняю его в контекст
    И я сохраняю каталог проекта в контекст
    И я устанавливаю временный каталог как рабочий каталог
    И я установил рабочий каталог как текущий каталог

Сценарий: Разборка файла из заданной папки
    Когда я выполняю команду "oscript" с параметрами "<КаталогПроекта>/v8files-extractor.os --decompile <КаталогПроекта>/tests/Fixture.epf <РабочийКаталог>"
    Тогда в рабочем каталоге содержатся исходники обработки "Fixture" в формате "v8reader"

Сценарий: Разборка макета из заданной папки
    Дано я создаю каталог "1" в рабочем каталоге
    И я копирую файл "Fixture.mxl" из каталога "tests" проекта в подкаталог "1" рабочего каталога
    Когда я выполняю команду "oscript" с параметрами "<КаталогПроекта>/v8files-extractor.os --decompile <РабочийКаталог>/1/Fixture.mxl <РабочийКаталог>/1"
    Тогда в подкаталоге "1" рабочего каталога существует файл "Fixture_mxl.txt"

Сценарий: Разборка каталога с вложенными каталогами
    Дано я создаю каталог "bin" в рабочем каталоге
    И я создаю каталог "1" в подкаталоге "bin" рабочего каталога
    И я копирую файл "Fixture.epf" из каталога "tests" проекта в подкаталог "bin/1" рабочего каталога
    И я создаю каталог "src" в рабочем каталоге
    Когда я выполняю команду "oscript" с параметрами "<КаталогПроекта>/v8files-extractor.os --decompile <РабочийКаталог>/bin <РабочийКаталог>/src"
    Тогда в подпапке "src/1" рабочего каталога содержатся исходники обработки "Fixture" в формате "v8reader"
