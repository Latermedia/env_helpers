# frozen_string_literal: true

RSpec.describe EnvHelpers do
  let(:env) { EnvHelpers }

  describe '.equal?' do
    it 'should check if the environment variable is equal to the value' do
      ClimateControl.modify TEST: 'hey' do
        expect(env.equal?('TEST', 'hey')).to eq(true)
        expect(env.equal?('TEST', 'nope')).to eq(false)
      end
    end
  end

  describe '.true?' do
    it 'return true if it is a true_value' do
      ClimateControl.modify TEST: 'true' do
        expect(env.true?('TEST')).to eq(true)
      end
    end

    it 'return false if it is not a true_value' do
      ClimateControl.modify TEST: 'something else' do
        expect(env.true?('TEST')).to eq(false)
      end
    end

    it 'return false env variable not defined' do
      expect(env.true?('NONEXISTANT_VAR')).to eq(false)
    end
  end

  describe '.false?' do
    it 'return true if it is a false_value' do
      ClimateControl.modify TEST: 'false' do
        expect(env.false?('TEST')).to eq(true)
      end
    end

    it 'return false if it is not a false_value' do
      ClimateControl.modify TEST: 'something else' do
        expect(env.true?('TEST')).to eq(false)
      end
    end

    it 'return false env variable not defined' do
      expect(env.true?('NONEXISTANT_VAR')).to eq(false)
    end
  end

  describe '.num' do
    it 'should return the to_f of the ENV val - 1' do
      ClimateControl.modify TEST: '123' do
        expect(env.num('TEST')).to eq(123.0)
      end
    end

    it 'should return the to_f of the ENV val - 2' do
      ClimateControl.modify TEST: 'asdf' do
        expect(env.num('TEST')).to eq(0.0)
      end
    end

    it 'should return the to_f of the ENV val - 3' do
      ClimateControl.modify TEST: '12asdf' do
        expect(env.num('TEST')).to eq(12.0)
      end
    end

    it 'should return the to_f of the ENV val - 4' do
      ClimateControl.modify TEST: '12.3asdf' do
        expect(env.num('TEST')).to eq(12.3)
      end
    end

    it 'should return number for a float' do
      ClimateControl.modify TEST: '123.00' do
        expect(env.num('TEST')).to eq(123.0)
      end
    end

    it 'should return negative ints' do
      ClimateControl.modify TEST: '-123' do
        expect(env.num('TEST')).to eq(-123.0)
      end
    end

    it 'should return negative floats' do
      ClimateControl.modify TEST: '-123.0' do
        expect(env.num('TEST')).to eq(-123.0)
      end
    end

    it 'should return the default' do
      expect(env.num('TEST', 123)).to eq(123)
    end
  end

  describe '.int' do
    it 'should return the to_i of the ENV val' do
      ClimateControl.modify TEST: '123' do
        expect(env.int('TEST')).to eq(123)
      end
    end

    it 'should return the to_i of the ENV val - 2' do
      ClimateControl.modify TEST: 'asdf' do
        expect(env.int('TEST')).to eq(0)
      end
    end

    it 'should return the to_i of the ENV val - 3' do
      ClimateControl.modify TEST: '-12asdf' do
        expect(env.int('TEST')).to eq(-12)
      end
    end

    it 'should return the to_i of the ENV val - 4' do
      ClimateControl.modify TEST: '12.3asdf' do
        expect(env.int('TEST')).to eq(12)
      end
    end

    it 'should return 0 if ENV is not an integer' do
      ClimateControl.modify TEST: 'asdf' do
        expect(env.int('TEST')).to eq(0)
      end
    end

    it 'should return integer portion for a float' do
      ClimateControl.modify TEST: '123.45' do
        expect(env.int('TEST')).to eq(123)
      end
    end

    it 'should return negative ints' do
      ClimateControl.modify TEST: '-123' do
        expect(env.int('TEST')).to eq(-123)
      end
    end

    it 'should return the default' do
      expect(env.int('TEST', 123)).to eq(123)
    end
  end

  describe '.bool' do
    it 'should return true if the ENV is a true_value' do
      allow(ENV).to receive(:key?).and_return(true)

      allow(EnvHelpers).to receive(:true_value?).and_return(true)
      allow(EnvHelpers).to receive(:false_value?).and_return(false)

      expect(env.bool('TEST')).to eq(true)
    end

    it 'should return false if the ENV is a false_value' do
      allow(ENV).to receive(:key?).and_return(true)

      allow(EnvHelpers).to receive(:true_value?).and_return(false)
      allow(EnvHelpers).to receive(:false_value?).and_return(true)

      expect(env.bool('TEST')).to eq(false)
    end

    it 'should return default if the ENV is not set' do
      allow(ENV).to receive(:key?).and_return(false)

      expect(env.bool('TEST')).to eq(nil)
    end

    it 'should return default if the ENV is not set - true' do
      allow(ENV).to receive(:key?).and_return(false)

      expect(env.bool('TEST', true)).to eq(true)
    end

    it 'should return default if the ENV is non-boolean value' do
      allow(ENV).to receive(:key?).and_return(true)

      allow(EnvHelpers).to receive(:true_value?).and_return(false)
      allow(EnvHelpers).to receive(:false_value?).and_return(false)

      expect(env.bool('TEST')).to eq(nil)
    end

    it 'should return default if the ENV is non-boolean value - true' do
      allow(ENV).to receive(:key?).and_return(true)

      allow(EnvHelpers).to receive(:true_value?).and_return(false)
      allow(EnvHelpers).to receive(:false_value?).and_return(false)

      expect(env.bool('TEST', true)).to eq(true)
    end

    context 'true' do
      it 'should return true if the ENV is t' do
        allow(ENV).to receive(:key?).and_return(true)
        allow(EnvHelpers).to receive(:true_value?).and_return(true)

        expect(env.bool('TEST')).to eq(true)
      end

      it 'should return true if the ENV is T' do
        ClimateControl.modify TEST: 'T' do
          expect(env.bool('TEST')).to eq(true)
        end
      end

      it 'should return true if the ENV is true' do
        ClimateControl.modify TEST: 'true' do
          expect(env.bool('TEST')).to eq(true)
        end
      end

      it 'should return true if the ENV is TRUE' do
        ClimateControl.modify TEST: 'TRUE' do
          expect(env.bool('TEST')).to eq(true)
        end
      end

      it 'should return true if the ENV is 1' do
        ClimateControl.modify TEST: '1' do
          expect(env.bool('TEST')).to eq(true)
        end
      end
    end

    context 'false' do
      it 'should return false if the ENV is f' do
        ClimateControl.modify TEST: 'f' do
          expect(env.bool('TEST')).to eq(false)
        end
      end

      it 'should return false if the ENV is F' do
        ClimateControl.modify TEST: 'F' do
          expect(env.bool('TEST')).to eq(false)
        end
      end

      it 'should return false if the ENV is false' do
        ClimateControl.modify TEST: 'false' do
          expect(env.bool('TEST')).to eq(false)
        end
      end

      it 'should return false if the ENV is FALSE' do
        ClimateControl.modify TEST: 'FALSE' do
          expect(env.bool('TEST')).to eq(false)
        end
      end

      it 'should return false if the ENV is 0' do
        ClimateControl.modify TEST: '0' do
          expect(env.bool('TEST')).to eq(false)
        end
      end
    end

    context 'default' do
      it 'should return default if the ENV is a non-boolean values - no default' do
        ClimateControl.modify TEST: 'things' do
          expect(env.bool('TEST')).to eq(nil)
        end
      end

      it 'should return default if the ENV is a non-boolean values - true' do
        ClimateControl.modify TEST: 'things' do
          expect(env.bool('TEST', true)).to eq(true)
        end
      end

      it 'should return default if the ENV is a non-boolean values - false' do
        ClimateControl.modify TEST: 'things' do
          expect(env.bool('TEST', false)).to eq(false)
        end
      end
    end
  end

  describe '.array' do
    it 'should return an array split on a comma' do
      ClimateControl.modify TEST: 'abc,123,xyz' do
        expect(env.array('TEST')).to eq(%w[abc 123 xyz])
      end
    end

    it 'should return an array split on a pipe' do
      ClimateControl.modify TEST: 'abc|123|xyz' do
        expect(env.array('TEST', '|')).to eq(%w[abc 123 xyz])
      end
    end

    it 'should return an array - single' do
      ClimateControl.modify TEST: 'abc' do
        expect(env.array('TEST')).to eq(['abc'])
      end
    end

    it 'should return an array - empty' do
      ClimateControl.modify TEST: '' do
        expect(env.array('TEST')).to eq([])
      end
    end

    it 'should return an empty array if ENV does not exist' do
      expect(env.array('TEST')).to eq([])
    end
  end

  describe '.json' do
    before(:each) do
      [:@rescue_json].each do |ivar|
        next unless env.instance_variable_defined?(ivar)

        env.remove_instance_variable(ivar)
      end
    end

    it 'should return an array from the parsed json' do
      json = '["a","b","c"]'

      ClimateControl.modify TEST: json do
        expect(env.json('TEST')).to eq(%w[a b c])
      end
    end

    it 'should return a hash from the parsed json' do
      json = '{"a":1,"b":2}'

      ClimateControl.modify TEST: json do
        expect(env.json('TEST')).to eq('a' => 1, 'b' => 2)
      end
    end

    it 'should raise error on invalid json' do
      json = '{"a":1,"b:2}'

      allow(env).to receive(:rescue_json?).and_return(false)

      ClimateControl.modify TEST: json do
        expect do
          env.json('TEST')
        end.to raise_error(JSON::ParserError)
      end
    end

    it 'should not raise error on invalid json' do
      json = '{"a":1,"b:2}'

      allow(env).to receive(:rescue_json?).and_return(true)

      ClimateControl.modify TEST: json do
        expect do
          expect(env.json('TEST')).to eq(nil)
        end.to_not raise_error
      end
    end

    describe '.rescue_json?' do
      it 'should return true if not set' do
        expect(env.rescue_json?).to eq(true)
      end

      it 'should return true if set to true' do
        env.rescue_json = true
        expect(env.rescue_json?).to eq(true)
      end

      it 'should return false if set to false' do
        env.rescue_json = false
        expect(env.rescue_json?).to eq(false)
      end
    end
  end
end
