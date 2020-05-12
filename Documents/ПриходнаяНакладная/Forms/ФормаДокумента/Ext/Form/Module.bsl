﻿
&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	ЭтотОбъект.СтандартныеЕдиницыИзмерения = ПараметрыСеанса.СтандартныеЕдиницыИзмерения;
	ЭтотОбъект.МножителиЕдиницИзмерения = ПараметрыСеанса.МножителиЕдиницИзмерения;
	
	Для Каждого ТекСтрока Из Объект.Товары Цикл
		ТекСтрока.Множитель = МножителиЕдиницИзмерения[ТекСтрока.ЕдиницаИзмерения];
	КонецЦикла;
	
КонецПроцедуры

&НаСервереБезКонтекста
Функция ПолучитьВидЕдиницыИзмерения(Номенклатура)
	Возврат Номенклатура.ПолучитьОбъект().ВидЕдиницыИзмерения;
КонецФункции

&НаКлиенте
Процедура ТоварыНоменклатураПриИзменении(Элемент)
	
	ТекущаяСтрока = Элементы.Товары.ТекущиеДанные;
	ТекущаяСтрока.ВидЕдиницыИзмерения = ПолучитьВидЕдиницыИзмерения(ТекущаяСтрока.Номенклатура);
	ТекущаяСтрока.ЕдиницаИзмерения = СтандартныеЕдиницыИзмерения[ТекущаяСтрока.ВидЕдиницыИзмерения];
	
КонецПроцедуры


&НаКлиенте
Процедура ТоварыЕдиницаИзмеренияПриИзменении(Элемент)
	
	ТекущаяСтрока = Элементы.Товары.ТекущиеДанные;
	ТекущаяСтрока.Множитель = МножителиЕдиницИзмерения[ТекущаяСтрока.ЕдиницаИзмерения];
	
КонецПроцедуры

