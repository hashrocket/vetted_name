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

var Vetted = React.createClass({
  render: function() {
    return (
      <div>
        <Checks checks={this.props.query.checks}/>
      </div>
    )
  }
});
