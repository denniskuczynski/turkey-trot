require 'rubygems'
require 'sinatra/base'

module TurkeyTrot
    class Server < Sinatra::Base

        root = File.dirname(File.expand_path(__FILE__))
        set :root, root
        if respond_to? :public_folder
          set :public_folder, "#{root}/resources"
        else
          set :public, "#{root}/resources"
        end
        set :static, true

        get '/' do
            redirect '/index.html'
        end

        post '/register' do
            puts params.inspect
             redirect '/thanks.html'
        end
        
    end
end
