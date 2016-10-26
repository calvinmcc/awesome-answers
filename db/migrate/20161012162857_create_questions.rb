class CreateQuestions < ActiveRecord::Migration[5.0]
  def change
    # sometimes this code is called DSL: domain specific language
    # still ruby code but written in way that seems like a new language
    # ruby is flexible to allow that
    # this migration file is not the database or the database table. It's a
    # list of instructions to generate the SQL to create the table in the db

    create_table :questions do |t|
      # by default, rails will always create a primary key integer: id
      t.string :title
      t.text :body


      # this generates two timestamp columns: created_at and updated_at
      t.timestamps
    end
  end
end
