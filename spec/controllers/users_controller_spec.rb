require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  before(:all) do
    @user = build(:users_cont_user_two)
    @user.save
  end
  let(:user) { @user }
    
  describe 'for all users' do
    it 'renders the new user page' do
      get :new
      
      expect(response).to have_http_status(200)
      expect(response).to render_template(:new)
    end
    
    describe 'user create method' do
      it 'creates a new user and logs in when given valid information' do
        params = FactoryGirl.attributes_for(:users_cont_user)
        post :create, :user => params
        new_user_id = User.last.id
        
        expect(session[:user_id]).to eq new_user_id
        expect(response).to have_http_status(302)
        expect(response).to redirect_to "/user_pins/#{new_user_id}"
      end
      
      it 'does not create user and refreshes create page when given invalid information' do
        params = FactoryGirl.attributes_for(:invalid_user)
        post :create, :user => params
        
        expect(session[:user_id]).to be nil
        expect(response).to have_http_status(200)
        expect(response).to render_template(:new)
      end
    end
  end
  
  describe 'for logged in users' do
    describe 'when editing a user' do
      it 'navigating to edit renders the edit user page' do
        session[:user_id] = user.id
        get :edit, :id => user.id
  
        expect(response).to have_http_status(200)
        expect(response).to render_template(:edit)
      end
    
      it 'submitting valid information to the update method updates the user 
            and redirects to the user home page' do
        session[:user_id] = user.id
        edit_params = FactoryGirl.attributes_for(:users_cont_user_edit)
        put :update, {:id => user.id, :user => edit_params }
        
        expect(flash[:success]).to eq("Profile has been successfuly updated")
        expect(response).to have_http_status(302)
        expect(response).to redirect_to("/users/#{user.id}")
        
        updated_user = User.find(user.id)
        expect(updated_user.name).to eq edit_params[:name]
        expect(updated_user.email).to eq edit_params[:email]
      end
    
      it 'submitting invalid information to the update method does not update the 
            user and renders the edit view' do
        session[:user_id] = user.id
        edit_params = FactoryGirl.attributes_for(:users_cont_user_edit_invalid)
        put :update, {:id => user.id, :user => edit_params }
        
        expect(response).to have_http_status(200)
        expect(response).to render_template(:edit)
        
        updated_user = User.find(user.id)
        expect(updated_user.name).not_to eq edit_params[:name]
        expect(updated_user.email).not_to eq edit_params[:email]
      end
    end
    
    describe 'navigating to show user page' do
      it 'renders the show user page' do
        session[:user_id] = user.id
        get :show, :id => user.id
        
        expect(response).to have_http_status(200)
        expect(response).to render_template(:show, :id => user.id)
      end
    end
    
    it 'destroy method removes user from db and redirects to root' do
      del_user = build(:users_cont_user_three)
      del_user.save
      del_id = del_user.id
      expect(User.find(del_id)).not_to be nil
      
      session[:user_id] = del_id
      
      delete :destroy, :id => del_id
      expect(User.find_by(id: del_id)).to be nil
      expect(response).to have_http_status(302)
      expect(response).to redirect_to('/')
    end
  end
  
  describe 'non-logged in users' do
    describe 'are routed to log in page' do
      it 'when navigating to a users edit page' do
        get :edit, :id => user.id
        
        expect(response).to have_http_status(302)
        expect(response).to redirect_to('/login')
      end
      
      it 'when navigating to a users show page' do
        get :edit, :id => user.id
        
        expect(response).to have_http_status(302)
        expect(response).to redirect_to('/login')
      end
      
      it 'when updating a user' do
        edit_params = FactoryGirl.attributes_for(:users_cont_user_edit)
        put :update, :id => user.id, :user => edit_params
        
        expect(response).to have_http_status(302)
        expect(response).to redirect_to('/login')
      end
      
      it 'when deleting a user' do
        delete :destroy, :id => user.id
        
        expect(response).to have_http_status(302)
        expect(response).to redirect_to('/login')
      end
    end
  end
  
  describe 'logged in but invalid users' do
    describe 'are routed to root page' do
      before(:each) do
        invalid_user = build(:users_cont_user_three)
        invalid_user.save
        session[:user_id] = invalid_user.id
      end
      
      it 'when accessing a users show page' do
        get :show, :id => user.id
        
        expect(response).to have_http_status(302)
        expect(response).to redirect_to('/')
      end
      
      it 'when accessing a users edit page' do
        get :edit, :id => user.id
        
        expect(response).to have_http_status(302)
        expect(response).to redirect_to('/')
      end
      
      it 'when updating a users information' do
        params = FactoryGirl.attributes_for(:users_cont_user_three)
        put :update, :id => user.id, :user => params
        
        expect(response).to have_http_status(302)
        expect(response).to redirect_to('/')
      end
      
      it 'when deleting a user' do
        delete :destroy, :id => user.id
        
        expect(response).to have_http_status(302)
        expect(response).to redirect_to('/')
      end
    end
  end
end
