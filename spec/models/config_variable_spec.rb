require 'rails_helper'

RSpec.describe ConfigVariable, type: :model do
  describe 'Factory' do
    it 'has a valid factory' do
      expect(build(:config_variable)).to be_valid
    end
  end

  describe 'Enums' do
    it { is_expected.to define_enum_for(:value_type) }
  end

  describe 'Validations' do
    it { is_expected.to validate_presence_of(:key) }
  end

  describe 'Methods' do
    describe '#casted_value' do
      context 'when value_type is string' do
        let!(:config_variable) do
          create(:config_variable,
                 value_type: :string,
                 value: 'MyString value')
        end

        it 'returns the value' do
          expect(config_variable.casted_value).to eq('MyString value')
        end
      end

      context 'when value_type is integer' do
        let!(:config_variable) do
          create(:config_variable,
                 value_type: :integer,
                 value: '123')
        end

        it 'returns the value as integer' do
          expect(config_variable.casted_value).to eq(123)
        end
      end

      context 'when value_type is boolean' do
        let!(:config_variable) do
          create(:config_variable,
                 value_type: :boolean,
                 value: 'true')
        end

        it 'returns the value as boolean' do
          expect(config_variable.casted_value).to eq(true)
        end
      end

      context 'when value_type is date' do
        let!(:config_variable) do
          create(:config_variable,
                 value_type: :date,
                 value: '2023-01-01')
        end

        it 'returns the value as date' do
          expect(config_variable.casted_value).to eq(Date.parse('2023-01-01'))
        end
      end
    end

    describe '.fetch' do
      let!(:config_variable) do
        create(:config_variable,
               key: 'test_key',
               value_type: :string,
               value: 'MyString value')
      end

      context 'when config variable exists' do
        it 'returns the value' do
          expect(described_class.fetch('test_key')).to eq('MyString value')
        end
      end

      context 'when config variable does not exist with default value' do
        it 'returns the default value' do
          expect(described_class.fetch('undefined_key', 'default'))
            .to eq('default')
        end
      end

      context 'when config variable does not exist without default value' do
        it 'raises an error' do
          expect { described_class.fetch('undefined_key') }
            .to raise_error(ActiveRecord::RecordNotFound)
        end
      end
    end
  end
end
