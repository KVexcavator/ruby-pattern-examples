require "example"

describe Example do
  before do
    @example = Example.new
  end
  describe 'hello' do
    it 'hello' do
      expect(@example.hello()).to eq('Hello! Welcome to Example!')
    end
  end
end
