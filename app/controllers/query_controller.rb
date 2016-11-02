class QueryController < ApplicationController
  expose(:query) { Query.find_or_create_by term: params[:term] }

  def show
    query.checks.each &:perform_job
  end
end
