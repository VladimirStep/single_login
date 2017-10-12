class CreateProfiles < ActiveRecord::Migration[5.1]
  def change
    create_table :profiles do |t|
      t.references :user, foreign_key: true
      t.string :first_name
      t.string :last_name
      t.string :gender
      t.datetime :birth_date
      t.string :street
      t.string :city
      t.string :country

      t.timestamps
    end
  end
end
