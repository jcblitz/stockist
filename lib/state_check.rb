require_relative './product_data_retriever'

class StateCheck
  attr_accessor :targets 
  def initialize(target_config = "targets.yaml")
    @targets = Array.new
    target_configs = YAML::load_documents(File.open(target_config))
    target_configs.each do |target_config|
    target = ProductQuery.new(target_config.first[1]["url"], target_config.first[1]["css_target"], target_config.first[1]["value"], StrategyFactory.create(target_config.first[1]["strategy"]))
    @targets << target
   end
  end

  def load_target(target)
    pdr = ProductDataRetriever.new(target.url, target.css_target)
    current_state = pdr.current_state
    target.current_state = current_state.content.strip
    return target
  end

  def load_targets
    targets.collect! { |x| load_target(x) }
  end

  def compare_state(target)
    target.execute_strategy
  end
end

class StrategyFactory
  def self.create type
    case type
      when :change
        ChangeStrategy.new
      else
        ChangeStrategy.new
    end
  end
end

class CompareStrategy

end

class ChangeStrategy < CompareStrategy
  def execute(target)
    if (target.current_state == target.previous_state)
      return false
    else
      return true
    end
  end
end
class ProductQuery
  attr_accessor :url, :css_target, :previous_state, :current_state, :strategy

  def initialize(url, css_target, previous_state, strategy)
    @url = url
    @css_target = css_target
    @previous_state = previous_state
    @strategy = strategy
  end

  def execute_strategy
    @strategy.execute(self)
  end
end
