require 'spec_helper'

describe User do
  let(:user) {Factory.create :user}
  
  it { should have_many :questions }
  it { should have_many :answers }
  it { should have_many :comments }
  it { should have_many :favourites }
  it { should have_many(:interesting_tags).through(:interesting_tag_taggings) }
  it { should have_many(:uninteresting_tags).through(:uninteresting_tag_taggings) }

  describe "new user record" do
    
    it "has zero reputation" do
      user = Factory.create(:endless_user)
      user.reputation.should == 0
    end
    
  end
  
  describe "voting on a voteable record:" do
    let(:question) { Factory.create(:question2)}
    let(:current_user) { Factory.create(:endless_user)}

    describe "the method vote_value_on" do

      it "returns +1 when the user upvoted" do
        vote = Vote.find_or_create_by_voteable_type_and_voteable_id_and_user_id("Question", question.id, current_user.id)
        vote.update_attributes(:value => "1") 
        current_user.vote_value_on(question).should eq(1)
      end

      it "returns -1 when the user upvotes" do
        vote = Vote.find_or_create_by_voteable_type_and_voteable_id_and_user_id("Question", question.id, current_user.id)
        vote.update_attributes(:value => "-1") 
        current_user.vote_value_on(question).should eq(-1)
      end

      it "returns 0 when the user downvotes" do
        current_user.vote_value_on(question).should eq(0)
      end
    end
  end

  describe "count_view!" do
    let(:current_user) { Factory.create(:endless_user) }
    it "should increase the views count" do
      lambda { current_user.count_view! }.should change(current_user, :views).by(1)
    end
  end
  
  describe "is_online" do
    it "returns true if user has been logged in during the last 5 minutes" do
      Factory.create(:endless_user, :last_request_at => Time.now).is_online?.should eq(true)
    end
    it "returns false if user hasn't logged in during the last 5 minutes" do
      Factory.create(:endless_user, :last_request_at => Time.now - 6.minutes).is_online?.should eq(false)
    end
  end
  
  describe "image_url" do
    context "no image uploaded" do
      pending "it returns the placeholder url"
    end
    context "image uploaded" do
      pending "it returns the image_url of the user's avatar"
    end
    
  end
  
  describe "validation" do
    
    describe "of passwords" do
    
      it "fails if password doesn't match confirmation" do
        user = Factory.build(:user, :password => "password", :password_confirmation => "nope")
        user.should_not be_valid
      end
    
      it "succeeds if password matches confirmation" do
        user = Factory.build(:user, :password => "password", :password_confirmation => "password")
        user.should be_valid
      end
    
    end
    
    describe "of reputation" do
      
      it "cannot be mass-assigned" do
        user = Factory(:endless_user, :reputation => 1000)
        expect { user.update_attributes(:reputation => 2000) }.to_not change {user.reputation}
      end
       
    end
  
    describe "of login name"  do
      
      it "requires presence" do
        user = Factory.build(:user, :login => nil)
        user.should_not be_valid
        user.should have(3).error_on(:login)
      end

      it "requires uniqueness" do
        duplicate_user =  Factory.build(:user, :login => user.login, :email => Faker::Internet.email)
        duplicate_user.should_not be_valid
        duplicate_user.should have(1).error_on(:login)
      end
      
      it "downcases login name" do
        user = Factory.build(:user, :login => "eLiTeHackR")
        user.should be_valid
        user.login.should == "eLiTeHackR".downcase
      end
      
      it "fails if the requested login name is only different in case from an existing username" do
        duplicate_user = Factory.build(:user, :login => user.login.upcase, :email => Faker::Internet.email)
        duplicate_user.should_not be_valid
      end

      it "strips leading and trailing whitespace" do
        user = Factory.build(:user, :login => " leandertaler ")
        user.should be_valid
        user.login.should == "leandertaler" 
      end
    
    end
    

    describe "of email"  do
      
      it "requires presence" do
        user = Factory.build(:user, :login => "anotheruser", :email => nil)
        user.should_not be_valid
        user.should have(2).error_on(:email)
      end

      it "requires uniqueness" do
        duplicate_user =  Factory.build(:user, :login => "anotheruser", :email => user.email)
        duplicate_user.should_not be_valid
        duplicate_user.should have(1).error_on(:email)
      end
    
    end
    
    describe "of interesting_tags" do
      let(:user) {Factory.create(:endless_user)}
      
      it "should have not more than 8 tags" do
        user.interesting_tag_list = "tag1,tag2,tag3,tag4,tag5,tag6,tag7,tag8,tag9"
        user.should_not be_valid
      end
      
      it "should have only downcase tags" do
        user.interesting_tag_list = "RUBY,JAVASCRIPT"
        user.should be_valid
        user.interesting_tag_list.should == ["ruby","javascript"]
      end
      
      it "should fix invalid tag names" do
        user.interesting_tag_list = "ruby .+,%JAVASCRIPT"
        user.should be_valid
        user.interesting_tag_list.should == ["ruby","javascript"]
      end
      
    end
     
    describe "of uninteresting_tags" do
      let(:user) {Factory.create(:endless_user)}
      
      it "should have not more than 8 tags" do
        user.uninteresting_tag_list = "tag1,tag2,tag3,tag4,tag5,tag6,tag7,tag8,tag9"
        user.should_not be_valid
      end
      
      it "should have only downcase tags" do
        user.uninteresting_tag_list = "RUBY,JAVASCRIPT"
        user.should be_valid
        user.uninteresting_tag_list.should == ["ruby","javascript"]
      end
      
      it "should fix invalid tag names" do
        user.uninteresting_tag_list = "ruby .+,%JAVASCRIPT"
        user.should be_valid
        user.uninteresting_tag_list.should == ["ruby","javascript"]
      end
      
    end
  
  end

end