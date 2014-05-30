class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :email, null: false
      t.string :password_digest, null: false
      t.string :token, null: false

      t.timestamps
    end
    
    add_index :users, [:token, :email], unique: true
  end
end
