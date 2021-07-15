require "rails_helper"

RSpec.describe Order, type: :model do
  subject { FactoryBot.create :order }
  
  let!(:user) { FactoryBot.create :user }
  let!(:order_1) { user.orders.create! }
  let!(:order_2) { user.orders.create! }

  describe "Associations" do
    it { should have_many(:order_details) }

    it { should belong_to(:user) }
  end
  
  describe "Scope" do
    it "orders by created_at desc" do
      expect(Order.sort_desc).to eq([order_2, order_1])
    end
    
    it "only orders approved" do
      order_1.rejected!
      order_2.approved!
      expect(Order.approved).to eq([order_2])
    end
    
    it "only order of user" do
      new_user = FactoryBot.create(:user, id: 1000,email: "nhut132@gmail.com")
      order_3 = new_user.orders.create!
      expect(Order.orders(1000)).to eq([order_3])
    end
  end
  
  describe "#reject_order" do
    it "is rejected" do
      subject.reject_order
      expect(subject.rejected?).to be true 
    end
    
    it "is quantity product refund" do
      current_quatity = subject.order_details[0].product.quatity
      subject.reject_order
      new_quatity = subject.order_details[0].product.quatity
      expect(new_quatity).to eq(current_quatity + subject.order_details[0].quatity )  
    end
  end
  
  describe "#approve_order" do
    it "is approve" do
      subject.approve_order
      expect(subject.approved?).to be true
    end
  end
  
  
  describe "#cancel_order" do
    it "is cancel" do
      subject.cancel_order
      expect(subject.cancel?).to be true 
    end
    
    it "is quantity product refund" do
      current_quatity = subject.order_details[0].product.quatity
      subject.reject_order
      new_quatity = subject.order_details[0].product.quatity
      expect(new_quatity).to eq(current_quatity + subject.order_details[0].quatity )  
    end
  end
    
end
