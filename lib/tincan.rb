["httparty", "json"].each(&method(:require))

# @author Charles Hollenbeck
class TinCan
    include HTTParty
    base_uri "apps.tincan.me"

    # Initializes the starting variables to connect to the TinCan Storage API
    #
    # @param app_id [String] The ID for your TinCan Storage application
    # @param app_key [String] The key for your TinCan Storage application
    # @param app_name [String] The name for your TinCan Storage application
    #
    # @example TinCan.new("5e6a7e38c97b", "81aca0b3a200dd52bda8bca268ee68a8", "example")
    def initialize(app_id, app_key, app_name)
        # Initialize the starting variables to connect to the TinCan Storage API
        @id   = app_id
        @key  = app_key
        @name = app_name
    end

    # Inserts data into a TinCan Storage Application
    # @param query [Hash] A hash of the query you wish to send to the TinCan Storage API
    # @example var.insert({:key => "value", :sec_key => "value"})
    # @return [Boolean, String] True or the error
    def insert(query) return read_response(req("insert", query.to_json))     end

    # Finds data in a TinCan Storage Application
    # @param query [Hash] A hash of the query you wish to send to the TinCan Storage API
    # @example var.find({:query => {:key => "value"}, :options => {}}) Options are listed at http://apps.tincan.me/#manipulating
    # @return [String] The returned data from the query or an error
    def find(query)   return read_response(req("find", query.to_json), true) end

    # Updates data in a TinCan Storage Application
    # @param query [Hash] A hash of the query you wish to send to the TinCan Storage API
    # @example var.find({:query => {:key => "value"}, :data => {"$inc" => {:age => 1}}}) Options are listed at http://apps.tincan.me/#manipulating
    # @return [Boolean, String] True or the error
    def update(query) return read_response(req("update", query.to_json))     end

    # Deletes data from a TinCan Storage Application
    # @param query [Hash] A hash of the query you wish to send to the TinCan Storage API
    # @example var.delete({:query => {:key => "value", :sec_key => "value"}, :options => {:drop => true}})
    # @note As a safeguard, an empty query will NOT delete all documents. To erase ALL data in your application's database, you can drop it by using the query {:options => {:drop => true}}. You don't need to supply a query attribute, as it will be ignored if this option is present.
    # @return [Boolean, String] True or the error
    def delete(query) return read_response(req("remove", query.to_json))     end

    # Validates your credentials with the TinCan Storage API
    # @example var.validate
    # @return [Boolean, String] True if it worked, an error otherwise. Errors can be: "NO SUCH APP" or "INVALID_CREDENTIALS"
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
        # Makes requests using HTTParty to the TinCan Storage API
        # @param type [String] The type of query being made (insert|find|update|remove)
        # @param query [String] The JSON Document to send to the TinCan Storage API
        # @return [String] The response's body
        def req(type, query)
            return  self.class.post(
                        "/#{@name}/#{type}",
                        :body => query,
                        :basic_auth => {:username => @id, :password => @key},
                        :headers => {"ContentType" => "application/json"}
                    ).body
        end

        # Interprets the response from the TinCan Storage API
        # @param res [String] The response body from the request
        # @param has_data [Boolean] Optional parameter to tell it wether it has data being sent back in the response
        # @return [Boolean, String] True if successful, a ruby hash of data if output has data or an error
        def read_response(res, has_data = false)
            res = JSON.parse(res)

            if res["success"]
                    return res_data if has_data
                return true
            end
            return res["error"]
        end
end