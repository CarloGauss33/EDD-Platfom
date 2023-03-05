class Openai::SendOpenaiQuestionResponseJob < ApplicationJob
  CONTEXT_CHARACTER_LIMIT = 7200
  queue_as :default

  def perform(question_text, strategy = :chat)
    @question_text = question_text

    return if @question_text.blank?

    strategy == :chat ? get_chat_completion : get_completion
  end

  private

  def prompt
    <<-TEXT
      En el contexto del lenguaje de programación C y de Estructuras de datos y algoritmos (EDA). Basandose en el libro
      Las siguientes preguntas

      Q: #{@question_text}
      A:
    TEXT
  end

  def chat_prompt
    [
      {
        role: 'system',
        content: 'Eres un asistente que responde preguntas sobre Estructuras de datos y algoritmos. Lenguaje C y teoria de computacion. Manten tus respuestas cortas y claras.'
      },
      {
        role: 'user',
        content: @question_text
      }
    ]
  end

  def get_completion
    openai_client.get_completion(prompt, max_tokens: 500, temperature: 0.1)
  end

  def get_chat_completion
    openai_client.get_chat_completion(chat_prompt, max_tokens: 500, temperature: 0.1)
  end

  def openai_client
    @openai_client ||= OpenaiClient.new
  end
end
