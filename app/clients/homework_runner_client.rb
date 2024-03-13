require 'net/http'
require 'uri'

class HomeworkRunnerClient < BaseClient
  def initialize
    super(
      headers: { 'Authorization': "Bearer #{homework_runner_api_key}" }
    )
  end

  def run_test_suite(test_suite, user, assignment, clean_run = true, pull_if_exists = true)
    post(
      "#{homework_runner_api_url}/assignments/#{test_suite}/#{user}",
      params: {
        assignment: assignment,
        clean_run: clean_run,
        pull_if_exists: pull_if_exists
      }
    )
  end

  def list_assignments
    get("#{homework_runner_api_url}/assignments")
  end

  private

  def homework_runner_api_url
    @homework_runner_api_url ||= ENV.fetch('HOMEWORK_RUNNER_API_URL')
  end

  def homework_runner_api_key
    @homework_runner_api_key ||= ENV.fetch('HOMEWORK_RUNNER_API_KEY')
  end
end
