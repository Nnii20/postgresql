create database intro;
--\c intro;

create table courses(
  c_no text primary key,
  title text,
  hours integer
);
--\help create table

insert into courses(c_no, title, hours)
values('CS301', 'Базы данных', 30),
      ('CS305', 'Сети ЭВМ', 60);

create table students(
  s_id integer primary key,
  name text,
  start_year integer
);
--\d students
-- \d - равносильно desc


insert into students(s_id, name, start_year)
values(1451, 'Анна', 2014),
      (1432, 'Виктор', 2014),
      (1556, 'Нина', 2015);

create table exams(
  s_id integer references students(s_id),
  c_no text references courses(c_no),
  score integer,
  constraint pk primary key(s_id, c_no)
);

insert into exams(s_id, c_no, score)
values (1451, 'CS301', 5),
       (1556, 'CS301', 5),
       (1451, 'CS305', 5),
       (1432, 'CS305', 4);

select title as course_title
     , hours
from courses;

select *
from courses;

select start_year
from students;

select distinct start_year
from students;

select 2 + 2 as result;

select *
from courses
where hours > 45;

select *
from courses
   , exams;

select courses.title
     , exams.s_id
     , exams.score
from courses
   , exams
where courses.c_no = exams.c_no;

select students.name
     , exams.score
from students
join exams
  on students.s_id = exams.s_id
  and exams.c_no = 'CS305';

select students.name
     , exams.score
from students
left join exams
  on students.s_id = exams.s_id
  and exams.c_no = 'CS305';

select students.name
     , exams.score
from students
left join exams on students.s_id = exams.s_id
where exams.c_no = 'CS305';

select name
     , (select score
        from exams
        where exams.s_id = students.s_id
          and exams.c_no = 'CS305')
from students;

select *
from exams
where (select start_year
       from students
       where students.s_id = exams.s_id) > 2014;

select *
from information_schema.tables
where table_catalog = 'intro'
  and table_schema = 'public';

-- \?           Справка по командам psql.
-- \h           Справка по SQL: список доступных команд или
--              синтаксис конкретной команды.
-- \x           Переключение табличного вывода (столбцы и
--              строки) на расширенный (каждый столбец на
--              отдельной строке) и обратно. Удобно для просмотра нескольких «широких» строк.
-- \l           Список баз данных.
-- \du          Список пользователей.
-- \dt          Список таблиц.
-- \di          Список индексов.
-- \dv          Список представлений.
-- \df          Список функций.
-- \dn          Список схем.
-- \dx          Список установленных расширений.
-- \dp          Список привилегий.
-- \d           имя Подробная информация по конкретному объекту базы данных.
-- \d+          имя Еще более подробная информация по конкретному объекту.
-- \timing on   Вывод времени выполнения операторов.
