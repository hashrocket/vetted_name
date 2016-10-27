class QueryChannel < ApplicationCable::Channel
  def subscribed
    query = Query.find_by term: params[:term]
    stream_for query
  end
end
