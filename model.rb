class User < ActiveRecord::Base
    validates :name, :password, presence: true
    validates :email, uniqueness: true
    validates :password, length: {minimum: 5, maximum: 8}
end

class CreatePost < ActiveRecord::Migration
    def change
      create_table :post do |t|
        t.VARCHAR :post # we will change this to t.string :role\
        t.image   :image
        t.references :user
        t.timestamps
      end
    end
  end
  