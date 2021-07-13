require "rails_helper"
include SessionsHelper

RSpec.describe StaticPagesController, type: :controller do
  describe "GET #home" do
    context "when admin login" do
      it "will redirect to admin home" do
        admin = FactoryBot.create :admin
        loggin_user admin
        get :home
        expect(response).to redirect_to admin_root_path
      end
    end
    
    context "when a user" do
      let(:user) { FactoryBot.create :user }
      let(:parent) { FactoryBot.create :category }
      let(:product_list) { FactoryBot.create_list :product, 8 }
      let(:order) { FactoryBot.create :order_without_order_detail }
      
      it "assign @parents" do
        get :home
        expect(assigns(:parents)).to eq([parent])
      end
      
      it "assign @products" do
        FactoryBot.create :order_detail, order: order, product: product_list[-1]
        get :home
        expect(assigns(:products)).to eq(product_list.sort_by{|x| -x.order_details.count})
      end
      
      it "will redirect to user home" do
        get :home
        expect(response).to render_template :home
      end
    end
  end
end
