require 'rubygems'
require 'sinatra/base'

require 'mail'

Mail.defaults do
  delivery_method :smtp, {
    :address => 'smtp.sendgrid.net',
    :port => '587',
    :domain => 'heroku.com',
    :user_name => ENV['SENDGRID_USERNAME'],
    :password => ENV['SENDGRID_PASSWORD'],
    :authentication => :plain,
    :enable_starttls_auto => true
  }
end

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
            name = params[:name]
            email = params[:email]
            type = params[:type]
            Mail.deliver do
              to 'dennis.kuczynski@gmail.com'
              cc 'leslie_kuczynski@yahoo.com'
              from 'dennis.kuczynski@gmail.com'
              subject "Turkey Trot New %s" % [type]
              body "Name:\t%s\nEmail:\t%s\nType:\t%s" % [name, email, type]
            end
            redirect '/thanks.html'         
        end
        
    end
end
