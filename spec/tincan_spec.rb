require "spec_helper"
require "tincan"

describe TinCan do
	context "when initalized with no arguments" do
		it do
			expect {
				TinCan.new
			}.to raise_error(ArgumentError)
		end
	end

	context "when initalized with all arguments" do
		subject { TinCan.new("Arg1", "Arg2", "Arg3") }

		context "# Arguments" do
			its(:id)   { should == "Arg1"}
			its(:key)  { should == "Arg2"}
			its(:name) { should == "Arg3"}
		end

		it { should respond_to(:insert) } #--|
		it { should respond_to(:find)   } #--| -- All of these are dynamically generated with the same code block in each
		it { should respond_to(:update) } #--|
		it { should respond_to(:remove) } #--|

		# Make sure private methods aren't able to be called on the object
		it { should_not respond_to(:req) }
		it { should_not respond_to(:read_response) }
		it { should_not respond_to(:is_json?) }

		context "# Queiries" do
			context "# Success" do
				it "should send the request when query is a valid json string" do
					json = '{"key":"value"}'
					subject.should_receive(:req).and_return('{"success": true}')
					subject.insert(json)
				end
			end

			context "# Errors" do
				it "should raise ArgumentError when query is not a string or hash" do
					expect {
						subject.insert(1)
						subject.find  (1)
						subject.update(1)
						subject.remove(1)
					}.to raise_error(ArgumentError)
				end

				it "should raise ArgumentError when query is a string and not valid JSON" do
					expect {
						subject.insert("{A")
						subject.find  ("{A")
						subject.update("{A")
						subject.remove("{A")
					}.to raise_error(ArgumentError)
				end
			end
		end

		context "# Private JSON parsing" do
			context "# Validation" do
				it "should be true when JSON is valid" do
					subject.send(:is_json?, '{"key":"value"}').should be_true
				end
				it "should be false when JSON is invalid" do
					subject.send(:is_json?, "{A").should be_false
				end
				it "should be false when argument is not a string" do
					subject.send(:is_json?, 13).should be_false
				end
			end

			context "# Parsing responses" do
				json_success_only      = '{"success":true}'
				json_success_with_data = '{"success":true, "data": {"key":"value"}}'
				json_failed_with_error = '{"success":false, "error": "INVALID_CREDENTIALS"}'

				it "should be true when JSON only has success = true" do
					subject.send(:read_response, json_success_only).should be_true
				end
				it "should return data when JSON is successful and has data" do
					subject.send(:read_response, json_success_with_data).should == {"key" => "value"}
				end
				it "should return an error if JSON is not successful and has an error" do
					subject.send(:read_response, json_failed_with_error).should == "INVALID_CREDENTIALS"
				end
			end
		end
	end
end