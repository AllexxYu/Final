﻿//начало текста модуля

///////////////////////////////////////////////////
//Служебные функции и процедуры
///////////////////////////////////////////////////

&НаКлиенте
// контекст фреймворка Vanessa-Behavior
Перем Ванесса;
 
&НаКлиенте
// Структура, в которой хранится состояние сценария между выполнением шагов. Очищается перед выполнением каждого сценария.
Перем Контекст Экспорт;
 
&НаКлиенте
// Структура, в которой можно хранить служебные данные между запусками сценариев. Существует, пока открыта форма Vanessa-Behavior.
Перем КонтекстСохраняемый Экспорт;

&НаКлиенте
// Функция экспортирует список шагов, которые реализованы в данной внешней обработке.
Функция ПолучитьСписокТестов(КонтекстФреймворкаBDD) Экспорт
	Ванесса = КонтекстФреймворкаBDD;
	
	ВсеТесты = Новый Массив;

	//описание параметров
	//Ванесса.ДобавитьШагВМассивТестов(ВсеТесты,Снипет,ИмяПроцедуры,ПредставлениеТеста,Транзакция,Параметр);

	Ванесса.ДобавитьШагВМассивТестов(ВсеТесты,"ЯЗагружаюТовары2()","ЯЗагружаюТовары","Допустим  я загружаю Товары");
	Ванесса.ДобавитьШагВМассивТестов(ВсеТесты,"ЯЗагружаюСотрудники()","ЯЗагружаюСотрудники","И я загружаю Акции");

	Ванесса.ДобавитьШагВМассивТестов(ВсеТесты,"ЕстьРезультатПроведенияДокументаПродажаРавный(Парам01)","ЕстьРезультатПроведенияДокументаПродажаРавный","И  есть результат проведения документа Продажа, равный ""Текст сообщения""");
	Ванесса.ДобавитьШагВМассивТестов(ВсеТесты,"ТекстСообщенияРавно(Парам01)","ТекстСообщенияРавно","Тогда текст сообщения равно ""Товара хватает""");
	Ванесса.ДобавитьШагВМассивТестов(ВсеТесты,"ТекстСообщения1Равно(Парам01)","ТекстСообщения1Равно","Тогда текст сообщения1 равно ""Не хватает товара""");
Возврат ВсеТесты;
КонецФункции
	
&НаСервере
// Служебная функция.
Функция ПолучитьМакетСервер(ИмяМакета)
	ОбъектСервер = РеквизитФормыВЗначение("Объект");
	Возврат ОбъектСервер.ПолучитьМакет(ИмяМакета);
КонецФункции
	
&НаКлиенте
// Служебная функция для подключения библиотеки создания fixtures.
Функция ПолучитьМакетОбработки(ИмяМакета) Экспорт
	Возврат ПолучитьМакетСервер(ИмяМакета);
КонецФункции

&НаКлиенте
Функция ЗагрузитьFixtureИзМакета(ИмяМакета)
	Ванесса.ЗапретитьВыполнениеШагов();
	НачальноеИмяФайла = "";
	Адрес = "";
	НачатьПеремещениеФайла(Новый ОписаниеОповещения("ЗагрузитьFixtureИзМакетаЗавершение", ЭтотОбъект, ИмяМакета), НачальноеИмяФайла, Адрес);
КонецФункции


&НаКлиенте
Функция ЗагрузитьFixtureИзМакетаЗавершение  (УдалосьПоместитьФайл, Адрес, ВыбранноеИмяФайла, ИмяМакета)    Экспорт 
	  ЗагрузитьFixtureИзМакетаЗавершениеНаСервере  (Адрес,  ИмяМакета) ;
	  Ванесса.ПродолжитьВыполнениеШагов();
КонецФункции

