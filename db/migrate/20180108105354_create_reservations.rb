# frozen_string_literal: true

class CreateReservations < ActiveRecord::Migration[5.1]
  def change
    create_table :reservations do |t|
      t.references :user, index: true

      t.date :date, index: true, null: false
      t.integer :hour, null: false

      t.integer :guests, null: false

      # next fields holds user's details on the moment of reservation
      t.string :name, null: false
      t.string :phone, null: false
      t.string :email, null: false

      t.integer :status, default: 0, null: false

      t.timestamps null: false
    end

    add_foreign_key :reservations, :users
  end
end
