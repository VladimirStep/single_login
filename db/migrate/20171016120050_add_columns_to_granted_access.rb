class AddColumnsToGrantedAccess < ActiveRecord::Migration[5.1]
  def change
    add_column :granted_accesses, :refresh_token, :string
    add_index :granted_accesses, :refresh_token
    add_column :granted_accesses, :access_token_expires_at, :datetime
  end
end
