require 'state_check'

describe StateCheck do
  describe "#initialize" do
    it "loads in properties" do
      sc = StateCheck.new("targets_spec.yaml")
      sc.targets.size.should eq 2
    end
  end
  describe "#load_targets" do
    it "gets data from configured sites and updates the target objects" do
      sc = StateCheck.new("targets_spec.yaml")
      sc.targets.each do |t|
        t.current_state.should eq nil
      end
      sc.load_targets
      sc.targets.each do |t|
        t.current_state.should_not eq nil
      end
    end
  end
  describe "#compare_state" do
    it "gives a notice when comparing" do
      sc = StateCheck.new("targets_spec.yaml")
      sc.load_targets
      sc.targets.each do |t|
        if sc.compare_state(t)
          puts "\nIt's been updated, go look. #{t.inspect}\n"
        end
      end
    end
  end
end

