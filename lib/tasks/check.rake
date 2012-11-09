require_relative '../state_check.rb'
require_relative '../product_data_retriever.rb'

task :default do
  # just run tests, nothing fancy
  puts "yup" 
end

task :check_changes do
  sc = StateCheck.new("targets.yaml")
  sc.load_targets
  sc.targets.each do |t|
    if sc.compare_state(t)
      puts "\nIt's been updated, go look. #{t.inspect}\n"
    end
  end
end
