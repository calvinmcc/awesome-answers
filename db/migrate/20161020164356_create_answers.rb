class CreateAnswers < ActiveRecord::Migration[5.0]
  def change
    create_table :answers do |t|
      t.text :body
      # this will g an integer field called 'question_id'
      # foreign_key: true <-- default
      # index isn't default
      # basically groups answers by question_id, speeds up search
      # have to update index with every new record
      t.references :question, foreign_key: true, index: true

      t.timestamps
    end
  end
end
