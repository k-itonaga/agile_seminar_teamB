require 'spec_helper'

RSpec.describe Hello do
  it 'massagte return hello' do
    expect(Hello.new.message).to eq 'hello'
  end
end