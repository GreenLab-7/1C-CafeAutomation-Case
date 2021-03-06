﻿// Функия, возвращающая множитель
//
// Параметры:
//	ЕдиницаИзмерения - ссылка на справочник ЕдиницыИзмерения
Функция ПолучитьМножитель(ЕдиницаИзмерения)	
	Возврат ПараметрыСеанса.МножителиЕдиницИзмерения[ЕдиницаИзмерения];	
КонецФункции

// Функция конвертирования единицы измерения в стандартную
//
// Параметры:
//	ЕдиницаИзмерения - единица измерения, в которой измеряется Значение
//	Значение - значение в переданных единицах измерения
Функция ВСтандартнуюЕИКонвертировать(ЕдиницаИзмерения, Значение) Экспорт
	
	// Получение множителя
	Множитель = ПолучитьМножитель(ЕдиницаИзмерения);
	
	// Вернуть полученое значение
	Возврат Значение * Множитель;
	
КонецФункции

// Функция конвертирования единицы измерения из стандартной
//
// Параметры:
//	ЕдиницаИзмерения - единица измерения, в которую будет происходить конвертация
//	Значение - значение в стандартной единице измерения
Функция ИзСтандартнойЕИКонвертировать(ЕдиницаИзмерения, Значение) Экспорт
	
	// Получение множителя
	Множитель = ПолучитьМножитель(ЕдиницаИзмерения);
	
	// Вернуть полученое значение
	Возврат Значение / Множитель;	
	
КонецФункции

// Функция для конвертирования одной единицы измерения в другую
//
// Параметры
//	ЕдиницаИзмеренияИз - единица измерения, из которой происходит конвертация
//	ЕдиницаИзмеренияВ - единица измерения, в которую происходит конвертация
//	Значение - значение в ЕдиницеИзмеренияИз
Функция РазныеЕИКонвертировать(ЕдиницаИзмеренияИз, ЕдиницаИзмеренияВ, Значение) Экспорт
	
	// Получение значений
	МножительИз = ПолучитьМножитель(ЕдиницаИзмеренияИз);
	МножительВ = ПолучитьМножитель(ЕдиницаИзмеренияВ);
	
	// Вернуть полученное значение
	Возврат (Значение * МножительИз) / МножительВ;
	
КонецФункции