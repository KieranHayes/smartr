class Comment < ActiveRecord::Base
  
  #Associations
  belongs_to :user
  belongs_to :commentable, :polymorphic => true
  has_many :votes, :as => :voteable
  belongs_to :question, :polymorphic => true
  
  #Validations
  validates_presence_of [:body]
  
  
end
