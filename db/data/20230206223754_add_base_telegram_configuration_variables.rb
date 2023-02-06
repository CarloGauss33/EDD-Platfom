# frozen_string_literal: true

class AddBaseTelegramConfigurationVariables < ActiveRecord::Migration[6.1]
  def up
    ConfigVariable.find_or_create_by!(
      key: 'TELEGRAM_BROADCAST_RECIPIENTS_CHAT_IDS',
      name: 'Telegram: Chat ids de los destinatarios de broadcasts',
      value: '',
      description: 'lista de chat_ids separados por "," para los cuales se enviarán los mensajes de broadcast',
      value_type: 'string'
    )

    ConfigVariable.find_or_create_by!(
      key: 'TELEGRAM_DEFAULT_COURSE_ID',
      name: 'Telegram: Id de curso por defecto para mensajes de información',
      description: 'id del curso por defecto para mensajes de información',
      value_type: 'integer'
    )
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
