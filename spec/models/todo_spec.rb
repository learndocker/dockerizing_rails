require 'rails_helper'

RSpec.describe Todo, type: :model do
  it 'have a default title' do
    expect(Todo.new.title).to eq('default title')
  end
end
