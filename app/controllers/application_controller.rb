class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper_method :most_recent_tool, :current_tool_summary, :current_user
  # before_action :set_tool_summary

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  # def set_tool_summary
  #   @tool_summary ||= ToolSummary.new(session[:current_tool_count, session [:most_recent_tool_id]])
  # end

  def most_recent_tool
    if session[:most_recent_tool_id].nil?
      "No tools added this session"
    else
      Tool.find(session[:most_recent_tool_id]).name
    end
  end

  def current_tool_summary
    session[:current_tool_count] = session[:current_tool_count] ||= 0
    session[:current_potential_revenue] = session[:current_potential_revenue] ||= 0
    "Tool count: #{session[:current_tool_count]}, Potential revenue: #{session[:current_potential_revenue]}"
  end
end
