# frozen_string_literal: true

class CreateClients < ActiveRecord::Migration[5.2]
  def change
    create_table :clients do |t|
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :phone_number

      t.timestamps
    end

    add_index :clients, :email
  end
end
