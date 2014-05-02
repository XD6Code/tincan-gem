["httparty", "json"].each(&method(:require))

class TinCan
    include HTTParty
    base_uri "apps.tincan.me"

    def initialize(app_id, app_key, app_name)
        @id   = app_id
        @key  = app_key
        @name = app_name
    end

    def insert(query) return read_response(req("insert", query.to_json))     end
    def find(query)   return read_response(req("find", query.to_json), true) end
    def update(query) return read_response(req("update", query.to_json))     end
    def delete(query) return read_response(req("remove", query.to_json))     end

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

            if res["success"]
                    return res_data if has_data
                return true
            end
            return res["error"]
        end
end