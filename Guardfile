guard :rspec, cmd: "bundle exec rspec" do
  watch(%r{^spec/.+_spec\.rb$})
  watch('spec/spec_helper.rb')  { "spec" }
  watch('spec/support/helper_methods.rb')  { "spec" }
  watch("app/controllers/application_controller.rb") { "spec" }
end
