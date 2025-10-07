-- migrations/000001_init_schema.up.sql

-- Enable UUID extension (PostgreSQL syntax)
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

-- Users table
CREATE TABLE IF NOT EXISTS users (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    email VARCHAR(255) UNIQUE NOT NULL,
    username VARCHAR(50) UNIQUE,
    password_hash VARCHAR(255) NOT NULL,
    created_at TIMESTAMP DEFAULT NOW(),
    updated_at TIMESTAMP DEFAULT NOW(),
    last_sync_at TIMESTAMP,
    is_active BOOLEAN DEFAULT TRUE
);

CREATE INDEX IF NOT EXISTS idx_users_email ON users(email);
CREATE INDEX IF NOT EXISTS idx_users_username ON users(username);

-- User Progress
CREATE TABLE IF NOT EXISTS user_progress (
    id SERIAL PRIMARY KEY,
    user_id UUID UNIQUE NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    total_points INT DEFAULT 100,
    lifetime_points_earned INT DEFAULT 0,
    lifetime_points_spent INT DEFAULT 0,
    level INT DEFAULT 1,
    current_xp INT DEFAULT 0,
    xp_to_next_level INT DEFAULT 100,
    current_streak INT DEFAULT 0,
    longest_streak INT DEFAULT 0,
    last_challenge_date TIMESTAMP,
    total_challenges_solved INT DEFAULT 0,
    total_challenges_failed INT DEFAULT 0,
    total_notes_created INT DEFAULT 0,
    total_notes_deleted INT DEFAULT 0,
    chaos_enabled BOOLEAN DEFAULT TRUE,
    challenge_time_limit INT DEFAULT 30,
    personality_tone VARCHAR(50) DEFAULT 'random',
    sound_enabled BOOLEAN DEFAULT TRUE,
    notifications_enabled BOOLEAN DEFAULT TRUE,
    updated_at TIMESTAMP DEFAULT NOW()
);

CREATE INDEX IF NOT EXISTS idx_user_progress_user_id ON user_progress(user_id);

-- Categories
CREATE TABLE IF NOT EXISTS categories (
    id SERIAL PRIMARY KEY,
    user_id UUID NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    name VARCHAR(100) NOT NULL,
    color VARCHAR(50),
    icon VARCHAR(100),
    sort_order INT DEFAULT 0,
    created_at TIMESTAMP DEFAULT NOW()
);

CREATE INDEX IF NOT EXISTS idx_categories_user_id ON categories(user_id);

-- Notes
CREATE TABLE IF NOT EXISTS notes (
    id UUID PRIMARY KEY,
    user_id UUID NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    title VARCHAR(255) NOT NULL,
    content TEXT,
    note_type VARCHAR(50) DEFAULT 'standard',
    is_locked BOOLEAN DEFAULT FALSE,
    unlock_date TIMESTAMP,
    category_id INT REFERENCES categories(id) ON DELETE SET NULL,
    sort_order INT DEFAULT 0,
    color VARCHAR(50),
    is_pinned BOOLEAN DEFAULT FALSE,
    is_favorite BOOLEAN DEFAULT FALSE,
    required_challenge_level INT,
    is_deleted BOOLEAN DEFAULT FALSE,
    deleted_at TIMESTAMP,
    edit_count INT DEFAULT 0,
    created_at TIMESTAMP DEFAULT NOW(),
    updated_at TIMESTAMP DEFAULT NOW(),
    device_id VARCHAR(255),
    version INT DEFAULT 1,
    last_synced_at TIMESTAMP DEFAULT NOW()
);

CREATE INDEX IF NOT EXISTS idx_notes_user_id ON notes(user_id);
CREATE INDEX IF NOT EXISTS idx_notes_category_id ON notes(category_id);
CREATE INDEX IF NOT EXISTS idx_notes_is_deleted ON notes(is_deleted);
CREATE INDEX IF NOT EXISTS idx_notes_updated_at ON notes(updated_at);

