require 'umls/umls_rest_client'

class TerminologyController < ApplicationController
  include ApplicationHelper

  def search
    render json: UmlsRestClient.instance.search_by_name(params[:term], oid_to_sab(params[:vocab]))
  end

  private

  def permitted_params
    params.permit(:vocab, :term)
  end

  def oid_to_sab oid
    if oid == '2.16.840.1.113883.6.103'
      return 'ICD9CM'
    elsif oid == '2.16.840.1.113883.6.90'
      return 'ICD10CM'
    elsif oid == '2.16.840.1.113883.6.3'
      return 'ICD10'
    elsif oid == '2.16.840.1.113883.6.96'
      return 'SNOMEDCT_US'
    elsif oid == '2.16.840.1.113883.6.88'
      return 'RXNORM'
    elsif oid == '2.16.840.1.113883.6.177'
      return 'MSH'
    elsif oid == '2.16.840.1.113883.6.69'  # NDC not supported
      return nil
    elsif oid == '2.16.840.1.113883.6.1'
      return 'LNC'
    elsif oid == '2.16.840.1.113883.6.174'
      return 'OMIM'
    elsif oid == '2.16.840.1.113883.6.336'
      return 'HGNC'
    end

    return nil
  end
end