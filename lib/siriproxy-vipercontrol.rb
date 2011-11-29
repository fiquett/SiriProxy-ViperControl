require 'cora'
require 'siri_objects'
require 'json'
require 'httparty'

class SiriProxy::Plugin::ViperControl < SiriProxy::Plugin
  	attr_accessor :host

  	def initialize(config = {})
    	self.host = config["url"]
  	end

  	#capture ViperControl status
  	listen_for(/Car.*start/i) { send_command_to_car("remote") }
  	listen_for(/start.*Car/i) { send_command_to_car("remote") }
  
  	listen_for(/Car.*lock/i) { send_command_to_car("arm") }
  	listen_for(/lock.*Car/i) { send_command_to_car("arm") }
  
  	listen_for(/Car.*unlock/i) { send_command_to_car("disarm") }
  	listen_for(/unlock.*Car/i) { send_command_to_car("disarm") }

  	listen_for(/Car.*trunk/i) { send_command_to_car("trunk") }
  	listen_for(/trunk.*Car/i) { send_command_to_car("trunk") }
 
 	listen_for(/Car.*panic/i) { send_command_to_car("panic") }
  	listen_for(/panic.*Car/i) { send_command_to_car("panic") }
  
  	def send_command_to_car(viper_command)
		say  "One moment while I connect to your vehicle..."
		Thread.new {
			result = HTTParty.get("#{self.url}?action=#{viper_command}").body rescue nil
			status = JSON.parse(open(result)) rescue nil
			say  "Connected..."
				if(status["Return"]["ResponseSummary"]["StatusCode"] == 0) #successful
					say "Viper Connection Successful"
					if(status["Return"]["Results"]["Device"]["Action"] == "arm")
						say "Vehicle security engaged!"
					elsif(status["Return"]["Results"]["Device"]["Action"] == "disarm")
						say "Vehicle security disabled!"
					elsif(status["Return"]["Results"]["Device"]["Action"]  == "remote")
						say "Vehicle ignition has been triggered"
					elsif(status["Return"]["Results"]["Device"]["Action"]  == "trunk")
						say "Vehicle trunk has been opened"
					end
				else
					say "Sorry, could not connect to your vehicle."
				end
			
			request_completed
		}	
	end
end