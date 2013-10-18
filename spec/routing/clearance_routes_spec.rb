require 'spec_helper'

describe 'routes for Clearance' do
  context 'signup disabled' do
    before(:all) do
      Clearance.configure do |config|
        config.allow_sign_up = false
      end
      Rails.application.reload_routes!
    end

    after :all do
      Clearance.configuration = Clearance::Configuration.new
      Rails.application.reload_routes!
    end

    it 'does not route sign_up' do
      { get: 'sign_up' }.should_not be_routable
    end

    it 'does not route to users#create' do
      { post: 'users' }.should_not be_routable
    end

    it 'does not route to users#new' do
      { get: 'users/new' }.should_not be_routable
    end
  end

  context 'signup enabled' do
    it 'does route sign_up' do
      { get: 'sign_up' }.should be_routable
    end

    it 'does route to users#create' do
      { post: 'users' }.should be_routable
    end
  end
end
