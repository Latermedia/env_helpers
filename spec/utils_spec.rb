# frozen_string_literal: true

RSpec.describe EnvHelpers::Utils do
  let(:utils) { EnvHelpers::Utils }

  describe 'true_value?' do
    it 'should return true for t' do
      expect(utils.true_value?('t')).to eq(true)
    end

    it 'should return true for T' do
      expect(utils.true_value?('T')).to eq(true)
    end

    it 'should return true for true (string)' do
      expect(utils.true_value?('true')).to eq(true)
    end

    it 'should return true for TRUE' do
      expect(utils.true_value?('TRUE')).to eq(true)
    end

    it 'should return true for true (bool)' do
      expect(utils.true_value?(true)).to eq(true)
    end

    it 'should return true for 1 (string)' do
      expect(utils.true_value?('1')).to eq(true)
    end

    it 'should return true for 1 (Integer)' do
      expect(utils.true_value?(1)).to eq(true)
    end

    it 'should return false for "things"' do
      expect(utils.true_value?('things')).to eq(false)
    end

    it 'should return false for 0' do
      expect(utils.true_value?('0')).to eq(false)
    end

    it 'should return false for f' do
      expect(utils.true_value?('f')).to eq(false)
    end
  end

  describe 'false_value?' do
    it 'should return true for f' do
      expect(utils.false_value?('f')).to eq(true)
    end

    it 'should return true for F' do
      expect(utils.false_value?('F')).to eq(true)
    end

    it 'should return true for false (string)' do
      expect(utils.false_value?('false')).to eq(true)
    end

    it 'should return true for FALSE' do
      expect(utils.false_value?('FALSE')).to eq(true)
    end

    it 'should return true for false (bool)' do
      expect(utils.false_value?(false)).to eq(true)
    end

    it 'should return true for 0 (string)' do
      expect(utils.false_value?('0')).to eq(true)
    end

    it 'should return true for 0 (Integer)' do
      expect(utils.false_value?(0)).to eq(true)
    end

    it 'should return false for "things"' do
      expect(utils.false_value?('things')).to eq(false)
    end

    it 'should return false for 1' do
      expect(utils.false_value?('1')).to eq(false)
    end

    it 'should return false for t' do
      expect(utils.false_value?('t')).to eq(false)
    end
  end

  describe '.boolean_value?' do
    it 'return true if it is a true_value' do
      allow(utils).to receive(:true_value?).and_return(true)
      allow(utils).to receive(:false_value?).and_return(false)

      expect(utils.boolean_value?(true)).to eq(true)
    end

    it 'return true if it is a true_value - non-mocked' do
      expect(utils.boolean_value?('1')).to eq(true)
    end

    it 'return true if it is a false_value' do
      allow(utils).to receive(:true_value?).and_return(false)
      allow(utils).to receive(:false_value?).and_return(true)

      expect(utils.boolean_value?(false)).to eq(true)
    end

    it 'return true if it is a false_value - non-mocked' do
      expect(utils.boolean_value?('0')).to eq(true)
    end

    it 'return false if it is a neither a true_value nor a false_value' do
      allow(utils).to receive(:true_value?).and_return(false)
      allow(utils).to receive(:false_value?).and_return(false)

      expect(utils.boolean_value?('things')).to eq(false)
    end

    it 'return false if it is a neither a true_value nor a false_value - non-mocked' do
      expect(utils.boolean_value?('things')).to eq(false)
    end

    context '.bool_value?' do
      it 'return false if it is a neither a true_value nor a false_value - non-mocked' do
        expect(utils.bool_value?('things')).to eq(false)
      end
    end
  end
end
