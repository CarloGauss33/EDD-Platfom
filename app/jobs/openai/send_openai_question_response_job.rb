class Openai::SendOpenaiQuestionResponseJob < ApplicationJob
  CONTEXT_CHARACTER_LIMIT = 7200
  queue_as :default

  def perform(question_text)
    @question_text = question_text

    return if @question_text.blank?

    get_completion
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

  def get_completion
    openai_client.get_completion(prompt, max_tokens: 500, temperature: 0.1)
  end

  def openai_client
    @openai_client ||= OpenaiClient.new
  end
end
