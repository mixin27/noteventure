-- migrations/000002_seed_challenges.up.sql

-- Math challenges (Easy)
INSERT INTO challenge_questions (challenge_type, difficulty, question, correct_answer, wrong_answers, is_active) VALUES
('math', 'easy', 'What is 5 + 7?', '12', '["10", "14", "15"]', true),
('math', 'easy', 'What is 8 - 3?', '5', '["4", "6", "7"]', true),
('math', 'easy', 'What is 4 × 3?', '12', '["10", "14", "16"]', true),
('math', 'easy', 'What is 15 ÷ 3?', '5', '["3", "4", "6"]', true),
('math', 'easy', 'What is 9 + 6?', '15', '["13", "14", "16"]', true);

-- Math challenges (Medium)
INSERT INTO challenge_questions (challenge_type, difficulty, question, correct_answer, wrong_answers, is_active) VALUES
('math', 'medium', 'What is 15 × 8?', '120', '["100", "115", "125"]', true),
('math', 'medium', 'What is 144 ÷ 12?', '12', '["10", "11", "14"]', true),
('math', 'medium', 'What is 25² (25 squared)?', '625', '["525", "600", "650"]', true),
('math', 'medium', 'What is 7 × 13?', '91', '["87", "89", "93"]', true),
('math', 'medium', 'What is √64 (square root of 64)?', '8', '["6", "7", "9"]', true);

-- Math challenges (Hard)
INSERT INTO challenge_questions (challenge_type, difficulty, question, correct_answer, wrong_answers, is_active) VALUES
('math', 'hard', 'What is 17 × 23?', '391', '["381", "387", "401"]', true),
('math', 'hard', 'What is 2⁸ (2 to the power of 8)?', '256', '["128", "512", "1024"]', true),
('math', 'hard', 'What is √169?', '13', '["11", "12", "14"]', true),
('math', 'hard', 'What is 15% of 360?', '54', '["48", "52", "56"]', true),
('math', 'hard', 'What is (15 + 25) × 2 - 10?', '70', '["60", "65", "75"]', true);

-- Trivia challenges (Easy)
INSERT INTO challenge_questions (challenge_type, difficulty, question, correct_answer, wrong_answers, category, is_active) VALUES
('trivia', 'easy', 'What is the capital of France?', 'Paris', '["London", "Berlin", "Madrid"]', 'geography', true),
('trivia', 'easy', 'How many days are in a week?', '7', '["5", "6", "8"]', 'general', true),
('trivia', 'easy', 'What color is the sky on a clear day?', 'Blue', '["Green", "Red", "Yellow"]', 'general', true),
('trivia', 'easy', 'How many continents are there?', '7', '["5", "6", "8"]', 'geography', true),
('trivia', 'easy', 'What is the largest planet in our solar system?', 'Jupiter', '["Mars", "Saturn", "Earth"]', 'science', true);

-- Trivia challenges (Medium)
INSERT INTO challenge_questions (challenge_type, difficulty, question, correct_answer, wrong_answers, category, is_active) VALUES
('trivia', 'medium', 'In what year did World War II end?', '1945', '["1943", "1944", "1946"]', 'history', true),
('trivia', 'medium', 'What is the smallest country in the world?', 'Vatican City', '["Monaco", "Liechtenstein", "Malta"]', 'geography', true),
('trivia', 'medium', 'Who wrote "Romeo and Juliet"?', 'William Shakespeare', '["Charles Dickens", "Jane Austen", "Mark Twain"]', 'literature', true),
('trivia', 'medium', 'What is the chemical symbol for gold?', 'Au', '["Go", "Gd", "Gl"]', 'science', true),
('trivia', 'medium', 'How many strings does a standard guitar have?', '6', '["5", "7", "8"]', 'music', true);

-- Trivia challenges (Hard)
INSERT INTO challenge_questions (challenge_type, difficulty, question, correct_answer, wrong_answers, category, is_active) VALUES
('trivia', 'hard', 'What is the rarest blood type?', 'AB negative', '["O negative", "AB positive", "B negative"]', 'science', true),
('trivia', 'hard', 'In what year was the first iPhone released?', '2007', '["2005", "2006", "2008"]', 'technology', true),
('trivia', 'hard', 'What is the longest river in the world?', 'Nile', '["Amazon", "Yangtze", "Mississippi"]', 'geography', true),
('trivia', 'hard', 'Who painted the Sistine Chapel ceiling?', 'Michelangelo', '["Leonardo da Vinci", "Raphael", "Donatello"]', 'art', true),
('trivia', 'hard', 'What is the speed of light in vacuum (approximately)?', '300,000 km/s', '["150,000 km/s", "450,000 km/s", "600,000 km/s"]', 'science', true);
