class SerializeReservations < ActiveRecord::Migration[5.1]
  def change
    add_column :reservations, :data, :jsonb
    Reservation.reset_column_information

    Reservation.all.each do |reservation|
      reservation.update!(
        data: {
          hour: reservation[:hour],
          guests: reservation[:guests],
          name: reservation[:name],
          phone: reservation[:phone],
          email: reservation[:email]
        }
      )
    end

    remove_column :reservations, :hour
    remove_column :reservations, :guests
    remove_column :reservations, :name
    remove_column :reservations, :phone
    remove_column :reservations, :email
  end
end
