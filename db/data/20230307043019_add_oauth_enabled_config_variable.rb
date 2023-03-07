# frozen_string_literal: true

class AddOauthEnabledConfigVariable < ActiveRecord::Migration[6.1]
  def up
    ConfigVariable.find_or_create_by!(
      key: 'OAUTH_ENABLED',
      name: 'OAuth habilitado',
      value: 'false',
      description: 'Indica si el sistema de autenticación OAuth está habilitado',
      value_type: 'boolean'
    )
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
