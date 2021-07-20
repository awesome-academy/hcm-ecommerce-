require "rails_helper"
include SessionsHelper

RSpec.describe OrdersController, type: :controller do
  let!(:user) { FactoryBot.create :user }
  let!(:product) { FactoryBot.create :product }
  
  describe "get #new" do
    
    context "susscess when valid attributes" do
      context "when session cart empty" do
        before do 
          loggin_user user
          get :new
        end
        
        it "assign @carts" do
          expect(assigns(:carts)).to be_empty  
        end
      end
      
      context "when session cart not empty" do
        before do 
          session[:cart] = { product.id => 5 }
          loggin_user user
          get :new
        end
        
        it "assign @carts" do
          cart = {
            name: product.name,
            quatity: 5,
            price: product.price,
            total: product.price * 5,
            id: product.id,
            image: assigns(:carts)[0][:image]
          }
          expect(assigns(:carts)).to eq([cart])  
          
        end
      end
      
      
    end
    
    it_behaves_like "user don't login"
  
    it_behaves_like "user is admin"

  end
  
  describe "post #create" do
    context "success when valid attributes" do
      before do
        session[:cart] = { product.id => 5,  -1 => -1 }
        loggin_user user
        post :create, params: {
          order: {
            fullname: "nhut",
            phone_number: 987654321,
            address: "địa chỉ"
          }
        }
      end
      it "assign @order" do
        expect(assigns(:order)).not_to be_nil
      end
      
      it "flash success" do
        expect(flash[:success]).to eq(I18n.t("common.flash.order_success"))  
      end
      
      it "remove cart" do
        expect(session[:cart]).to be_nil  
      end
      
      it "redirect root path" do
        expect(response).to redirect_to root_path  
      end
    end
    
    context "fail when don't have session cart wrong data" do
      before do
        session[:cart] = [{  "asd" => "asd" }]
        allow(Product).to receive(:find_by).and_raise(ActiveRecord::StaleObjectError)
        loggin_user user
        post :create, params: {
          order: {
            fullname: "nhut",
            phone: 987654321,
            address: "address"
          }
        }
      end
        it "will role back order" do
          expect(Order.all.count).to eq(0)  
        end
        
        it "flash error" do 
          expect(flash[:error]).to eq(I18n.t("common.flash.order_fail"))    
        end
        
        it "redirect to new order path" do
          expect(response).to redirect_to new_order_path  
        end
    end
    
    it_behaves_like "user don't login"
  
    it_behaves_like "user is admin"
    
  end
  
  describe "patch #update" do
    let!(:product) { FactoryBot.create :product, quatity: 10 }
    let!(:order) { FactoryBot.create :order_with_product_quatity }
    context "success when valid attributes" do
      before do
        loggin_user user
        patch :update, params: {
          id: order.id
        }
      end
      
      it "assign @order" do
        expect(assigns(:order)).to eq(order)  
      end
      
      it "status order is cancel" do
        order.reload
        expect(order.cancel?).to be true
      end
      
      it "quantity product will refund" do
        product.reload
        expect(product.quatity).to eq(12)  
      end
      
      it "flash success" do
        expect(flash[:success]).to eq(I18n.t("common.flash.cancel"))  
      end
      
      it "redirect to order path" do
        expect(response).to redirect_to orders_path  
      end
    end
    
    context "fail when id order not found" do
      before do
        loggin_user user
        patch :update, params: {
          id: -1
        }
      end
      
      it_behaves_like "id order not found"
    end
    
    it_behaves_like "user don't login"
  
    it_behaves_like "user is admin"
    
  end
  
  describe "get #index" do
    let!(:order) { FactoryBot.create :order, user: user }
    context "success when valid attributes" do
      before do
        loggin_user user
        get :index, params: {
          page: 1
        }
      end
      
      it "assign @orders" do
        expect(assigns(:orders)).to eq([order])  
      end
      
      it "assign @result" do
        result = {
          order_quatity: order.order_details[0].quatity,
          price: order.order_details[0].quatity * order.order_details[0].price,
          status: order.status,
          order_time: order.created_at,
          order_id: order.id,
          fullname: order.fullname,
          phone_number: order.phone_number
        }
        expect(assigns(:result)).to eq([result])  
      end
  end
  it_behaves_like "user don't login"
  
  it_behaves_like "user is admin"
  end
  
  describe "get #edit" do
    let(:order) { FactoryBot.create :order }
    context "success when valid attributes" do
      before do
        loggin_user user
        get :edit, params: {
          id: order.id
        }
      end
      
      it "assign @order" do
        expect(assigns(:order)).to eq(order)  
      end
      
      it "assign @total" do
        total =  order.order_details.reduce(0){|a, e| a + e[:price] * e[:quatity]}
        expect(assigns(:total)).to eq(total)
      end
    end
    
    context "fail when id order not found" do
      before do
        loggin_user user
        get :edit, params: {
          id: -1
        }
      end
      
      it_behaves_like "id order not found"
    end
    
    it_behaves_like "user don't login"
  
    it_behaves_like "user is admin"
  end
  
end
