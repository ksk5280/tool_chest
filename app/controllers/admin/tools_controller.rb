class Admin::ToolsController < Admin::BaseController
  def index
    @tools = Tool.all
  end
end
