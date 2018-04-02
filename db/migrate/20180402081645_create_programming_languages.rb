class CreateProgrammingLanguages < ActiveRecord::Migration[5.1]
  def change
    create_table :programming_languages do |t|
      t.string :name

      t.timestamps
    end
  end
end
