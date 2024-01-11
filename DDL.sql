create table  tests (
    test_id serial primary key,
    test_name varchar(255) not null
);

create table questions (
    questions_id serial primary key,
    test_id int references  tests(test_id),
    questions_text TEXT not null
);

create table answers(
   answers_id serial primary key,
   questions_id int references questions(questions_id),
   answer_text text not null,
   is_correct boolean not null
);
create table students(
    student_id serial primary key,
    student_first_name varchar(255) not null,
    student_last_name varchar(255) not null
);

create table test_results(
    result_id serial primary key,
    test_id int references tests(test_id),
    student_id int references students(student_id),
    test_date date not null,
    foreign key (test_id) references tests(test_id),
    foreign key (student_id) references students(student_id)
);
