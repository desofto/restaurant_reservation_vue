# frozen_string_literal: true

class CreateSchedule < ActiveRecord::Migration[5.1]
  def change
    create_table :schedule do |t|
      t.date :date, null: false

      t.integer :count, null: false

      t.timestamps null: false
    end

    add_reference :reservations, :schedule, index: true
    add_foreign_key :reservations, :schedule

    remove_column :reservations, :date, :date
  end
end
