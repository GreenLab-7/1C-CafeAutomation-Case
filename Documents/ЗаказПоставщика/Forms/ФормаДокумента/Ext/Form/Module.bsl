﻿&НаКлиенте
Процедура ТоварыНоменклатураПриИзменении(Элемент)
	
	ТекущаяСтрока = Элементы.Товары.ТекущиеДанные;
	ТекущаяСтрока.ВидЕдиницыИзмерения = ПолучитьВидЕдиницыИзмерения(ТекущаяСтрока.Номенклатура);
	ТекущаяСтрока.Цена = ЦеныПокупкиПродажи.Получить(ТекущаяСтрока.Номенклатура);
	ТекущаяСтрока.ЕдиницаИзмерения = СтандартныеЕдиницыИзмерения[ТекущаяСтрока.ВидЕдиницыИзмерения];
	ТоварыЕдиницаИзмеренияПриИзменении(Элемент);
	ТоварыЦенаПриИзменении(Элемент);
	
КонецПроцедуры                          

&НаСервереБезКонтекста
Функция ПолучитьВидЕдиницыИзмерения(Номенклатура)
	Возврат Номенклатура.ПолучитьОбъект().ВидЕдиницыИзмерения;	
КонецФункции

&НаКлиенте
Процедура ТоварыКоличествоПриИзменении(Элемент)
	ТоварыЦенаПриИзменении(Элемент);
КонецПроцедуры

&НаКлиенте
Процедура ТоварыЦенаПриИзменении(Элемент)
	
	ТекущаяСтрока = Элементы.Товары.ТекущиеДанные;
	ТекущаяСтрока.Сумма = ТекущаяСтрока.Цена * ТекущаяСтрока.Количество;
	
КонецПроцедуры

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	ЭтотОбъект.СтандартныеЕдиницыИзмерения = ПараметрыСеанса.СтандартныеЕдиницыИзмерения;
	ЭтотОбъект.МножителиЕдиницИзмерения = ПараметрыСеанса.МножителиЕдиницИзмерения;
		
	ТЗ = РегистрыСведений.ЦеныПокупкиПродажи.СрезПоследних(Объект.Дата,);
	ЦеныПокупкиПродажиСоотв = Новый Соответствие();
	
	Для Каждого Элем Из ТЗ Цикл
		ЦеныПокупкиПродажиСоотв.Вставить(Элем.Номенклатура, Элем.Цена);
	КонецЦикла;
	
	ЦеныПокупкиПродажи = Новый ФиксированноеСоответствие(ЦеныПокупкиПродажиСоотв);
	ПрошлыйМножитель = 1;
	
КонецПроцедуры

&НаКлиенте
Процедура ТоварыЕдиницаИзмеренияПриИзменении(Элемент)
	
	ТекущаяСтрока = Элементы.Товары.ТекущиеДанные;
	ТекущаяСтрока.Цена = МножителиЕдиницИзмерения[ТекущаяСтрока.ЕдиницаИзмерения] * (ТекущаяСтрока.Цена / ПрошлыйМножитель);
	ПрошлыйМножитель = МножителиЕдиницИзмерения[ТекущаяСтрока.ЕдиницаИзмерения];
	ТоварыЦенаПриИзменении(Элемент);
	
КонецПроцедуры