&НаСервере                                        
Функция ЗагрузитьFixtureИзМакетаЗавершениеНаСервере  (Адрес,  ИмяМакета) 
	ИмяВременногоФайла = ПолучитьИмяВременногоФайла();
	
	ДвоичныеДанные = ПолучитьИзВременногоХранилища(Адрес);
	ДвоичныеДанные.Записать(ИмяВременногоФайла);
	
	ВнешняяОбработка = ВнешниеОбработки.Создать(ИмяВременногоФайла, Ложь);
	
	ИмяВременногоФайла =  ПолучитьИмяВременногоФайла();
	
	Текст = РеквизитФормыВЗначение("Объект").ПолучитьМакет(ИмяМакета).ПолучитьТекст();
	
	ВременныйДокумент = Новый ТекстовыйДокумент;
	ВременныйДокумент.УстановитьТекст(Текст);
	ВременныйДокумент.Записать(ИмяВременногоФайла, КодировкаТекста.UTF8);
	
	ВнешняяОбработка.ВыполнитьЗагрузку(ИмяВременногоФайла);
КонецФункции



///////////////////////////////////////////////////
//Работа со сценариями
///////////////////////////////////////////////////

&НаКлиенте
// Процедура выполняется перед началом каждого сценария
Процедура ПередНачаломСценария() Экспорт
	
КонецПроцедуры

&НаКлиенте
// Процедура выполняется перед окончанием каждого сценария
Процедура ПередОкончаниемСценария() Экспорт
	
КонецПроцедуры



///////////////////////////////////////////////////
//Реализация шагов
///////////////////////////////////////////////////


&НаКлиенте
//Допустим  я загружаю Товары
//@ЯЗагружаюТовары()
Процедура ЯЗагружаюТовары2(ПредставлениеСправочника) Экспорт
	
	СостояниеVanessaBehavior = Ванесса.ПолучитьСостояниеVanessaBehavior();
	Если СостояниеVanessaBehavior.ТекущийСценарий.Имя = "Продажа товаров" Тогда
		ЗагрузитьFixtureИзМакета("Товары");
	КонецЕсли;
	//Ванесса.ПосмотретьЗначение(Парам01,Истина);
КонецПроцедуры

&НаКлиенте
//И я загружаю Акции
//@ЯЗагружаюАкции()
Процедура ЯЗагружаюСотрудники() Экспорт
	СостояниеVanessaBehavior = Ванесса.ПолучитьСостояниеVanessaBehavior();
	Если СостояниеVanessaBehavior.ТекущийСценарий.Имя = "Продажа товаров" Тогда
		ЗагрузитьFixtureИзМакета("Сотрудники");
	КонецЕсли;
	//Ванесса.ПосмотретьЗначение(Парам01,Истина);
КонецПроцедуры



&НаСервере
//И  есть результат проведения документа Продажа, равный Текст сообщения
//@ЕстьРезультатПроведенияДокументаПродажаРавныйСервер()
Функция ЕстьРезультатПроведенияДокументаПродажаРавныйСервер() Экспорт
	//Ванесса.ПосмотретьЗначение(Парам01,Истина);
	ДокументПродажа = ОбщийМодуль2.ПолучитьДокументПродажа();
	ДокументПродажаОбъект = ДокументПродажа.ПолучитьОбъект();
	Попытка
		ДокументПродажаОбъект.Записать(РежимЗаписиДокумента.Проведение);
		ТекстСообщения = "Товара хватает";
	Исключение
		ТекстСообщения = "Не хватает товара";
	КонецПопытки;
	Возврат ТекстСообщения;
КонецФункции


&НаКлиенте
//И  есть результат проведения документа Продажа, равный Текст сообщения
//@ЕстьРезультатПроведенияДокументаПродажаРавный()
Процедура ЕстьРезультатПроведенияДокументаПродажаРавный(ТекстСообщения) Экспорт
	ТекстСообщения = ЕстьРезультатПроведенияДокументаПродажаРавныйСервер() ;
	КонтекстСохраняемый.Вставить("ТекстСообщения",ТекстСообщения);
	//Ванесса.ПосмотретьЗначение(ТекстСообщения,Истина);
КонецПроцедуры


&НаКлиенте
//Допустим  товар не списан из остатков товара
//@ТоварНеСписанИзОстатковТовара()
Процедура ТоварНеСписанИзОстатковТовара() Экспорт
	//Ванесса.ПосмотретьЗначение(Парам01,Истина);
	ВызватьИсключение "Не реализовано.";
КонецПроцедуры

