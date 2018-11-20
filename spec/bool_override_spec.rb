# frozen_string_literal: true

RSpec.describe EnvHelpers, override: true do
  let(:env) { EnvHelpers }

  before(:all) do
    require 'bool_override_monkey_patch'
  end

  it 'should think false is true - 1' do
    ClimateControl.modify TEST: 'false' do
      expect(env.true?('TEST')).to eq(true)
    end
  end

  it 'should think false is true - 2' do
    ClimateControl.modify TEST: 'true' do
      expect(env.true?('TEST')).to eq(false)
    end
  end

  it 'should think true is false - 1' do
    ClimateControl.modify TEST: 'false' do
      expect(env.false?('TEST')).to eq(false)
    end
  end

  it 'should think true is false - 2' do
    ClimateControl.modify TEST: 'true' do
      expect(env.false?('TEST')).to eq(true)
    end
  end
end
