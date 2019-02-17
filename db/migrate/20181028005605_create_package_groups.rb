# frozen_string_literal: true

class CreatePackageGroups < ActiveRecord::Migration[5.2]
  def change
    create_table :package_groups do |t|
      t.string :name
      t.text :description

      t.timestamps
    end
  end
end
