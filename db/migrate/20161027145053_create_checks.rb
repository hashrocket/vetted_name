class CreateChecks < ActiveRecord::Migration[5.0]
  def change
    create_table :checks do |t|
      t.belongs_to :query
      t.belongs_to :service
      t.boolean :passed
      t.timestamps
    end
  end
end