&НаКлиенте
//Когда я создаю документ Продажа
//@ЯСоздаюДокументПродажа()
Процедура ЯСоздаюДокументПродажа() Экспорт
	//Ванесса.ПосмотретьЗначение(Парам01,Истина);
	ВызватьИсключение "Не реализовано.";
КонецПроцедуры

&НаКлиенте
//И я заполняю шапку документа   Продажа
//@ЯЗаполняюШапкуДокументаПродажа()
Процедура ЯЗаполняюШапкуДокументаПродажа() Экспорт
	//Ванесса.ПосмотретьЗначение(Парам01,Истина);
	ВызватьИсключение "Не реализовано.";
КонецПроцедуры

&НаКлиенте
//И я заполняю товары Документа Продажа
//@ЯЗаполняюТоварыДокументаПродажа()
Процедура ЯЗаполняюТоварыДокументаПродажа() Экспорт
	//Ванесса.ПосмотретьЗначение(Парам01,Истина);
	ВызватьИсключение "Не реализовано.";
КонецПроцедуры


&НаКлиенте
//И товара достаточное количество
//@ТовараДостаточноеКоличество()
Процедура ТекстСообщенияРавно(ОжидаемыйРезультат) Экспорт
 	Ванесса.ПосмотретьЗначение(ОжидаемыйРезультат,Истина);
	Если КонтекстСохраняемый.ТекстСообщения = ОжидаемыйРезультат Тогда
		ВызватьИсключение "Товара хватает";
	Иначе
		ВызватьИсключение "Не хватает товара";
	КонецЕсли;
КонецПроцедуры

&НаКлиенте
//Тогда текст сообщения1 равно "Товара НЕ хватает"
//@ТекстСообщения1Равно(Парам01)
Процедура ТекстСообщения1Равно(ОжидаемыйРезультат) Экспорт
	//Ванесса.ПосмотретьЗначение(Парам01,Истина);
 	Ванесса.ПосмотретьЗначение(ОжидаемыйРезультат,Истина);
	Если КонтекстСохраняемый.ТекстСообщения = ОжидаемыйРезультат Тогда
		ВызватьИсключение "Не хватает товара";
	Иначе
		ВызватьИсключение "Товара хватает";
	КонецЕсли;
КонецПроцедуры


&НаКлиенте
//Тогда  документ Продажа  проводится
//@ДокументПродажаПроводится()
Процедура ДокументПродажаПроводится() Экспорт
	//Ванесса.ПосмотретьЗначение(Парам01,Истина);
	ВызватьИсключение "Не реализовано.";
КонецПроцедуры

&НаКлиенте
//И я заполняю шапку документа
//@ЯЗаполняюШапкуДокумента()
Процедура ЯЗаполняюШапкуДокумента() Экспорт
	//Ванесса.ПосмотретьЗначение(Парам01,Истина);
	ВызватьИсключение "Не реализовано.";
КонецПроцедуры

&НаКлиенте
//И я заполняю товары
//@ЯЗаполняюТовары()
Процедура ЯЗаполняюТовары() Экспорт
	//Ванесса.ПосмотретьЗначение(Парам01,Истина);
	ВызватьИсключение "Не реализовано.";
КонецПроцедуры

&НаКлиенте
//И товара недостаточное количество
//@ТовараНедостаточноеКоличество()
Процедура ТовараНедостаточноеКоличество() Экспорт
	//Ванесса.ПосмотретьЗначение(Парам01,Истина);
	ВызватьИсключение "Не реализовано.";
КонецПроцедуры

&НаКлиенте
//Тогда  документ Продажа не проводится
//@ДокументПродажаНеПроводится()
Процедура ДокументПродажаНеПроводится() Экспорт
	//Ванесса.ПосмотретьЗначение(Парам01,Истина);
	ВызватьИсключение "Не реализовано.";
КонецПроцедуры

&НаКлиенте
//И документ Продажа выдает сообщение об ошибке
//@ДокументПродажаВыдаетСообщениеОбОшибке()
Процедура ДокументПродажаВыдаетСообщениеОбОшибке() Экспорт
	//Ванесса.ПосмотретьЗначение(Парам01,Истина);
	ВызватьИсключение "Не реализовано.";
КонецПроцедуры

//окончание текста модуля
