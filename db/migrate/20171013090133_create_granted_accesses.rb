class CreateGrantedAccesses < ActiveRecord::Migration[5.1]
  def change
    create_table :granted_accesses do |t|
      t.references :user, foreign_key: true
      t.references :website, foreign_key: true
      t.string :code
      t.string :state
      t.string :access_token

      t.timestamps
    end
    add_index :granted_accesses, :code
    add_index :granted_accesses, :access_token
  end
end
