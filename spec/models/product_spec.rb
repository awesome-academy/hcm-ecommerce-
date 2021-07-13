require "rails_helper"

RSpec.describe Product, type: :model do
  subject { FactoryBot.create :product }
  
  describe "Associations" do
    it { should have_many(:order_details) }
    
    it { should have_many(:evaluates) }

    it { should belong_to(:category)}
  end

  describe "Validations" do
    it "is valid with valid attributes" do
      is_expected.to be_valid
    end
    
    it "is not valid without name" do
      subject.name = nil
      is_expected.not_to be_valid
    end
    
    it "is not valid without quatity" do
      subject.quatity = nil
      is_expected.not_to be_valid
    end
    
    it "is not valid without category_id" do
      subject.category_id = nil
      is_expected.not_to be_valid
    end
    
    it "is not valid without price" do
      subject.price = nil
      is_expected.not_to be_valid
    end
    
    it "is not valid without description" do
      subject.description = nil
      is_expected.not_to be_valid
    end
    
    it "is not valid with price below 0" do
      subject.price = -1
      is_expected.not_to be_valid
    end
    
    it "is valid with price bigger -1" do
      subject.price = 0
      is_expected.to be_valid
    end
    
    it "is not valid with category_id not exits" do
      subject.category_id = -1
      is_expected.not_to be_valid
    end
    
    it "is not valid with quatity below 0" do
      subject.quatity = -1
      is_expected.not_to be_valid
    end
    
    it "is valid with quatity bigger -1" do
      subject.quatity = 0
      is_expected.to be_valid
    end
    
    it "is not valid with name already" do
      duplicate_product = subject.dup
      duplicate_product.save
      expect(duplicate_product).not_to be_valid
    end
  end
end
