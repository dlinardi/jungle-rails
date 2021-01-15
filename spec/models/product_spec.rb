require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do

    params = {
      name: 'Product Name',
      price: 50.00,
      quantity: 39,
      category_id: 1
    }

    it 'should have a name' do
      @product = Product.new(params)
      @product.save
      expect(@product.name).to be_present
    end
    it 'should have a price' do
      @product = Product.new(params)
      @product.save
      expect(@product.price).to be_present
    end
    it 'should have a quantity' do
      @product = Product.new(params)
      @product.save
      expect(@product.quantity).to be_present
    end
    it 'should have a category' do
      @product = Product.new(params)
      @product.save
      expect(@product.category_id).to be_present
    end
    it 'should return error if empty' do
      @product = Product.new(params)
      @product.save
      expect(@product.errors.full_messages).to be_present
    end
  end
end
