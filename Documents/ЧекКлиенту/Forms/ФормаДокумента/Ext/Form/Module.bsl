﻿&НаКлиенте
Процедура ТоварыТоварыПриИзменении(Элемент)

	ТекущаяСтрока = Элементы.Товары.ТекущиеДанные;
	ТекущаяСтрока.ВидЕдиницыИзмерения = ПолучитьВидЕдиницыИзмерения(ТекущаяСтрока.Товары);
	ТекущаяСтрока.Цена = ПолучитьЦенуПродажи1(ТекущаяСтрока.Товары);
	ТекущаяСтрока.ЕдиницаИзмерения = СтандартныеЕдиницыИзмерения[ТекущаяСтрока.ВидЕдиницыИзмерения];
	ТоварыЕдиницаИзмеренияПриИзменении(Элемент);
	ОбновитьЦену();

КонецПроцедуры

&НаКлиенте
Процедура ТоварыЦенаПриИзменении(Элемент)
	ОбновитьЦену();
КонецПроцедуры

&НаСервереБезКонтекста
Функция ПолучитьЦенуПродажи1(Товар)
	Возврат Товар.ПолучитьОбъект().Цена;
КонецФункции

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
	ТекущаяСтрока.Сумма = ТекущаяСтрока.Цена * ТекущаяСтрока.Количество * ТекущаяСтрока.Множитель;
	
КонецФункции

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	ЭтотОбъект.СтандартныеЕдиницыИзмерения = ПараметрыСеанса.СтандартныеЕдиницыИзмерения;
	ЭтотОбъект.МножителиЕдиницИзмерения = ПараметрыСеанса.МножителиЕдиницИзмерения;
	
	Для Каждого ТекСтрока Из Объект.Товары Цикл
		ТекСтрока.Множитель = МножителиЕдиницИзмерения[ТекСтрока.ЕдиницаИзмерения];
	КонецЦикла;
	
КонецПроцедуры

&НаКлиенте
Процедура ТоварыЕдиницаИзмеренияПриИзменении(Элемент)
	
	ТекущаяСтрока = Элементы.Товары.ТекущиеДанные;
	ТекущаяСтрока.Множитель = МножителиЕдиницИзмерения[ТекущаяСтрока.ЕдиницаИзмерения];
	ОбновитьЦену();
	
КонецПроцедуры
