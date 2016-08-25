class CreateSeeks < ActiveRecord::Migration
  def change
    create_table :seeks do |t|
      t.string :content
      t.references :user, index: true

      t.timestamps
    end
  end
end
