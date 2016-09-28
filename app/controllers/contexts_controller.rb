class ContextsController < ApplicationController
  # GET /contexts
  # GET /contexts.json
  def new
    @context = Context.new
    render :partial => "infobutton_context_element"
  end
end