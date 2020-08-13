-- 1. +Вибрати усіх клієнтів, чиє ім'я має менше ніж 6 символів.
-- SELECT * FROM bank.client WHERE length(bank.client.FirstName)<6;

-- 2. +Вибрати львівські відділення банку.
-- SELECT * FROM bank.department WHERE bank.department.DepartmentCity='Lviv';

--  3. +Вибрати клієнтів з вищою освітою та посортувати по прізвищу.
-- SELECT * FROM bank.client WHERE bank.client.Education='HIGH' ORDER BY bank.client.LastName;

--  4. +Виконати сортування у зворотньому порядку над таблицею Заявка і вивести 5 останніх елементів.
-- SELECT * FROM bank.application ORDER BY idApplication DESC LIMIT 5 OFFSET 10;

-- 5. +Вивести усіх клієнтів, чиє прізвище закінчується на OV чи OVA.
-- SELECT * FROM bank.client where bank.client.LastName LIKE '%OV' OR '%OVA';

-- 6. +Вивести клієнтів банку, які обслуговуються київськими відділеннями.
-- SELECT * FROM bank.client join bank.department ON Department_idDepartment=idDepartment WHERE DepartmentCity='KYIV';

-- 7. +Вивести імена клієнтів та їхні номера паспортів, погрупувавши їх за іменами.
-- SELECT FirstName,LastName,Passport FROM bank.client group by FirstName;

-- 8. +Вивести дані про клієнтів, які мають кредит більше ніж на 5000 тисяч гривень.
-- SELECT * from bank.client join bank.application ON client.idClient=application.Client_idClient WHERE (bank.application.Currency='GRYVNIA' AND bank.application.SUM > '5000');

-- 9. +Порахувати кількість клієнтів усіх відділень та лише львівських відділень.
-- SELECT count(Department_idDepartment) from bank.client;
-- SELECT count(idClient) from bank.client join bank.department ON client.Department_idDepartment =department.idDepartment WHERE department.DepartmentCity='Lviv';

-- 10. Знайти кредити, які мають найбільшу суму для кожного клієнта окремо.
-- SELECT Client_idClient,max(sum) from bank.application where application.Client_idClient=1 ;
-- SELECT Client_idClient, max(sum) from bank.application where application.Client_idClient=2;
-- SELECTClient_idClient, max(sum) from bank.application where application.Client_idClient=3;
-- SELECTClient_idClient, max(sum) from bank.application where application.Client_idClient=4;
-- SELECT Client_idClient,max(sum) from bank.application where application.Client_idClient=5;
-- SELECT Client_idClient,max(sum) from bank.application where application.Client_idClient=6;
-- SELECT Client_idClient, max(sum) from bank.application where application.Client_idClient=7;
-- SELECT Client_idClient,max(sum) from bank.application where application.Client_idClient=8;
-- SELECT Client_idClient,max(sum) from bank.application where application.Client_idClient=9;
-- SELECT Client_idClient,max(sum) from bank.application where application.Client_idClient=10;

-- 11. Визначити кількість заявок на крдеит для кожного клієнта.
-- select application.client_idClient, count(idApplication)from bank.application group by Client_idClient;

-- 12.. Визначити найбільший та найменший кредити.
-- select max(sum) from bank.application;
-- select min(sum) from bank.application;

-- 13. Порахувати кількість кредитів для клієнтів,які мають вищу освіту.
-- SELECT 
--     application.client_idClient,
--     COUNT(idApplication),
--     FIRSTNAME,
--     EDUCATION
-- FROM
--     bank.application
--         JOIN
--     BANK.CLIENT ON application.Client_idClient = CLIENT.iDCLIENT
-- WHERE
--     CLIENT.EDUCATION = 'HIGH'
-- GROUP BY Client_idClient;

-- 14. Вивести дані про клієнта, в якого середня сума кредитів найвища.
-- SELECT 
--     *, AVG(sum) AS AvgSum
-- FROM
--     bank.client AS bc
--         JOIN
--     bank.application AS ba ON bc.idClient = ba.Client_idclient
-- GROUP BY bc.idClient
-- ORDER BY AvgSum DESC
-- LIMIT 1;

-- 15. Вивести відділення, яке видало в кредити найбільше грошей.
-- SELECT 
--     SUM(sum), idDepartment, DepartmentCity
-- FROM
--     bank.application AS ba
--         JOIN
--     bank.client AS bc ON ba.Client_idClient = bc.idClient
--         JOIN
--     bank.department AS bd ON bd.idDepartment = bc.Department_idDepartment
-- GROUP BY idDepartment
-- ORDER BY SUM(sum) DESC
-- LIMIT 1;


-- 16. Вивести відділення, яке видало найбільший кредит.
-- SELECT 
--     MAX(sum), idDepartment, DepartmentCity
-- FROM
--     bank.application AS ba
--         JOIN
--     bank.client AS bc ON bc.idClient = ba.client_idClient
--         JOIN
--     bank.department AS bd ON bc.department_idDepartment = bd.idDepartment;


-- 17. Усім клієнтам, які мають вищу освіту, встановити усі їхні кредити у розмірі 6000 грн.
-- update bank.application as ba join bank.client as bc on  bc.idclient=ba.client_idclient  set sum=6000 where  bc.education='high';

-- 18. Усіх клієнтів київських відділень пересилити до Києва.
-- update bank.client as bc join bank.department as bd on bc.department_iddepartment=bd.iddepartment set city='Kyiv' where departmentCity='Kyiv';

-- 19. Видалити усі кредити, які є повернені.
-- delete from bank.application where bank.application.creditstate='returned';

-- 20. Видалити кредити клієнтів, в яких друга літера прізвища є голосною.
-- delete from bank.client where LastName regexp '_[o,a,e,u,i,]%';

-- Знайти львівські відділення, які видали кредитів на загальну суму більше ніж 5000
-- SELECT 
--     iddepartment, departmentCity, SUM(sum)
-- FROM
--     bank.department AS bd
--         JOIN
--     bank.client AS bc ON bd.idDepartment = bc.Department_idDepartment
--         JOIN
--     bank.application AS ba ON ba.Client_idClient = bc.idClient
-- WHERE
--     sum > 5000 AND DepartmentCity = 'lviv'
-- GROUP BY DepartmentCity;

-- Знайти клієнтів, які повністю погасили кредити на суму більше ніж 5000
-- select * from bank.client as bc join bank.application as ba on bc.idclient=ba.client_idclient where CreditState='returned'and sum >5000;

/* Знайти максимальний неповернений кредит.*/
-- select max(sum) from bank.application where creditstate='not returned';

/*Знайти клієнта, сума кредиту якого найменша*/
-- select *from bank.application as ba join bank.client as bc on bc.idClient=ba.Client_idClient order by sum  limit 1 ;




/*Знайти кредити, сума яких більша за середнє значення усіх кредитів*/



/*Знайти клієнтів, які є з того самого міста, що і клієнт, який взяв найбільшу кількість кредитів*/



-- #місто чувака який набрав найбільше кредитів

-- select idclient,city,firstname,lastname ,count(idapplication) as ca from bank.client as bc join bank.application as ba on bc.idClient=ba.Client_idClient 
-- group by idClient  order by ca desc limit 1;

