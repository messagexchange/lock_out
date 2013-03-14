class CreateLockOutDates < ActiveRecord::Migration
  def change
    create_table :lock_out_dates do |t|
      t.integer :year
      t.integer :month
      t.boolean :locked, :default => true
    end

    add_index :lock_out_dates, [:year, :month], :unique => true
  end
end
