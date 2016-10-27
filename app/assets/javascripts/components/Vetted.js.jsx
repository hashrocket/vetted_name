var Check = React.createClass({
  statusMap: {
    'null': 'pending',
    'true': 'passed',
    'false': 'failed',
  },
  statusMessage: function() {
    const key = String(this.props.check.passed);
    return this.statusMap[key]
  },
  render: function() {
    return (
      <div className="check">
        <h1>{this.props.check.name}</h1>
        <p>{this.statusMessage()}</p>
      </div>
    )
  }
});

var Checks = React.createClass({
  checks: function() {
    return this.props.checks.map((check) =>
      <Check key={check.id.toString()} check={check} />
    )
  },
  render: function() {
    return (
      <div className="checks">{this.checks()}</div>
    );
  }
});

var NameSearch = React.createClass({
  getInitialState: function() {
    return { term: this.props.term };
  },
  handleChange: function(event) {
    this.setState({ term: event.target.value });
  },
  handleClick: function() {
    window.location = "/check/" + this.state.term;
  },
  render: function() {
    return (
      <header>
        <h1>Vetted Name</h1>
        <input type="text" value={this.state.term} onChange={this.handleChange} />
        <button onClick={this.handleClick}>Search</button>
      </header>
    )
  }
});

var Vetted = React.createClass({
  render: function() {
    return (
      <div>
        <NameSearch term={this.props.query.term} />
        <Checks checks={this.props.query.checks}/>
      </div>
    )
  }
});
