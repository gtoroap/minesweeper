class AddGridToGame < ActiveRecord::Migration[6.0]
  def change
    change_table :games do |t|
      t.integer 'grid', array: true
    end
  end
end
