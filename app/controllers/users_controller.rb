class UsersController < ApplicationController
  
  def login
    client = TwitterOAuth::Client.new(
        :consumer_key => TWITTER_CONSUMER_KEY,
        :consumer_secret => TWITTER_CONSUMER_SECRET
    )
    RAILS_DEFAULT_LOGGER.info c("client = #{client.inspect}")
    request_token = client.request_token(:oauth_callback => TWITTER_CALLBACK_URL)
    session[:request_token] = request_token
    session[:client] = client
    redirect_to request_token.authorize_url
    #:oauth_callback required for web apps, since oauth gem by default force PIN-based flow 
    #( see http://groups.google.com/group/twitter-development-talk/browse_thread/thread/472500cfe9e7cdb9/848f834227d3e64d )
  end
  
  def authenticate
    RAILS_DEFAULT_LOGGER.info c("\n\ndo 1\n\n")
    puts TWITTER_CONSUMER_KEY.inspect
    client = TwitterOAuth::Client.new(
        :consumer_key => TWITTER_CONSUMER_KEY,
        :consumer_secret => TWITTER_CONSUMER_SECRET
    )
    #Dump::var("client",client.inspect)
    puts client.inspect
    puts session[:request_token].params[:oauth_token].inspect
    RAILS_DEFAULT_LOGGER.info c("\n\ndo 2\n\n")
    access_token = client.authorize(
      session[:request_token].params[:oauth_token],
      session[:request_token].params[:oauth_token_secret],
      :oauth_verifier => params[:oauth_verifier]
    )
    
    puts 'token ' + access_token.inspect
    
    RAILS_DEFAULT_LOGGER.info c("\n\ndo 3\n\n")
    if client.authorized?
      RAILS_DEFAULT_LOGGER.info c("\n\nclient.user -- #{client.user.inspect}\n\n")
      user = User.find_by_username(client.user.first['user']['screen_name'])
      if user.full_name.blank?
        user.update_attributes!({:full_name => client.user.first['user']['name']})
      end
      if user.nil?
        user = User.create(:username => client.user.first['user']['screen_name'], 
                    :full_name => client.user.first['user']['name'],
                    :image => client.user.first['user']['profile_image_url'], 
                    :oauth_token => access_token.params[:oauth_token],
                    :oauth_secret => access_token.params[:oauth_token_secret])
      else
        user.update_attributes!({:image => client.user.first['user']['profile_image_url'], 
                                 :oauth_secret => access_token.params[:oauth_token_secret],
                                 :oauth_token => access_token.params[:oauth_token]
                                 })
      end
      RAILS_DEFAULT_LOGGER.info c("\n\ndo 4\n\n")
      session[:oauth_token] = access_token.params[:oauth_token]
      session[:oauth_secret] = access_token.params[:oauth_token_secret]
      RAILS_DEFAULT_LOGGER.info c("client.user.first['user']['screen_name'] = #{client.user.first['user']['screen_name'].inspect}")
      session[:username] = client.user.first['user']['screen_name']
      session[:user_id] = user.id
      RAILS_DEFAULT_LOGGER.info c("user = #{user.inspect}")
      redirect_to :controller => :courses, :action => :index
      return
    end
    flash[:notice] = "There was a problem logging in.  Please try again"
    redirect_to :controller => :courses, :action => :index  
  end
  
  def logout
    session[:oauth_token] = nil
    session[:oauth_secret] = nil
    session[:username] = nil
    session[:user_id] = nil
    flash[:notice] = "You have successfully been logged out"
    redirect_to :controller => :courses, :action => :index  
  end
  
  def find
    sub1 = "(select user_id from user_companies where company_id = '#{session[:selected_company]}')"
    @users = User.find(:all,:conditions => "username like '#{params['begins_with']}%' and id not in #{sub1}",:order => "username")
    render 'find', :layout => false
  end
  
  def fake_login
    users = User.all
    user = User.find_by_id(params[:fake_user_id])
    chars = ("a".."z").to_a + ("1".."9").to_a
    oauth_token = Array.new(51, '').collect{chars[rand(chars.size)]}.join
    oauth_secret = Array.new(44, '').collect{chars[rand(chars.size)]}.join
    if user.nil?
      user = User.create(:username => "user_#{params[:fake_user_id]}",
                  :oauth_token => oauth_token,
                  :oauth_secret => oauth_secret)
      RAILS_DEFAULT_LOGGER.info c("user = #{user.inspect}")
    else
      user.update_attributes!({:oauth_token => oauth_token,
                               :oauth_secret => oauth_secret
                               })
    end
    session[:oauth_token] = oauth_token
    session[:oauth_secret] = oauth_secret
    session[:username] = "user_#{params[:fake_user_id]}"
    session[:user_id] = params[:fake_user_id]
    redirect_to :controller => :companies, :action => :index
  end
  
  def fake_logout
    session[:oauth_token] = ""
    session[:oauth_secret] = ""
    session[:username] = ""
    session[:user_id] = ""
    render :nothing => true 
  end
end
