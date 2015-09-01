class TodoList extends React.Component {
  constructor(props) {
    super(props);
    this.state = {"items": []};
  }

  componentDidMount() {
    $.ajax({
      url: "/lists/" + this.props.id + "/items",
      dataType: "json",
      cache: false,
      success: data => { this.setState({items: data}); },
      error: (xhr, status, err) => { console.error(status, err.toString()); }
    });
  }

  render() {
    var items = this.state.items.map(item => {
      return (<TodoListItem id={item.id} name={item.name} key={item.id} />);
    });
    return <div>
      <h2>{this.props.name}</h2>
      <ul id="items">
        {items}
      </ul>
      <a href="#" onClick={this.props.reset}>Back</a>
    </div>;
  }
}
