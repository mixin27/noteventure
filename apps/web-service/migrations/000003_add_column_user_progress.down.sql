-- Remove last_synced_at column from user_progress table
ALTER TABLE user_progress
DROP COLUMN IF EXISTS last_synced_at;
