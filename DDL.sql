create table tests
(
    test_id             serial primary key,
    test_name           varchar(255) not null,
    number_of_questions int          not null,
    minimal_threshold   int          not null
);

create table questions
(
    questions_id   serial primary key,
    test_id        int references tests (test_id),
    questions_text TEXT not null
);
create table answer_options
(
    answer_options_id serial primary key,
    questions_id      int references questions (questions_id),
    text              text    not null,
    is_correct        boolean not null
);

create table student_answers
(
    student_answers_id serial primary key,
    questions_id       int references questions (questions_id),
    answer_options_id  int references answer_options (answer_options_id),
    student_id         int references students (student_id),
    test_result_id     int references test_results (result_id)
);
create table students
(
    student_id         serial primary key,
    student_first_name varchar(255) not null,
    student_last_name  varchar(255) not null
);

create table test_results
(
    result_id  serial primary key,
    test_id    int references tests (test_id),
    student_id int references students (student_id),
    test_date  date    not null,
    is_done    boolean not null,
    foreign key (test_id) references tests (test_id),
    foreign key (student_id) references students (student_id)
);

