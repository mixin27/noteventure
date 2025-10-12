-- Add last_synced_at column to user_progress table
ALTER TABLE user_progress
ADD COLUMN IF NOT EXISTS last_synced_at TIMESTAMP;
