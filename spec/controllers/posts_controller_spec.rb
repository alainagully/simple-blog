require 'rails_helper'

RSpec.describe PostsController, type: :controller do

  let(:blog_post) { create(:post) }
  let(:test_user) { create(:user) }

  describe '#new' do
    it 'renders the new template' do
      sign_in(test_user)
      get :new
      expect(response).to render_template(:new)
    end
    
    it 'instantiates a new post instance variable' do
      sign_in(test_user)
      get :new
      expect(assigns(:post)).to be_a_new(Post)
    end
  end

  describe '#create' do

    context 'with valid attributes' do
      
      def valid_request
        sign_in(test_user)
        post :create, post: FactoryGirl.attributes_for(:post)
      end

      it 'saves a record to the db' do
        count_before = Post.count
        valid_request
        count_after = Post.count
        expect(count_after).to eq(count_before + 1)
      end
      
      it 'shows a flash notice' do
        valid_request
        expect(flash[:notice]).to be
      end
    end

    context 'with invalid attributes' do
      def invalid_request
        sign_in(test_user)
        post :create, post: {title: nil}
      end

      it "doesn't save a record to the db" do
        count_before = Post.count
        invalid_request
        count_after = Post.count
        expect(count_before).to eq(count_after)
      end      
      it "renders the new template" do
        invalid_request
        expect(response).to render_template(:new)
      end
      
      it "renders a flash alert message" do
        invalid_request
        expect(flash[:alert]).to be
      end
    end
   
  end

  describe '#show' do

    before do
      get :show, id: blog_post.id
    end
    
    it 'renders the show template' do
      expect(response).to render_template(:show)
    end
    
    it 'sets an instance variable to the post with the passed id' do
      expect(assigns(:post)).to eq(blog_post)
    end
  end

  describe '#index' do
    
    it 'renders the index template' do
      get :index
      expect(response).to render_template(:index)
    end

    it "sets posts instance variable to all posts in the DB" do
      post_1 = FactoryGirl.create(:post)
      post_2 = FactoryGirl.create(:post)
      get :index
      expect(assigns(:posts)).to match_array([post_1, post_2])
    end
  end
    
end
