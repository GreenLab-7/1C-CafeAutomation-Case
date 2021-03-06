﻿
&НаКлиенте
Процедура ОткрытьСеанс(Команда)
	ДатаНачала = ТекущаяДата();
	УстановитьСеанс();
КонецПроцедуры

&НаСервере
Процедура УстановитьСеанс()
	ПараметрыСеанса.ИдетСеанс = Истина;
КонецПроцедуры

&НаКлиенте
Процедура ЗакрытьСеанс(Команда)
	ОбработатьСеанс();	
КонецПроцедуры

&НаСервере
Процедура ОбработатьСеанс()
	
	МЗ = РегистрыСведений.СеансыБарист.СоздатьМенеджерЗаписи();
	Ключ = РегистрыСведений.СеансыБарист.СоздатьКлючЗаписи(
		Новый Структура("Период,Сотрудник", НачалоДня(ДатаНачала), ПараметрыСеанса.ТекущийСотрудник));
	ЗаполнитьЗначенияСвойств(МЗ, Ключ);
	МЗ.Прочитать();
	
	Если Не МЗ.Выбран() Тогда	
		Набор = РегистрыСведений.СеансыБарист.СоздатьНаборЗаписей();
		Набор.Прочитать();
	
		Запись = Набор.Добавить();
		Запись.Период = НачалоДня(ТекущаяДата());
		Запись.Сотрудник = ПараметрыСеанса.ТекущийСотрудник;
		Запись.ДатаНачала = ДатаНачала;
		Запись.ДатаОкончания = ТекущаяДата();
	
		Набор.Записать();
	Иначе
		МЗ.ДатаОкончания = ТекущаяДата();
		МЗ.Записать();
	КонецЕсли;
	
	ПараметрыСеанса.ИдетСеанс = Ложь;
	
КонецПроцедуры

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
		
	Если ПараметрыСеанса.ТекущийСотрудник.Пустая() Тогда
		Отказ = Истина;
		Сообщить("Невозможно открыть, для текущего пользователя нет сотрудника");
		Возврат;
	КонецЕсли;
	
	ОбновитьЦеныНаСервере();
	
КонецПроцедуры

&НаКлиенте
Процедура ОбновитьЦены(Команда)
	ОбновитьЦеныНаСервере();
КонецПроцедуры

&НаСервере
Процедура ОбновитьЦеныНаСервере()
	
	Объект.ЦеныНаСегодня.Очистить();
	
	Запрос = Новый Запрос;
	Запрос.Текст = 
		"ВЫБРАТЬ
		|	ЦеныПокупкиПродажиСрезПоследних.Номенклатура КАК Номенклатура,
		|	ЦеныПокупкиПродажиСрезПоследних.Цена КАК Цена
		|ИЗ
		|	РегистрСведений.ЦеныПокупкиПродажи.СрезПоследних(&ДатаСреза) КАК ЦеныПокупкиПродажиСрезПоследних
		|ГДЕ
		|	ЦеныПокупкиПродажиСрезПоследних.Номенклатура ССЫЛКА Справочник.Товары";
	
	Запрос.УстановитьПараметр("ДатаСреза", ТекущаяДата());
	РезультатЗапроса = Запрос.Выполнить();
	
	Если Не РезультатЗапроса.Пустой() Тогда
		ВыборкаДетальныеЗаписи = РезультатЗапроса.Выбрать();
	
		Пока ВыборкаДетальныеЗаписи.Следующий() Цикл
			Строка = Объект.ЦеныНаСегодня.Добавить();
			Строка.Товар = ВыборкаДетальныеЗаписи.Номенклатура;
			Строка.цена = ВыборкаДетальныеЗаписи.Цена;
		КонецЦикла;
	КонецЕсли;	
	
КонецПроцедуры
