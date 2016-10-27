var DisplayResults = {
  bootstrap: function(query) {
    this.query = query;
    this.render()
    this.subscribe()
  },
  query: {},
  render: function() {
    ReactDOM.render(
      <Vetted query={this.query} />,
      document.getElementById('root')
    );
  },
  subscription: null,
  subscribe: function() {
    if (this.subscription == null) {
      const sub = { channel: 'QueryChannel', term: this.query.term }
      const options = { received: this.received.bind(this) }
      this.subscription = App.cable.subscriptions.create(sub, options);
    }
  },
  received: function(data) {
    if (query = data.query) {
      this.bootstrap(query);
      return
    }

    if (check = data.check) {
      this.updateCheck(check);
      return
    }
  },
  updateCheck: function(newCheck) {
    const index = this.query.checks.findIndex((check) => check.id == newCheck.id);
    this.query.checks[index] = newCheck
    this.render();
  }
}
