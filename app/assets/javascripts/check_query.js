function check_query(term) {
  function incoming(data) {
    console.log(data);
  }
  App.cable.subscriptions.create({ channel: "QueryChannel", term: term }, {received: incoming});
}
