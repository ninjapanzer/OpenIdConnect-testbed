class OmniAuthConfig < ActiveRecord::Base

  def strategy_config
    strategy = Strategies.const_get(self.strategy, false)
    strategy.from_json(json)
  end
end
