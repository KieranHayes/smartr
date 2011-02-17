FactoryGirl.define do
  factory :answer do
    body 'Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.'
  end

  factory :full_answer, :class => Answer do
    body 'Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.'
    association :user, :factory => :user2
    association :question, :factory => :question2
  end
  
  factory :endless_answer, :class => Answer do
    sequence(:body) {|n| "#{n} Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua."}
    association :user, :factory => :endless_user
  end
  
  factory :endless_answer_with_question, :class => Answer do
    sequence(:body) {|n| "#{n} Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua."}
    association :user, :factory => :endless_user
    association :question, :factory => :question
  end
  
end