class QueryController < ApplicationController
  expose(:query) { Query.find_or_create_by term: params[:term] }
end
