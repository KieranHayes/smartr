class CheckVoteValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)

    if record.value_was == 1
      if record.value_changed?
        record.errors[attribute] << "Already Voted in that direction" unless (record.value == -1)
      end
    end
    
    if record.value_was == -1
      if record.value_changed?
        record.errors[attribute] << "Already Voted in that direction" unless (record.value == 1)
      end
    end
  end
end

class CheckDirectionValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    unless value.to_s.match(/(^up$)|(^down$)/).nil?
      record.errors[attribute] << "Direction is invalid"
    end
    record.errors[attribute] << "Nothing changed" if record.value_was == record.value
  end
end

class Vote < ActiveRecord::Base
  
  # Associations
  belongs_to :user
  belongs_to :voteable, :polymorphic => true
  
  # Filter
  after_save :update_votes_count
  after_save :update_reputation
  
  # Scopes
  default_scope :order => "updated_at asc"
  
  # Virtual Attribute
  attr_reader :direction
  
  # Validations
  validates :value, :presence => true, :check_direction => true, :check_vote => true
  validates :direction, :presence => true, :format => {:with =>  /up|down/}
  
  def direction
    case value
      when 1
        "up"
      when -1
        "down"
      else
        nil
    end
  end
  
  def self.has_voted?(user, record)
    vote = Vote.find_by_user_id_and_voteable_type_and_voteable_id(user.id, record.class.name, record.id)
    if(vote)
      vote.value
    else
      false
    end
  end
  
  def self.can_vote?(user)
    vote = Vote.find_by_user_id_and_voteable_type_and_voteable_id(user.id, self.voteable.class.name, self.voteable.id)
    if(vote)
      vote.value
    else
      false
    end
  end
  
  def self.count_on(type, id)
    rating = 0
    record = type.constantize.find(id)    
    
    record.votes.each do |vote|
     rating = rating + vote.value
    end
     rating
  end
  
  def update_votes_count
    rating = 0
    Rails.logger.info "Rating is 0"
    voteable.votes.each {|vote|
      rating += vote.value
      Rails.logger.info "Rating is #{rating}"
      }
    voteable.update_attributes(:votes_count => rating)
  end
  
  def update_reputation
    
    target_user = self.voteable.user
    Rails.logger.info "Original Value #{value_was}"
    Rails.logger.info "Current Value #{value}"
    
    case direction
      when "up"
        Rails.logger.info "Trying to vote up"
        value = value_was + 1
        Reputation.set("up", self.voteable_type, self.user, target_user) if value_was == -1 || value_was == 0
        Reputation.unpenalize(self.voteable_type, self.user, target_user) if value_was == -1
      when "down"
        Rails.logger.info "Trying to vote down"
        value = value_was - 1
        Reputation.set("down", self.voteable_type, self.user, target_user) if value_was == 1 || value_was == 0
        Reputation.penalize(self.voteable_type, self.user, target_user) if value_was == 1 || value_was == 0
    end
    Rails.logger.info "#{value_was} / #{value}"
    if value == 0
      Rails.logger.info "VOTEABLE COUNT SHOULD BE #{(voteable.votes_count + value)}"
      
      voteable.update_attributes(:votes_count => (voteable.votes_count + value))
      self.destroy
    end
  end
  
end

# == Schema Information
#
# Table name: votes
#
#  id            :integer(4)      not null, primary key
#  voteable_type :string(255)
#  voteable_id   :integer(4)
#  user_id       :integer(4)
#  value         :integer(4)      default(0)
#  created_at    :datetime
#  updated_at    :datetime
#

