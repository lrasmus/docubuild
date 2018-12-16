class TerminologyController < ApplicationController
  include ApplicationHelper

  def search
    render json: [{code_value: "1234.5", display: "test"}, {code_value: "1235.5", display: "other test"}]
  end

  private

  def permitted_params
    params.permit(:vocab, :term)
  end
end  