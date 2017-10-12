class CreateWebsites < ActiveRecord::Migration[5.1]
  def change
    create_table :websites do |t|
      t.references :user, foreign_key: true
      t.string :name
      t.string :domain_name
      t.string :secrete_id
      t.string :secrete_token

      t.timestamps
    end
    add_index :websites, :secrete_id
  end
end
