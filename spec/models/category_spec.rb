require "rails_helper"

RSpec.describe Category, type: :model do 
  
  describe "Associations" do
    it { should have_many(:products) }
    
    it { should have_many(:childrens) }
    
    it { should belong_to(:parent) }
  end
  
  describe "Scope" do
    
    let!(:parent) { FactoryBot.create(:category, id: 1000) }
    let!(:children) { FactoryBot.create(:category, parent_id: 1000) }
   
    it "only category no have children" do
      expect(Category.parents).to eq([parent]) 
    end
    
    it "only category have children" do
      expect(Category.childrens).to eq([children]) 
    end
  end
  
end
