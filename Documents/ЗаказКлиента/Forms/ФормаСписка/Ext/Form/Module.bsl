﻿
&НаКлиенте
Процедура ОформитьРеализациюАссортимента(Команда)
	
	СтруктураТоваров = ПолучитьДанныеПоДокументам();
	
	Для Каждого ЭлемТовар Из СтруктураТоваров Цикл		
		Форма = ПолучитьФорму("Документ.РеализацияАссортимента.ФормаОбъекта", , , Новый УникальныйИдентификатор);
		Форма.ЗаполнитьСКлиента(ЭлемТовар);
		Форма.ВыполнитьЗаполнениеОстатков();
		Форма.Открыть();
	КонецЦикла;
	
КонецПроцедуры

&НаСервереБезКонтекста
Функция СоздатьНовыйДокументРеализацияАссортимента()
	Возврат Документы.РеализацияАссортимента.СоздатьДокумент();
КонецФункции

&НаСервере
Функция ПолучитьДанныеПоДокументам()
	
	СтруктураТоваров = Новый Соответствие();
	
	Запрос = Новый Запрос;
	Запрос.Текст = "ВЫБРАТЬ
	|	ТоварыКлиента.Товары КАК Товары,
	|	ТоварыКлиента.Количество КАК Количество
	|ИЗ
	|	Документ.ЗаказКлиента КАК Док
	|		ЛЕВОЕ СОЕДИНЕНИЕ
	|	Документ.ЗаказКлиента.Товары КАК ТоварыКлиента
	|		ПО
	|	Док.Ссылка = ТоварыКлиента.Ссылка
	|ГДЕ
	|	Док.ЗаказОприходован = Ложь И
	|	НАЧАЛОПЕРИОДА(Док.Дата, ДЕНЬ) = &Период";
	
	Запрос.УстановитьПараметр("Период", Период);
	РезультатЗапроса = Запрос.Выполнить();
	
	Если Не РезультатЗапроса.Пустой() Тогда
		Выборка = РезультатЗапроса.Выбрать();
		
		Пока Выборка.Следующий() Цикл
			Если СтруктураТоваров.Получить(Выборка.Товары) = Неопределено Тогда
				СтруктураТоваров.Вставить(Выборка.Товары, Выборка.Количество);
			Иначе
				СтруктураТоваров.Получить(Выборка.Товары).Значение = СтруктураТоваров.Получить(Выборка.Товары).Значение + Выборка.Количество;
			КонецЕсли;
		КонецЦикла;
	КонецЕсли;
	
	Возврат СтруктураТоваров;
	
КонецФункции

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	Период = ТекущаяДата();
КонецПроцедуры
