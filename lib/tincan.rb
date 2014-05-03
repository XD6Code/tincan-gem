["httparty", "json"].each(&method(:require))

class TinCan
    include HTTParty
    base_uri "apps.tincan.me"
    attr_accessor :id, :key, :name

    def initialize(app_id, app_key, app_name)
        @id, @key, @name = app_id, app_key, app_name
    end

    [:insert, :find, :update, :remove].each do |method|
    	define_method method do |query|
    		case query
	    		when Hash
	    			return read_response(req(method, query.to_json))
				when String
					return read_response(req(method, query)) # Assume it's JSON
				else
					raise "Query needs to either be a hash or a JSON string"
			end
		end
	end

    def validate
        return  read_response(
                    self.class.get(
                        "/#{@name}/authorized",
                        :basic_auth => {:username => @id, :password => @key},
                        :headers => {"ContentType" => "application/json"}
                    ).body
                )
    end

    private
        def req(type, query)
            return  self.class.post(
                        "/#{@name}/#{type}",
                        :body => query,
                        :basic_auth => {:username => @id, :password => @key},
                        :headers => {"ContentType" => "application/json"}
                    ).body
        end

        def read_response(res, has_data = false)
            res = JSON.parse(res)
            return res["data"] || res["success"] || res["error"]
        end
end