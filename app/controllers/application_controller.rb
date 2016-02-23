class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper_method :most_recent_tool, :current_tool_summary

  def most_recent_tool
    return "No tools added this session" if session[:most_recent_tool_id].nil?
    Tool.find(session[:most_recent_tool_id]).name
  end

  def current_tool_summary
    session[:current_tool_count] = session[:current_tool_count] ||= 0
    session[:current_potential_revenue] = session[:current_potential_revenue] ||= 0
    "Tool count: #{session[:current_tool_count]}, Potential revenue: #{session[:current_potential_revenue]}"
  end
end