-- Challenge Questions
CREATE TABLE IF NOT EXISTS challenge_questions (
    id SERIAL PRIMARY KEY,
    challenge_type VARCHAR(50) NOT NULL,
    difficulty VARCHAR(20) NOT NULL,
    question TEXT NOT NULL,
    correct_answer TEXT NOT NULL,
    wrong_answers JSONB,
    explanation TEXT,
    category VARCHAR(50),
    times_used INT DEFAULT 0,
    last_used TIMESTAMP,
    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT NOW()
);

CREATE INDEX IF NOT EXISTS idx_challenge_questions_type ON challenge_questions(challenge_type);
CREATE INDEX IF NOT EXISTS idx_challenge_questions_difficulty ON challenge_questions(difficulty);
CREATE INDEX IF NOT EXISTS idx_challenge_questions_category ON challenge_questions(category);

-- Challenge History
CREATE TABLE IF NOT EXISTS challenge_history (
    id UUID PRIMARY KEY,
    user_id UUID NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    challenge_type VARCHAR(50),
    difficulty VARCHAR(20),
    difficulty_level INT,
    question TEXT,
    correct_answer TEXT,
    user_answer TEXT,
    was_correct BOOLEAN,
    points_earned INT,
    xp_earned INT,
    time_spent_seconds INT,
    time_limit_seconds INT,
    was_double_or_nothing BOOLEAN DEFAULT FALSE,
    was_part_of_streak BOOLEAN DEFAULT FALSE,
    trigger_reason VARCHAR(50),
    related_note_id UUID,
    completed_at TIMESTAMP DEFAULT NOW(),
    synced_at TIMESTAMP DEFAULT NOW()
);

CREATE INDEX IF NOT EXISTS idx_challenge_history_user_id ON challenge_history(user_id);
CREATE INDEX IF NOT EXISTS idx_challenge_history_completed_at ON challenge_history(completed_at);

-- Achievement Definitions
CREATE TABLE IF NOT EXISTS achievement_definitions (
    achievement_key VARCHAR(100) PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    description TEXT,
    icon_name VARCHAR(100),
    target_value INT,
    point_reward INT DEFAULT 0,
    rarity VARCHAR(20) DEFAULT 'common'
);

-- User Achievements
CREATE TABLE IF NOT EXISTS user_achievements (
    id SERIAL PRIMARY KEY,
    user_id UUID NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    achievement_key VARCHAR(100) NOT NULL REFERENCES achievement_definitions(achievement_key),
    current_progress INT DEFAULT 0,
    is_unlocked BOOLEAN DEFAULT FALSE,
    unlocked_at TIMESTAMP,
    synced_at TIMESTAMP DEFAULT NOW(),
    UNIQUE(user_id, achievement_key)
);

CREATE INDEX IF NOT EXISTS idx_user_achievements_user_id ON user_achievements(user_id);
CREATE INDEX IF NOT EXISTS idx_user_achievements_unlocked ON user_achievements(is_unlocked);

-- Point Transactions
CREATE TABLE IF NOT EXISTS point_transactions (
    id UUID PRIMARY KEY,
    user_id UUID NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    amount INT NOT NULL,
    reason VARCHAR(100),
    description TEXT,
    related_note_id UUID,
    related_challenge_id UUID,
    related_event_id INT,
    balance_after INT,
    timestamp TIMESTAMP DEFAULT NOW(),
    synced_at TIMESTAMP DEFAULT NOW()
);

CREATE INDEX IF NOT EXISTS idx_point_transactions_user_id ON point_transactions(user_id);
CREATE INDEX IF NOT EXISTS idx_point_transactions_timestamp ON point_transactions(timestamp);

