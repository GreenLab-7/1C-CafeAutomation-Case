﻿
Процедура УстановкаПараметровСеанса(ТребуемыеПараметры)

	УстановлениеПользователяИБ();
	ПараметрыСеанса.ИдетСеанс = Ложь;
	
	// Установка параметра сеанса СтандартныеЕдиницыИзмерения
	СтандЕдиницыИзмерения = Новый Соответствие();
	
	Запрос = Новый Запрос;
	Запрос.Текст = "ВЫБРАТЬ
	|	Регистр.ВидЕдиницыИзмерения,
	|	Регистр.ЕдиницаИзмерения
	|ИЗ
	|	РегистрСведений.МножителиЕдиницИзмерения КАК Регистр
	|ГДЕ
	|	Регистр.СтандартнаяЕдиницаИзмерения = Истина";
	
	РезультатЗапроса = Запрос.Выполнить();
	Выборка = РезультатЗапроса.Выбрать();
	
	Пока Выборка.Следующий() Цикл
		СтандЕдиницыИзмерения.Вставить(Выборка.ВидЕдиницыИзмерения, Выборка.ЕдиницаИзмерения);
	КонецЦикла;
	
	ПараметрыСеанса.СтандартныеЕдиницыИзмерения = Новый ФиксированноеСоответствие(СтандЕдиницыИзмерения);
	
	// Установка параметра сеанса МножителиЕдиницИзмерения
	МножителиЕдиницИзмерения = Новый Соответствие();
	
	Запрос2 = Новый Запрос;
	Запрос2.Текст = "ВЫБРАТЬ
	|	Регистр.ЕдиницаИзмерения,
	|	Регистр.Множитель
	|ИЗ
	|	РегистрСведений.МножителиЕдиницИзмерения КАК Регистр";
	
	РезультатЗапроса2 = Запрос2.Выполнить();
	Выборка2 = РезультатЗапроса2.Выбрать();
	
	Пока Выборка2.Следующий() Цикл
		МножителиЕдиницИзмерения.Вставить(Выборка2.ЕдиницаИзмерения, Выборка2.Множитель);
	КонецЦикла;
	
	ПараметрыСеанса.МножителиЕдиницИзмерения = Новый ФиксированноеСоответствие(МножителиЕдиницИзмерения);
	
КонецПроцедуры

Процедура УстановлениеПользователяИБ()
	
	Сотрудник = Справочники.Сотрудники.НайтиПоРеквизиту("ПользовательИБ", ПользователиИнформационнойБазы.ТекущийПользователь().УникальныйИдентификатор,,);
	
	Если Сотрудник = Справочники.Сотрудники.ПустаяСсылка() Тогда
		Сообщить("Предупреждение: на пользователя не найден соответсвующий сотрудник");
	КонецЕсли;
	
	ПараметрыСеанса.ТекущийСотрудник = Сотрудник;
	
КонецПроцедуры
