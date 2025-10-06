-- migrations/000001_init_schema.down.sql

DROP TABLE IF EXISTS app_settings;
DROP TABLE IF EXISTS sync_log;
DROP TABLE IF EXISTS active_effects;
DROP TABLE IF EXISTS daily_challenges;
DROP TABLE IF EXISTS user_themes;
DROP TABLE IF EXISTS theme_definitions;
DROP TABLE IF EXISTS chaos_events;
DROP TABLE IF EXISTS point_transactions;
DROP TABLE IF EXISTS user_achievements;
DROP TABLE IF EXISTS achievement_definitions;
DROP TABLE IF EXISTS challenge_history;
DROP TABLE IF EXISTS challenge_questions;
DROP TABLE IF EXISTS notes;
DROP TABLE IF EXISTS categories;
DROP TABLE IF EXISTS user_progress;
DROP TABLE IF EXISTS users;

DROP EXTENSION IF EXISTS "uuid-ossp";
