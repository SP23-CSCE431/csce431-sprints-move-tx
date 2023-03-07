require 'rails_helper'

RSpec.describe ExcusesController, type: :routing do
  describe 'routing' do
    it 'routes to #index' do
      expect(get: '/excuses').to route_to('excuses#index')
    end

    it 'routes to #new' do
      expect(get: '/excuses/new').to route_to('excuses#new')
    end

    it 'routes to #show' do
      expect(get: '/excuses/1').to route_to('excuses#show', id: '1')
    end

    it 'routes to #edit' do
      expect(get: '/excuses/1/edit').to route_to('excuses#edit', id: '1')
    end


    it 'routes to #create' do
      expect(post: '/excuses').to route_to('excuses#create')
    end

    it 'routes to #update via PUT' do
      expect(put: '/excuses/1').to route_to('excuses#update', id: '1')
    end

    it 'routes to #update via PATCH' do
      expect(patch: '/excuses/1').to route_to('excuses#update', id: '1')
    end

    it 'routes to #destroy' do
      expect(delete: '/excuses/1').to route_to('excuses#destroy', id: '1')
    end
  end
end
