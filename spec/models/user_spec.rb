require "rails_helper"

RSpec.describe User, type: :model do
  subject { FactoryBot.create :user }
  
  describe "Associations" do
    it { should have_many(:orders)}

    it { should have_many(:evaluates)}
  end

  describe "Validations" do
    it "is valid with valid attributes" do
      is_expected.to be_valid
    end
    
    it "is not valid without email" do
      subject.email = nil
      is_expected.not_to be_valid
    end
    
    it "is not valid without password" do
      subject.password = nil
      is_expected.not_to be_valid
    end
  end
  
  describe "Scope" do
    it "only user have order" do
      new_user = User.create!(id: 1000,email: "nhut132@gmail.com", password: "12345")
      subject.orders.create!
      expect(User.customers).to eq([subject])
    end
  end
  
  
  describe ".new_token" do
    let(:new_token) {User.new_token}
    
    it "is return a string" do
      expect(new_token).to be_instance_of String  
    end
    
    it "is not nil" do
      expect(new_token).not_to be_nil  
    end
    
    it "is has length 22 character" do
      expect(new_token.length).to eq(22)  
    end
  end
  
  describe ".digest" do
    let(:digest) {User.digest("12345")}
    
    it "is not nil" do
      expect(digest).not_to be_nil
    end
    
    it "is can compare with plaintext" do
      expect(BCrypt::Password.new(digest).is_password? "12345").to be true
    end
  end
  
  describe "#authenticate?" do
    it "is false with wrong password_digest nil" do
      subject.password_digest = nil 
      expect(subject.authenticate?("password","123456")).to be false 
    end
    
    it "is true with correct password" do
      expect(subject.authenticate?("password","123456")).to be true
    end
    
    it "is false with wrong password" do
      expect(subject.authenticate?("password","12345678")).to be false
    end
  end
  
  describe "#remember" do
    it "is remember digest nil" do
      expect(subject.remember_digest).to be_nil
    end
    
    it "is update remember digest" do
      subject.remember
      expect(subject.remember_digest).not_to be_nil   
    end
  end
  
  describe "#forgot" do
    it "is update remember digest nil" do
      subject.remember
      subject.forgot
      expect(subject.remember_digest).to be_nil
    end
  end
end
