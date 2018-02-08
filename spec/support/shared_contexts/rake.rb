require 'rake'

shared_context 'rake' do
  subject { Rake::Task[@task_name] }

  before(:all) do
    @task_name = self.class.top_level_description
    Rake.application.rake_require "tasks/#{@task_name.split(':').first}"
    Rake::Task.define_task(:environment)
  end
end
