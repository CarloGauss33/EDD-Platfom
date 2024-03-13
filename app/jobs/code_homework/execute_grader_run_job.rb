class CodeHomework::ExecuteGraderRunJob < ApplicationJob
  queue_as :default

  def perform(code_homework_run)
    return unless code_homework_run&.may_run?

    @code_homework_run = code_homework_run
    code_homework_run.run!

    begin
      update_run_status
    rescue StandardError => e
      Rails.logger.error("Error updating run status: #{e.message}")
      code_homework_run.fail!
    end
  end

  private

  def update_run_status
    @code_homework_run.update!(
      graded_at: Time.zone.now,
      status: :success,
      run_results: execute_grader_run
    )
  end

  def student
    @code_homework_run.student
  end

  def repository_prefix
    @code_homework_run.repository_prefix
  end

  def execute_grader_run
    client.run_test_suite(
      repository_prefix,
      student.github_username,
      repository_prefix
    )
  end

  def client
    @client ||= HomeworkRunnerClient.new
  end
end
