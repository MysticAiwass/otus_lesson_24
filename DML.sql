INSERT INTO tests (test_name) VALUES ('Тест по математике');
INSERT INTO questions (questions_id,test_id, questions_text) VALUES (1, 1, 'Сколько будет 2 + 2?');
INSERT INTO answers (questions_id, answer_text, is_correct) VALUES (1, '4', TRUE);
INSERT INTO students (student_id,student_first_name, student_last_name) VALUES (1, 'Иван', 'Иванов');
INSERT INTO test_results (result_id, test_id, student_id, test_date) VALUES (1,1, 1, '2024-01-11');

SELECT
    tr.result_id,
    tr.test_date,
    s.student_first_name,
    s.student_last_name,
    t.test_name,
    q.questions_text,
    a.answer_text,
    a.is_correct
FROM
    test_results tr
JOIN
    students s ON tr.student_id = s.student_id
JOIN
    tests t ON tr.test_id = t.test_id
JOIN
    questions q ON q.test_id = t.test_id
JOIN
    answers a on q.questions_id = a.questions_id;