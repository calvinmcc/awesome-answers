class Answer < ApplicationRecord
  # auto-generated belongs_to method here enables us to have features for the
  # answer model that makes it easy to use it in assoctiation with the question
  # model
  # the model you reference with 'belongs_to' should be singular

  belongs_to :question

  belongs_to :user

  validates :body, presence: true, length: { minimum: 5 }

  def user_full_name
    if user
      user.full_name
    else
      'Anonymous'
    end
  end

end
