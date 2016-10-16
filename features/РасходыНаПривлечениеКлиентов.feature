﻿# encoding: utf-8
# language: ru
@tree

Функционал: Расходы на привлечение клиентов
	Как Маркетолог
	Хочу автоматически фиксировать акции
	Чтобы  автоматически заполнять акции при продаже
Контекст: 
	Дано Я запускаю сценарий открытия TestClient или подключаю уже существующий
Сценарий: Заполнение акции в документе Покупка
	
	Когда я заполняю акцию в документе Покупка
		Когда В панели разделов я выбираю "Закупки"
		И     В панели функций я выбираю "Покупка"
		Тогда открылось окно "Покупка"
		И     В форме "Покупка" в таблице "Список" я перехожу к строке:
		| 'Дата'               | 'Номер'     |
		| '13.10.2016 14:32:28' | '000000015' |
		И     в ТЧ "Список" я активизирую поле "Номер"
		И     В форме "Покупка" в ТЧ "Список" я выбираю текущую строку
		Тогда открылось окно "Покупка * от *"
		И     я перехожу к закладке "Акция"
		И     я перехожу к закладке "Группа1"
		И     я открываю выпадающий список "Акция"
		И     из выпадающего списка "Акция" я выбираю "Новогодняя"
		И     в поле "Сумма расходов" я ввожу текст "500,00"
	И я провожу документ Покупка
		И     я нажимаю на кнопку "Провести и закрыть"
	Тогда результат записываться в базу
