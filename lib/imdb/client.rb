module Imdb
  class Client
    attr_accessor :headers

    def initialize(options = {})
      @headers = {}
      @headers['Accept-Language'] = 'en-US,en;q=0.5'
      @headers.merge! options[:headers] if options.key?(:headers)
    end

    def get(url_or_uri, redirections_limit = 10)
      raise ArgumentError, 'Too many redirects' if redirections_limit == 0

      uri = url_or_uri.kind_of?(URI::Generic) ? url_or_uri : URI(url_or_uri)

      response = Net::HTTP.start(uri.hostname, uri.port,
                      :use_ssl => uri.scheme == 'https') do |http|
        http.request_get(uri, headers)
      end

      case response
      when Net::HTTPRedirection
        redirect_uri = uri.merge(response['location'])
        get(redirect_uri, redirections_limit -1)
      else
        response.body
      end
    end
  end
end
