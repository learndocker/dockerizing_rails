require 'rails_helper'

RSpec.describe TodosController, type: :controller do

  let(:valid_attributes) {
    { title: 'Do this and that' }
  }

  let(:invalid_attributes) {
    { title: '' }
  }

  let(:valid_session) { {} }

  describe "GET #index" do
    it "returns a success response" do
      todo = Todo.create! valid_attributes
      get :index, params: {}, session: valid_session
      expect(response).to have_http_status(:ok)
    end
  end

  describe "GET #show" do
    it "returns a success response" do
      todo = Todo.create! valid_attributes
      get :show, params: {id: todo.to_param}, session: valid_session
      expect(response).to have_http_status(:ok)
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new Todo" do
        expect {
          post :create, params: { todo: valid_attributes }, session: valid_session
        }.to change(Todo, :count).by(1)
      end

      it "renders a JSON response with the new todo" do
        post :create, params: { todo: valid_attributes }, session: valid_session
        expect(response).to have_http_status(:created)
        expect(response.content_type).to eq('application/json')
        expect(response.location).to eq(todo_url(Todo.last))
      end
    end

    context "with invalid params" do
      it "renders a JSON response with errors for the new todo" do
        post :create, params: { todo: invalid_attributes }, session: valid_session
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq('application/json')
      end
    end
  end

  describe "PUT #update" do
    context "with valid params" do
      let(:new_attributes) {
        { title: 'New title' }
      }

      it "updates the requested todo" do
        todo = Todo.create! valid_attributes
        put :update, params: { id: todo.to_param, todo: new_attributes }, session: valid_session
        todo.reload
        expect(todo.title).to eq('New title')
      end

      it "renders a JSON response with the todo" do
        todo = Todo.create! valid_attributes

        put :update, params: {id: todo.to_param, todo: valid_attributes}, session: valid_session
        expect(response).to have_http_status(:ok)
        expect(response.content_type).to eq('application/json')
      end
    end

    context "with invalid params" do
      it "renders a JSON response with errors for the todo" do
        todo = Todo.create! valid_attributes

        put :update, params: {id: todo.to_param, todo: invalid_attributes}, session: valid_session
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq('application/json')
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested todo" do
      todo = Todo.create! valid_attributes
      expect {
        delete :destroy, params: { id: todo.to_param }, session: valid_session
      }.to change(Todo, :count).by(-1)
    end
  end

end
