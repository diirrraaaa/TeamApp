class User < ActiveRecord::Base
    validates :name, :password, presence: true
    validates :email, uniqueness: true
    validates :password, length: {minimum: 5, maximum: 8}
    validates_inclusion_of :birthday, :in => Date.new(1900)..Time.now.years_ago(18).to_date,
    :message => 'Too young, dude!'

    has_many :posts
end

class Post < ActiveRecord::Base
  belongs_to :user
end