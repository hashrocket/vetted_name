class QueryChannel < ApplicationCable::Channel
  def subscribed
    query = Query.find_by term: params[:term]
    stream_for query
    QueryChannel.broadcast_to query, { query: query }
  end
end
