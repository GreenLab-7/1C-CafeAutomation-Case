﻿&НаКлиенте
Процедура ТоварыТоварыПриИзменении(Элемент)

	ТекущаяСтрока = Элементы.Товары.ТекущиеДанные;
	ТекущаяСтрока.ВидЕдиницыИзмерения = ПолучитьВидЕдиницыИзмерения(ТекущаяСтрока.Товары);
	ТекущаяСтрока.Цена = ЦеныПокупкиПродажи.Получить(ТекущаяСтрока.Товары);
	ТекущаяСтрока.ЕдиницаИзмерения = СтандартныеЕдиницыИзмерения[ТекущаяСтрока.ВидЕдиницыИзмерения];
	ТоварыЕдиницаИзмеренияПриИзменении(Элемент);
	ОбновитьЦену();

КонецПроцедуры

&НаКлиенте
Процедура ТоварыЦенаПриИзменении(Элемент)
	ОбновитьЦену();
КонецПроцедуры

&НаСервереБезКонтекста
Функция ПолучитьВидЕдиницыИзмерения(Товар)
	Возврат Товар.ПолучитьОбъект().ВидЕдиницыИзмерения;
КонецФункции

&НаКлиенте
Процедура ТоварыКоличествоПриИзменении(Элемент)
	ОбновитьЦену();
КонецПроцедуры

&НаКлиенте
Функция ОбновитьЦену()
	
	ТекущаяСтрока = Элементы.Товары.ТекущиеДанные;
	ТекущаяСтрока.Сумма = ТекущаяСтрока.Цена * ТекущаяСтрока.Количество;
	
КонецФункции

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
	ОбновитьЦену();
	
КонецПроцедуры
