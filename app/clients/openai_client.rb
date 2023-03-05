require 'ruby/openai'

class OpenaiClient
  OPENAI_API_KEY = ENV.fetch('OPENAI_API_KEY', nil)

  def get_completion(prompt, max_tokens: 250, temperature: 0.1, model: 'text-davinci-003')
    return nil if prompt.blank?
    return 'OpenAI not enabled' unless check_openai_enabled?

    result = openai_client.completions(
      parameters: {
        model: model,
        prompt: prompt,
        temperature: temperature,
        max_tokens: max_tokens
      }
    )

    return nil if result['choices'].blank?

    result['choices'][0]['text']
  end

  def get_chat_completion(messages, max_tokens: 250, temperature: 0.1, model: 'gpt-3.5-turbo')
    return nil if messages.blank?
    return 'OpenAI not enabled' unless check_openai_enabled?

    result = openai_client.chat(
      parameters: {
        model: model,
        messages: messages,
        temperature: temperature,
        max_tokens: max_tokens
      }
    )

    result.dig("choices", 0, "message", "content")
  end

  private

  def openai_client
    @openai_client ||= OpenAI::Client.new(access_token: OPENAI_API_KEY)
  end

  def check_openai_enabled?
    ConfigVariable.fetch('OPENAI_ENABLED', false) && OPENAI_API_KEY.present?
  end
end
