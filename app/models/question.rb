class Question < ApplicationRecord

  # this sets up the one to many association from the question model. You
  # always provide plural form of the model, in this case answers
  # this will give us handy methods to easily work with the association
  # You must provide a 'dependent' option to your 'has_many'
  has_many :answers, lambda { order(created_at: :DESC) }, dependent: :destroy
  # has_many :answers, dependent: :nullify -- updates question_id's to 'NULL'
  has_many :likes, dependent: :destroy
  has_many :likers, through: :likes, source: :user
  has_many :votes, dependent: :destroy
  has_many :voters, through: :votes, source: :user

  belongs_to :user

  validates :title, presence: true, uniqueness: {case_sensitive: false,
                                                 message: 'must be unique'}

  # with scope we validate that the combination of two fields is unique. In the
  # example below, we're validating that the combination of title/body is unique
  # -only invalid if a question and title aren't unique
  validates :body, length: {minimum: 5, message: 'title must have more letters'},
                   uniqueness: {scope: :title}

  validates :view_count, numericality: { greater_than_or_equal_to: 0 }

  # can create custom validations
  validate :no_monkey

  after_initialize :set_defaults
  before_validation :titleize_title

  # scope :recent_ten, lambda {limit(10).order(created_at: :desc)}

  def self.recent_ten
    limit(10).order(created_at: :desc)
  end

  def user_full_name
    if user
      user.full_name
    else
      'Anonymous'
    end
  end

  def like_for(user)
    likes.find_by(user: user)
  end

  def vote_value
    votes.up.count - votes.down.count
  end


  private

  def no_monkey
    if title && title.include?('monkey')
      errors.add(:title, 'No fucking monkeys')
    end
  end

  def set_defaults
    self.view_count ||= 0
  end

  def titleize_title
    self.title = title.titleize
  end
end
