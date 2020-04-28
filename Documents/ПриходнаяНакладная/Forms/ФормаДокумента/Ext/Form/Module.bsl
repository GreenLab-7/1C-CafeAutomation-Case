﻿&НаКлиенте
Процедура ТоварыНоменклатураПриИзменении(Элемент)
	
	ТекущаяСтрока = Элементы.Товары.ТекущиеДанные;
	ТекущаяСтрока.Цена = ПолучитьЦенуПокупкиПоНоменклатуре(ТекущаяСтрока.Номенклатура);
	ТоварыЦенаПриИзменении(Элемент);
	
КонецПроцедуры

&НаСервереБезКонтекста
Функция ПолучитьЦенуПокупкиПоНоменклатуре(Номенклатура)
	Возврат Номенклатура.ПолучитьОбъект().ЦенаПокупки;
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
