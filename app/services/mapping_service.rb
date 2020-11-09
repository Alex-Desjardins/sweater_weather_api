class MappingService
  def self.mapping_data(start, stop)
    response = conn.get('directions/v2/route') do |f|
      f.params[:from] = start
      f.params[:to] = stop
    end
    JSON.parse(response.body, symbolize_names: true)
  end

  private

  def self.conn
    Faraday.new(url: 'http://www.mapquestapi.com/') do |f|
      f.params[:key] = ENV['MAPPING_API_KEY']
    end
  end
end
