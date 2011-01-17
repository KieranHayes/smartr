require 'spec_helper'

describe Answer do

  describe "Validations of" do
    
    describe "of body" do
      it "requires presence" do
        answer = Factory.build(:answer, :body => nil)
        answer.should_not be_valid
      end
      
      it "requires a minimum length of 75 characters" do
        answer = Factory.build(:answer, :body => "This answer is too short!")
        answer.should_not be_valid
      end
      
      it "cannot be longer than 2048 characters" do
        answer = Factory.build(:answer, :body => "a"*2049)
        answer.should_not be_valid
      end
      
    end
    
    describe "restrict number of answers for question" do
      it "permit only one one answer from the same user" do
        user = Factory(:user2) 
        question = Factory(:question, :user_id => user.id)
        answer = Factory(:answer, :question => question, :user => question.user)
        another_answer_from_same_user = Factory.build(:answer, :question => question, :user => question.user)
        another_answer_from_same_user.should_not be_valid
      end
    end
    
  end
end
