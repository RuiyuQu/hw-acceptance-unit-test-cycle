require 'rails_helper'

RSpec.describe MoviesController, type: :controller do
# index
  describe 'Index' do
    it 'Should display propery for the Index Page' do
      get :index
      expect(response).to be_successful
    end
  end

# sort
  describe 'Sort Movies' do
    it 'Should sort movies by the titiles' do
      get :index, :sort => 'title'
      expect(Movie.order(:title)).to eq((Movie.order(:title)).sort)
    end
  end
    
# create
  describe 'Create Movies' do 
    it 'Should create a movie according to the passed on params' do
      post :create, movie: { title: 'Star Wars',director: 'George Lucas',rating: 'PG', description: '',:release_date => '1977-05-25'} 
      expect(response).to redirect_to(movies_path)
    end
  end
  
# update
  describe 'Update Movies' do
    it 'Should update a movie detail according to the passed on params' do
      movie = Movie.create({title: 'Star Wars',director: 'George Lucas',rating: 'PG', description: '',:release_date => '1977-05-25'})
      post :update, ActionController::Parameters.new(id: movie.id, movie: {title: 'Star Wars',director: 'George Lucas',rating: 'PG', description: '',:release_date => '1977-05-25'})
      expect(response).to redirect_to(movie_path(movie))
    end
  end
  
# destroy
  describe 'Delete Movies' do
    it 'Should delete a movie with given movie id' do
      @movie = Movie.create({ title: 'Star Wars',director: 'George Lucas',rating: 'PG', description: '',:release_date => '1977-05-25'})
      delete :destroy, :id => @movie.id
      response.should redirect_to(movies_path)
    end
  end

end