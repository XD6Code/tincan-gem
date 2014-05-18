["httparty", "json"].each(&method(:require))

class TinCan
    include HTTParty
    base_uri "apps.tincan.me:443"
    ssl_ca_file File.expand_path(File.join(File.dirname(__FILE__), "ssl" , "tincan.crt"))
    headers "ContentType" => "application/json"
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
                	if is_json?(query)
                		return read_response(req(method, query))
            		else
            			raise ArgumentError, "Query must be valid JSON if it is a String"
        			end
                else
                    raise ArgumentError, "Query argument must be a string or hash"
            end
        end
    end

    def validate
        return  read_response(
                    self.class.get(
                        "/#{@name}/authorized",
                        :basic_auth => {:username => @id, :password => @key}
                    ).body
                )
    end

    private
        def req(type, query)
            return  self.class.post(
                        "/#{@name}/#{type}",
                        :body => query,
                        :basic_auth => {:username => @id, :password => @key}
                    ).body
        end

        def read_response(res, has_data = false)
            res = JSON.parse(res)
            return res["data"] || res["success"] || res["error"]
        end

        def is_json?(json)
        	return false unless json.is_a?(String)
        	begin
        		JSON.parse(json)
        		return true
        	rescue JSON::ParserError
        		return false
        	end
        end
end