-- Chaos Events
CREATE TABLE IF NOT EXISTS chaos_events (
    id SERIAL PRIMARY KEY,
    user_id UUID NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    event_key VARCHAR(100),
    event_type VARCHAR(20),
    title VARCHAR(255),
    message TEXT,
    points_awarded INT DEFAULT 0,
    was_resolved BOOLEAN DEFAULT FALSE,
    triggered_at TIMESTAMP DEFAULT NOW()
);

CREATE INDEX IF NOT EXISTS idx_chaos_events_user_id ON chaos_events(user_id);
CREATE INDEX IF NOT EXISTS idx_chaos_events_triggered_at ON chaos_events(triggered_at);

-- Theme Definitions
CREATE TABLE IF NOT EXISTS theme_definitions (
    theme_key VARCHAR(100) PRIMARY KEY,
    name VARCHAR(255),
    description TEXT,
    unlock_cost INT,
    primary_color VARCHAR(50),
    secondary_color VARCHAR(50),
    background_color VARCHAR(50),
    surface_color VARCHAR(50),
    theme_style VARCHAR(50)
);

-- User Themes
CREATE TABLE IF NOT EXISTS user_themes (
    id SERIAL PRIMARY KEY,
    user_id UUID NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    theme_key VARCHAR(100) NOT NULL REFERENCES theme_definitions(theme_key),
    is_unlocked BOOLEAN DEFAULT FALSE,
    unlocked_at TIMESTAMP,
    is_active BOOLEAN DEFAULT FALSE,
    UNIQUE(user_id, theme_key)
);

CREATE INDEX IF NOT EXISTS idx_user_themes_user_id ON user_themes(user_id);

-- Daily Challenges
CREATE TABLE IF NOT EXISTS daily_challenges (
    id SERIAL PRIMARY KEY,
    user_id UUID NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    date DATE NOT NULL,
    challenge_type VARCHAR(50),
    title VARCHAR(255),
    description TEXT,
    target_count INT,
    current_progress INT DEFAULT 0,
    point_reward INT,
    is_completed BOOLEAN DEFAULT FALSE,
    completed_at TIMESTAMP,
    UNIQUE(user_id, date)
);

CREATE INDEX IF NOT EXISTS idx_daily_challenges_user_id ON daily_challenges(user_id);
CREATE INDEX IF NOT EXISTS idx_daily_challenges_date ON daily_challenges(date);

-- Active Effects
CREATE TABLE IF NOT EXISTS active_effects (
    id SERIAL PRIMARY KEY,
    user_id UUID NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    effect_type VARCHAR(50),
    multiplier REAL DEFAULT 1.0,
    description TEXT,
    started_at TIMESTAMP DEFAULT NOW(),
    expires_at TIMESTAMP,
    is_active BOOLEAN DEFAULT TRUE,
    related_event_id INT
);

CREATE INDEX IF NOT EXISTS idx_active_effects_user_id ON active_effects(user_id);
CREATE INDEX IF NOT EXISTS idx_active_effects_expires_at ON active_effects(expires_at);

-- Sync Log
CREATE TABLE IF NOT EXISTS sync_log (
    id SERIAL PRIMARY KEY,
    user_id UUID NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    entity_type VARCHAR(50),
    entity_id VARCHAR(255),
    action VARCHAR(20),
    synced_at TIMESTAMP DEFAULT NOW()
);

CREATE INDEX IF NOT EXISTS idx_sync_log_user_id ON sync_log(user_id);
CREATE INDEX IF NOT EXISTS idx_sync_log_synced_at ON sync_log(synced_at);

-- App Settings
CREATE TABLE IF NOT EXISTS app_settings (
    id SERIAL PRIMARY KEY,
    user_id UUID NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    setting_key VARCHAR(100) NOT NULL,
    setting_value TEXT,
    updated_at TIMESTAMP DEFAULT NOW(),
    UNIQUE(user_id, setting_key)
);

CREATE INDEX IF NOT EXISTS idx_app_settings_user_id ON app_settings(user_id);
