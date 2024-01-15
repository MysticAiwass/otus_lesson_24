INSERT INTO tests (test_id, test_name, number_of_questions, minimal_threshold)
VALUES (1, 'Тест по математике', 1, 1);

INSERT INTO questions (questions_id, test_id, questions_text)
VALUES (1, 1, 'Сколько будет 2 + 2?');

INSERT INTO answer_options (answer_options_id, questions_id, text, is_correct)
VALUES (1, 1, '4', TRUE);

INSERT INTO answer_options (answer_options_id, questions_id, text, is_correct)
VALUES (2, 1, '6', FALSE);

INSERT INTO answer_options (answer_options_id, questions_id, text, is_correct)
VALUES (3, 1, '3', FALSE);

INSERT INTO students (student_id, student_first_name, student_last_name)
VALUES (1, 'Иван', 'Иванов');

--Записываем ответ студента 
INSERT INTO student_answers (student_answers_id, questions_id, answer_options_id, student_id)
VALUES (1, 1, 1, 1);

--На основании предоставленных ответов формируем результат 
WITH TEST_INFO AS (
    SELECT t.test_id as test_id, t.minimal_threshold as minimal_threshold
    FROM tests t
    WHERE t.test_id = 1
),
ANSWER_SUMMARY AS (
    SELECT
        (SELECT count(sa.answer_options_id)
         FROM student_answers sa
         JOIN answer_options ao on sa.answer_options_id = ao.answer_options_id
         JOIN questions q on sa.questions_id = q.questions_id
         JOIN tests t on q.test_id = t.test_id
         WHERE t.test_id = 1
           AND sa.student_id = 1
           AND ao.is_correct = true) >= TI.minimal_threshold as PASSED
    FROM TEST_INFO TI
)
INSERT INTO test_results(result_id, test_id, student_id, test_date, is_done)
VALUES (1, 1, 1, '2024-01-11', (SELECT PASSED FROM ANSWER_SUMMARY));

--Выполняем запрос о прохождении теста студентом
SELECT s.student_first_name, s.student_last_name, tr.is_done, tr.test_date
FROM test_results tr
         JOIN students s on tr.student_id = s.student_id