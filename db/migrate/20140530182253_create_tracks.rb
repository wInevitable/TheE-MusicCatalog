class CreateTracks < ActiveRecord::Migration
  def change
    create_table :tracks do |t|
      t.string :name, :null => false
      t.integer :album_id, :null => false
      t.integer :track_number, :null => false
      t.boolean :bonus, :default => false, :null => false
      t.text :lyrics, :null => false
      
      t.timestamps
    end
    
    add_index :tracks, [:album_id, :track_number], :unique => true
  end
end
