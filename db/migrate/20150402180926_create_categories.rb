class CreateCategories < ActiveRecord::Migration
  def change
    create_table :categories do |t|
      t.references :topic, index: true
      t.boolean :religion
      t.boolean :politics
      t.boolean :software
      t.boolean :culture
      t.boolean :cars
      t.boolean :family
      t.boolean :women
      t.boolean :sports
      t.boolean :hardware
      t.boolean :civil_rights
      t.boolean :men
      t.boolean :technology
      t.boolean :children
      t.boolean :science
      t.boolean :computers
      t.boolean :racism
      t.boolean :animals
      t.boolean :school
    end
    add_foreign_key :categories, :topics
  end
end
