# frozen_string_literal: true

class AddOpenaiEnabledConfigVariable < ActiveRecord::Migration[6.1]
  def up
    ConfigVariable.find_or_create_by!(
      key: 'OPENAI_ENABLED',
      name: 'OpenAI Enabled',
      value: 'false',
      description: 'Enable OpenAI integrations',
      value_type: 'boolean'
    )
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
