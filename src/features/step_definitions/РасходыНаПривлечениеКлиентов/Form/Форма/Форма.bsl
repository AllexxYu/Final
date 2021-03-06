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

	Ванесса.ДобавитьШагВМассивТестов(ВсеТесты,"ЯЗагружаюАкции1()","ЯЗагружаюАкции","И я загружаю Акции");

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
//И я загружаю Акции
//@ЯЗагружаюАкции()
Процедура ЯЗагружаюАкции1() Экспорт
	СостояниеVanessaBehavior = Ванесса.ПолучитьСостояниеVanessaBehavior();
	Если СостояниеVanessaBehavior.ТекущийСценарий.Имя = "Поступление товара" Тогда
		ЗагрузитьFixtureИзМакета("Акции");
	КонецЕсли;
	//Ванесса.ПосмотретьЗначение(Парам01,Истина);
КонецПроцедуры


&НаКлиенте
//Когда я заполняю акцию в документе Покупка
//@ЯЗаполняюАкциюВДокументеПокупка()
Процедура ЯЗаполняюАкциюВДокументеПокупка() Экспорт
	СостояниеVanessaBehavior = Ванесса.ПолучитьСостояниеVanessaBehavior();
	Если СостояниеVanessaBehavior.ТекущийСценарий.Имя = "Заполнение акции в документе Покупка" Тогда
		ЗагрузитьFixtureИзМакета("Акции");
	КонецЕсли;
	//Ванесса.ПосмотретьЗначение(Парам01,Истина);
КонецПроцедуры

&НаКлиенте
//И я заполняю сумму расходов в документе Покупка
//@ЯЗаполняюСуммуРасходовВДокументеПокупка()
Процедура ЯЗаполняюСуммуРасходовВДокументеПокупка() Экспорт
	//Ванесса.ПосмотретьЗначение(Парам01,Истина);
	ВызватьИсключение "Не реализовано.";
КонецПроцедуры

&НаКлиенте
//И я провожу документ Покупка
//@ЯПровожуДокументПокупка()
Процедура ЯПровожуДокументПокупка() Экспорт
	//Ванесса.ПосмотретьЗначение(Парам01,Истина);
	ВызватьИсключение "Не реализовано.";
КонецПроцедуры

&НаКлиенте
//Тогда результат записываться в базу
//@РезультатЗаписыватьсяВБазу()
Процедура РезультатЗаписыватьсяВБазу() Экспорт
	//Ванесса.ПосмотретьЗначение(Парам01,Истина);
	ВызватьИсключение "Не реализовано.";
КонецПроцедуры

//окончание текста модуля