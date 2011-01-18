class Question < ActiveRecord::Base
  
  #Associations
  belongs_to :user
  has_many :comments, :as => :commentable, :dependent => :destroy
  has_many :votes, :as => :voteable, :dependent => :destroy
  has_many :answers, :dependent => :destroy
  has_many :favourites, :dependent => :destroy
  belongs_to :answer

  #Validations
  validates_presence_of [:body, :name]
  validates_uniqueness_of [:name, :body]
  validates_length_of :name, :minimum => 20
  validates_length_of :body, :minimum => 75
  validates :tag_list, :presence => true, :length => {:maximum => 8}
  
  #Extensions
  acts_as_taggable_on :tags
  has_friendly_id :permalink
  
  #Named Scopes
  default_scope :include => :user
  scope :latest, :order => "created_at DESC"
  scope :hot, :order => "answers_count DESC,updated_at DESC"
  scope :active, :order => "updated_at DESC, answers_count DESC"
  scope :unanswered, :order => "created_at ASC", :conditions => ["answers_count = ?", "0"]
  
  # Callbacks
  before_validation :set_permalink
  before_save :check_answer_count
  
  #Methods
  def favourited?(user)
    Favourite.find_by_user_id_and_question_id(user.id, self).present?
  end
  
  # Callback methods
  def set_permalink
    self.permalink = self.name.to_permalink unless self.name.nil?
  end
  
  def check_answer_count
    self.answers_count = 0 if self.answers_count.nil?
  end
  
  def update_views
    number_of_views = self.views.nil?? 0 : self.views
    self.views = number_of_views + 1
    self.save(:validate => false)
  end
  
  def answered_by?(user)
    if(Answer.find_by_user_id_and_question_id(user.id, self.id))
      true
    else
      false
    end
  end
end

#Sunspot Configuration
Sunspot.setup(Question) do
  text :name, :boost => 2.0
  text :body
  integer :user_id, :references => User
  
  text :answers do 
    answers.map {|answer| 
      answer.body_plain
    }
  end
  
  text :comments do
    comments.map {|comment|
      comment.body
    }
  end
  
  text :user do
    user.login
  end
  
  text(:tags) do
    tags.map{|tag| tag.name}
  end
  
  time :updated_at
  time :created_at
  
  integer :id
  
  string :sort_title do
    name.downcase.sub(/^(an?|the) /, '')
  end
end