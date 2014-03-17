class AddDefaultUser < ActiveRecord::Migration
  def self.up
    execute 'INSERT INTO users(email, encrypted_password, remember_token, created_at, updated_at)' +
                " VALUES ('michal@svab.net', '$2a$10$Hq8Yx.FqFSfivC/j.paaee5ohllYl6p7yCeuGfCcLDH52SxiBvHSm', 'lol', now(), now())"
  end

  def self.down
    User.find_by_email('michal@svab.net').delete
  end
end
