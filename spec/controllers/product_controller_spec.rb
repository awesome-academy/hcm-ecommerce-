require "rails_helper"

RSpec.describe ProductsController, type: :controller do
  describe "get #edit" do
    context "succes when valid attributes" do
      let!(:product) { FactoryBot.create :product }
      before {get :edit, params: {id: product.id }}

      it "assign @product" do
        expect(assigns(:product)).to eq(product)
      end
      
      it "store forwarding_url" do
        expect(session[:forwarding_url]).not_to be_nil
      end
      
      it "render edit template" do
        expect(response).to render_template :edit
      end
    end
    
    context "fail when id user not found" do
      before {get :edit, params: {id: "" }}
      
      it "assign @product" do
        expect(assigns(:product)).to be_nil
      end
      
      it "don't store forwarding_url" do
        expect(session[:forwarding_url]).to be_nil
      end
      
      it "flash error" do
        expect(flash[:error]).to eq(I18n.t("common.flash.load_product_fail"))  
      end
      
      it "redirect to root path" do
        expect(response).to redirect_to root_path  
      end
    end
    
  end
  
end
