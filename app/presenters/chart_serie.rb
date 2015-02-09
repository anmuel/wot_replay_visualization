class ChartSerie
  include Virtus.model

  attribute :attribute, String
  attribute :criteria, String
  attribute :name, String

  attr_reader :data
  attr_reader :criteria

  def for(criteria, as: nil)
    self.criteria = criteria
    self.name = as || criteria
    self
  end

  def with(wot_replays)
    @data = wot_replays.reduce({}) do |hash, wot_replay|
      key = Time.new(wot_replay.time.year,
        wot_replay.time.month,
        wot_replay.time.day).to_s

      hash[key] ||= 0
      hash[key] += 1 if wot_replay.send(attribute) == criteria

      hash
    end.values

    self
  end

  def to_hash
    {
      name: name,
      data: data
    }
  end
end
