require 'spec_helper'
require 'rails/all'

class TestUser < TestModel
  validates :name, resource_name: true
end

class Application < Rails::Application
end

module ActiveModel
  module Validations
    describe ResourceNameValidator do
      before do
        TestUser.reset_callbacks(:validate)
      end

      it "returns false used routes" do
        ActiveModel::Validations::ResourceNameValidator.routes = ['/users']
        TestUser.validates :name, resource_name: true
        test_user = TestUser.new(name: 'users')
        expect(test_user.valid?).to be false
        expect(test_user.errors[:name]).to eq(["is unavailable."])
      end

      it "returns false format specified routes" do
        ActiveModel::Validations::ResourceNameValidator.routes = ['/users(.:format)']
        TestUser.validates :name, resource_name: true
        test_user = TestUser.new(name: 'users')
        expect(test_user.valid?).to be false
        expect(test_user.errors[:name]).to eq(["is unavailable."])
      end

      it "returns false nested routes" do
        ActiveModel::Validations::ResourceNameValidator.routes = ['/users/1']
        TestUser.validates :name, resource_name: true
        test_user = TestUser.new(name: 'users')
        expect(test_user.valid?).to be false
        expect(test_user.errors[:name]).to eq(["is unavailable."])
      end

      it "returns true" do
        ActiveModel::Validations::ResourceNameValidator.routes = ['/user']
        TestUser.validates :name, resource_name: true
        test_user = TestUser.new(name: 'users')
        expect(test_user.valid?).to be true
        expect(test_user.errors[:name]).to eq([])
      end
    end
  end
end
