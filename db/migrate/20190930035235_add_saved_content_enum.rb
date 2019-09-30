class AddSavedContentEnum < ActiveRecord::Migration[5.2]
  def change
    execute <<-DDL
      CREATE TYPE saved_content_type AS ENUM (
        'movie', 'show'
      );
    DDL
  end
end
